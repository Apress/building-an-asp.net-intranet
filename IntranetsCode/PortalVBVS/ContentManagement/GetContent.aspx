<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Register TagPrefix="Wrox" TagName="Actions" Src="ContentActionTabs.ascx" %>
<%@ Page language="vb" CodeBehind="GetContent.aspx.vb" AutoEventWireup="false" Inherits="Wrox.Intranet.ContentManagement.Pages.GetContent" %>
<HTML>
	<HEAD>
		<link rel="stylesheet" href='<%= Request.ApplicationPath & "/Portal.css" %>' type="text/css" >
	</HEAD>
	<body leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0" marginheight="0" marginwidth="0">
		<form runat="server">
			<table width="100%" cellspacing="0" cellpadding="0" border="0">
				<tr valign="top">
					<td colspan="2">
						<portal:Banner id="SiteHeader" runat="server" />
					</td>
				</tr>
				<tr>
					<td>
						<br>
						<table width="98%" cellspacing="0" cellpadding="4" border="0">
							<tr valign="top">
								<td width="100">
									&nbsp;
								</td>
								<td width='*'>
									<table width="750" cellpadding="3">
										<!-- Add the main content here -->
										<tr>
											<td class="Head" vAlign="top" width="100%">Read Content
											</td>
										</tr>
										<tr>
											<td>
												<hr noshade size="1">
											</td>
										</tr>
										<tr>
											<td width="100%"><asp:label id="ErrorMessage" CssClass="NormalRed" Runat="server"></asp:label></td>
										</tr>
										<tr>
											<td class="subhead" vAlign="top">
												<asp:Label ID="title" Runat="server" />
											</td>
										</tr>
										<tr>
											<td class="normal" vAlign="top" bgcolor="LightGrey">
												<asp:Label ID="summary" Runat="server" />
											</td>
										</tr>
										<tr>
											<td class="normal" vAlign="top">
												<div runat="server" id="body"></div>
											</td>
										</tr>
										<tr>
											<td align="right">
												<Wrox:Actions Id="Actions" runat="server"></Wrox:Actions>
											</td>
										</tr>
									</table>
									<p>
									<P></P>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
