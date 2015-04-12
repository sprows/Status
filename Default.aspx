<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SC.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentBody" runat="server">
<input type="hidden" name="UID" id="UID" value="" />
<input type="hidden" name="JSONStatus" id="JSONStatus" value="" />
<input type="hidden" name="JSONFriend" id="JSONFriend" value="" />
<input type="hidden" name="FriendCount" id="FriendCount" value="" />
<input type="hidden" name="LogonN" id="LogonN" value="" />
<asp:ScriptManager ID="ScriptManager1" 
            runat="server" EnablePageMethods="true">
            <Scripts>
                <asp:ScriptReference Path="PageMethods.js"/>
            </Scripts>
        </asp:ScriptManager>

    <asp:Panel ID="LogonPanel" runat="server">
    <div style="height:700px;">
             <h2 style="text-align:center;">Your Friends.  Your Status.  Your Data.</h2>  
             <h2 style="text-align:center;">Take it back!</h2>
             <br />
             <h3 style="text-align:center;">[Search, Filter, Analyze your Past Facebook Status updates]</h3>
             <h4 style="text-align:center;"><a href="How.aspx">(How it works)</a></h4>
             <br /><br />
             <div style="text-align:center;">    
               <img src="img/get.jpg" style="cursor:pointer" onclick="GoGoGo();" /></div>
              <br /><br />
       
     <table width="100%">
     <tr align="center">
     <td style="white-space:nowrap;"> <div id="Loader" style="width:100%;float: left;"> <h4>Retrieving data from Facebook.  May take a bit depending on how many status updates.</h4><img src="img/ajax-loader.gif" alt="Retrieving data from Facebook ..." /></div></td></tr>
     <tr align="center">
     <td><span style="color:#454545;font-size:40px;line-height:1.5em;"  id="LoaderCount"></span></td>
     </tr>
     </table>
     
     <div style="padding-top:50px;" align="center">
        <table>
        <tr>
        <td><a href='http://www.allfacebook.com/statushistory-delivers-facebooks-most-memorable-2011-06'><img id="Image2" src="img/allfacebook.jpg" style="border-width:0px;" /></a></td><td><a href='http://www.killerstartups.com/Web-App-Tools/statushistory-com-review-facebook-status-updates'><img id="Image3" src="img/logo_Killer_200pxS.gif" style="border-width:0px;" /></a></td>

        <td><a href='http://www.widgetslab.com/2011/06/27/see-the-history-of-your-facebook-status-posts/'><img id="Image4" src="img/widgetslab.gif" style="border-width:0px;" /></a></td>

        </tr>

        </table>
        <div style="text-align:center;">
            <div  style="text-align:center"><fb:like href="http://www.facebook.com/pages/StatusHistorycom/226476307375941" send="true" width="450" show_faces="true"></fb:like></div>
		                            
        </div> 
        </div>
        
      </div> 

      


     </asp:Panel>
     



     <asp:Panel ID="StatPanel" runat="server">
         
         <br /><br />
         <span style="white-space:nowrap;color:#454545;font-size:18px;line-height:1.5em;"><asp:Label  ID="StatusHistoryLabel" runat="server" Text=""></asp:Label></span>
         <div style="text-align:center;">
<div id="Div1" style="text-align:center"><fb:like href="http://www.facebook.com/pages/StatusHistorycom/226476307375941" send="true" width="450" show_faces="true" font=""></fb:like></div>
</div>  
       
         <br /><br />
         <div style="  margin-left:auto;margin-right:auto;width: 22em;">
        
</div>
         <div><h2 style='font-size:30px;'>Quick Facts</h2></div>
         <div style="width:300px;">
         <table >
            <tr><td style="white-space:nowrap;color:#454545;font-size:18px;line-height:1.5em;"><asp:Label  ID="StatusCountLabel" runat="server" Text=""></asp:Label></td></tr>  
            <tr><td style="white-space:nowrap;"><asp:Label style="color:#454545;font-size:40px;line-height:1.5em;" ID="FriendCommentedLabel" runat="server" Text=""></asp:Label> <span style="color:#454545;font-size:18px;line-height:1.5em;">out of</span>  <asp:Label style="color:#454545;font-size:40px;line-height:1.5em;" ID="FriendCountLabel" runat="server" Text=""></asp:Label> <span style="color:#454545;font-size:18px;line-height:1.5em;">friends commented on one of your status updates. </span> <asp:Label style="color:#454545;font-size:40px;line-height:1.5em;" ID="FriendCommentedPercentLabel" runat="server" Text=""></asp:Label></td></tr>
            <tr><td style="white-space:nowrap;"><asp:Label style="color:#454545;font-size:40px;line-height:1.5em;" ID="FriendLikedLabel" runat="server" Text=""></asp:Label> <span style="color:#454545;font-size:18px;line-height:1.5em;">out of</span>  <asp:Label style="color:#454545;font-size:40px;line-height:1.5em;" ID="FriendCountLabel2" runat="server" Text=""></asp:Label> <span style="color:#454545;font-size:18px;line-height:1.5em;">friends "Liked" one of your status updates. </span> <asp:Label style="color:#454545;font-size:40px;line-height:1.5em;" ID="FriendLikedPercentLabel" runat="server" Text=""></asp:Label></td></tr>
            <tr><td style="white-space:nowrap;color:#454545;font-size:18px;line-height:1.5em;"><asp:Label  ID="StatusToCommentLabel" runat="server" Text=""></asp:Label></td></tr>
            <tr><td style="white-space:nowrap;color:#454545;font-size:18px;line-height:1.5em;"><asp:Label  ID="StatusToLikeLabel" runat="server" Text=""></asp:Label></td></tr>  
            <tr><td style="white-space:nowrap;color:#454545;font-size:18px;line-height:1.5em;"><asp:Label  ID="TopFriendCommentLabel" runat="server" Text=""></asp:Label></td></tr> 
            <tr><td style="white-space:nowrap;color:#454545;font-size:18px;line-height:1.5em;"><asp:Label  ID="TopFriendLikeLabel" runat="server" Text=""></asp:Label></td></tr>
            <tr><td style="white-space:nowrap;color:#454545;font-size:18px;line-height:1.5em;"><div id="likedLabel" style="display:none;"><asp:Label   ID="TopStatusComments" runat="server" Text=""></asp:Label></div></td></tr>
            <tr><td style="white-space:nowrap;color:#454545;font-size:18px;line-height:1.5em;"><span style="color:#454545;font-size:18px;line-height:1.5em;"><asp:Label  ID="Label1" runat="server" Text="<span style='color:#454545;font-size:40px;line-height:1.5em;'>'Like'</span> this website to receive a Bonus Quick Fact! "></asp:Label></span> <fb:like href="http://www.facebook.com/pages/StatusHistorycom/226476307375941" show_faces="false" font=""></fb:like></td></tr>
            <tr><td style="white-space:nowrap;color:#454545;font-size:18px;line-height:1.5em;"><asp:Label  ID="TopLikedComments" runat="server" Text=""></asp:Label></td></tr>  
         </table>
         </div>
<div style="text-align:center;">
<div  style="text-align:center"></div>
</div>  
            
        <br /><br />
     
     </asp:Panel>
    <script>

        FB.Event.subscribe('edge.create', function (response) {
         
           document.getElementById('likedLabel').style.display = '';

        });


        if (document.getElementById('Loader') != null) {
            document.getElementById('Loader').style.display = 'none';
        }

        var JSONstring;
        var urlGlobal;
        var untilRecGlobal;
        var RecordCounter = 0;
        var HasDoneLinks = false;


        JSON.stringify = JSON.stringify || function (obj) {
            var t = typeof (obj);
            if (t != "object" || obj === null) {
                // simple data type  
                if (t == "string") obj = '"' + obj + '"';
                return String(obj);
            }
            else {
                // recurse array or object  
                var n, v, json = [], arr = (obj && obj.constructor == Array);
                for (n in obj) {
                    v = obj[n]; t = typeof (v);
                    if (t == "string") v = '"' + v + '"';
                    else if (t == "object" && v !== null) v = JSON.stringify(v);
                    json.push((arr ? "" : '"' + n + '":') + String(v));
                }
                return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
            }
        };

        function TellFriendsComments() {

            FB.ui(
                   {
                       method: 'feed',
                       name: 'StatusHistory.com',
                       link: 'http://www.StatusHistory.com',
                       picture: 'http://www.statushistory.com/img/StatusH.jpg',
                       caption: 'Discover your Top 10 Commenters at StatusHistory.com',
                       description: '<% =_Top10FriendsComment %>'
                   },
                   function (response) {
                       if (response && response.post_id) {
                           //alert('Post was published.');
                       } else {
                           //alert('Post was not published.');
                       }
                   }
                 );

               }

               function TellFriendsLikes() {

                   FB.ui(
                   {
                       method: 'feed',
                       name: 'StatusHistory.com',
                       link: 'http://www.StatusHistory.com',
                       picture: 'http://www.statushistory.com/img/StatusH.jpg',
                       caption: 'Discover your Top 10 Likers at StatusHistory.com',
                       description: '<% =_Top10FriendsLiked %>'
                   },
                   function (response) {
                       if (response && response.post_id) {
                           //alert('Post was published.');
                       } else {
                           //alert('Post was not published.');
                       }
                   }
                 );

               }

               function TellFriendsStatus() {

                   FB.ui(
                   {
                       method: 'feed',
                       name: 'StatusHistory.com',
                       link: 'http://www.StatusHistory.com',
                       picture: 'http://www.statushistory.com/img/StatusH.jpg',
                       caption: 'Discover your Top Status at StatusHistory.com',
                       description: '<% =_TopComment %>'
                   },
                   function (response) {
                       if (response && response.post_id) {
                           //alert('Post was published.');
                       } else {
                           //alert('Post was not published.');
                       }
                   }
                 );

               }


               

        


        function OnDone(result, userContext, methodName) {


            if (!HasDoneLinks) {
                
                HasDoneLinks = true;
                BuildMe('links');
            }
            else {

                DoneDone();

            }
           

        }

        function OnS(result, userContext, methodName) {

   
            Build(JSONstring, urlGlobal, untilRecGlobal);


        }

        function OnF(error, userContext, methodName) {

            alert('error: ' + error.get_message());

        }


        function GoGoGo() {
		
	    FB.init({ appId: '<%=ConfigurationManager.AppSettings["ApplicationKey"] %>', status: true, cookie: true,
                xfbml: true, oauth: true
            });


            FB.login(function (response) {
                if (response.authResponse) {
                    console.log('Welcome!  Fetching your information.... ');
                    ProcessStuff();
                } else {
                    console.log('User cancelled login or did not fully authorize.');
                }
            }, { scope: 'read_stream' });

        }


        function ProcessStuff() {

            //http://developers.facebook.com/docs/reference/api/user/ -Graph Permission API - For Logon

            BuildMe('statuses');


//            FB.api(
//                         {
//                             method: 'fql.query',
//                             query: 'SELECT name FROM user WHERE uid=' + FB.getSession().uid

//                         },
//                            function (response) {
//                                BuildMe('statuses');
//                            }
//                         );

        }


        function CreateStatusArray(status) {

            var StatusArray = [];

            for (i = 0; i < status.data.length; i++) {

                var StatusOBJ = new Object();
                StatusOBJ.message = status.data[i].message;

                if (status.data[i].updated_time != undefined) {
                    StatusOBJ.time = status.data[i].updated_time;
                }
                else if (status.data[i].created_time != undefined) {
                    StatusOBJ.time = status.data[i].created_time;
                }
                
                StatusOBJ.id = status.data[i].id;


                if (status.data[i].likes != undefined) {
                    StatusOBJ.likes = status.data[i].likes.data.length;

                    var LikeArray = [];
                    for (l = 0; l < StatusOBJ.likes; l++) {

                        var LikeOBJ = new Object();
                        LikeOBJ.Likeid = status.data[i].likes.data[l].id;
                        LikeOBJ.LikeFrom = status.data[i].likes.data[l].name;

                        LikeArray.push(LikeOBJ);

                    }

                    StatusOBJ.likeslist = LikeArray;
                }
                else {
                    StatusOBJ.likes = 0;
                }

                //Comments
                if (status.data[i].comments != undefined) {
                    StatusOBJ.CommentLength = status.data[i].comments.data.length;



                    var CommentArray = [];
                    var CommentIDs = [];

                    for (c = 0; c < StatusOBJ.CommentLength; c++) {

                        var CommentOBJ = new Object();
                        CommentOBJ.id = status.data[i].comments.data[c].id;
                        CommentOBJ.from = status.data[i].comments.data[c].from;
                        CommentOBJ.message = status.data[i].comments.data[c].message;
                        CommentOBJ.createdtime = status.data[i].comments.data[c].created_time;

                        if (status.data[i].comments.data[c].likes != undefined) {

                            CommentOBJ.messagelikes = status.data[i].comments.data[c].likes;
                        }
                        else {
                            CommentOBJ.messagelikes = 0;
                        }


                        CommentArray.push(CommentOBJ);

                    }

                    StatusOBJ.Comments = CommentArray;


                }
                else {
                    StatusOBJ.CommentLength = 0;
                }

                StatusArray.push(StatusOBJ);
            }

            return StatusArray;

        }



        function dynamicSort(property) {
            return function (a, b) {
                return (a[property] < b[property]) ? -1 : (a[property] > b[property]) ? 1 : 0;
            }
        }

        function DoneDone() {

            FB.api('/' + FB.getAuthResponse().userID + '/friends?access_token=' + FB.getAuthResponse().accessToken, function (response) {

                if (typeof response.data != "undefined") {
                    document.getElementById("FriendCount").value = response.data.length;
                }

                document.getElementById('JSONStatus').value = 'done'; //JSON.stringify(StatusArray);
                document.getElementById('UID').value = FB.getAuthResponse().userID;

                var theForm = document.forms['aspnetForm'];
                theForm.submit();


            });


        }

        function Build(parJSON, url, untilRec) {

            document.getElementById('LoaderCount').innerHTML = RecordCounter + " <span style='color:#454545;font-size:18px;line-height:1.5em;'>statuses retrieved</span>";

            var StatusArray = CreateStatusArray(parJSON);
            RecordCounter = RecordCounter + StatusArray.length;

            

            var Done = false;

            if (url != undefined) {
                FB.api(url, function (response) {
                    if (response != undefined) {

                        if (response.paging != undefined) {
                            var untilNum = '1'//getQueryVariable('until', response.paging.next);
                            if (response.paging.next != undefined) {
                                var theredirect = response.paging.next;
                                theredirect = theredirect.replace('https://graph.facebook.com', '');

                                JSONstring = response;
                                urlGlobal = theredirect;
                                untilRecGlobal = untilNum;

                                PageMethods.ProccessJSON(JSON.stringify(StatusArray), FB.getAuthResponse().userID, OnS, OnF);

                            }
                            else {
                                //alert(JSON.stringify(StatusArray));
                                PageMethods.ProccessJSON(JSON.stringify(StatusArray), FB.getAuthResponse().userID, OnDone, OnF);
                                //DoneDone(StatusArray);
                            }

                        }
                        else {
                            PageMethods.ProccessJSON(JSON.stringify(StatusArray), FB.getAuthResponse().userID, OnDone, OnF);
                            //alert(response.paging);

                        }

                    }
                    else {
                        alert('response == undefined 2');
                        alert(Object.keys(response));
                    }

                });

            }
        }

        function getQueryVariable(variable, theString) {
            // var query = theString.search.substring(1);
            var vars = theString.split("&");
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                if (pair[0] == variable) {
                    return pair[1];
                }
            }
        }



        function BuildMe(type) {

            document.getElementById('Loader').style.display = '';

            // Kick it off
            FB.api('/' + FB.getAuthResponse().userID + '/' + type + '?access_token=' + FB.getAuthResponse().accessToken, function (response) {

                //alert('/' + FB.getAuthResponse().userID + '/' + type + '?access_token=' + FB.getAuthResponse().accessToken);
                //return;
                if (response != undefined) {

                    if (response.paging != undefined) {
                        if (response.paging.next != undefined) {


                            var theredirect = response.paging.next;
                            theredirect = theredirect.replace('https://graph.facebook.com', '');


                            Build(response, theredirect);

                        }
                    }
                    else {
                        DoneDone();
                    }
                }
            });

        }

</script>
</asp:Content>
