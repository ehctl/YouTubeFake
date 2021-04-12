let calculateDay = (date) => {
    let old_date = new Date(date);
    let new_date = new Date();

    let diff = new_date - old_date;
    let totalYears = diff / (24 * 60 * 60 * 365 * 1000);
    let totalMonths = diff / (24 * 60 * 60 * 31 * 1000);
    let totalDays = diff / (24 * 60 * 60 * 1000);
    let totalHours = diff / (60 * 60 * 1000);
    let totalMinutes = diff / (60 * 1000);
    let totalSeconds = diff / 1000;
    let outputDay;

    if (totalYears >= 1) {
        outputDay = Math.round(totalYears) + " year ago";
    }
    else if ( totalMonths >= 1) {
        outputDay = Math.round(totalMonths) + " month ago";
    }
    else if (totalDays >= 1) {
        outputDay = Math.round(totalDays) + " day ago";
    }
    else if (totalHours >= 1) {
        outputDay = Math.round(totalHours) + " hour ago";
    }
    else if (totalMinutes >= 1) {
        outputDay = Math.round(totalMinutes) + " minute ago";
    }
    else {
        outputDay = Math.round(totalSeconds) + " second ago";
    }

    return outputDay;
}

let convertToDate = (date) => {
    date = date.slice(6, -2);
    return new Date(parseInt(date));
}

let calculateView = (view) => {
    let outputView = "";
    view = parseInt(view);
    if (view < 1000) {
        outputView += view + " views";
    }
    else if (view > 1000 && view < 1000000) {
        outputView += view / 1000 + "." + (view % 1000) / 100 + " k views";
    } else if (view > 1000000) {
        outputView += view / 1000000 + "." + (view % 1000000) / 100000 + " mil views";
    }

    return outputView;
}

let CalculateDuration = (Duration)=>{

    let hour = Math.round(Duration / 3600);
    let minute = Math.round((Duration % 3600) / 60);
    let second = Duration % 60;

    if (second < 10 && minute >= 1) second = "0" + second;
    if (minute < 10 && hour >= 1) minute = "0" + minute;

    let dur = hour == 0 ? "" : hour + ":";
    dur += minute + ":" + second;
    return dur;


}

let ApiCall = (Url, Method, formData = null)=>{
    return new Promise((resolve, reject) => {
        xml = new XMLHttpRequest();

        xml.onreadystatechange = function () {
            if (this.readyState === 4) {
                if (this.status === 200) {
                    resolve(this.response);
                } else {
                    reject(this.response);
                }
            }
        }

  
        xml.open(Method, Url);

        if (formData != null) {
            xml.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xml.send(formData);
        }
        else
            xml.send();
    })
}

let ApiCallWithAbort = (Url, Method, formData = null) => {
    return new Promise((resolve, reject) => {
        xml = new XMLHttpRequest();

        xml.onreadystatechange = function () {
            if (this.readyState === 4) {
                if (this.status === 200) {
                    resolve(this);
                } else {
                    reject(this.response);
                }
            }
        }


        xml.open(Method, Url);

        if (formData == null)
            xml.send(formData);
        else
            xml.send();
    })
}