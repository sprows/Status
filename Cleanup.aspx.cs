using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SC
{
    public partial class Cleanup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["goo"] != null)
            {
                if (Request.QueryString["goo"] == "tomrocks")
                {
                    DBData info = new DBData();
                    info.CleanUp();
                }
            }
          

        }
    }
}