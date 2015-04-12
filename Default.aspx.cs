using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Web.Script;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Data;

namespace SC
{
   

    public partial class Default : System.Web.UI.Page
    {

        public string _Top10FriendsComment = "";
        public string _Top10FriendsLiked = "";
        public string _TopComment = "";


        protected void Page_Load(object sender, EventArgs e)
        {

            LogonPanel.Visible = true;
            StatPanel.Visible = false;

            

           
                if (Request.Form["JSONStatus"] != null)
                {
                    string jsonStatus = Request.Form["JSONStatus"].ToString();
                    string UID = Request.Form["UID"].ToString();
                    string FriendCount = Request.Form["FriendCount"].ToString();
                   
                 
                    //Add Cookie
                    HttpCookie cookie = Request.Cookies["Status"];
                    if (cookie == null)
                    {
                        cookie = new HttpCookie("Status");
                    }

                    cookie["UID"] = UID;
                    cookie["FriendCount"] = FriendCount;
                    //cookie.Expires = DateTime.Now.AddYears(1);
                    Response.Cookies.Add(cookie);
                    
                    //Insert new cookie
                    DBData info = new DBData();
                    info.InsertStats(UID);

                }


                if (Request.Cookies["Status"] == null)
                {
                    LogonPanel.Visible = true;
                    StatPanel.Visible = false;

                }
                else
                {

                    HttpCookie cookie = Request.Cookies["Status"];
                    string UID = cookie["UID"].ToString();
                    DBData info = new DBData();

                    string FriendCount = cookie["FriendCount"].ToString();
                    string FriendsCommented = info.GetFriendCountWhoCommented(UID).ToString();
                    string FriendsLiked = info.GetFriendCountWhoLiked(UID).ToString();

                    FriendCountLabel.Text = FriendCount;
                    FriendCountLabel2.Text = FriendCount;
                    FriendCommentedLabel.Text = FriendsCommented;
                    FriendLikedLabel.Text = FriendsLiked;

                    if (Convert.ToInt32(FriendCount) > 0)
                    {
                        Double friendCommentRatio = (Convert.ToDouble(FriendsCommented) / Convert.ToDouble(FriendCount));
                        Double friendLikeRatio = (Convert.ToDouble(FriendsLiked) / Convert.ToDouble(FriendCount));

                        FriendCommentedPercentLabel.Text = friendCommentRatio.ToString("%#0.00");
                        FriendLikedPercentLabel.Text = friendLikeRatio.ToString("%#0.00");
                    }


                    String StatusCount = info.GetStatusCount(UID);

                    StatusHistoryLabel.Text = "<div style='text-align:center'>Your Status History has been retrieved from Facebook.</div>";

                    StatusCountLabel.Text = "You have a total of <span style='color:#454545;font-size:40px;line-height:1.5em;'>" + StatusCount + "</span> Statuses.<br/> Take a look <a href='Status.aspx?SessionID=" + UID + "'>here</a> to view, search, filter and scroll through all of your <a href='Status.aspx?SessionID=" + UID + "'>Status Updates</a>";

                    //Status Stats
                    DataSet dsStatusStat = info.GetStatusStat(UID);
                    if (dsStatusStat.Tables[0] != null)
                    {
                        if (dsStatusStat.Tables[0].Rows.Count > 0)
                        {
                            Double StatusCommentRatio = (Convert.ToDouble(dsStatusStat.Tables[0].Rows[0]["CommentCount"]) / Convert.ToDouble(dsStatusStat.Tables[0].Rows[0]["Posts"]));
                            Double LikeCommentRatio = (Convert.ToDouble(dsStatusStat.Tables[0].Rows[0]["likes"]) / Convert.ToDouble(dsStatusStat.Tables[0].Rows[0]["Posts"]));

                            StatusToCommentLabel.Text = "Friends have Commented on your Statuses <span style='color:#454545;font-size:40px;line-height:1.5em;'>" + dsStatusStat.Tables[0].Rows[0]["CommentCount"].ToString() + "</span> times or <span style='color:#454545;font-size:40px;line-height:1.5em;'>" + StatusCommentRatio.ToString("#0.00") +"</span> times per Status. ";
                            StatusToLikeLabel.Text = "Friends have 'Liked' your Statuses <span style='color:#454545;font-size:40px;line-height:1.5em;'>" + dsStatusStat.Tables[0].Rows[0]["likes"].ToString() + "</span> times or <span style='color:#454545;font-size:40px;line-height:1.5em;'>" + LikeCommentRatio.ToString("#0.00") + "</span> times per Status. ";
                        }
                    }

              

                    //Top Friends
                    DataSet dsTopComment = info.GetTopFriends(UID);
                    
                    if (dsTopComment.Tables[0] != null)
                    {
                        if (dsTopComment.Tables[0].Rows.Count > 1)
                        {
                            _Top10FriendsComment = CreateTop10String(dsTopComment.Tables[0].Rows, "Top 10 Commenters on my Status:  ", "PostCount");

                            string TopCommenters = dsTopComment.Tables[0].Rows[0]["FBFrom"].ToString() + @" <fb:profile-pic uid='" + dsTopComment.Tables[0].Rows[0]["FromFBUID"].ToString() + "' size='thumb'></fb:profile-pic> commented on your statuses <span style='color:#454545;font-size:40px;line-height:1.5em;'>" + dsTopComment.Tables[0].Rows[0]["PostCount"].ToString() + "</span> times.<br>";
                            TopCommenters = TopCommenters + dsTopComment.Tables[0].Rows[1]["FBFrom"].ToString() + " <fb:profile-pic uid='" + dsTopComment.Tables[0].Rows[1]["FromFBUID"].ToString() + "' size='thumb'></fb:profile-pic> commented on your statuses <span style='color:#454545;font-size:40px;line-height:1.5em;'>" + dsTopComment.Tables[0].Rows[1]["PostCount"].ToString() + "</span> times.<br> ";
                            TopCommenters = TopCommenters + "Take a look to see all of your <a rel='gb_page_center[800, 600]' href='Comments.aspx?type=3&statusid=" + UID + "'>Top Commenters </a>. Post Top 10 Commenters to your wall! <span style='font-size:40px;line-height:1.5em;'><a href='#' onclick='TellFriendsComments();'>[Share to Wall]</a></span>";
                              TopFriendCommentLabel.Text = TopCommenters;
                        }
                    }

                    //TopLiked
                    DataSet dsTopLiked = info.GetTopLiked(UID);

                    if (dsTopLiked.Tables[0] != null)
                    {
                        if (dsTopLiked.Tables[0].Rows.Count > 1)
                        {
                         

                            _Top10FriendsLiked = CreateTop10String(dsTopLiked.Tables[0].Rows, "Top 10 Likes on my Status:  ", "PostLike");

                            string TopLiked = dsTopLiked.Tables[0].Rows[0]["FBFrom"].ToString() + @" <fb:profile-pic uid='" + dsTopLiked.Tables[0].Rows[0]["FBLikeID"].ToString() + "' size='thumb'></fb:profile-pic> Liked your statuses <span style='color:#454545;font-size:40px;line-height:1.5em;'>" + dsTopLiked.Tables[0].Rows[0]["PostLike"].ToString() + "</span> times.<br> ";
                            TopLiked = TopLiked + dsTopLiked.Tables[0].Rows[1]["FBFrom"].ToString() + @" <fb:profile-pic uid='" + dsTopLiked.Tables[0].Rows[1]["FBLikeID"].ToString() + "' size='thumb'></fb:profile-pic> Liked your statuses <span style='color:#454545;font-size:40px;line-height:1.5em;'>" + dsTopLiked.Tables[0].Rows[1]["PostLike"].ToString() + "</span> times.<br> ";
                            TopLiked = TopLiked + "Take a look to see all of your <a rel='gb_page_center[800, 600]' href='Comments.aspx?type=4&statusid=" + UID + "'>Top Likers </a>.  Post Top 10 Likes to your wall! <span style='font-size:40px;line-height:1.5em;'><a href='#' onclick='TellFriendsLikes();'>[Share to Wall]</a></span>";
                            TopFriendLikeLabel.Text = TopLiked;
                        }
                    }

                    //TopCommented
                    DataSet dsTopComments = info.GetTopComments(UID);
                    if (dsTopComments.Tables[0] != null)
                    {
                        if (dsTopComments.Tables[0].Rows.Count > 0)
                        {
                           
                            _TopComment = "My Top Status has been Commented on " + dsTopComments.Tables[0].Rows[0]["MessageCount"].ToString() + " times.  My Top Status: " + dsTopComments.Tables[0].Rows[0]["message"].ToString();

                            string TopComments = @"<h2 style='font-size:30px;'>Bonus Fact: </h2><span style='color:#454545;font-size:40px;line-height:1.5em;'>" + dsTopComments.Tables[0].Rows[0]["MessageCount"].ToString() + "</span> is the highest Comment count you received on a Status. ";
                            TopComments = TopComments + "Take a look here to see your <a rel='gb_page_center[800, 600]' href='Comments.aspx?type=1&statusid=" + dsTopComments.Tables[0].Rows[0]["StatusID"].ToString() + "'>Top Status </a>. <br/>Post your Top Status to your wall!<span style='font-size:40px;line-height:1.5em;'> <a href='#' onclick='TellFriendsStatus();'>[Share to Wall]</a></span>";
                            TopStatusComments.Text = TopComments;
                        }
                    }

                    
                    LogonPanel.Visible = false;
                    StatPanel.Visible = true;

                   
                }

                

            

          
        }

 
        private string CreateTop10String(DataRowCollection dsTop10, string Top10, string CountString)
        {
         
            int i = 1;

            foreach (DataRow dr in dsTop10)
            {
                Top10 = Top10 + i.ToString() + ") " + dr["FBFrom"].ToString() + " " + dr[CountString].ToString() + " times. ";
                i = i + 1;
            }

           return Top10;

        }


        [WebMethod]
        public static void ProccessJSON(string json, string UID)
        {

            try
            {

                JavaScriptSerializer ser = new JavaScriptSerializer();
                Array oStatus = (Array)ser.DeserializeObject(json);
                DBCommon.ProcessStatus(oStatus, UID);
            }
            catch (Exception ex)
            {
                string foo = ex.ToString();
            }
     
        }
    }
}