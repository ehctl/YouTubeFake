using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace p3
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "VideoProvider",
                url: "video_provider/{action}",
                defaults: new { controller = "VideoProvider", action = "Index" }
            );

            routes.MapRoute(
               name: "Authentication",
               url: "authentication/",
               defaults: new { controller = "Authentication",action = "Index" }
           );

            routes.MapRoute(
               name: "search",
               url: "search/",
               defaults: new { controller = "search", action = "Index" }
           );

            routes.MapRoute(
               name: "channel",
               url: "channel/",
               defaults: new { controller = "channel", action = "Index" }
           );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
