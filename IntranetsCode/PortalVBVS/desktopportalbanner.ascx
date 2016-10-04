<%@ Import Namespace="ASPNetPortal" %>
<%@ Control CodeBehind="DesktopPortalBanner.ascx.vb" language="vb" AutoEventWireup="false" Inherits="ASPNetPortal.DesktopPortalBanner" %>
<%--

   The DesktopPortalBanner User Control is responsible for displaying the standard Portal
   banner at the top of each .aspx page.

   The DesktopPortalBanner uses the Portal Configuration System to obtain a list of the
   portal's sitename and tab settings. It then render's this content into the page.

--%>
<table width="100%" cellspacing="0" class="HeadBg" border="0">
	<tr valign="top">
		<td colspan="3" class="SiteLink" background="<%= Request.ApplicationPath %>/images/bars.gif" align="right">
			<asp:label id="WelcomeMessage" class="WelcomeMessage" runat="server" />
			<a href="<%= Request.ApplicationPath %>" class="SiteLink">Portal Home</a>
			<span class="Accent">
                |</span>
			<a href="<%= Request.ApplicationPath %>/Docs/Docs.htm" target="_blank" class="SiteLink">
				Portal Documentation</a>
			<%= LogoffLink %>
			&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td width="10" rowspan="2">
			&nbsp;
		</td>
		<td height="40">
			<asp:label id="siteName" CssClass="SiteTitle" EnableViewState="false" runat="server" />
		</td>
	</tr>
	<tr>
		<td>
			<asp:datalist id="tabs" class="TabHolder" repeatdirection="horizontal" EnableViewState="false" runat="server">
				<ItemTemplate>
					<table border="0" cellpadding="0" cellspacing="0" height="28" class="OtherTabsBg">
						<tr>
							<td><img src='<%= Request.ApplicationPath %>/images/unselTL.gif'></td>
							<td background='<%= Request.ApplicationPath %>/images/unselT.gif'></td>
							<td><img src='<%= Request.ApplicationPath %>/images/unselTR.gif'></td>
						</tr>
						<tr>
							<td><img src='<%= Request.ApplicationPath %>/images/unselL.gif'></td>
							<td><a href='<%= Request.ApplicationPath %>/DesktopDefault.aspx?tabindex=<%# Container.ItemIndex %>&tabid=<%# Ctype(Container.DataItem, TabStripDetails).TabId %>' class="OtherTabs"><%# Ctype(Container.DataItem, TabStripDetails).TabName %></a></td>
							<td><img src='<%= Request.ApplicationPath %>/images/unselR.gif'></td>
						</tr>
						<tr>
							<td><img src='<%= Request.ApplicationPath %>/images/unselBL.gif'></td>
							<td background='<%= Request.ApplicationPath %>/images/unselB.gif'></td>
							<td><img src='<%= Request.ApplicationPath %>/images/unselBR.gif'></td>
						</tr>
					</table>
				</ItemTemplate>
				<SelectedItemTemplate>
					<table border="0" cellpadding="0" cellspacing="0" height="28" class="TabBg">
						<tr>
							<td><img src='<%= Request.ApplicationPath %>/images/selTL.gif'></td>
							<td background='<%= Request.ApplicationPath %>/images/selT.gif'></td>
							<td><img src='<%= Request.ApplicationPath %>/images/selTR.gif'></td>
						</tr>
						<tr>
							<td><img src='<%= Request.ApplicationPath %>/images/selL.gif'></td>
							<td><span class="SelectedTab"><%# Ctype(Container.DataItem, TabStripDetails).TabName %></span></td>
							<td><img src='<%= Request.ApplicationPath %>/images/selR.gif'></td>
						</tr>
						<tr>
							<td><img src='<%= Request.ApplicationPath %>/images/selBL.gif'></td>
							<td background='<%= Request.ApplicationPath %>/images/selB.gif'></td>
							<td><img src='<%= Request.ApplicationPath %>/images/selBR.gif'></td>
						</tr>
					</table>
				</SelectedItemTemplate>
			</asp:datalist>
		</td>
	</tr>
</table>
