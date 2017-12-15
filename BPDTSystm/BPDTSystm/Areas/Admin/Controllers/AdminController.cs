using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BPDTSystm.Areas.Admin.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin/Admin
        
        public ActionResult NewsFeed()
        {
            return View();
        }
        public ActionResult UsersList()
        {
            return View();
        }
        public ActionResult RegistrationDates()
        {
            return View();
        }
        public ActionResult ExameDates()
        {
            return View();
        }
        public ActionResult Lecturing()
        {
            return View();
        }
        public ActionResult Examinations()
        {
            return View();
        }
        public ActionResult Repeat()
        {
            return View();
        }
    }
}