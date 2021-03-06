﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mobile.aspx.cs" Inherits="SC.mobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
        <meta name="format-detection" content="telephone=no" />
        <!-- WARNING: for iOS 7, remove the width=device-width and height=device-height attributes. See https://issues.apache.org/jira/browse/CB-4323 -->
        <meta property="og:title" content="My biggest stalkers on Facebook!"/>
        <meta property="og:type" content="website"/>
        <meta property="fb:app_id" content="137162329692959"/>
        <meta property="og:url" content=<%=FBPageName%>/>
        <meta property="og:image" content=<%=FBImageName%>/>
        <meta property="og:site_name" content="StatusHistory.com"/>
        <meta property="og:image:width" content="601"/>
        <meta property="og:image:height" content="672"/>  
        <meta property="og:description"
          content="Who is stalking you on Facebook? StatusHistory.com enables you to find out your Facebook top 10 commentors and top 10 likers.  You can also Scroll/Search through your past Facebook statuses"/>
        <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0"/>
       

        <link rel="stylesheet" href="css/skel.css" />
		<link rel="stylesheet" href="css/styleR.css" />
		<link rel="stylesheet" href="css/style-xlarge.css" />
        
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.scrolly.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/init.js"></script>
        <!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->

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

        var CommentedImageName = '';
        var LikedImageName = '';
        var GhostedImageName = '';

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

        

        function FacebookPush(ImageName) {

            FB.ui({
                method: 'feed',
                link: 'http://www.statushistory.com',
                picture: ImageName,
                caption: 'Who is stalking you on Facebook?',
                description: 'StatusHistory.com enables you to find out your Facebook top 10 commentors and top 10 likers.  You can also Scroll/Search through your past Facebook statuses',
            }, function (response) { });

        }

        function ShareStuff(ImageName) {

            //var TheImage = ImageName;
            var TheImage = 'http%3A%2F%2Fwww.statushistory.com%2Fcdn%2F66771c16-700e-4782-8964-b8d5dc3d2a67.png';
            var theURL = 'https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Fwww.statushistory.com&picture=' + TheImage + '&title=My+biggest+stalkers+on+Facebook%21&caption=StatusHistory.com&quote=&description=Who+is+stalking+you+on+Facebook%3F+StatusHistory.com+enables+you+to+find+out+your+Facebook+top+10+commentors+and+top+10+likers.++You+can+also+Scroll%2FSearch+through+your+past+Facebook+statuses';
            window.open(theURL);
        }

        function FacebookShare(desc) {

           

            FB.ui({
                method: 'feed',
                link: 'http://www.statushistory.com',
                picture: 'http://www.statushistory.com/img/Mag173x173.png',
                caption: 'Find out how friends interact with your Facebook page',
                description: desc,
            }, function (response) { });

        }
        ;

      

</script>
        <script type="text/javascript">

            function FacebookPopup(ImageName) {

                FB.ui({
                    method: 'share',
                    href: 'http://www.statushistory.com/mobile.aspx?i=' + ImageName,
                }, function (response) { });


                ////var TheImage = ImageName;
                //var TheImage = 'http://www.statushistory.com/test.png';
                //var theURL = 'https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Fwww.statushistory.com&picture=http%3A%2F%2Fwww.statushistory.com/cdn/' + ImageName + '&title=My+biggest+stalkers+on+Facebook%21&caption=StatusHistory.com&quote=&description=Who+is+stalking+you+on+Facebook%3F+StatusHistory.com+enables+you+to+find+out+your+Facebook+top+10+commentors+and+top+10+likers.++You+can+also+Scroll%2FSearch+through+your+past+Facebook+statuses';
                //window.open(theURL);

            }

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
        <script>
            window.fbAsyncInit = function () {
                FB.Event.subscribe(
                  'ad.loaded',
                  function (placementId) {
                      console.log('Audience Network ad loaded');
                  }
                );
                FB.Event.subscribe(
                  'ad.error',
                  function (errorCode, errorMessage, placementId) {
                      console.log('Audience Network error (' + errorCode + ') ' + errorMessage);
                  }
                );
            };
            (function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = "//connect.facebook.net/en_US/sdk/xfbml.ad.js#xfbml=1&version=v2.5&appId=137162329692959";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
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

                         FB.Event.subscribe(
                             'ad.loaded',
                             function (placementId) {
                                 console.log('Audience Network ad loaded');
                             }
                           );
                         FB.Event.subscribe(
                           'ad.error',
                           function (errorCode, errorMessage, placementId) {
                               console.log('Audience Network error (' + errorCode + ') ' + errorMessage);
                           }
                         );

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
                         }(document, 'script', 'facebook-jssdk'));

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
                 <div id= "MyHeader" data-role="header" style="background-color: #38c;text-shadow:none;font-family:sans-serif;">
                     <h1 style="color:white;">StatusHistory.com</h1>
                     <%--<div align="center"><fb:ad placementid="137162329692959_963758693699981" format="320x50" testmode="false"></fb:ad></div> --%>
	            </div><!-- /header -->
                 
                 <div id="LoginBlock"> 
                      
		            <!-- Header -->
			        <section id="header">
				<div class="inner">
					<span class="icon major fa-cloud"></span>
                    <h2>Who is stalking you on Facebook?</h2>
					<p><h3>StatusHistory.com is a utility that allows you to find out how friends interact with your Facebook page.</h3></p>

                    
                    
                    <p>Find out your Facebook top commentors and top likers. <br />
                        Determine your 'Ghost Friends' or friends who do not interact with your profile <br />
                        Search/Scroll through your past Facebook statuses.</p> 
                    <br />
                    <p>
                    <fb:login-button scope="user_posts,email" data-size="xlarge" onlogin="checkLoginState();">
                  </fb:login-button>
                    </p><br />
                <h2>Log In to get started</h2>
                    
                It may take a few moments to retrieve your data<br />depending on how many statuses you have.
				</div>
			</section>
                    <!-- Two -->
                    <section id="Demo1" class="main style2">
            <div class="container" align="center">
                <h1>How it works</h1>
                 <br /><br /><br /><br />
                <div class="row 150%">
                    
                    <div class="6u 12u$(medium)">
                        <header>
                            <h2>Find out who commented on your statuses the most</h2>
                        </header>
                    </div>
                    <div class="6u$ 12u$(medium) important(medium)">
                        <span class="image"><img src="images/Demo1.PNG" alt="" /></span>
                    </div>
                </div>
               <br /><br />
                <div class="row 150%">
                    <div class="6u 12u$(medium)">
                        <header>
                            <h2>Scroll through all of your past Facebook Statuses</h2>
                        </header>
                    </div>
                    <div class="6u$ 12u$(medium) important(medium)">
                        <span class="image"><img src="images/Demo2.PNG" alt="" /></span>
                    </div>
                </div>
                <br /><br />
                <div class="row 150%">
                    <div class="6u 12u$(medium)">
                        <header>
                            <h2>Quickly search for keywords in your Facebook status history</h2>
                        </header>
                    </div>
                    <div class="6u$ 12u$(medium) important(medium)">
                        <span class="image"><img src="images/Demo3.PNG" alt="" /></span>
                    </div>

                 </div>
                <br /><br />
                <div class="row 150%">
                    <div class="6u 12u$(medium)">
                        <header>
                            <h2>Perform all of the the same features for one of your Fan pages</h2>
                        </header>
                    </div>
                    <div class="6u$ 12u$(medium) important(medium)">
                        <span class="image"><img src="images/Demo4.PNG" alt="" /></span>
                    </div>

                </div>
                
                <br /><br />
                <ul class="actions">
                    <li><a href="#press" class="button scrolly">What they are saying</a></li>
                </ul>
            </div>
        </section>
		            <!-- One -->
			        <section id="press" class="main style1">
				<div class="container">
					<div class="row 150%">
						<div class="6u 12u$(medium)">
							<header class="major">
								<h2>"Find out your top 10 Facebook stalkers ... not only is this beneficial to the average Joe, but it can also be a big help with brands and companies"</h2>
							</header>
						</div>
						<div class="6u$ 12u$(medium) important(medium)">
                            <span class="image fit">
                                <a target="_blank" href="http://www.adweek.com/socialtimes/status-history/437277?red=af"><img src="images/SocialTimes.PNG" alt="" /></a>
                            </span>
						</div>
					</div>
				</div>
			</section>

                    <section id="promo" class="main style1">
            <div class="container">
                <div class="row 150%">
                    <div class="6u 12u$(medium)">
                        <header class="major">
                            <h2>"How to find an old Facebook Post.  'Liked' by over 3 million facebook users"</h2>
                        </header>
                    </div>
                    <div class="6u$ 12u$(medium) important(medium)">
                        <span class="image fit"><a target="_blank" href="http://www.tecmundo.com.br/tutorial/60973-facebook-fazer-encontrar-post-antigo-voce.htm"><img src="images/techmundo.jpg" alt="" /></a></span>
                    </div>
                </div>
            </div>
        </section>

		            <!-- Footer -->
			        <section id="footer">
				<ul class="icons">
					<li><a href="https://www.twitter.com" class="icon alt fa-twitter"><span class="label">Twitter</span></a></li>
					<li><a href="https://www.facebook.com/StatusHistory" class="icon alt fa-facebook"><span class="label">Facebook</span></a></li>
					<!-- <li><a href="#" class="icon alt fa-instagram"><span class="label">Instagram</span></a></li>
					<li><a href="#" class="icon alt fa-github"><span class="label">GitHub</span></a></li>
					<li><a href="#" class="icon alt fa-envelope"><span class="label">Email</span></a></li>-->
				</ul>
				<ul class="copyright">
					<li><a href="http://www.statushistory.com/privacy.html">Privacy</a></li><li><a href="http://www.statushistory.com/terms.html">Terms</a></li><li>&copy; StatusHistory.com</li><li>2015</li>
				</ul>
			</section>

                </div>
                     
                     
                     
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
                
                <div id="SettingsDisplay">
                    Logged in as: <b><span id="userName"></span></b>
                    <br />
                    <div id="PagesLoginBlock" align="center">
                   <%-- <br />
                    Do you want to find out your Facebook top 10 commentors and top 10 likers of your <b>Facebook fan pages</b> you administer?<br /><br />

                    <fb:login-button scope="manage_pages" size="large" onlogin=" DisplayPages();">
                            Read Fan Pages
                        </fb:login-button>
                        <br /><br />--%>
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
                    <br />
                     <h3>Key Stats</h3>
                    <ul id="MyStats" data-role="listview" data-inset="true">
                    </ul>
                    
                    <%--<h4><div align="center">These are your top 10 friends who <b>Commented</b> on your statuses the most in Facebook.  Share this right now with your friends and let them know who are your stalkers!</div></h4>--%>
                    

                   <%-- <div align="center"><a href="#" onclick="FacebookPopup(CommentedImageName);"><img src="img/facebook.png" /></a></div>--%>
                    <div id="TopCommentors"></div>
                    <h4><div align="center">Share with your Facebook friends and let them know who are your biggest Commentors!!</div></h4>
                    <div align="center"><a href="#" style="text-decoration:none" onclick="FacebookPopup(CommentedImageName);"><img src="img/facebook.png" /></a></div>
                    
                    <br /><br /><br />

                   
                    <%--<div align="center"><a href="#" onclick="FacebookPopup(LikedImageName);"><img src="img/facebook.png" /></a></div>--%>
                    <div id="TopLikers"></div>
                    <h4><div align="center">Share with your Facebook friends and let them know who are your biggest Likers!!</div></h4>
                    <div align="center"><a href="#" onclick="FacebookPopup(LikedImageName);"><img src="img/facebook.png" /></a></div>
                    
                    <br /><br /><br />

                   <%-- <h4><div align="center">These are your "Ghost" friends who only commented 1 time on your Facebook.  Share this right now with your friends and let them know who are your "Ghost Friends"!</div></h4>
                    <div align="center"><a href="#" onclick="FacebookPopup(GhostedImageName);"><img src="img/facebook.png" /></a></div>
                    <div id="GhostFriends"></div>
                    <div align="center"><a href="#" onclick="FacebookPopup(GhostedImageName);"><img src="img/facebook.png" /></a></div>--%>
                 
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

            @media only screen 
            and (min-device-width : 320px) 
            and (max-device-width : 480px) {
            /* Styles */
            }

            /* Smartphones (landscape) ----------- */
            @media only screen 
            and (min-width : 321px) {
            /* Styles */
            }

            /* Smartphones (portrait) ----------- */
            @media only screen 
            and (max-width : 320px) {
            /* Styles */
            }

            /* iPads (portrait and landscape) ----------- */
            @media only screen 
            and (min-device-width : 768px) 
            and (max-device-width : 1024px) {
            /* Styles */
            }

            /* iPads (landscape) ----------- */
            @media only screen 
            and (min-device-width : 768px) 
            and (max-device-width : 1024px) 
            and (orientation : landscape) {
            /* Styles */
            }

            /* iPads (portrait) ----------- */
            @media only screen 
            and (min-device-width : 768px) 
            and (max-device-width : 1024px) 
            and (orientation : portrait) {
            /* Styles */
            }

            /* Desktops and laptops ----------- */
            @media only screen 
            and (min-width : 1224px) {
            /* Styles */
            }

            /* Large screens ----------- */
            @media only screen 
            and (min-width : 1824px) {
            /* Styles */
            }

            /* iPhone 4 ----------- */
            @media
            only screen and (-webkit-min-device-pixel-ratio : 1.5),
            only screen and (min-device-pixel-ratio : 1.5) {
            /* Styles */


        </style>
</body>

</html>
