using p3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace p3.Controllers
{
    public class VideoProviderController : Controller
    {
        MainDBContext db = new MainDBContext();
        int VIDEO_SEGMENT_LENGTH = 10;
        // GET: VideoProvider
        public ActionResult Index(string v,string file_name)
        {
            try
            {
                string path = Server.MapPath("~/Video_Uploaded/" + v + "/") + file_name;

                if (Session["userID"] != null)
                {
                    int userID = Convert.ToInt32(Session["userID"]);
                    string regex = "^segment_([\\d]+).m4s$";

                    Match m = Regex.Match(file_name, regex);
                    if (m.Groups.Count > 1)
                    {
                        int segmentIndex = Convert.ToInt32(m.Groups[1].ToString());
                        if (segmentIndex % 3 == 0 && segmentIndex > 2)
                        {
                            db.updateWatchTimeOfVideo(userID, v, (segmentIndex - 1) * VIDEO_SEGMENT_LENGTH);
                        }
                    }

                }

                //Read the File data into Byte Array.
                byte[] bytes = System.IO.File.ReadAllBytes(path);

                //Send the File to Download.
                return File(bytes, "application/octet-stream", file_name);
            }catch(Exception e)
            {
                return Json(e.Message, JsonRequestBehavior.AllowGet);
            }
        }
    }
}