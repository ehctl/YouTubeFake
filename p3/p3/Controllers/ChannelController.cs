using p3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace p3.Controllers
{
    public class ChannelController : Controller
    {
        MainDBContext db = new MainDBContext();
        // GET: Channel
        public ActionResult Index(string id)
        {
            int MAXIMUM_VIDEO_PER_FETCH = 10;
            try
            {
                if (id != null)
                {
                    int channelID = Convert.ToInt32(id);
                    int userID = Session["userID"] == null ? -1 : Convert.ToInt32(Session["userID"]);
                    ChannelVideoElementData[] videoList = db.getChannelVideos(channelID,userID,MAXIMUM_VIDEO_PER_FETCH);

                    var u = db.findChannel(channelID);

                    bool isSubscriber = false;
                    
                    isSubscriber = userID == -1 ? false : db.isSubscriber(userID, channelID);

                    if (u == null)
                    {
                        throw new Exception("No channel found");
                    }
                    else
                    {
                        var channel = new ChannelData();
                        channel.User = u;
                        channel.VideoList = videoList;
                        channel.IsSubscriber = isSubscriber;

                        ViewBag.channel = channel;
                        return View("Channel");
                    }

                    //return Json(subscriber, JsonRequestBehavior.AllowGet);

                }
                else
                    throw new Exception("L01 trong ham");
            }catch(Exception e)
            {
                ViewBag.error = e.Message;
                return View("Error");
            }            
        }        

        [HttpGet]
        public ActionResult subscribe(string c_id,string op)
        {
            if( Session["userID"] == null)
            {
                return new HttpStatusCodeResult(400);
            }
                                
            try
            {
                int userID = (int)Session["userID"];
                int channelID = Convert.ToInt32(c_id);
                //int userID = 0;

                Subscriber subscribeDetail = db.getSubscribeDetail(userID, channelID);
                if (subscribeDetail == null)
                {
                    if (op.Equals("subscribe"))
                    {
                        db.AddSubscriber(c_id, userID, Subscriber.SUBSCRIBE_ACTION);
                        return new HttpStatusCodeResult(200);
                    }
                    else
                    {
                        throw new Exception("A");
                        return new HttpStatusCodeResult(400);
                    }
                }   
                else
                {
                    if (subscribeDetail.Action == Subscriber.SUBSCRIBE_ACTION)
                    {
                        if (op.Equals("unsubscribe"))
                        {
                            db.AddSubscriber(c_id, userID, Subscriber.UNSUBSCRIBE_ACTION);
                            return new HttpStatusCodeResult(200);
                        }
                        else
                        {
                            throw new Exception("B");

                            return new HttpStatusCodeResult(400);
                        }
                    }
                    else
                    {
                        if (op.Equals("subscribe"))
                        {
                            db.AddSubscriber(c_id, userID, Subscriber.SUBSCRIBE_ACTION);
                            return new HttpStatusCodeResult(200);
                        }
                        else
                        {
                            throw new Exception("C");

                            return new HttpStatusCodeResult(400);
                        }
                    }
                }

            }catch(Exception e)
            {
                return Json(e.Message, JsonRequestBehavior.AllowGet);
            }

        }  

    }
}