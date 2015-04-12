<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="SC.Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentBody" runat="server">

<asp:Panel ID="LogonPanel" runat="server">
    <asp:TextBox ID="passwordText" TextMode="Password" runat="server"></asp:TextBox>
    <asp:Button ID="LogonButton"
        runat="server" Text="Logon" onclick="LogonButton_Click" />
</asp:Panel>
<asp:Panel ID="GridPanel" runat="server">
<asp:GridView Width="100%" ID="AdminGridview" runat="server" AllowPaging="True"
        AllowSorting="True" AutoGenerateColumns="False" GridLines="None" OnPageIndexChanging="gridView_PageIndexChanging" OnSorting="gridView_Sorting">
    <Columns>
         <asp:TemplateField HeaderText="Pic">
            <ItemTemplate>
                <a href='http://www.facebook.com/<%#DataBinder.Eval(Container.DataItem, "FBUID") %>'><img src='http://graph.facebook.com/<%#DataBinder.Eval(Container.DataItem, "FBUID") %>/picture?type=small'></img></a>
               <%--<fb:profile-pic uid='<%#DataBinder.Eval(Container.DataItem, "FBUID") %>' size="thumb"></fb:profile-pic>--%>
            </ItemTemplate>
            </asp:TemplateField>
        <asp:BoundField DataField="FBUID" HeaderText="FBUID"  ReadOnly="True" />
        <asp:BoundField DataField="Posts" HeaderText="Posts" SortExpression="Posts" ReadOnly="True" />
        <asp:BoundField DataField="CommentCount" HeaderText="Comments" SortExpression="CommentCount" ReadOnly="True"  />
        <asp:BoundField DataField="Likes" HeaderText="Likes" SortExpression="Likes" ReadOnly="True"  />
        <asp:BoundField DataField="CreatedDate" HeaderText="CreatedDate" SortExpression="CreatedDate" ReadOnly="True"  />
    </Columns>
    </asp:GridView>
 </asp:Panel>

</asp:Content>
