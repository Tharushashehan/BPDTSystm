using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BPDTSystmAPI.Controllers
{
    public class ProRataRegistrationAutocompleteController : ApiController
    {
        public IHttpActionResult AutocompleteProrataRegistrationData(Pro_Rata_Registration_Data data)
        {
            return Ok(DA_AdminController.AutocompleteProrataRegistrationData(data));
        }
    }
}
