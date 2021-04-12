using Newtonsoft.Json;
using p3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace p3.Controllers
{
    public class WatchController : Controller
    {
        MainDBContext db = new MainDBContext();
        public static int MAXIMUM_COMMENT_PER_FETCH = 20;
        public static int DEFAULT_RATING = 15;
        // GET: Watch
        public ActionResult Index(string v,string t)
        {
            try
            {
                if (v != null)
                {
                    Video video = db.getVideo(v);
                    if (video != null)
                    {
                        WatchData watchElement = GetWatchData(video);
                        ViewBag.watchElement = watchElement;

                        this.db.increaseView(video.Id);
                        if( Session["userID"] != null)
                        {
                            int userID = Convert.ToInt32(Session["userID"]);
                            this.db.ProcessFavoriteTag(userID, video.Id);
                            this.db.AddWatchHistory(userID,video.Id);
                        }

                        if (t != null)
                            ViewBag.defaultTime = Convert.ToInt32(t);
                        else
                            ViewBag.defaultTime = 0;

                        return View("Watch");
                    }
                    else
                    {
                        throw new Exception("Video not found!");
                    }
                }
                else
                    throw new Exception("Invalid parameter");
            }
            catch (Exception e)
            {
                ViewBag.error = e.Message;
                return View("Error");
            }
        }

        public ActionResult test(string v_id)
        {
            try
            {
                var t = db.getFavoriteTagList(0);

                return Json(t, JsonRequestBehavior.AllowGet);
            }catch(Exception e)
            {
                return Json(e.Message, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult Add_comment(FormCollection form)
        {
            if (Session["userID"] != null)
            {
                try
                {
                    string videoID = form["video_id"];
                    string cmt = form["comment"];
                    int userID = Convert.ToInt32(Session["userID"]);
                    db.AddComment(videoID, userID, cmt);

                    return new HttpStatusCodeResult(200);   
                }
                catch (Exception e)
                {
                    return Json(e.InnerException.InnerException);
                }
            }
            else
            {
                return new HttpStatusCodeResult(400);
            }
        }

        [NonAction]
        public WatchData GetWatchData(Video video)
        {
            User user = db.getUser(video.Owner_id);

            bool isSubscribe = Session["userID"] == null ? false : db.isSubscriber((int)Session["userID"], user.Id);
            CommentElementData[] comments = db.getVideoComments(video.Id, MAXIMUM_COMMENT_PER_FETCH);
            Array.Reverse(comments, 0, comments.Length);

            WatchData watchElement = new WatchData();
            watchElement.IsSubscriber = isSubscribe;
            watchElement.User = user;
            watchElement.Video = video;
            watchElement.Comments = comments;

            return watchElement;
        }
    }
}