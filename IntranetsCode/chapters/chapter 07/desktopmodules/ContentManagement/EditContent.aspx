<%@ Page language="vb" CodeBehind="EditContent.aspx.vb" AutoEventWireup="false" Inherits="Wrox.Intranet.ContentManagement.Pages.EditContent" %>
<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Register TagPrefix="ContentEditor" Namespace="Wrox.Intranet.ContentManagement.Components" Assembly="Portal"%>
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
											<td class="Head" vAlign="top" width="100%" colSpan="2">Add Content
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<hr noshade size="1">
											</td>
										</tr>
										<tr>
											<td class="normal" vAlign="top" width="100%" colSpan="2">Using this page you can 
												publish new content. You can also edit the content.
											</td>
										</tr>
										<tr>
											<td width="100%" colSpan="2"><asp:label id="ErrorMessage" CssClass="NormalRed" Runat="server"></asp:label></td>
										</tr>
										<tr>
											<td class="subhead" vAlign="top" width="10%">Title
											</td>
											<td class="normaltextbox" vAlign="top" width="90%"><asp:textbox id="Title" Runat="server" Width="479px"></asp:textbox><asp:requiredfieldvalidator id="ValTitle" Runat="server" Display="Dynamic" ErrorMessage="Please enter content title" ControlToValidate="Title"></asp:requiredfieldvalidator></td>
										</tr>
										<tr>
											<td class="subhead" vAlign="top" width="10%">Summary
											</td>
											<td class="normaltextbox" vAlign="top" width="90%"><asp:textbox id="Summary" Runat="server" Width="491px" MaxLength="5000" TextMode="MultiLine"></asp:textbox><asp:requiredfieldvalidator id="ValSummary" Runat="server" Display="Dynamic" ErrorMessage="Please enter content summary" ControlToValidate="Summary"></asp:requiredfieldvalidator></td>
										</tr>
										<tr>
											<td class="subhead" vAlign="top" noWrap width="10%">Begin Date
											</td>
											<td class="normaltextbox" vAlign="top" width="90%"><asp:textbox id="BeginDate" Runat="server"></asp:textbox><asp:requiredfieldvalidator id="ValBDate" Runat="server" Display="Dynamic" ErrorMessage="Please enter a content scheduled begin date" ControlToValidate="BeginDate"></asp:requiredfieldvalidator><asp:comparevalidator id="VerifyBeginDate" runat="server" Display="Dynamic" ErrorMessage="You Must Enter a Valid Begin Date" ControlToValidate="BeginDate" Type="Date" Operator="DataTypeCheck"></asp:comparevalidator></td>
										</tr>
										<tr>
											<td class="subhead" vAlign="top" noWrap width="10%" height="24">End Date
											</td>
											<td class="normaltextbox" vAlign="top" width="90%" height="24"><asp:textbox id="EndDate" Runat="server"></asp:textbox><asp:requiredfieldvalidator id="ValEDate" Runat="server" Display="Dynamic" ErrorMessage="Please enter content expiry date" ControlToValidate="EndDate"></asp:requiredfieldvalidator><asp:comparevalidator id="VerifyEndDate" runat="server" Display="Dynamic" ErrorMessage="You Must Enter a Valid End Date" ControlToValidate="EndDate" Type="Date" Operator="DataTypeCheck"></asp:comparevalidator></td>
										</tr>
										<tr>
											<td class="subhead" vAlign="top" width="100%" colSpan="2">Content Body
											</td>
										</tr>
										<tr>
											<td class="normaltextbox" vAlign="top" width="100%" colSpan="2"><ContentEditor:RTFEditor id="ContentBody" RichText="<B>Enter content here</B>" Runat="server" Width="656px" Height="198px"></ContentEditor:RTFEditor></td>
										</tr>
									</table>
									<p>
										<asp:LinkButton id="updateButton" Text="Update" runat="server" class="CommandButton" BorderStyle="none" />
										&nbsp;
										<asp:LinkButton id="cancelButton" Text="Cancel" CausesValidation="False" runat="server" class="CommandButton" BorderStyle="none" />
										&nbsp;
										<asp:LinkButton id="deleteButton" Text="Delete" CausesValidation="False" runat="server" class="CommandButton" BorderStyle="none" />
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
