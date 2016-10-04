<%@ Control language="vb" Inherits="ASPNetPortal.QuickLinks" CodeBehind="quicklinks.ascx.vb" AutoEventWireup="false" %>

<hr noshade size="1pt" width="98%">

<span class="SubSubHead">Quick Launch</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<asp:hyperlink id="EditButton" cssclass="CommandButton" EnableViewState="false" runat="server" />

<asp:DataList id="myDataList" CellPadding="4" Width="100%" EnableViewState="false" runat="server">
    <ItemTemplate>
        <span class="Normal">
            <asp:HyperLink id="editLink" ImageUrl="<%# linkImage %>" NavigateUrl='<%# "~/DesktopModules/EditLinks.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ItemID") & "&mid=" & ModuleId %>' runat="server" />
            <a href='<%# DataBinder.Eval(Container.DataItem,"Url") %>'>
                <%# DataBinder.Eval(Container.DataItem,"Title") %>
            </a></span>
        <br>
    </ItemTemplate>
</asp:DataList>

<br>
