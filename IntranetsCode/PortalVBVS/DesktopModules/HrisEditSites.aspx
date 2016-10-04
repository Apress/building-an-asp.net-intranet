<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Page language="vb" CodeBehind="HrisEditSites.aspx.vb" AutoEventWireup="false" Inherits="ASPNetPortal.Hris.HrisEditSites" %>
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
								<td width="150">
									&nbsp;
								</td>
								<td>
									<table width="500" cellspacing="0" cellpadding="0" border="0">
										<tr>
											<td align="left" class="Head">
												Site Details
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<hr noshade size="1">
											</td>
										</tr>
									</table>
									<table width="750" cellspacing="0" cellpadding="0" border="0">
										<tr valign="top">
											<td width="100" class="SubHead">
												Site Code:
											</td>
											<td rowspan="5">
												&nbsp;
											</td>
											<td align="left">
												<asp:TextBox id="CodeField" cssclass="NormalTextBox" width="80" Columns="30" maxlength="5" runat="server" />
											</td>
											<td width="25" rowspan="5">
												&nbsp;
											</td>
											<td class="Normal" width="250">
												<asp:RequiredFieldValidator Display="Static" runat="server" ErrorMessage="You Must Enter a code" ControlToValidate="CodeField" id="Requiredfieldvalidator2" />
											</td>
										</tr>
										<tr valign="top">
											<td width="100" class="SubHead">
												Description:
											</td>
											<td align="left">
												<asp:TextBox id="DescriptionField" cssclass="NormalTextBox" width="390" Columns="30" maxlength="50" runat="server" />
											</td>
											<td class="Normal" width="250">
												<asp:RequiredFieldValidator Display="Static" runat="server" ErrorMessage="You Must Enter a Description" ControlToValidate="DescriptionField" id="RequiredFieldValidator1" />
											</td>
										</tr>
									</table>
									<p>
										<asp:LinkButton id="updateButton" Text="Update" runat="server" class="CommandButton" BorderStyle="none" />
										&nbsp;
										<asp:LinkButton id="cancelButton" Text="Cancel" CausesValidation="False" runat="server" class="CommandButton" BorderStyle="none" />
										&nbsp;
										<asp:LinkButton id="deleteButton" Text="Delete this item" CausesValidation="False" runat="server" class="CommandButton" BorderStyle="none" />
										<hr noshade size="1" width="500">
										<span class="Normal">Created by
                                            <asp:label id="CreatedBy" runat="server" />&nbsp;on 
                                            &nbsp;
                                            <asp:label id="CreatedDate" runat="server" />
                                            <br>
                                        </span>
										<br>
										<asp:Label id="lblError" runat="server" CssClass="NormalRed" Width="90%"></asp:Label>
									</SPAN>
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
