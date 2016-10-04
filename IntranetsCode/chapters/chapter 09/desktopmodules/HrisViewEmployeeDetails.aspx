<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Page language="vb" CodeBehind="HrisViewEmployeeDetails.aspx.vb" AutoEventWireup="false" Inherits="ASPNetPortal.Hris.HrisViewEmployeeDetails" %>
<%@ OutputCache Duration="15" VaryByParam="ID" %>
<HTML>
	<HEAD>
		<link href='<%= Request.ApplicationPath & "/Portal.css" %>' type=text/css 
rel=stylesheet>
	</HEAD>
	<body bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0" marginheight="0" marginwidth="0">
		<form encType="multipart/form-data" runat="server">
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="top">
					<td colSpan="2"><portal:banner id="SiteHeader" runat="server"></portal:banner></td>
				</tr>
				<tr>
					<td><br>
						<table cellSpacing="0" cellPadding="4" width="98%" border="0">
							<tr vAlign="top">
								<td width="150">
									<P>&nbsp;
										<asp:image id="Image1" runat="server" Width="120px" Height="160px" BorderWidth="0px"></asp:image></P>
								</td>
								<td>
									<table cellSpacing="0" cellPadding="0" width="500">
										<tr>
											<td class="Head" align="left"><asp:label id="lblName" runat="server">lblName</asp:label>
												<hr noShade SIZE="1">
											</td>
										</tr>
									</table>
									<table cellSpacing="0" cellPadding="0" width="726" border="0">
										<tr vAlign="top">
											<td class="SubHead" width="140">Title:
											</td>
											<td><asp:hyperlink id="hlnkTitle" runat="server" CssClass="Normal">HyperLink</asp:hyperlink></td>
										</tr>
										<TR>
											<TD class="SubHead" width="140">Status:</TD>
											<TD><asp:label id="lblStatus" runat="server" CssClass="Normal">Label</asp:label></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">Site:</TD>
											<TD><asp:label id="lblSite" runat="server" CssClass="Normal">Label</asp:label></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">Age:</TD>
											<TD><asp:label id="lblAge" runat="server" CssClass="Normal">Label</asp:label></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">Start Date:</TD>
											<TD><asp:label id="lblStartDate" runat="server" CssClass="Normal">Label</asp:label></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140"></TD>
											<TD></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">E-Mail:</TD>
											<TD><asp:hyperlink id="hlnkEMail" runat="server" CssClass="Normal">HyperLink</asp:hyperlink></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">Telephone Num:</TD>
											<TD><asp:label id="lblTelephoneNum" runat="server" CssClass="Normal">Label</asp:label></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140"></TD>
											<TD></TD>
										</TR>
										<TR>
											<TD class="SubHead" vAlign="top" width="140">Notes:</TD>
											<TD><asp:textbox id="txtNotes" runat="server" Width="100%" CssClass="Normal" TextMode="MultiLine" Rows="5" ReadOnly="True"></asp:textbox></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140"></TD>
											<TD></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">Review Date:</TD>
											<TD><asp:label id="lblReviewDate" runat="server" CssClass="Normal">Label</asp:label></TD>
										</TR>
									</table>
									<P><asp:panel id="pnlHRAdmin" runat="server" Width="100%" Height="188px" HorizontalAlign="Left"></P>
									<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0">
										<TR>
											<TD class="SubHead" width="140">Salary:</TD>
											<TD><asp:label id="lblSalary" runat="server" Width="352px" CssClass="Normal">Label</asp:label></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">SSN:</TD>
											<TD><asp:label id="lblSSN" runat="server" Width="355px" CssClass="Normal">Label</asp:label></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">Ethnic Origin:</TD>
											<TD><asp:label id="lblEthnicOrigin" runat="server" Width="348px" CssClass="Normal">Label</asp:label></TD>
										</TR>
										<TR>
											<TD class="SubHead" vAlign="top" width="140">Home Address:</TD>
											<TD><asp:textbox id="txtHomeAddress" runat="server" Width="95%" CssClass="Normal" TextMode="MultiLine" Rows="4" ReadOnly="True"></asp:textbox></TD>
										</TR>
										<TR>
											<TD class="SubHead" vAlign="top" width="140">Health Notes:</TD>
											<TD><asp:textbox id="txtHealthNotes" runat="server" Width="95%" CssClass="Normal" TextMode="MultiLine" Rows="4" ReadOnly="True"></asp:textbox></TD>
										</TR>
										<TR>
											<TD class="SubHead" vAlign="top" width="140">Next Of Kin:</TD>
											<TD><asp:textbox id="txtNextOfKin" runat="server" Width="95%" CssClass="Normal" TextMode="MultiLine" Rows="4" ReadOnly="True"></asp:textbox></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">Contract:</TD>
											<TD>
												<asp:HyperLink id="hlnkContract" CssClass="Normal" Target="_new" runat="server">HyperLink</asp:HyperLink></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140"></TD>
											<TD>&nbsp;</TD>
										</TR>
										<TR>
											<TD class="ItemTitle" width="140">Bank Details:</TD>
											<TD></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">Sortcode:</TD>
											<TD><asp:label id="lblBankRT" runat="server" Width="148px" CssClass="Normal">Label</asp:label></TD>
										</TR>
										<TR>
											<TD class="SubHead" width="140">ABA (Account):</TD>
											<TD><asp:label id="lblBankAcct" runat="server" Width="202px" CssClass="Normal">Label</asp:label></TD>
										</TR>
									</TABLE>
									</asp:panel></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
