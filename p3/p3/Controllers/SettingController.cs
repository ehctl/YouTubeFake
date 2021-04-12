using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace p3.Controllers
{
    public class SettingController : Controller
    {
        // GET: Setting
        public ActionResult Index()
        {
            if (Session["username"] == null)
            {
                return RedirectToAction("login", "authentication");
            }
            return View("Setting");
        }
    }
}