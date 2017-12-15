using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BPDTSystmAPI.Controllers
{
    public class ProrataRegistrationLoadDataController : ApiController
    {
        public IHttpActionResult LoadProrataRegistrationData(Pro_Rata_Registration_Data data)
        {
            return Ok(DA_AdminController.LoadProrataRegistrationData(data));
        }
    }
}
