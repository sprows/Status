<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mobile.aspx.cs" Inherits="SC.mobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
        <meta name="format-detection" content="telephone=no" />
        <!-- WARNING: for iOS 7, remove the width=device-width and height=device-height attributes. See https://issues.apache.org/jira/browse/CB-4323 -->
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <meta property="og:title" content="StatusHistory.com"/>
        <meta property="og:type" content="website"/>
        <meta property="og:url" content="http://www.StatusHistory.com/"/>
        <meta property="og:image" content="http://www.statushistory.com/img/Mag173x173.png"/>
        <meta property="og:site_name" content="StatusHistory.com"/>
        <meta property="fb:admins" content="767233921"/>
        <meta property="fb:app_id" content="767233921" />
        <meta property="og:description"
          content="Who are your Facebook friends that interact with your Facebook page the most? StatusHistory.com enables you to find out your Facebook top 10 commentors and top 10 likers.  You can also Scroll/Search through your past Facebook statuses"/>
         
          <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css" />
	    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	    <script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>
        
        <style>
        .content .ui-icon-searchfield::after{
            display:none !important;
        }

        .content .ui-input-search{
            padding:0 10px !important;
        }
        
        ul.someText li {
            font-size:30px;
        }
        
      
    </style>
    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-2623536-3']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

        function TwitterPopup() {
            var width = 575,
            height = 400,
            left = ($(window).width() - width) / 2,
            top = ($(window).height() - height) / 2,
            url = 'https://twitter.com/share?url=http://www.statushistory.com&hashtags=StatusHistory&text=Search past Facebook posts and find out your friends that interact with your Facebook page the most',
            opts = 'status=1' +
                        ',width=' + width +
                        ',height=' + height +
                        ',top=' + top +
                        ',left=' + left;

            window.open(url, 'twitter', opts);

                return false;
            }

            function FacebookPopup() {
            
            FB.ui({
                method: 'share',
                href: 'http://www.statushistory.com/mobile.aspx/',
                }, function(response){});
            }

</script>
        <script type="text/javascript">

            $("#LoginBlock").hide();

            console.log("WP8 WB Log Console samle");

            function DoMe() {
                console.log('in DoMe');
                openFB.StuffMe();
            }


            function login() {

                openFB.login('email,user_posts,manage_pages',
                function () {
                    console.log('Facebook login succeeded');
                },
                function (error) {
                    console.log('Facebook login failed: ' + error.error_description);
                });
            }

            function getInfo() {
                openFB.api({
                    path: '/me',
                    success: function (data) {
                        console.log(JSON.stringify(data));
                        document.getElementById("userName").innerHTML = data.name;
                    },
                    error: errorHandler
                });
            }

            function share() {
                openFB.api({
                    method: 'POST',
                    path: '/me/feed',
                    params: {
                        message: 'Testing Facebook APIs'
                    },
                    success: function () {
                        alert('the item was posted on Facebook');
                    },
                    error: errorHandler
                });
            }


            function revoke() {
                openFB.revokePermissions(
                function () {
                    alert('Permissions revoked');
                },
                errorHandler);
            }

            function errorHandler(error) {
                alert(error.message);
            }

            
          

        </script>
        <title>StatusHistory.com</title>
</head>
<body>
           <div class="app">
          
                 <script>
                     // This is called with the results from from FB.getLoginStatus().
                     function statusChangeCallback(response) {
                         console.log('statusChangeCallback');
                         console.log(response);
                         // The response object is returned with a status field that lets the
                         // app know the current login status of the person.
                         // Full docs on the response object can be found in the documentation
                         // for FB.getLoginStatus().
                         if (response.status === 'connected') {
                             //94853774264
                             openFB.init('<%=ConfigurationManager.AppSettings["ApplicationKey"] %>', 'https://www.facebook.com/connect/login_success.html', window.sessionStorage); //
                             console.log('Value of tokenStore: ' + openFB.tokenStore);
                             openFB.tokenStore['fbtoken'] = response.authResponse.accessToken;

                             // Logged into your app and Facebook.
                             testAPI();
                             TryThis();
                         } else if (response.status === 'not_authorized') {
                             // The person is logged into Facebook, but not your app.
                             document.getElementById('status').innerHTML = 'Please log ' +
                            'into this app.';
                         } else {
                             // The person is not logged into Facebook, so we're not sure if
                             // they are logged into this app or not.
                             document.getElementById('status').innerHTML = 'Please log ' +
                            'into Facebook.';
                         }
                     }

                     // This function is called when someone finishes with the Login
                     // Button.  See the onlogin handler attached to it in the sample
                     // code below.
                     function checkLoginState() {
                         FB.getLoginStatus(function (response) {
                             statusChangeCallback(response);
                         });
                     }
                     //7234266583
                     window.fbAsyncInit = function () {
                         FB.init({
                             appId: '<%=ConfigurationManager.AppSettings["ApplicationKey"] %>',
                             cookie: true,  // enable cookies to allow the server to access 
                             // the session
                             xfbml: true,  // parse social plugins on this page
                             version: 'v2.0' // use version 2.0
                         });

                         // Now that we've initialized the JavaScript SDK, we call 
                         // FB.getLoginStatus().  This function gets the state of the
                         // person visiting this page and can return one of three states to
                         // the callback you provide.  They can be:
                         //
                         // 1. Logged into your app ('connected')
                         // 2. Logged into Facebook, but not your app ('not_authorized')
                         // 3. Not logged into Facebook and can't tell if they are logged into
                         //    your app or not.
                         //
                         // These three cases are handled in the callback function.

                         FB.getLoginStatus(function (response) {
                             statusChangeCallback(response);
                         });

                     };

                     // Load the SDK asynchronously
                     (function (d, s, id) {
                         var js, fjs = d.getElementsByTagName(s)[0];
                         if (d.getElementById(id)) return;
                         js = d.createElement(s); js.id = id;
                         js.src = "//connect.facebook.net/en_US/sdk.js";
                         fjs.parentNode.insertBefore(js, fjs);
                     } (document, 'script', 'facebook-jssdk'));

                     // Here we run a very simple test of the Graph API after login is
                     // successful.  See statusChangeCallback() for when this call is made.
                     function testAPI() {
                         console.log('Welcome!  Fetching your information.... ');
                         FB.api('/me', function (response) {
                             console.log('Successful login for: ' + response.name);
                             //openFB.tokenStore = window.sessionStorage;

                             document.getElementById('status').innerHTML =
        'Thanks for logging in, ' + response.name + '!';
                         });
                     }


                     //                    Collection of Post objects
                     //                    https://developers.facebook.com/docs/graph-api/reference/v2.0/post


                     //                    id
                     //                    story (* optional -- when someone else posted)
                     //                    message (* optional -- when you post)
                     //                    picture (thumbnail jpg to the photo)
                     //                    link (* link to the photo page)
                     //                    source (* A URL to any Flash movie or video file attached to the post.)
                     //                    Name (* Name of the source?)
                     //                    with_tags (list of people if u tagged it)
                     //                    status_type (tagged_in_photo, mobile_status_update, shared_story, added_photos)
                     //                    type (status, photo, 
                     //                    description (info about the message/story)
                     //                    application (* i.e. Windows Phone)
                     //                    updated_time
                     //                    created_date



</script>

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->



<div id="status">
</div>

                 <div data-role="page" class="jqm-demos" data-quicklinks="true">
                 <div data-role="header">
		            <h1>StatusHistory</h1>
	            </div><!-- /header -->
                  <div data-role="content">
                  
                  <span id="SearchStuff">
                        What do you want to search for?<span id="SearchBlock"><input type="search" name="search" id="search-basic" value="" /></span>
                        <button class="btn btn-block"onclick="ProccessSearch();">Search</button>
                        <button class="btn btn-block"onclick="ResetSearch();">Reset</button>
                        <button class="btn btn-block"onclick="SelectRandomPost();">Random</button>
                 <br /><br />
                 
                 <div align="center"><a href="#" onclick="FacebookPopup();"><img src="img/facebook.png" /></a> <a href="#" onclick="TwitterPopup();"><img src="img/Twitter.png" class="twitter-share-button" /></a></div>

                 
                  </span>
                 <div align="center" id="pageNavPosition"></div> 
                 <ul id="MyListView" data-role="listview" data-inset="true  class="ui-listview ui-listview-inset ui-corner-all ui-shadow">
                 </ul>
                 <%--<div id="cmtLike" class="fb-like" data-href="http://www.facebook.com/pages/StatusHistorycom/226476307375941" data-layout="standard" data-action="like" data-show-faces="true" data-share="true"></div>--%>
                 <div id="LoginBlock" align="center">
                        <!--<h1>StatusHistory.com</h1>-->
                        <img src="img/Mag173x173.png" /><br /><br />
                        <b>Who are your Facebook friends that interact with your Facebook page the most?</b><br /><br />StatusHistory.com enables you to find out your Facebook top 10 commentors and top 10 likers.  You can also Scroll/Search through your past Facebook statuses.
                        <br /> <br />
                        <fb:login-button scope="user_posts,email" size="large" onlogin="checkLoginState();">
                            Get Status History
                        </fb:login-button>
                        <br />
                        <br />
                        <br />
                        <b>Find out your top 10s</b><br /><br />
                        <img src="img/info.png" />
                        <br />
                        <br />
                        <br />
                        <b>Scroll through all of your past Posts</b><br /><br />
                        <img src="img/Status.png" />
                        <br />
                        <br />
                        <br />
                        <b>Keyword search your Posts</b><br /><br />
                        <img src="img/Search.png" />
                        <br />
                        <br />
                        <br />
                        <b>Do the same features as your Fan Page</b><br /><br />
                        <img src="img/Settings.png" />

                            
 <br /><br />
	            <div align="center"><a href="http://www.statushistory.com/privacy.html" >[Privacy Policy]</a></div>

 <!--<p>Name: <span id="userName"></span></p>
	           
                            <button class="btn btn-block" onclick="getInfo()">Get My Info</button><br />
                            <button class="btn btn-block" onclick="login()">Get My Status</button>-->
                <br /><br />
                                       
                </div>
                <div id="SettingsDisplay">
                    Logged in as: <b><span id="userName"></span></b>
                    <br />
                    <div id="PagesLoginBlock" align="center">
                    <br />
                    Do you want to find out your Facebook top 10 commentors and top 10 likers of your <b>Facebook fan pages</b> you administer?<br /><br />

                    <fb:login-button scope="manage_pages" size="large" onlogin=" DisplayPages();">
                            Read Fan Pages
                        </fb:login-button>
                        <br /><br />
                    </div>
                    <div id="PagesBlock">
                     <div class="ui-field-contain">
                        <label for="PagesSelect">Pages:</label>
                            <select name="PagesSelect" id="PagesSelectItem">
                            </select>
                    </div>
                    <br />
                    <button class="btn btn-block"onclick="SelectPage();">Get My Page Statuses</button>
                    <button class="btn btn-block"onclick="SelectPageMe();">Get My Statuses</button>
                    <br /><br /><br />
                    </div>
                    Developed by Sprows Solutions LLC
                    <br /><br />
                      <div align="center"><a href="#" onclick="FacebookPopup();"><img src="img/facebook.png" /></a> <a href="#" onclick="TwitterPopup();"><img src="img/Twitter.png" class="twitter-share-button" /></a></div>
	  <br />
	 <div align="center"><a href="http://www.statushistory.com/privacy.html" >[Privacy Policy]</a></div>
                </div>

                <div id="info">
                    <h3>Top 10 commentors</h3>
                    <ul id="TopCommentors" data-role="listview" data-inset="true">
                    </ul>
                    <h3>Top 10 Likers</h3>
                    <ul id="TopLikers" data-role="listview" data-inset="true">
                    </ul>
                      <div align="center"><a href="#" onclick="FacebookPopup();"><img src="img/facebook.png" /></a> <a href="#" onclick="TwitterPopup();"><img src="img/Twitter.png" class="twitter-share-button" /></a></div>
                </div>
                
                </div>
                <div id="myFooter" data-role="footer" data-position="fixed">
                    
                    <div data-role="navbar">
                        <ul>
                            <li><a id="BtnInfo" href="#" data-icon="info" onclick="SelectInfoButton();">Info</a></li>
                            <li><a id="BtnStatus" href="#" data-icon="gear" onclick="SetUpStatus();">Status</a></li>
                            <li><a id="BtnSearch" href="#" data-icon="star" class="ui-btn-active" onclick="SetUpSearch();">Search</a></li>
                            <li><a id="BtnSettings" href="#" data-icon="grid" onclick="SelectSettingButton();">Settings</a></li>
                            
                        </ul>
                    </div><!-- /navbar -->
                </div><!-- /footer -->
                </div>




            </div>

        <script type="text/javascript" src="js/index.js"></script>
        <script type="text/javascript" src="js/openFB.js"></script>
        <script type="text/javascript" src="js/Status.js"></script>
          <script type="text/javascript">
             
        
            
        </script>
       <style type="text/css">    
            .pg-normal {
                color: black;
                font-weight: normal;
                text-decoration: none;    
                cursor: pointer;    
            }
            .pg-selected {
                color: black;
                font-weight: bold;        
                text-decoration: underline;
                cursor: pointer;
            }
        </style>
</body>

</html>
