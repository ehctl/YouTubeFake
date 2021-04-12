using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace p3.Models
{
    public class SearchData
    {
        public string SearchString { get; set; }
        public SearchDataElement[] ResultList { get; set; }
    }

    public class SearchDataElement
    {
        public static int VIDEO_TYPE = 0;
        public static int CHANNEL_TYPE = 1;
        public int ResultType { get; set; }
        public VideoElementData videoData { get; set; }
        public ChannelElementData channelData { get; set; }
    }

    public class HomeData
    {
        public UserTag[] favoriteTagList { get; set; }
        public HomeVideoListData GeneralList { get;set; }
    }

    public class HomeVideoListData
    {
        public string ListName { get; set; }
        public VideoElementData[] VideoList { get; set; }
        public bool IsEnd { get; set; }
    }

    public class ChannelElementData
    {
        public User ChannelInfo { get; set; }
        public bool isSubscribe { get; set; }
    }
    public class VideoElementData
    {
        public int Channel_id { get; set; }
        public string Channel_avatar { get; set; }
        public string Channel_name { get; set; }
        public Video Video { get; set; }
        public int Watch_time { get; set; }
    }

    public class UserTag
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class ChannelVideoElementData
    {
        public Video Video { get; set; }
        public int Watch_time { get; set; }
    }

    public class ChannelData
    {
        public ChannelVideoElementData[] VideoList { get; set; }
        public User User { get; set; }
        public bool IsSubscriber { get; set; }
    }

    public class WatchData
    {
        public Video Video { get; set; }
        public User User { get; set; }
        public bool IsSubscriber { get; set; }
        public CommentElementData[] Comments { get; set; }
    }

    public class CommentElementData
    {
        public int OwnerID { get; set; }
        public string OwnerAvatar { get; set; }
        public string OwnerName { get; set; }
        public VideoComment Comment { get; set; }
    }
}