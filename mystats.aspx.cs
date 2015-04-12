using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SC
{
    public partial class mystats : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string posts = "";
            string likes = "";
            string comments = "";
            string id = "";

            if (Request.QueryString["g"] == "good")
            {
                if (Request.QueryString["p"] != null)
                {
                    posts = Request.QueryString["p"];
                }

                if (Request.QueryString["l"] != null)
                {
                    likes = Request.QueryString["l"];
                }

                if (Request.QueryString["c"] != null)
                {
                    comments = Request.QueryString["c"];
                }

                if (Request.QueryString["id"] != null)
                {
                    id = Request.QueryString["id"];
                }

                DBData db = new DBData();

                try
                {
                    db.InsertStatusStats(id, Convert.ToInt32(likes), Convert.ToInt32(comments), Convert.ToInt32(posts));
                }
                catch (Exception ex)
                {
                    //Ignore
                }
            }

        }
    }
}