using p3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace p3.Controllers
{
    public class AuthenticationController : Controller
    {
        // GET: Authentication
        private MainDBContext db = new MainDBContext();
        public void Index()
        {
        }
        
        [AllowAnonymous]
        public ActionResult Login(string username,string password,string return_url)
        {
            if (Session["username"] == null)
            {
                if (Request.HttpMethod == "GET")
                {
                    ViewBag.op = "LOGIN";
                        ViewBag.returnUrl = return_url;
    
                    return View("LR");
                }
                else if (Request.HttpMethod == "POST")
                {
                    if (username.Trim().Length > 0 && password.Trim().Length > 0)
                    {
                        User user = db.login(username, password);

                        if ( user != null)
                        {
                            switch( user.Account_status)
                            {
                                case 0:
                                    return new HttpStatusCodeResult(HttpStatusCode.PreconditionFailed);
                                case 1:
                                    Session.Add("username", username);
                                    Session.Add("avatar", user.Avatar.Trim());
                                    Session.Add("userID", user.Id);
                                    Session.Add("channelName", user.Channel_name);
                                    return new HttpStatusCodeResult(System.Net.HttpStatusCode.OK);
                            }
                        }
                        else
                        {
                            return new HttpStatusCodeResult(System.Net.HttpStatusCode.NonAuthoritativeInformation);
                        }
                    }
                    return new HttpStatusCodeResult(System.Net.HttpStatusCode.NonAuthoritativeInformation);
                }

                return new HttpStatusCodeResult(400);
            }
            else
            {
                return Redirect("/");
            }
        }

        public ActionResult Register(FormCollection collection)
        {
            if (Session["username"] == null)
            {
                if (Request.HttpMethod == "GET")
                {
                    if (Session["username"] != null)
                        ViewBag.isLoggedIn = true;
                    else
                        ViewBag.isLoggedIn = false;

                    ViewBag.op = "REGISTER";
                    return View("LR");
                }
                else if (Request.HttpMethod == "POST")
                {
                    String username = collection["username"];
                    String password = collection["password"];
                    String email = collection["email"];
                    String firstname = collection["firstname"];
                    String lastname = collection["lastname"];
                    String birthdate = collection["birthdate"];

                    if (!db.checkUserEmail(email))
                    {
                        string activeCode = Helper.RandomString(7);
                        string sadCode = Helper.RandomString(7);

                        password = Helper.EncryptSha256(password + sadCode);

                        User user = db.AddUser(username, firstname, lastname, email, password, birthdate,activeCode,sadCode);
                        sendConfirmationMail(email, activeCode);

                        return Json("Register email successful , Please active this account by click the link we sent to your email !", JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        return Json("This email is being used by another account ! Please using another account !",JsonRequestBehavior.AllowGet);
                    }
                    
                }

                return new HttpStatusCodeResult(400);
            }
            else
            {
                return Redirect("/");
            }
        }

        public ActionResult active(string active_code)
        {
            var user = db.ActiveUser(active_code);
            if (user != null) {
                Session.Add("username", user.Username);
                Session.Add("avatar", user.Avatar.Trim());
                Session.Add("userID", user.Id);
                Session.Add("channelName", user.Channel_name);

                return Redirect("/");
            }
            else
            {
                ViewBag.error = "Error!";
                return View("Error");
            }
        }

        public ActionResult test(string input)
        {
            // return sendConfirmationMail("tuanlinh29720@gmail.com", "adadadadada");
            return null;
        }

        [NonAction]
        public void sendConfirmationMail(string mail,string active_code)
        {

            var body = "<p>Hi there ! Please click in this <a href='https://localhost:44317/authentication/active?active_code=" + active_code+"'> Link </a> to fully register your account !</p> ";
            var message = new MailMessage();
            message.To.Add(new MailAddress(mail));  // replace with valid value 
            message.From = new MailAddress("formyw3b@gmail.com");  // replace with valid value
            message.Subject = "Confirmation mail";
            message.Body = body;
            message.IsBodyHtml = true;

            using (var smtp = new SmtpClient("smtp.gmail.com",587))
            {
                var credential = new NetworkCredential
                {
                    UserName = "formyw3b@gmail.com",  // replace with valid value
                    Password = "tuanlinh"  // replace with valid value
                };

                smtp.UseDefaultCredentials = false;
                smtp.Credentials = credential;
                smtp.EnableSsl = true;
                smtp.SendMailAsync(message);
               // return Json("OKOKOK", JsonRequestBehavior.AllowGet);
            }
        }   

        public ActionResult Logout(string name)
        {
            if (Session["username"] != null)
            {
                Session.Remove("username");
                Session.Remove("userID");
                Session.Remove("avatar");
                Session.Remove("channelName");

            }
            return RedirectToAction("Index", "Home");

        }

    }
}