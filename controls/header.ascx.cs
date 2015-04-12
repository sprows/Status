using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;
//using Facebook.Session;
//using Facebook.Rest;
//using Facebook.Schema;

namespace SC.controls
{
    public partial class header : System.Web.UI.UserControl
    {
        public string ApplicationKey = ConfigurationManager.AppSettings["ApplicationKey"];
        private string SecretKey = ConfigurationManager.AppSettings["SecretKey"];

       // public Api _facebookAPI;
       // public ConnectSession _connectSession;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

      
    }
}