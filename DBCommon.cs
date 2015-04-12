using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SC
{
    static public class DBCommon
    {

        public static void ProcessStatus(Array oStatus, string fbUID)
        {
            DBData db = new DBData();

                foreach (object status in oStatus)
                {
                    try
                    {

                        Dictionary<string, object> stat = (Dictionary<string, object>)status;

                        if (stat.Keys.Contains("message"))
                        {
                            string Status = stat["message"].ToString();
                            DateTime StatusTime = Convert.ToDateTime(stat["time"].ToString().Split('T')[0] + ' ' + stat["time"].ToString().Split('T')[1]);
                            string StatusID = stat["id"].ToString();
                            int Likes = (int)stat["likes"];
                            int CommentLength = (int)stat["CommentLength"];

                            Array Comments = new Array[1];
                            if (stat.ContainsKey("Comments"))
                            {
                                Comments = (Array)stat["Comments"];
                            }

                            Array LikesList = new Array[1];
                            if (stat.ContainsKey("likeslist"))
                            {
                                LikesList = (Array)stat["likeslist"];
                            }



                            //Insert
                            string smStatusID = db.InsertStatus(fbUID, StatusID, CommentLength, Likes, Status, StatusTime);


                            foreach (object comment in Comments)
                            {
                                try
                                {

                                    if (comment != null)
                                    {
                                        Dictionary<string, object> comm = (Dictionary<string, object>)comment;

                                        String CommentID = comm["id"].ToString();
                                        Dictionary<string, object> CommentFromDict = (Dictionary<string, object>)comm["from"];
                                        String CommentFrom = CommentFromDict["name"].ToString();
                                        String CommentFromID = CommentFromDict["id"].ToString();
                                        String CommentMessage = comm["message"].ToString();
                                        DateTime CommentTime = Convert.ToDateTime(comm["createdtime"].ToString().Split('T')[0] + ' ' + comm["createdtime"].ToString().Split('T')[1]);
                                        int CommentLikes = (int)comm["messagelikes"];

                                        db.InsertComment(CommentMessage, CommentLikes, CommentTime, CommentID, CommentFrom, CommentFromID, Convert.ToInt32(smStatusID));


                                    }
                                }
                                catch (Exception ex)
                                {
                                    string foo = ex.ToString();
                                }

                            }


                            foreach (object like in LikesList)
                            {
                                try
                                {
                                    if (like != null)
                                    {
                                        Dictionary<string, object> lik = (Dictionary<string, object>)like;

                                        String FBLikeID = lik["Likeid"].ToString();
                                        String FBFrom = lik["LikeFrom"].ToString();

                                        db.InsertLike(FBFrom, FBLikeID, Convert.ToInt32(smStatusID));


                                    }
                                }
                                catch (Exception ex)
                                {
                                    string foo = ex.ToString();
                                }

                            }

                        }

                    }
                    catch (Exception ex)
                    {
                        string foo = ex.ToString();
                    }

                }
           
        }
    }
}