using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;


namespace BPDTSystmAPI.Controllers
{
    public class AdminController : ApiController
    {
        //here we create Http post methods api controller to save data
       
        [HttpPost]
        public IHttpActionResult SaveRegularRegistrationData(Regular_Registration_Data data)
        {
            return Ok(DA_AdminController.SaveRegularRegistrationData(data));
        }

    }
}
