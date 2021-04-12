using p3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace p3.Controllers
{
    public class HomeController : Controller
    {
        private MainDBContext db = new MainDBContext();
        public static int MAXIMUM_VIDEO_PER_PAGE = 20;
        public static int MAXIMUM_FAVORITE_TAG_LOADED = 11;
        // GET: Home
        public ActionResult Index()
        {
            try
            {
                HomeData homeData = this.loadHomePageData();

                ViewBag.homeData = homeData;
                return View("Home");
            }catch(Exception e)
            {
                //ViewBag.error = e.Message;
                //return View("Error");

                return Json(e, JsonRequestBehavior.AllowGet);
            }
        } 

        public ActionResult get_by_tag(string t_id,string index="0")
        {
            try
            {
                int tagID = Convert.ToInt32(t_id);
                int userID = (Session["userID"] != null) ? Convert.ToInt32(Session["userID"]) : -1;
                int videoIndex = Convert.ToInt32(index);

                if (tagID >= 0)
                {                
                    HomeVideoListData data = new HomeVideoListData();
                    switch (tagID)
                    {
                        case 0:
                            data.VideoList = db.getAllVideo(userID);
                            break;
                        case 1:
                            data.VideoList = db.getMostPopular(userID, MAXIMUM_VIDEO_PER_PAGE, videoIndex);
                            break;
                        case 2:
                            if (userID != -1)
                                data.VideoList = db.getUserPlaylist(userID, MAXIMUM_VIDEO_PER_PAGE, videoIndex);
                            else
                                return new HttpStatusCodeResult(400);
                            break;
                        default:
                            data.VideoList = db.getVideoByTagID(userID, tagID, videoIndex);
                            break;
                    }

                    data.IsEnd = data.VideoList.Length < MAXIMUM_VIDEO_PER_PAGE ? true : false;
                    return Json(data, JsonRequestBehavior.AllowGet);
                }

                return new HttpStatusCodeResult(400);
            }catch(Exception e)
            {
                return Json(e.Message, JsonRequestBehavior.AllowGet);
            }
        }

        //[NonAction]
        public HomeData loadHomePageData(int index=0)
        {
            int userID =  (Session["userID"] != null) ? Convert.ToInt32(Session["userID"]) : -1;

            HomeData homeData = new HomeData();
            VideoElementData[] videoList;
            HomeVideoListData trending = new HomeVideoListData();

            videoList = db.getAllVideo(userID);

            UserTag[] favoriteTagList = db.getFavoriteTagList(userID);

            trending.ListName = "All";
            trending.VideoList = videoList;
            trending.IsEnd = videoList.Length < MAXIMUM_VIDEO_PER_PAGE ? true : false;

            homeData.GeneralList = trending;
            homeData.favoriteTagList = favoriteTagList;
            //return Json(videoList, JsonRequestBehavior.AllowGet);

            return homeData;
        }

        public ActionResult test()
        {
            //try
            //{
            //    return Json(db.getSuggestVideo(0), JsonRequestBehavior.AllowGet);
            //}
            //catch (Exception e)
            //{
            //    return Json(e.InnerException.InnerException, JsonRequestBehavior.AllowGet);
            //}
            return Json(db.getUserPlaylist(0, MAXIMUM_VIDEO_PER_PAGE, 0)
, JsonRequestBehavior.AllowGet);

        }

        public ActionResult watch_history(string index="0")
        {
            try
            {
                if ( Session["userID"] != null)
                {
                    VideoElementData[] list;
                    int userId = Convert.ToInt32(Session["userID"]);
                         
                    list = db.getWatchHistory(userId, 10, Convert.ToInt32(index));
                    return Json(new { VideoList = list, IsEnd = (list.Length < 10 ? true : false) }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return new HttpStatusCodeResult(400);
                }
            }
            catch(Exception e)
            {
                return Json(e.InnerException.Message, JsonRequestBehavior.AllowGet);
            }
        }
    }
}