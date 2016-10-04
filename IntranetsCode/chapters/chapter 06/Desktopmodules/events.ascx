<%@ Register TagPrefix="Portal" TagName="Title" Src="~/DesktopModuleTitle.ascx"%>
<%@ Control language="vb" Inherits="ASPNetPortal.Events" CodeBehind="Events.ascx.vb" AutoEventWireup="false" %>
<P><portal:title id="Title1" runat="server" EditUrl="~/DesktopModules/EditEvents.aspx" EditText="Add New Event"></portal:title><br>
  <asp:calendar id="myCalendar" runat="server" CellSpacing="4" CellPadding="4" Width="60%">
    <DayStyle CssClass="Normal"></DayStyle>
    <DayHeaderStyle CssClass="NormalBold"></DayHeaderStyle>
    <TitleStyle Font-Size="Larger" Font-Names="Verdana" ForeColor="Maroon" BorderStyle="Solid" BorderColor="#E0E0E0" BackColor="White"></TitleStyle>
    <OtherMonthDayStyle ForeColor="DarkGray"></OtherMonthDayStyle>
  </asp:calendar></P>
<p><SPAN class="Normal">View </SPAN><asp:dropdownlist id="ViewByList" runat="server" AutoPostBack="True" Font-Size="9px" Font-Names="Verdana"></asp:dropdownlist>
  <hr>
  <asp:datalist id="myDataList" runat="server" CellPadding="4" Width="98%">
    <HeaderTemplate>
      <asp:label id="eventsMessage" runat="server" Text="<%# dataListTitle %>" CssClass="ItemTitle">
      </asp:label>
    </HeaderTemplate>
    <ItemTemplate>
      <SPAN class="ItemTitle">
        <asp:HyperLink id="editLink" runat="server" Visible="<%# IsEditable %>" NavigateUrl='<%# "~/DesktopModules/EditEvents.aspx?ItemID=" &amp; DataBinder.Eval(Container.DataItem,"ItemID") &amp; "&amp;mid=" &amp; ModuleId %>' ImageUrl="~/images/edit.gif">
        </asp:HyperLink>
        <asp:Label id="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Title") %>'>
        </asp:Label>
      </SPAN><BR>
      <SPAN class="Normal">
        <I>
          <%# DataBinder.Eval(Container.DataItem,"EventDate","{0:D}") %>
          -
          <%# DataBinder.Eval(Container.DataItem,"WhereWhen") %>
        </I>
      </SPAN><BR>
      <SPAN class="Normal">
        <%# DataBinder.Eval(Container.DataItem,"Description") %>
      </SPAN><BR>
    </ItemTemplate>
  </asp:datalist>
<P></P>
