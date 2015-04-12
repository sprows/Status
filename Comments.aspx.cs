using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace SC
{
    public partial class Comments : System.Web.UI.Page
    {
        public string ApplicationKey = ConfigurationManager.AppSettings["ApplicationKey"];
        private string SecretKey = ConfigurationManager.AppSettings["SecretKey"];

        protected void Page_Load(object sender, EventArgs e)
        {

            CommentRepeater.Visible = false;
            LikeRepeater.Visible = false;
            TopCommentersRepeater.Visible = false;
            TopLikedRepeater.Visible = false;

            if (Request.QueryString["statusid"] != null)
            {
                string StatusID = Request.QueryString["statusid"];
                DBData info = new DBData();
 

                if (Request.QueryString["type"].ToString() == "1")
                {
                    StatusLabel.Text = info.GetStatus(StatusID);

                    CommentRepeater.Visible = true;
                    CommentRepeater.DataSource = info.GetComments(StatusID);
                    CommentRepeater.DataBind();
                }
                else if (Request.QueryString["type"].ToString() == "2")
                {
                    StatusLabel.Text = info.GetStatus(StatusID);

                    LikeRepeater.Visible = true;
                    LikeRepeater.DataSource = info.GetLikes(StatusID);
                    LikeRepeater.DataBind();
                }
                else if (Request.QueryString["type"].ToString() == "3")
                {
                    TopCommentersRepeater.Visible = true;
                    TopCommentersRepeater.DataSource = info.GetTopFriends(StatusID.ToString());
                    TopCommentersRepeater.DataBind();
                }
                else if (Request.QueryString["type"].ToString() == "4")
                {
                    TopLikedRepeater.Visible = true;
                    TopLikedRepeater.DataSource = info.GetTopLiked(StatusID.ToString());
                    TopLikedRepeater.DataBind();
                }
                

              
            }

        }
    }
}