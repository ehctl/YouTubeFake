localStorage.setItem('name', name);

$(document).ready(() => {
    handleResources.createMediaSource();
    handleDomEvent.setUpControlBar();
});

var handleData = {
    mediaSource: null,
    sourceBuffer: null,
    video,
    indexBuffer: [],
    loadingQueue: [],
    volume: 50,
    time: defaultTime,
    segmentLength: 10,
    checkUpdatingInterval: null,
    source_url: "video_provider?v=",
    image_url: "Content/image/",
    videoMimeo: 'video/mp4; codecs="avc1.42E01E, mp4a.40.2"',
    selectedSegmentLoad: false,
    VIDEO_LOAD_INTERVAL_IN_MS: 100,
};

var handleDomEvent = {
    setUpControlBar: () => {
        Object.defineProperty(HTMLMediaElement.prototype, "playing", {
            get: function () {
                return !!(
                    this.currentTime > 0 &&
                    !this.paused &&
                    !this.ended &&
                    this.readyState > 2
                );
            },
        });

        handleData.video = document.querySelector("#video");

        $("#control-bar").css('visibility', 'hidden')
        var timeout = null;
        $("#video-container").width(window.innerWidth * 0.6);
        $("#video").width($("#video-container").width());

        $("#video-container").mousemove(function (e) {
            handleDomEvent.mouseEnter(e);
            clearTimeout(timeout);
            timeout = setTimeout(function () {
                $("#control-bar").css('visibility', 'hidden');
            }, 5000);
        });

        $('#volume-bar').change((e) => {
            if (e.currentTarget.value <= 40) {
                if (handleData.volume > 40) {
                    $('#volume-image').attr('src', handleData.image_url + 'lowVolume.png')
                    console.log("?z")
                }
            } else {
                if (handleData.volume <= 40) {
                    $('#volume-image').attr('src', handleData.image_url + 'highVolume.png')
                }
            }
            console.log(e.currentTarget.value)
            handleData.volume = e.currentTarget.value;
            handleData.video.volume = e.currentTarget.value / 100;
        })

        $("#video-container").mouseenter(handleDomEvent.mouseEnter);

        $("#video-container").mouseleave(handleDomEvent.mouseLeave);

        $("#control-bar").mouseenter(handleDomEvent.mouseEnter);

        $("#control-bar").mouseleave(handleDomEvent.mouseLeave);

        $("#play-pause").click(handleDomEvent.playPause);

        $("#video-container").click(handleDomEvent.playPause);

        $("#control-bar").click(function (e) {
            e.stopPropagation();
        });

        $("#progress").click(function (e) {
            let { time, coor } = handleStmElse.calculateTimeProgressBar(e);
            handleData.time = time;
            if (handleData.time > handleData.mediaSource.duration)
                handleData.time = handleData.mediaSource.duration;

            $("#timer").text(
                handleStmElse.formatTime(time) +
                " / " +
                Math.floor(handleData.mediaSource.duration / 60) +
                ":" +
                handleStmElse.pad(Math.floor(handleData.mediaSource.duration % 60))
            );

            $("#bar").width(coor);

            handleResources.addToQueue(handleData.time).then((a) => {
                handleData.video.currentTime = handleData.time;
            });
            e.preventDefault();
        });

        $('#progress').mousemove((e) => {
            let time = Math.floor((handleStmElse.calculateTimeProgressBar(e)).time);
            $('#time-hint').show();
            $('#time-hint').text(handleStmElse.formatTime(time));
            $('#time-hint').css('left', e.pageX - document.querySelector('#control-bar').getBoundingClientRect().left)
        }
        )

        $('#progress').mouseleave((e) => {
            $('#time-hint').hide();
        })

        $("#video-container").keydown((e) => {
            switch (e.keyCode) {
                case 70: {
                    if (document.fullscreen) {
                        handleDomEvent.exitFullScreen();
                    } else {
                        handleDomEvent.fullScreen();
                    }
                    break;
                }
                case 32: {
                    handleDomEvent.playPause(e);
                    break;
                }
            }
        });

        $("#fullscreen").click(function (e) {
            if (!document.fullscreen) {
                handleDomEvent.fullScreen();
            } else {
                handleDomEvent.exitFullScreen();
            }
            e.stopPropagation();
        });

        $(window).resize(function () {
            handleResources.updateLoadingBar();
        });

        $(window).on("fullscreenchange", function () {
            if (!document.fullscreen) {
                $("#control-bar").removeClass("control-bar1").addClass("control-bar");
                $("#video-container").removeClass("video-fullscreen").addClass("video");
            }

            handleResources.updateLoadingBar();

        });

        $(window).keydown(function (e) { });

        setInterval(handleDomEvent.refreshProgressBar, handleData.VIDEO_LOAD_INTERVAL_IN_MS);
    },

    mouseEnter: (e) => {
        setTimeout(() => {
            $("#control-bar").css('visibility', 'visible');
        }, 100);

        e.stopPropagation();
    },

    mouseLeave: (e) => {
        setTimeout(() => {
            $("#control-bar").css('visibility', 'hidden');
        }, 100);

        e.stopPropagation();
    },

    playPause: async (e) => {
        $("#video").trigger("mousemove");
        if (!handleData.video.playing) {
            var playPromise = $("#video")[0].play();

            if (playPromise !== undefined) {
                playPromise
                    .then((_) => {
                        $("#play-pause").attr("src", handleData.image_url +  "pause.png");
                    })
                    .catch((error) => { });
            }
            handleDomEvent.playPauseAnimation(true);
        } else {
            $("#video")[0].pause();
            $("#play-pause").attr("src", handleData.image_url + "play.png");
            handleDomEvent.playPauseAnimation(false);
        }

        if (e) e.stopPropagation();
    },

    playPauseAnimation: (isPlay) => {
        let centerImage = document.querySelector("#center-image");
        centerImage.style.display = "block";

        let image_name = isPlay ? "play.png" : "pause.png";

        centerImage.src = handleData.image_url + image_name;
        setTimeout(() => {
            centerImage.style.display = "none";
        }, 500);
    },

    refreshProgressBar: () => {
        if (handleData.video.playing) {
            if (handleData.time >= handleData.mediaSource.duration) {
                handleData.time = 0;
                handleData.video.currentTime = 0;
                //playPause();
                return;
            } else {
                $("#timer").text(
                    Math.floor(handleData.time / 60) +
                    ":" +
                    handleStmElse.pad(Math.floor(handleData.time % 60)) +
                    " / " +
                    Math.floor(handleData.mediaSource.duration / 60) +
                    ":" +
                    handleStmElse.pad(Math.floor(handleData.mediaSource.duration % 60))
                );

                $("#bar").width(
                    $("#progress").width() *
                    (handleData.time / handleData.mediaSource.duration)
                );

                handleResources
                    .addToQueue(handleData.time)
                    .then(() => {
                        if (!handleData.selectedSegmentLoad) {
                            handleData.time += handleData.VIDEO_LOAD_INTERVAL_IN_MS / 1000;
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    });
            }
        } else {
            if (handleData.time >= handleData.mediaSource.duration - handleData.VIDEO_LOAD_INTERVAL_IN_MS / 1000) {
                handleData.time = 0;
                handleData.video.currentTime = 0;
            }
        }
        // if (handleData.time >= handleData.mediaSource.duration) {
        //   console.log("hola")
        //   handleData.time = 0;
        //   handleData.video.currentTime = 0;
        //   //playPause();
        //   return;
        // }
    },

    exitFullScreen: () => {
        if (document.exitFullscreen) {
            document.exitFullscreen();
        } else if (document.msExitFullscreen) {
            document.msExitFullscreen();
        } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        } else if (document.webkitExitFullscreen) {
            document.webkitExitFullscreen();
        }

        $("#control-bar").removeClass("control-bar1").addClass("control-bar");
        $("#video-container").removeClass("video-fullscreen").addClass("video");
    },

    fullScreen: () => {
        let temp = document.querySelector("#video-container");
        if (temp.requestFullscreen) {
            temp.requestFullscreen();
        } else if (temp.msRequestFullscreen) {
            temp.msRequestFullscreen();
        } else if (temp.mozRequestFullScreen) {
            temp.mozRequestFullScreen();
        } else if (temp.webkitRequestFullscreen) {
            temp.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
        }

        $("#control-bar").removeClass("control-bar").addClass("control-bar1");
        $("#video-container").removeClass("video").addClass("video-fullscreen");
    },
};

var handleResources = {
    createMediaSource: () => {
        handleData.mediaSource = new MediaSource();
        const url = URL.createObjectURL(handleData.mediaSource);

        $("#video").attr("src", url);
        handleData.mediaSource.addEventListener(
            "sourceopen",
            handleResources.sourceOpen
        );
    },

    sourceOpen: () => {
        handleData.sourceBuffer = handleData.mediaSource.addSourceBuffer(
            handleData.videoMimeo
        );

        handleResources.loadSourceInfo();
        console.log("Source open event");
        handleResources.initAudioSource().then((duration) => {
            if (type === "video") {
                console.log("Duration: " + duration);
                $("#timer").html(
                    CalculateDuration(handleData.time) + " / " +
                    Math.floor(duration / 60) +
                    ":" +
                    handleStmElse.pad(Math.floor(duration % 60))
                );
                handleResources.addToQueue(handleData.time).then(() => {
                    handleData.video.currentTime = handleData.time;
                });
            }
            //else {
            //    $("#timer").html("live");
            //    handleData.segmentLength = 2;
            //    handleResources.addToQueue(0).then(() => {
            //        // $("#video").currentTime = duration - 1;
            //        console.log("duration " + duration);
            //    });
            //}
            // playPause()
        });
    },

    initAudioSource: () => {
        if (type === "video") {
            return fetch(
                handleData.source_url +
                localStorage.getItem("name") +
                "&file_name=segment_init.mp4"
            )
                .then((response) => {
                    return response.arrayBuffer();
                })
                .then((data) => {
                    return new Promise((resolve, reject) => {
                        handleData.sourceBuffer.addEventListener("updateend", (_) => {
                            resolve(handleData.mediaSource.duration);
                        });

                        handleData.sourceBuffer.addEventListener("error", (e) => {
                            console.log(e);
                        });
                        handleData.sourceBuffer.appendBuffer(data);
                    });
                });
        } else if (type === "liveStream") {
            console.log(currTime);
            return Promise.resolve(currTime);
        }
    },

    loadSourceInfo: () => {
        return fetch(
            handleData.source_url +
            localStorage.getItem("name") +
            "&file_name=" +
            localStorage.getItem("name") +
            "_dash.mpd"
        ).then((response) => {
            response.text().then((data) => {
                let s = handleResources
                    .parseXml(data)
                    .getElementsByTagName("MPD")[0]
                    .getAttribute("mediaPresentationDuration");
                info = s.match(/[0-9\.]+/g);
                hour = parseInt(info[0]);
                minute = parseInt(info[1]);
                second = parseFloat(info[2]);
                handleData.duration = hour * 3600 + minute * 60 + second;

                handleData.numberOfSegments = Math.floor(handleData.duration % handleData.segmentLength === 0 ?
                    handleData.duration / handleData.segmentLength
                    : handleData.duration / handleData.segmentLength + 1);
            });
        });
    },

    addToQueue: async (time) => {
        var index;

        //if (time % handleData.segmentLength === 0)
        //    index = time / handleData.segmentLength;
        //else 
        index = Math.round(time / handleData.segmentLength)+1;

        if (
            !handleData.indexBuffer.includes(index - 1) &&
            !handleData.loadingQueue.includes(index - 1)
        ) {
            if (handleData.time - handleData.segmentLength >= 0) {
                handleData.loadingQueue.unshift(index - 1);
            }
        }

        if (
            !handleData.indexBuffer.includes(index + 1) &&
            !handleData.loadingQueue.includes(index + 1)
        ) {
            if (
                handleData.time + handleData.segmentLength <=
                handleData.mediaSource.duration
            ) {
                handleData.loadingQueue.unshift(index + 1);
            }
        }

        if (
            !handleData.indexBuffer.includes(index) &&
            !handleData.loadingQueue.includes(index)
        ) {
            handleData.loadingQueue.unshift(index);
        }

        await handleResources.loadingBufferFromQueue();
    },

    loadAudioSegment: (index) => {
        return new Promise((resolve, reject) => {
            handleResources.fetchVideo(
                handleData.source_url +
                localStorage.getItem("name") +
                "&file_name=segment_" +
                index +
                ".m4s",
                (data) => {
                    console.log(
                        "Before Source buffer Updating: " + handleData.sourceBuffer.updating
                    );
                    if (handleData.sourceBuffer.updating) {
                        // abort and pop bc the prev segment loaded in index buff is still loading
                        // and i wanna abort it
                        handleData.sourceBuffer.abort();
                        handleData.loadingQueue.push(handleData.indexBuffer.pop());
                    }
                    handleData.sourceBuffer.appendBuffer(data);
                    console.log(
                        "Source buffer Updating: " + handleData.sourceBuffer.updating
                    );

                    handleData.sourceBuffer.removeEventListener(
                        "updateend",
                        handleResources.eventListener
                    );
                    handleData.sourceBuffer.addEventListener(
                        "updateend",
                        handleResources.eventListener(resolve)
                    );
                }
            );
        });
    },

    loadingBufferFromQueue: async () => {
        if (!handleData.sourceBuffer.updating) {
            if (handleData.loadingQueue.length > 0) {
                handleData.video.pause();
                console.log("Loading queue: " + handleData.loadingQueue);
                console.log("Index buffer: " + handleData.indexBuffer);

                // just need to load the first segment to play video
                var index = handleData.loadingQueue[0];
                if (index <= Math.round(handleData.time / handleData.segmentLength) + 1) {
                    handleData.selectedSegmentLoad = true;

                    document.querySelector("#center-image").src =
                        handleData.image_url + "loading.gif";
                    document.querySelector("#center-image").style.display = "block";
                    await handleResources.loadAudioSegment(index);
                    handleData.indexBuffer.push(handleData.loadingQueue.shift());

                    document.querySelector("#center-image").style.display = "none";
                    handleData.selectedSegmentLoad = false;
                }

                while (handleData.loadingQueue.length > 0) {
                    var index = handleData.loadingQueue[0];
                    await handleResources.loadAudioSegment(index);
                    handleData.indexBuffer.push(handleData.loadingQueue.shift());
                    handleResources.updateLoadingBar();
                }

                handleData.video
                    .play()
                    .then(() => { })
                    .catch((e) => {
                        // its fine if autoplay is off and play() throws an exception bout that
                        console.log(e);
                    });
                console.log("Video playing: " + handleData.video.playing);
            }
        } else {
            console.log("Loading video so we will dumb all the loading segments xD");
            handleData.sourceBuffer.abort();
        }
    },

    updateLoadingBar: () => {
        let current_segment = Math.floor(handleData.time / handleData.segmentLength + 1);
        let loaded_segment = null;
        for (let i = current_segment; ; i++) {
            if (handleData.indexBuffer.includes(i)) {
                loaded_segment = i;
            } else {
                break;
            }
        }

        if (loaded_segment) {
            document.querySelector('#progress').style.display = 'flex'

            let duration = loaded_segment === handleData.numberOfSegments ? handleData.duration : loaded_segment * handleData.segmentLength;

            $("#loading-bar").width(
                ($("#progress").width() * duration /
                    handleData.duration));

        } else {
            // loading_bar.style.display = 'none';
        }
    },

    searchForSegment: (ind) => {
        for (var index of handleData.indexBuffer) {
            if (index == ind) {
                return true;
            }
        }
        return false;
    },

    fetchVideo: (url, cb) => {
        var xhr = new XMLHttpRequest();
        xhr.open("get", url);
        xhr.responseType = "arraybuffer";
        xhr.onload = function () {
            cb(xhr.response);
        };
        xhr.send();
    },

    eventListener: (resolve) => {
        console.log(
            "After Buffer updating when ended : " + handleData.sourceBuffer.updating
        );
        resolve();
    },

    parseXml: (xml) => {
        var dom = null;
        if (window.DOMParser) {
            try {
                dom = new DOMParser().parseFromString(xml, "text/xml");
            } catch (e) {
                dom = null;
            }
        } else if (window.ActiveXObject) {
            try {
                dom = new ActiveXObject("Microsoft.XMLDOM");
                dom.async = false;
                if (!dom.loadXML(xml))
                    // parse error ..

                    window.alert(dom.parseError.reason + dom.parseError.srcText);
            } catch (e) {
                dom = null;
            }
        } else alert("cannot parse xml string!");
        return dom;
    },
};

var handleStmElse = {
    pad: (d) => {
        return d < 10 ? "0" + d.toString() : d.toString();
    },

    calculateTimeProgressBar: (e) => {
        let coor;
        coor = e.clientX - document.querySelector("#control-bar").getBoundingClientRect().left;
        coor = coor < 0 ? 0 : coor;

        return { time: (coor / $("#control-bar").width()) * handleData.mediaSource.duration, coor };
    },

    formatTime: (time) => {
        return Math.floor(time / 60) +
            ":" +
            handleStmElse.pad(Math.floor(time % 60));
    }
};
