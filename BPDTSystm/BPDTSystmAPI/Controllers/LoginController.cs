using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BPDTSystmAPI.Controllers
{
    public class LoginController : ApiController
    {

        [HttpPost]
        public IHttpActionResult LoginAuthorization(Users_List data)
        {
            return Ok(DA_AdminController.LoginAuthorization(data));
        }
    }
}
