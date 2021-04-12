using p3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace p3.Controllers
{
    public class StudioController : Controller
    {
        MainDBContext db = new MainDBContext();
        // GET: Studio
        public ActionResult Index(string p_index)
        {
            int numberOfPage = 2;
            int STATISTIC_PAGE = 0;
            int UPLOAD_PAGE = 1;
            try
            {
                if (Session["username"] == null)
                {
                    return RedirectToAction("login", "authentication");
                }

                if (p_index == null)
                {
                    ViewBag.pageIndex = UPLOAD_PAGE;
                }
                else
                {
                    int pageIndex = Convert.ToInt32(p_index);
                    if( pageIndex < numberOfPage && pageIndex >= 0)
                        ViewBag.pageIndex = pageIndex;
                    else
                        throw new Exception("Invalid page index");
                }
                return View("Studio");
            }catch(Exception e)
            {
                ViewBag.error = e.Message;
                return View("Error");
            }
        }

        public ActionResult playlist(string op, string v_id)
        {
            try
            {
                if (Session["userID"] == null)
                    throw new Exception("Not allow");
                else {
                    int userID = Convert.ToInt32(Session["userID"]);

                    switch (op)
                    {
                        case "add":
                            {
                                db.AddVideoToPlaylist(userID, v_id);
                                break;
                            }
                        case "remove":
                            {
                                db.RemoveVideoFromPlaylist(userID, v_id);
                                break;
                            }
                        case "default":
                            {
                                return new HttpStatusCodeResult(400);
                            }
                    }

                    return new HttpStatusCodeResult(200);
                }
            }
            catch (Exception e)
            {
                return Json(e.Message, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult check_playlist(string v_id)
        {
            try
            {
                if (Session["userID"] == null)
                    throw new Exception("Not allow");
                else
                {
                    int userID = Convert.ToInt32(Session["userID"]);

                    bool check = db.checkVideoInPlaylist(userID, v_id);

                    return Json(new { isInPlayList= check }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception e)
            {
                return Json(e.Message, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult tag_suggest(string query)
        {
            Tag[] tags = this.db.searchTagByName(query);

            return Json(tags, JsonRequestBehavior.AllowGet);
        }

    }
}