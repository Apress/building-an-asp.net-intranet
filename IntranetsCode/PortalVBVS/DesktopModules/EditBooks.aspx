<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Page language="vb" CodeBehind="EditBooks.aspx.vb" AutoEventWireup="false" Inherits="ASPNetPortal.EditBooks" %>
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
								<td width="*">
									<table width="520" cellspacing="0" cellpadding="0">
										<tr>
											<td align="left" class="Head">
												Book Details
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<hr noshade size="1">
											</td>
										</tr>
									</table>
									<table width="750" cellspacing="0" cellpadding="0">
										<tr valign="top">
											<td width="100" class="SubHead">
												Title:
											</td>
											<td rowspan="6">
												&nbsp;
											</td>
											<td>
												<asp:TextBox id="TitleField" cssclass="NormalTextBox" width="390" Columns="30" maxlength="100" runat="server" />
											</td>
											<td width="25" rowspan="6">
												&nbsp;
											</td>
											<td class="Normal" width="250">
												<asp:RequiredFieldValidator id="Req1" Display="Static" ErrorMessage="You Must Enter a Valid Title" ControlToValidate="TitleField" runat="server" />
											</td>
										</tr>
										<tr valign="top">
											<td class="SubHead">
												Image URL:
											</td>
											<td>
												<asp:TextBox id="ImageUrlField" cssclass="NormalTextBox" width="390" Columns="30" maxlength="100" runat="server" />
											</td>
											<td class="Normal" width="250">
												<asp:RequiredFieldValidator id="Req2" Display="Static" ErrorMessage="You Must Enter a Valid URL" ControlToValidate="ImageURLField" runat="server" />
											</td>
										</tr>
										<tr valign="top">
											<td class="SubHead" nowrap>
												Authors:
											</td>
											<td>
												<asp:TextBox id="AuthorsField" cssclass="NormalTextBox" width="390" Columns="30" maxlength="100" runat="server" />
											</td>
											<td class="Normal" width="250">
												<asp:RequiredFieldValidator id="Req3" Display="Static" ErrorMessage="You Must Enter a Valid Author List" ControlToValidate="AuthorsField" runat="server" />
											</td>
										</tr>
										<tr valign="top">
											<td class="SubHead" nowrap>
												ISBN:
											</td>
											<td>
												<asp:TextBox id="ISBNField" cssclass="NormalTextBox" width="390" Columns="30" maxlength="100" runat="server" />
											</td>
											<td class="Normal" width="250">
												<asp:RequiredFieldValidator id="Req4" Display="Static" ErrorMessage="You Must Enter a Valid ISBN" ControlToValidate="ISBNField" runat="server" />
											</td>
										</tr>
										<tr valign="top">
											<td class="SubHead">
												Price:
											</td>
											<td>
												<asp:TextBox id="PriceField" runat="server" maxlength="100" Columns="30" width="390" cssclass="NormalTextBox"></asp:TextBox>
											</td>
											<td class="Normal">
												<asp:RequiredFieldValidator id="Req5" Display="Static" ErrorMessage="You Must Enter a Valid Price" ControlToValidate="PriceField" runat="server" />
											</td>
										</tr>
										<tr valign="top">
											<td class="SubHead">
												BuyLink:
											</td>
											<td>
												<asp:TextBox id="BuyLinkField" runat="server" maxlength="100" Columns="30" width="390" cssclass="NormalTextBox"></asp:TextBox>
											</td>
											<td class="Normal">
											</td>
										</tr>
									</table>
									<p>
										<asp:LinkButton id="updateButton" Text="Update" runat="server" CssClass="CommandButton" BorderStyle="none" />
										&nbsp;
										<asp:LinkButton id="cancelButton" Text="Cancel" CausesValidation="False" runat="server" CssClass="CommandButton" BorderStyle="none" />
										&nbsp;
										<asp:LinkButton id="deleteButton" Text="Delete this item" CausesValidation="False" runat="server" CssClass="CommandButton" BorderStyle="none" />
										<hr noshade size="1" width="520">
										<span class="Normal">Created by
                                            <asp:label id="CreatedBy" runat="server" />
                                            on
                                            <asp:label id="CreatedDate" runat="server" />
                                            <br>
                                        </span>
										<br>
										<br>
										<span class="Head">Global Module Settings</span>
										<hr noshade size="1" width="520">
										<table width="750" cellspacing="0" cellpadding="0">
											<tr valign="top">
												<td width="100" class="SubHead">
													Columns:
												</td>
												<td>
													&nbsp;
												</td>
												<td>
													<asp:TextBox id="ColumnsField" cssclass="NormalTextBox" width="390" Columns="30" maxlength="100" runat="server" />
												</td>
												<td width="25">
													&nbsp;
												</td>
											</tr>
										</table>
										<br>
										<asp:LinkButton id="updateGlobalButton" Text="Update" runat="server" CssClass="CommandButton" BorderStyle="none" />
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
