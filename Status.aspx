<%@ Page Title="" Language="C#" Trace="false" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Status.aspx.cs" Inherits="SC.Status" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentBody" runat="server">
<table>
<tr>
<td><asp:Label ID="SearchLabelLabel" runat="server" Text="Keyword:"></asp:Label></td>
<td><asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox></td>
<td><asp:Label ID="CommentLabel" runat="server" Text="Commented:"></asp:Label></td>
<td><asp:DropDownList ID="CommentedDropDown" EnableViewState="true" runat="server"></asp:DropDownList></td>
<td><asp:Label ID="Label1" runat="server" Text="Liked:"></asp:Label></td>
<td><asp:DropDownList ID="LikeDropDown" EnableViewState="true" runat="server"></asp:DropDownList></td>
<td><asp:Button ID="SearchButton" runat="server" Text="Search Status" 
        onclick="SearchButton_Click" /></td>
</tr>
   
</table>
    
   
<asp:GridView Width="100%" ID="CommentGridview"  runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" GridLines="None" DataSourceID="StatusDataSource" 
        EnableModelValidation="True">
    <Columns>
        <asp:BoundField DataField="Message" ItemStyle-Width="400" HeaderText="Status" ReadOnly="True" 
            SortExpression="Message" />
        <asp:BoundField DataField="MessageTime" HeaderText="Date" 
            ReadOnly="True" SortExpression="MessageTime" />
         <asp:TemplateField HeaderText="Likes" SortExpression="Likes">
            <ItemTemplate>
                <a rel="gb_page_center[600, 400]" href='Comments.aspx?type=2&statusid=<%#Eval("StatusID")%>'><%#Eval("Likes")%> </a>
            </ItemTemplate>
            </asp:TemplateField>
        <asp:TemplateField HeaderText="Comments" SortExpression="CommentCount">
            <ItemTemplate>
                <a rel="gb_page_center[800, 600]" href='Comments.aspx?type=1&statusid=<%#Eval("StatusID")%>'><%#Eval("CommentCount")%> </a>
            </ItemTemplate>
            </asp:TemplateField>
    </Columns>
    </asp:GridView>

        <asp:ObjectDataSource ID="StatusDataSource" runat="server"
                TypeName="SC.DBData" SelectMethod="GetStatusMessages" EnablePaging="true"
                SelectCountMethod="GetRowCount" StartRowIndexParameterName="startRow"
                MaximumRowsParameterName="pageSize" SortParameterName="sortColumns" OnObjectCreated="DBData_ObjectCreated">
        </asp:ObjectDataSource>


</asp:Content>
