<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Page language="vb" CodeBehind="HrisEditJobTitles.aspx.vb" AutoEventWireup="false" Inherits="ASPNetPortal.Hris.HrisEditJobTitles" %>
<HTML>
	<HEAD>
		<link rel="stylesheet" href='<%= Request.ApplicationPath & "/Portal.css" %>' type="text/css" >
	</HEAD>
	<body leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0" marginheight="0" marginwidth="0">
		<form enctype="multipart/form-data" runat="server">
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
									<table width="500" cellspacing="0" cellpadding="0">
										<tr>
											<td align="left" class="Head">
												Job Title Details
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<hr noshade size="1">
											</td>
										</tr>
									</table>
									<table width="726" cellspacing="0" cellpadding="0" border="0">
										<tr valign="top">
											<td width="100" class="SubHead">
												Title:
											</td>
											<td>
												&nbsp;
											</td>
											<td>
												<asp:TextBox id="TitleField" cssclass="NormalTextBox" width="353" Columns="28" maxlength="150" runat="server" />
											</td>
											<td width="25" rowspan="6">
												&nbsp;
											</td>
											<td class="Normal" width="250">
												<asp:RequiredFieldValidator Display="Static" runat="server" ErrorMessage="You Must Enter a Job Title" ControlToValidate="TitleField" id="RequiredFieldValidator1" />
											</td>
										</tr>
										<tr valign="top">
											<td nowrap class="SubHead">
												Document:&nbsp;
											</td>
											<td>
												&nbsp;
											</td>
											<td class="Normal">
												<input type="file" id="FileUpload" class="Normal" width="300" style="FONT-FAMILY:verdana" runat="server" size="25">
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
