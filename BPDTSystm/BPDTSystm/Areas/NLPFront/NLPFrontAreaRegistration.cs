using System.Web.Mvc;

namespace BPDTSystm.Areas.NLPFront
{
    public class NLPFrontAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "NLPFront";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "NLPFront_default",
                "NLPFront/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}