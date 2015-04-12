using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SC
{
    public partial class Status : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            CheckForCookie();

            if (!Page.IsPostBack)
            {
                string FBUID = "";
                if (Request["SessionID"] != null)
                {
                    FBUID = Request["SessionID"].ToString();
                    LoadCombos(FBUID);
                }
            }

        }

        private void LoadCombos(string FBUID)
        {
            DBData info = new DBData();

            DataSet dsFriends = info.GetDistinctListOfCommentedFriends(FBUID);

            CommentedDropDown.DataSource = dsFriends;
            CommentedDropDown.DataTextField = "FBFrom";
            CommentedDropDown.DataValueField = "FromFBUID";
            CommentedDropDown.DataBind();

            CommentedDropDown.Items.Insert(0, "");



            LikeDropDown.DataSource = info.GetDistinctListOfLikedFriends(FBUID);
            LikeDropDown.DataTextField = "FBFrom";
            LikeDropDown.DataValueField = "FBLikeID";
            LikeDropDown.DataBind();

            LikeDropDown.Items.Insert(0, "");

        }


        private void CheckForCookie()
        {
            HttpCookie cookie = Request.Cookies["Status"];
            if (cookie != null)
            {
                 if (Request["SessionID"] != null)
                 {
                     if (cookie["UID"].ToString() != Request["SessionID"].ToString())
                     {
                         Response.Redirect("Default.aspx");
                     }

                 }
                 else
                 {
                     Response.Redirect("Default.aspx");
                 }
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }


        protected void DBData_ObjectCreated(object sender, ObjectDataSourceEventArgs e)
        {
            DBData info = e.ObjectInstance as DBData;
            if (info != null)
            {
                info.SortColumns = "CommentCount DESC";
                if (Request["SessionID"] != null)
                {
                    info.SessionID = Request["SessionID"].ToString();
                    info.Commented = CommentedDropDown.SelectedValue;
                    info.Liked = LikeDropDown.SelectedValue;
                    info.SearchCritera = SearchTextBox.Text;

                }

                //info.SearchCritera = txtSearch.Text;
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            

            CommentGridview.DataBind();
        }
    }
}