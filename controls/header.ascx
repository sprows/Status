<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="header.ascx.cs" Inherits="SC.controls.header" %>
        <div id="nav">
                <ul>
                <li <%--class="first current"--%>><a href="default.aspx" title="Home">Home</a></li>
                
                <%if (Request.Cookies["Status"] != null)
                  { %>
                <li><a href="Status.aspx?SessionID=<%=Request.Cookies["Status"]["UID"]%>"  title="contact">Search Status</a></li>
                <% } %>
                <li <%--class="first current"--%>><a href="About.aspx"  title="contact">About</a></li>
                <li><a href="How.aspx"  title="contact">How</a></li>
                </ul>
        </div>

<div id="fb-root"></div>
<script src="http://connect.facebook.net/en_US/all.js"></script>
<script>
   
    
    window.fbAsyncInit = function () {
        FB.init({ appId: '<%=ApplicationKey %>', status: true, cookie: true,
            xfbml: true, oauth: true
        });

        //Perform getLogonStatus here after init
        FB.getLoginStatus(function (response) {
            //alert('Callback');
            if (response.status === 'connected') {
                // logged in and connected user, someone you know
                //alert('logged in');
                if (document.getElementById('LogonButton') != null) {
                    document.getElementById('LogonButton').style.display = 'none';
                    SetLogonStatus();
                }
            } else {
                // no user session available, someone you dont know
                //alert('not logged in');
                if (document.getElementById('LogonButton') != null) {
                    document.getElementById('LogonButton').style.display = '';
                }
            }
        });

    };
    (function () {
        var e = document.createElement('script'); e.async = true;
        e.src = document.location.protocol +
      '//connect.facebook.net/en_US/all.js';
        document.getElementById('fb-root').appendChild(e);
    } ());


    

        function LogMeOut() {

            FB.logout(function (response) {
               
            });

            document.getElementById('LogonInfo').style.display = 'none';

            if (document.getElementById('PrePublish') != null) {
                document.getElementById('PrePublish').style.display = '';
            }
            
             if (document.getElementById('PostPublish') != null) {
             
                document.getElementById('PostPublish').style.display = 'none';
             }
            


        }

    

</script>
