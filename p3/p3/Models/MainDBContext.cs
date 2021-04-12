using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using p3.Controllers;
using System.Threading.Tasks;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Data.SqlClient;
using System.Collections;

namespace p3.Models
{
    public class MainDBContext : DbContext
    {
        Random rand;
        public MainDBContext()
        {
            rand = new Random();
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
        }

        public DbSet<User> Users { get; set; }

        public DbSet<SearchQuery> SearchQueries { get; set; }

        public DbSet<Video> Videos { get; set; }

        public DbSet<VideoTag> VideoTags { get; set; }

        public DbSet<Subscriber> Subscribers { get; set; }

        public DbSet<VideoComment> VideoComments { get; set; }

        public DbSet<WatchHistory> WatchHistory { get; set; }

        public DbSet<Playlist> Playlists { get; set; }

        public DbSet<VideoPlaylist> VideoPlaylists { get; set; }

        public DbSet<Tag> Tags { get; set; }

        public DbSet<UserFavoriteTag> UserFavoriteTags { get; set; }

        public bool isSubscriber(int userID, int channelID)
        {
            bool isSubscriber = false;

            if (userID != channelID)
            {
                var subscriberFiler = this.Subscribers
                                 .Where(s => s.Channel_id == channelID);

                var sub = subscriberFiler
                              .Where(s => s.User_id == userID)
                              .OrderByDescending(s => s.Time)
                              .FirstOrDefault();
                if (sub != null) isSubscriber = sub.Action == Subscriber.SUBSCRIBE_ACTION ? true : false;

            }
            return isSubscriber;
        }

        public Subscriber getSubscribeDetail(int userID, int channelID)
        {
            var sub = this.Subscribers
                    .Where(s => s.Channel_id == channelID)
                    .Where(s => s.User_id == userID)
                    .OrderByDescending(s => s.Time)
                    .FirstOrDefault();

            return sub;
        }

        public User findChannel(int channelID)
        {
            var c = this.Users
                .Where(us => us.Id == channelID)
                .FirstOrDefault();

            return c;
        }

        public ChannelVideoElementData[] getChannelVideos(int ownerID,int userID,int quantity, int index = 0)
        {
            var videos = this.Videos
                .Where(v => v.Owner_id == ownerID)
                .GroupJoin(
                   (this.WatchHistory.Where(wh => wh.User_id == userID))
                   , v => v.Id
                   , wh => wh.Video_id
                   , (xx, yy) => new ChannelVideoElementData
                   {
                       Video = xx,
                       Watch_time = yy.Select(yys => yys.Watch_time).FirstOrDefault()
                   }
                )
                .OrderBy(v => v.Video.Created_date)
                .Take(quantity);


            return videos.ToArray();
        }

        public VideoElementData[] getWatchHistory(int userID,int quantity,int index=0)
        {
            var videos = this.Videos
               .Join(this.Users
                   , v => v.Owner_id
                   , u => u.Id
                   , (v, u) => new { User = u, Video = v }
               )
               .Join(this.WatchHistory
                       .Where(wh => wh.User_id == userID)
                   , x => x.Video.Id
                   , wh => wh.Video_id
                   , (x, wh) => new
                   {
                       VED = new VideoElementData
                       {
                           Channel_avatar = x.User.Avatar,
                           Channel_name = x.User.Channel_name,
                           Channel_id = x.User.Id,
                           Video = x.Video,
                           Watch_time = wh.Watch_time,
                       }
                        ,
                       time = wh.Time
                   }
               )
               .OrderByDescending(v => v.time)
               .Select(v => v.VED)
               .Skip(index)
               .Take(quantity);

            return videos.ToArray();
        }

        private IQueryable<VideoElementData> getVideoElementRaw()
        {
            var videos = this.Videos
                .Join(this.Users
                    , v => v.Owner_id
                    , u => u.Id
                    , (v, u) => new VideoElementData
                    {
                        Channel_avatar = u.Avatar,
                        Channel_name = u.Channel_name,
                        Channel_id = u.Id,
                        Video = v,
                    });
            return videos;
        }

        private IQueryable<VideoElementData> getVideoElementRawWithFilter(IQueryable<Video> source)
        {
            var videos = source
                .Join(this.Users
                    , v => v.Owner_id
                    , u => u.Id
                    , (v, u) => new VideoElementData
                    {
                        Channel_avatar = u.Avatar,
                        Channel_name = u.Channel_name,
                        Channel_id = u.Id,
                        Video = v,
                    });
            return videos;
        }

        private IQueryable<VideoElementData> getVideoElementRawWithIdentity(int userID)
        {
            var videos = this.Videos
                .Join(this.Users
                   , v => v.Owner_id
                   , u => u.Id
                   , (v, u) => new { User = u, Video = v })
                .GroupJoin(
                   (this.WatchHistory.Where(wh => wh.User_id == userID))
                   , x => x.Video.Id
                   , wh => wh.Video_id
                   , (xx, yy) => new VideoElementData
                   {
                       Channel_avatar = xx.User.Avatar,
                       Channel_name = xx.User.Channel_name,
                       Channel_id = xx.User.Id,
                       Video = xx.Video,
                       Watch_time = yy.Select(yys => yys.Watch_time).FirstOrDefault()
                   }
                );

            return videos;
        }

        private IQueryable<VideoElementData> getVideoElementRawWithIdentityWithFilter(int userID,IQueryable<Video> source)
        {
            var videos = source
                .Join(this.Users
                   , v => v.Owner_id
                   , u => u.Id
                   , (v, u) => new { User = u, Video = v })
                .GroupJoin(
                   (this.WatchHistory.Where(wh => wh.User_id == userID))
                   , x => x.Video.Id
                   , wh => wh.Video_id
                   , (xx, yy) => new VideoElementData
                   {
                       Channel_avatar = xx.User.Avatar,
                       Channel_name = xx.User.Channel_name,
                       Channel_id = xx.User.Id,
                       Video = xx.Video,
                       Watch_time = yy.Select(yys => yys.Watch_time).FirstOrDefault()
                   }
                );

            return videos;
        }

        public VideoElementData[] getVideoElementData(int userID,int quantity,int index = 0)
        {
            IQueryable<VideoElementData> videos;
            if (userID == -1)
            {
                videos = this.getVideoElementRaw()
                    .OrderBy(v => v.Video.Created_date)
                    .Skip(index)
                    .Take(quantity);
            }
            else
            {
                videos = this.getVideoElementRawWithIdentity(userID)
                    .OrderBy(v => v.Video.Created_date)
                    .Skip(index)
                    .Take(quantity);
            }

            if (videos.Count() > 0)
                return videos.ToArray();
            else
                return null;
        }

        public bool checkUserEmail(string email)
        {
            var mail = this.Users
                        .Where(u => u.Email.Equals(email))
                        .FirstOrDefault();

            return mail != null ? true : false;
        }
        public User AddUser(string username,string firstname,string lastname,string email,string password,string birthdate,string activeCode,string sadCode)
        {
            User user = new User();
            user.Account_status = 0;
            user.Birth_date = Convert.ToDateTime(birthdate);
            user.Email = email;
            user.First_name = firstname;
            user.Last_name = lastname;
            user.Username = username;
            user.Password = password;
            user.Channel_name = username;
            user.Active_code = activeCode;
            user.Sad_code = sadCode;

            this.Users.Add(user);
            this.SaveChanges();

            return user;
        }

        public User ActiveUser(string activeCode)
        {
            var user = this.Users
                        .Where(u => u.Active_code.Equals(activeCode))
                        .FirstOrDefault();

            if( user != null)
            {
                user.Account_status = 1;
                this.SaveChanges();
            }

            return user;
        }
        public User login(string username,string password)
        {
            var user = this.Users
                       .Where(u => u.Username.Equals(username))
                       .FirstOrDefault();

            if( user != null)
            {
                if( Helper.EncryptSha256(password + user.Sad_code).Equals(user.Password))
                {
                    return user;
                }
            }

            return null;
        }

        public User getUser(int userID)
        {
            var user = this.Users
                        .Where(u => u.Id == userID)
                        .FirstOrDefault();

            return user;
        }

        public void AddSubscriber(string c_id, int userID, int Action)
        {
            var subscriber = new Subscriber();
            subscriber.Action = Action;
            subscriber.Channel_id = Convert.ToInt32(c_id);
            subscriber.User_id = userID;

            this.Subscribers.Add(subscriber);
            this.SaveChanges();

            UpdateSubscriberCount(subscriber.Channel_id,Action);
        }

        public void UpdateSubscriberCount(int c_id,int Action)
        {
            var u = this.Users
                   .Find(c_id);

            u.Subscriber += Action == Subscriber.SUBSCRIBE_ACTION ? 1 : -1;
            this.SaveChanges();
        }

        public IQueryable<string> getVideoBasedOnTag(string query)
        {
            var list = this.Tags
                         .Where(x => x.Name.Contains(query))
                         .Join(
                             this.VideoTags
                             , t => t.Id
                             , vt => vt.Tag_id
                             , (t, vt) => new { Tag = t, VideoTag = vt }
                         )
                         .Select(x => x.VideoTag.Video_id);

            return list;
        }

        public IQueryable<string> getVideoBaseOnTitle(string query)
        {
            var list = this.Videos
                        .Where(x => x.Title.Contains(query))
                        .Select(x => x.Id);

            return list;
        }

        public IQueryable<User> getChannelBaseOnName(string query, int userID)
        {
            var list = this.Users
                        .Where(u => u.Channel_name.Contains(query));

            return list;
        }

        public SearchDataElement[] search(string query,int userID)
        {
            IQueryable<string> p1 = getVideoBasedOnTag(query);
            IQueryable<string> p2 = getVideoBaseOnTitle(query);


            p1 = p1.Concat(p2);
            p1 = p1.Distinct();

            IQueryable<VideoElementData> videos;
            if( userID == -1)
            {
                videos = getVideoElementRawWithFilter(p1.Join(this.Videos, x => x, v => v.Id, (x, v) => v));
            }
            else
            {
                videos = getVideoElementRawWithIdentityWithFilter(userID,p1.Join(this.Videos, x => x, v => v.Id, (x, v) => v));
            }

            IQueryable<SearchDataElement> videoList = videos.
                        Select(x => new SearchDataElement()
                            {
                                ResultType = SearchDataElement.VIDEO_TYPE,
                                videoData = x                             
                            });

            IQueryable<SearchDataElement> channelList = getChannelBaseOnName(query, userID)
                                    .Select(u => new SearchDataElement()  
                                        {
                                            ResultType = SearchDataElement.CHANNEL_TYPE,
                                            channelData = new ChannelElementData()
                                            {
                                                ChannelInfo = u,
                                                isSubscribe = false
                                            },
                                        }
                                    );
            List<SearchDataElement> cl = channelList.ToList();
            cl.AddRange(videoList.ToList());
            foreach(var item in cl)
            {
                if( item.ResultType == SearchDataElement.CHANNEL_TYPE)
                {
                    item.channelData.isSubscribe = isSubscriber(userID, item.channelData.ChannelInfo.Id);
                }
            }
            var output = cl.ToArray();
            return output;
        }


        public SearchQuery[] getQuery(string query, int quantity, int index = 0)
        {
            SearchQuery[] queries = this.SearchQueries
                           .Where(q => q.Search_query.Contains(query))
                           .Skip(index)
                           .Take(quantity)
                           .ToArray();

            return queries;
        }

        public Video getVideo(string id)
        {
            var video = this.Videos.Find(id);
            return video;
        }

        public CommentElementData[] getVideoComments(string videoID,int quantity,int index=0)
        {
            var comments = this.VideoComments
                           .Where(vc => vc.Video_id == videoID)
                           .OrderBy(vc => vc.Created_at)
                           .Skip(index)
                           .Take(quantity);
            List<CommentElementData> data = new List<CommentElementData>();
            foreach (var item in comments.ToArray())
            {
                User u = this.Users.Find(item.Owner_id);
                CommentElementData comment = new CommentElementData();
                comment.Comment = item;
                comment.OwnerAvatar = u.Avatar;
                comment.OwnerID = u.Id;
                comment.OwnerName = u.Channel_name;

                data.Add(comment);
            }
            return data.ToArray();
        }

        public void increaseView(string videoID)
        {
            var v = this.Videos
                        .Where(vid => vid.Id.Equals(videoID))
                        .FirstOrDefault();

            if (v != null)
            {
                v.View += 1;
                this.SaveChanges();
            }
        }

        public void AddComment(string videoID,int userID,string cmt)
        {
            VideoComment c = new VideoComment();
            c.Video_id = videoID;
            c.Owner_id = Convert.ToInt32(userID);
            c.Comment = cmt;
            c.Created_at = DateTime.Now;
            c.Updated_at = c.Created_at;
            c.Status = 0;

            this.VideoComments.Add(c);
            this.SaveChanges();

            IncreaseCommentCount(videoID);
        }

        public void IncreaseCommentCount(string videoID)
        {
            var video =  this.Videos
                    .Where(vid => vid.Id.Equals(videoID))
                    .FirstOrDefault();

            if (video != null)
            {
                video.Comment += 1;
                this.SaveChanges();
            }
        }

        public void AddWatchHistory(int userID,string videoID)
        {
            var wh = this.WatchHistory
                    .Where(w => (w.User_id == userID && w.Video_id.Equals(videoID)))
                    .FirstOrDefault();

            if( wh == null)
            {
                WatchHistory watchHistory = new WatchHistory();
                watchHistory.User_id = userID;
                watchHistory.Video_id = videoID;
                watchHistory.Time = DateTime.Now;
                watchHistory.Watch_time = 0;

                this.WatchHistory.Add(watchHistory);
            }
            else
            {
                wh.Time = DateTime.Now;
            }

            this.SaveChanges();
        }

        public void ProcessFavoriteTag(int userID,string videoID)
        {
            var videoTags = this.VideoTags
                            .Where(vt => vt.Video_id.Equals(videoID)).ToArray();
            foreach (var tag in videoTags)
            {
                var t = this.UserFavoriteTags
                        .Where(x => x.Tag_id == tag.Tag_id && x.User_id == userID)
                        .FirstOrDefault();
                if (t == null)
                {
                    UserFavoriteTag userFavTag = new UserFavoriteTag();
                    userFavTag.Tag_id = tag.Tag_id;
                    userFavTag.User_id = userID;
                    userFavTag.Rating = WatchController.DEFAULT_RATING;
                    this.UserFavoriteTags.Add(userFavTag);
                }
                else
                {
                    // check if user have ever watch this video
                    var wh = this.WatchHistory
                            .Where(w => w.User_id == userID && w.Video_id.Equals(videoID))
                            .FirstOrDefault();
                    if (wh == null)
                    {
                        if (t.Rating < 39)
                        {
                            t.Rating += (40 - t.Rating) == 1 ? 1 : 2;
                        }
                    }
                }
            }                           
            this.SaveChanges();
        }

        public void updateWatchTimeOfVideo(int userID,string videoID, int time)
        {
            var wh = this.WatchHistory
                    .Where(w => (w.User_id == userID && w.Video_id.Equals(videoID)))
                    .FirstOrDefault();

            if(wh != null)
            {
                if( wh.Watch_time < time)
                {
                    wh.Watch_time = time;
                    this.SaveChanges();
                }
            }
        }

        public int GetVideoWatchTime(int userID,string videoID)
        {
            int watchTime = 0;

            var wh = this.WatchHistory
                    .Where(w => (w.User_id == userID && w.Video_id.Equals(videoID)))
                    .FirstOrDefault();

            if (wh != null)
            {
                watchTime = wh.Watch_time;
            }

            return watchTime;
        }

        public void AddVideoToPlaylist(int userID,string videoID)
        {
            var playlist = this.Playlists
                          .Where(x => x.Owner_id == userID)
                          .FirstOrDefault();
            if(playlist == null)
            {
                var user = this.Users
                           .Find(userID);

                Playlist pl = new Playlist();
                pl.Owner_id = userID;
                pl.Quantity = 1;
                pl.Name = user.Channel_name + "'s playlist";
                pl.Last_modified = DateTime.Now;
                this.Playlists.Add(pl);
                this.SaveChanges();
                 

                VideoPlaylist vp = new VideoPlaylist();
                vp.Video_id = videoID;
                vp.Playlist_id = pl.Id;
                this.VideoPlaylists.Add(vp);

                this.SaveChanges();
            }
            else
            {
                playlist.Quantity += 1;
                playlist.Last_modified = DateTime.Now;

                var vpTest = this.VideoPlaylists
                            .Where(x => x.Playlist_id == playlist.Id && x.Video_id.Equals(videoID))
                            .FirstOrDefault();
                if (vpTest == null)
                {
                    VideoPlaylist vp = new VideoPlaylist();
                    vp.Video_id = videoID;
                    vp.Playlist_id = playlist.Id;

                    this.VideoPlaylists.Add(vp);

                    this.SaveChanges();
                }
            }
        }

        public void RemoveVideoFromPlaylist(int userID,string videoID)
        {
            var playlist = this.Playlists
                        .Where(x => x.Owner_id == userID)
                        .FirstOrDefault();
            if( playlist != null)
            {
                playlist.Quantity -= 1;
                var vp = this.VideoPlaylists
                        .Where(x => (x.Video_id == videoID && x.Playlist_id == playlist.Id))
                        .FirstOrDefault();

                if( vp != null)
                {
                    this.VideoPlaylists.Remove(vp);

                    this.SaveChanges();
                }
            }
        }

        public bool checkVideoInPlaylist(int userID, string videoID)
        {
            var playlist = this.Playlists
                       .Where(x => x.Owner_id == userID)
                       .FirstOrDefault();
            if (playlist != null)
            {
                var check = this.VideoPlaylists
                            .Where(x => x.Playlist_id == playlist.Id && x.Video_id == videoID)
                            .FirstOrDefault();

                if (check == null)
                    return false;
                else
                    return true;
            }
            else
            {
                return false;
            }
        }

        public VideoElementData[] getAllVideo(int userID)
        {
            VideoElementData[] videos;
            if (userID == -1)
            {
                videos = this.getVideoElementRawWithFilter(getRandom(this.Videos,HomeController.MAXIMUM_VIDEO_PER_PAGE))
                        .Take(p3.Controllers.HomeController.MAXIMUM_VIDEO_PER_PAGE)
                        .ToArray();
            }
            else
            {
                videos = this.getSuggestVideo(userID);
                //videos = null;
            }
            return videos.ToArray();
        }

        public VideoElementData[] getSuggestVideo(int userID)
        {
            var userFavoriteTag = this.UserFavoriteTags
                            .Where(x => x.User_id == userID)
                            .OrderByDescending(t => t.Rating);

            // get recently watched videos
            var recentlyWatched = getRandom(this.WatchHistory
                                     .Where(wh => wh.User_id == userID)
                                     .OrderByDescending(wh => wh.Time) , 2)
                                 .Select(x => x.Video_id)
                                 .Take(2);

            var trending = this.WatchHistory
                            .GroupBy(x => x.Video_id)
                            .OrderByDescending(x => x.Count())
                            .Select(x => x.Key)
                            .Take(3)
                            ;

            IQueryable<string> pool = recentlyWatched;
            pool = pool.Concat(trending);
            pool = pool.Distinct();

            var uf = this.UserFavoriteTags
                    .Join(
                        this.VideoTags
                        , uft => uft.Tag_id
                        , vt => vt.Tag_id
                        , (uft, vt) => new { Video_id = vt.Video_id, Tag_id = uft.Tag_id }
                    );

            var uftList = userFavoriteTag.ToArray();
            int quantity;

            for (int i = 1;i < 4; i++)
            {
                if( uftList.Length < i)
                {
                    break;
                }

                int tagId = uftList[i - 1].Tag_id;
                quantity = 4 - i;
                pool = pool.Concat(
                        getRandom(
                            uf
                            .Where(vt => vt.Tag_id == tagId)
                            .Select(vt => vt.Video_id),quantity)
                            .Take(quantity) 
                    );
            }

            if (uftList.Length < 5)
            {
                quantity = 20 - pool.Count();
                pool = pool.Concat(
                        getRandom(
                            uf
                            .Select(vt => vt.Video_id), quantity)
                            .Take(quantity)
                    );

                pool = pool.Distinct();
            }

            int remaining = 20 - pool.Count();

            while (true)
            {
                //if (remaining > this.VideoTags.Count()) remaining = this.VideoTags.Count();
                pool = pool.Concat(
                            getRandom(this.VideoTags
                                .Select(x => x.Video_id), remaining)
                            .Take(remaining)
                        );

                pool = pool.Distinct();

                if (pool.Count() >= 20 || remaining > this.VideoTags.Count())
                {
                    pool = pool.Take(20);
                    break;
                }
            }

            var list = pool
                      .Join(
                           this.Videos
                        , p => p
                        , v => v.Id
                        , (p, v) => v
                      );

            var temp = getVideoElementRawWithIdentityWithFilter(userID, list).ToArray();
            Helper.ShuffleArray(ref temp);
            return temp;
        }

        private IQueryable<Video> getRandom(IQueryable<Video> source,int quantity)
        {
            int minSize = source.Count() - quantity;
            int skip = minSize > 0 ? (int)(rand.NextDouble() * minSize) : 0;
            return source.OrderBy(o => o.Created_date).Skip(skip);
        }

        private IQueryable<WatchHistory> getRandom(IQueryable<WatchHistory> source,int quantity)
        {
            int minSize = source.Count() - quantity;
            int skip = minSize > 0 ? (int)(rand.NextDouble() * minSize) : 0;
            return source.OrderBy(o => o.Time).Skip(skip);
        }

        private IQueryable<string> getRandom(IQueryable<string> source, int quantity)
        {
            int minSize = source.Count() - quantity;
            int skip = minSize > 0 ? (int)(rand.NextDouble() * minSize) : 0;
            return source.OrderBy(o => o).Skip(skip);
        }

        public VideoElementData[] getMostPopular(int userID,int quantity,int index = 0)
        {
            var mostPopularList = this.Videos;

            //trendingList = getRandom(trendingList,HomeController.MAXIMUM_VIDEO_PER_PAGE);
            IQueryable<VideoElementData> videos;
            if (userID == -1) {
                videos = this.getVideoElementRawWithFilter(mostPopularList)
                    .OrderByDescending( x=>x.Video.View)
                    .Skip(index)
                    .Take(quantity);
            }
            else
            {
                videos = this.getVideoElementRawWithIdentityWithFilter(userID, mostPopularList)
                    .OrderByDescending(x => x.Video.View)
                    .Skip(index)
                    .Take(quantity);
            }

            return videos.ToArray();
        }

        public VideoElementData[] getVideoByTagID(int userID,int tagId,int index=0)
        {
            var vQuery = this.Videos
                            .Join(this.VideoTags
                                , v => v.Id
                                , vt => vt.Video_id
                                , (v, vt) => new { Video = v, VideoTag = vt }
                            )
                            .Where(x => x.VideoTag.Tag_id == tagId)
                            .Select(x => x.Video);
            vQuery = getRandom(vQuery, HomeController.MAXIMUM_VIDEO_PER_PAGE);
            if ( userID == -1)
            {
                var videos = this.getVideoElementRawWithFilter(vQuery)
                            .Take(HomeController.MAXIMUM_VIDEO_PER_PAGE);

                return videos.ToArray();
            }
            else
            {
                var videos = this.getVideoElementRawWithIdentityWithFilter( userID,vQuery)
                            .Take(HomeController.MAXIMUM_VIDEO_PER_PAGE);

                return videos.ToArray();
            }
        }

        public UserTag[] getFavoriteTagList(int userID)
        {
            var favTagList = this.UserFavoriteTags
                             .Where(x => x.User_id == userID)
                             .Join(this.Tags
                                 , x => x.Tag_id
                                 , t => t.Id
                                 , (x, t) => new { Id = x.Tag_id, Name = t.Name, Rating = x.Rating })
                             .OrderByDescending(x => x.Rating)
                             .Select(x => new UserTag { Id = x.Id, Name = x.Name })
                             .Take(HomeController.MAXIMUM_FAVORITE_TAG_LOADED);

            List<UserTag> list = favTagList.ToList();

            if (checkUserPlaylistExistence(userID))
            {
                UserTag playlist = new UserTag() { Id = 2, Name = "Your playlist" };
                list.Insert(0, playlist);
            }

            return list.ToArray();
        }

        public bool checkUserPlaylistExistence(int userID)
        {
            var playlist = this.Playlists
                            .Where(pl => pl.Owner_id == userID)
                            .FirstOrDefault();

            return playlist != null;
        }

        public VideoElementData[] getUserPlaylist(int userID, int quantity, int index = 0)
        {
            var playlist = this.Playlists
                            .Where(pl => pl.Owner_id == userID)
                            .Join(
                                this.VideoPlaylists
                                , pl => pl.Id
                                , vpl => vpl.Playlist_id
                                , (pl, vpl) => vpl
                            )
                            .Join(
                                this.Videos
                                , x => x.Video_id
                                , v => v.Id
                                , (x, v) => new { Added_at = x.Added_at, Video = v }
                            )
                            .Join(this.Users
                               , v => v.Video.Owner_id
                               , u => u.Id
                               , (v, u) => new { User = u, Video = v })
                            .GroupJoin(
                               (this.WatchHistory.Where(wh => wh.User_id == userID))
                               , x => x.Video.Video.Id
                               , wh => wh.Video_id
                               , (xx, yy) => new
                               {
                                   data = new VideoElementData
                                   {
                                       Channel_avatar = xx.User.Avatar,
                                       Channel_name = xx.User.Channel_name,
                                       Channel_id = xx.User.Id,
                                       Video = xx.Video.Video,
                                       Watch_time = yy.Select(yys => yys.Watch_time).FirstOrDefault()
                                   },
                                   Added_at = xx.Video.Added_at
                               }
                            )
                            .OrderByDescending(x => x.Added_at)
                            .Select(x => x.data)
                            .Skip(index)
                            .Take(quantity);

            return playlist.ToArray();
        }

        public Tag[] searchTagByName(string name)
        {
            var tags = this.Tags
                    .Where(t => t.Name.Contains(name));

            return tags.ToArray();
        }
    }
}