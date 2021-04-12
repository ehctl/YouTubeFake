using p3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using static p3.Models.SearchQuery;

namespace p3.Controllers
{
    public class SearchController : Controller
    {
        private MainDBContext db = new MainDBContext();
        private int MAXIMUM_NUMBER_OF_VIDEO_PER_PAGE = 8;
        private int P1_QUANTITY = 4;

        // GET: Search
        public ActionResult Index(string query,string tracking)
        {
            try
            {
                if (query != null)
                    if (query.Trim().Length > 0)
                    {
                        int userID = Session["userID"] == null ? -1 : Convert.ToInt32(Session["userID"]);
                        SearchQuery sQuery = new SearchQuery();
                        sQuery.User_id = userID;
                        sQuery.Search_query = query;
                        sQuery.Searched_at = DateTime.Now;
                        sQuery.Query_status = 0;

                        db.SearchQueries.Add(sQuery);
                        db.SaveChanges();
                        ViewBag.query = query;

                        JsonResult data = this.Search(query,userID);
                        
                        ViewBag.data = (SearchData)data.Data;
                        ViewBag.query = query;
                        return View("Search");
                    }
                    else
                        throw new Exception();
                else
                    throw new Exception();
            }catch(Exception e)
            {
                ViewBag.error = e.Message;
                return View("Error");
            }
        }

        public ActionResult searchSuggest(string query)
        {
            var queries = db.getQuery(query, 10);

            return Json(queries, JsonRequestBehavior.AllowGet);
        }

        public ActionResult moreVideo(string query,string p1_index,string p2_index)
        {
            int userID = Session["userID"] == null ? -1 : Convert.ToInt32(Session["userID"]);

            if ( query != null)
            {
                var result = Search(query,userID, p1_index, p2_index);

                return result;
            }
            return new HttpStatusCodeResult(400);
        }

        public ActionResult test(string query)
        {
            return Search(query, 0);
        }

        [NonAction]
        public JsonResult Search(String query,int userID,string p1_index = "0" , string p2_index = "0")
        {
            SearchDataElement[] list = db.search(query, userID);

            SearchData data = new SearchData();
            data.SearchString = query;
            data.ResultList = list;
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}