using Microsoft.Owin;
using Owin;
using System;
using System.Threading.Tasks;
using System.Web;
using System.Web.SessionState;

[assembly: OwinStartup(typeof(p3.Startup1))]

namespace p3
{
    public class Startup1
    {
        public void Configuration(IAppBuilder app)
        {
            // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=316888

            //app.Use((context, next) =>
            //{
            //    HttpContextBase httpContext = context.Get<HttpContextBase>(typeof(HttpContextBase).FullName);
            //    httpContext.SetSessionStateBehavior(SessionStateBehavior.Required);
            //    return next.Invoke();
            //});

            //app.Use(async (hhtpContext, next) =>
            //{
            //    if (hhtpContext.Request.Path.ToString().ToLower() == "/testurl")
            //        await hhtpContext.Response.WriteAsync(System.Web.HttpContext.Current.Session["name"].ToString());
            //    else
            //        await next.Invoke();
            //});
        }
    }
}
