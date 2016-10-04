<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Page language="vb" CodeBehind="AddRelatedContent.aspx.vb" AutoEventWireup="false" Inherits="Wrox.Intranet.ContentManagement.Pages.AddRelatedContent" %>
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
									<table width="750">
										<!-- Add the main content here -->
										<tr>
											<td class="Head" vAlign="top" width="100%">Add Related Content
											</td>
										</tr>
										<tr>
											<td>
												<hr noshade size="1">
											</td>
										</tr>
										<tr>
											<td width="100%" valign="top" class="Normal">
												Using this page you can assign related content to the content that you have 
												published.
											</td>
										</tr>
										<tr>
											<td width="100%" valign="top" class="NormalRed">
												<asp:Label ID="ErrorMessage" Runat="server"></asp:Label>
											</td>
										</tr>
										<tr>
											<td width="100%" valign="top" class="Normal">
												<br>
												<asp:Label ID="question" Runat="server" CssClass="Normal">Do you Want to assign related content?</asp:Label>
												<br>
												<asp:RadioButtonList AutoPostBack="true" ID="AssignRelated" Runat="server" CssClass="Normal" Width="58px" RepeatDirection="Horizontal" OnSelectedIndexChanged="AssignRelated_SelectedIndexChanged">
													<asp:ListItem Value="1">Yes</asp:ListItem>
													<asp:ListItem value="0">No</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td>
												<asp:CheckBoxList ID="relContent" Runat="server" DataValueField="ID" DataTextField="Title" CssClass="Normal"></asp:CheckBoxList>
												<br>
											</td>
										</tr>
										<tr align="right">
											<td align="right">
												<asp:LinkButton ID="relCon" Runat="server" Text="Save" class="CommandButton" ForeColor="darkred" BorderWidth="0px">Save</asp:LinkButton>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
