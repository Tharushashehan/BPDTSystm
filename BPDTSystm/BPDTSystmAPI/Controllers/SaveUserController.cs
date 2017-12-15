using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BPDTSystmAPI.Controllers
{
    public class SaveUserController : ApiController
    {
        [HttpPost]
        public IHttpActionResult SaveUserData(Users_List data)
        {
            return Ok(DA_AdminController.SaveUserData(data));
        }
    }
}
