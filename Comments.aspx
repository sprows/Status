<%@ Page Language="C#" Trace="false" AutoEventWireup="true" CodeBehind="Comments.aspx.cs" Inherits="SC.Comments" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<%--<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection"/>--%>
<link rel="stylesheet" href="css/print.css" type="text/css" media="print"/>
<link rel="stylesheet" href="css/grid.css" type="text/css" media="screen, projection"/>
<link rel="stylesheet" id="defaultStyle" href="css/style.css" type="text/css" media="screen, projection" />

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
        //document.getElementById('fb-root').appendChild(e);
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

<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
    <h4><div style="padding-left:10px;padding-right:10px;"><asp:Label Width="100%" ID="StatusLabel" runat="server" Text=""></asp:Label></div></h4>

    <asp:Repeater id="CommentRepeater"  runat="server" >
        <HeaderTemplate>
        <table border="0" cellpadding="2" cellspacing="2" width="100%">
        <tr>
        <td><b>Comments</b></td>
        <td></td>
        <td style="width:250px;"></td>
        <td><b>Created</b></td>
         <td><b>Likes</b></td>
        </tr>
        </HeaderTemplate>

            <ItemTemplate>
            <tr>
            <td> <fb:profile-pic uid='<%#DataBinder.Eval(Container.DataItem, "FromFBUID") %>' size="thumb"></fb:profile-pic></td>
            <td> <%# DataBinder.Eval(Container.DataItem, "FBFrom")%> </td>
            <td> <%# DataBinder.Eval(Container.DataItem, "Comment")%> </td>
            <td> <%# DataBinder.Eval(Container.DataItem, "CommentTime")%> </td>
            <td> <%# DataBinder.Eval(Container.DataItem, "CommentLikes")%> </td>     
            </tr>
            </ItemTemplate>

            <FooterTemplate>
            </table>
            </FooterTemplate>

            </asp:Repeater>

         <asp:Repeater id="LikeRepeater"  runat="server" >
        <HeaderTemplate>
        <table border="0" cellpadding="2" cellspacing="2">
        <tr>
        <td><b>Likes</b></td>
        <td></td>
        </tr>
        </HeaderTemplate>

            <ItemTemplate>
            <tr>
            <td> <fb:profile-pic uid='<%#DataBinder.Eval(Container.DataItem, "FBLikeID") %>' size="thumb"></fb:profile-pic></td>
            <td> <%# DataBinder.Eval(Container.DataItem, "FBFrom")%> </td>   
            </tr>
            </ItemTemplate>

            <FooterTemplate>
            </table>
            </FooterTemplate>

        </asp:Repeater>

        <asp:Repeater id="TopCommentersRepeater"  runat="server" >
        <HeaderTemplate>
        <table border="0" cellpadding="2" cellspacing="2">
        <tr>
        <td><b>Top 10 Commenters</b></td>
        <td></td>
        </tr>
        </HeaderTemplate>

            <ItemTemplate>
            <tr>
            <td> <fb:profile-pic uid='<%#DataBinder.Eval(Container.DataItem, "FromFBUID") %>' size="thumb"></fb:profile-pic></td>
            <td> <%# DataBinder.Eval(Container.DataItem, "FBFrom")%> </td>
            <td> <%# DataBinder.Eval(Container.DataItem, "PostCount")%> </td>      
            </tr>
            </ItemTemplate>

            <FooterTemplate>
            </table>
            </FooterTemplate>

        </asp:Repeater>

        <asp:Repeater id="TopLikedRepeater"  runat="server" >
        <HeaderTemplate>
        <table border="0" cellpadding="2" cellspacing="2">
        <tr>
        <td><b>Top 10 Likers</b></td>
        <td></td>
        </tr>
        </HeaderTemplate>

            <ItemTemplate>
            <tr>
            <td> <fb:profile-pic uid='<%#DataBinder.Eval(Container.DataItem, "FBLikeID") %>' size="thumb"></fb:profile-pic></td>
            <td> <%# DataBinder.Eval(Container.DataItem, "FBFrom")%> </td> 
             <td> <%# DataBinder.Eval(Container.DataItem, "PostLike")%> </td>        
            </tr>
            </ItemTemplate>

            <FooterTemplate>
            </table>
            </FooterTemplate>

        </asp:Repeater>


    
    </div>
    </form>
</body>
</html>
