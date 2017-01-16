using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SC
{
    public partial class mobile : System.Web.UI.Page
    {

        public string FBImageName = "";
        public string FBPageName = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.QueryString["i"] != null)
            {
                FBImageName = "\"http://www.statushistory.com/cdn/" + Request.QueryString["i"] + "\"";
                FBPageName = "\"http://www.statushistory.com/mobile.aspx?i=" + Request.QueryString["i"] + "\"";
            }
            else
            {
                FBImageName = "\"http://www.statushistory.com/cloud.png\"";
                FBPageName = "\"http://www.statushistory.com/mobile.aspx\"";
            }

        }
    }
}