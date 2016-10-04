<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Page language="vb" CodeBehind="HrisEditEmployees.aspx.vb" AutoEventWireup="false" Inherits="ASPNetPortal.Hris.HrisEditEmployees" %>
<HTML>
	<HEAD>
		<link href='<%= Request.ApplicationPath + "/Portal.css" %>' type=text/css 
rel=stylesheet>
	</HEAD>
	<body bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0" marginheight="0" marginwidth="0">
		<form encType="multipart/form-data" runat="server">
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<tr vAlign="top">
						<td colSpan="2"><portal:banner id="SiteHeader" runat="server"></portal:banner></td>
					</tr>
					<tr>
						<td><br>
							<table cellSpacing="0" cellPadding="4" width="98%" border="0">
								<TBODY>
									<tr vAlign="top">
										<td width="150">&nbsp;
										</td>
										<td>
											<table cellSpacing="0" cellPadding="0" width="500">
												<tr>
													<td class="Head" align="left">Employee Details
													</td>
												</tr>
												<tr>
													<td colSpan="2">
														<hr noShade SIZE="1">
													</td>
												</tr>
											</table>
											<table cellSpacing="0" cellPadding="0" width="726" border="0">
												<TBODY>
													<tr vAlign="top">
														<td class="SubHead" width="100">Title:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:dropdownlist id="TitleDDL" runat="server" CssClass="Normal">
																<asp:ListItem>Mr</asp:ListItem>
																<asp:ListItem>Mrs</asp:ListItem>
																<asp:ListItem>Miss</asp:ListItem>
																<asp:ListItem>Ms</asp:ListItem>
																<asp:ListItem>Dr</asp:ListItem>
															</asp:dropdownlist></td>
														<td width="25" rowSpan="50">&nbsp;
														</td>
														<td class="Normal" width="250">&nbsp;
														</td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">First Name:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="FirstNameField" runat="server" cssclass="NormalTextBox" width="353" Columns="28" maxlength="50"></asp:textbox></td>
														<td class="Normal" width="250"><asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" Display="Static" ErrorMessage="You must enter a first name" ControlToValidate="FirstNameField"></asp:requiredfieldvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="140">Middle Names:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="MiddleNamesField" runat="server" cssclass="NormalTextBox" width="353" Columns="28" maxlength="50"></asp:textbox></td>
														<td class="Normal" width="250">&nbsp;
														</td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Last Name:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="LastNameField" runat="server" cssclass="NormalTextBox" width="353" Columns="28" maxlength="50"></asp:textbox></td>
														<td class="Normal" width="250"><asp:requiredfieldvalidator id="Requiredfieldvalidator2" runat="server" Display="Static" ErrorMessage="You must enter a last name" ControlToValidate="LastNameField"></asp:requiredfieldvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="150">Ethnic Origin:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:dropdownlist id="EthnicOriginDDL" cssclass="Normal" DataTextField="Description" DataValueField="ID" Runat="server"></asp:dropdownlist></td>
														<td class="Normal" width="250">&nbsp;
														</td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">SSN:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="SSNField" runat="server" cssclass="NormalTextBox" width="200" Columns="28" maxlength="12"></asp:textbox></td>
														<td class="Normal" width="250"><asp:regularexpressionvalidator id="RegularExpressionValidator1" Display="Static" ErrorMessage="Invalid SSN Format NNN-NN-NNNN" ControlToValidate="SSNField" Runat="server" ValidationExpression="^\d{3}-\d{2}-\d{4}$"></asp:regularexpressionvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Home Address:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="HomeAddField" runat="server" cssclass="NormalTextBox" width="353" Columns="28" maxlength="300" TextMode="MultiLine" Rows="4"></asp:textbox></td>
														<td class="Normal" width="250"><asp:requiredfieldvalidator id="Requiredfieldvalidator3" runat="server" Display="Static" ErrorMessage="Home Address is required" ControlToValidate="HomeAddField"></asp:requiredfieldvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Telephone:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="TelephoneNumField" runat="server" cssclass="NormalTextBox" width="200" Columns="28" maxlength="25"></asp:textbox></td>
														<td class="Normal" width="250"><asp:requiredfieldvalidator id="Requiredfieldvalidator4" runat="server" Display="Static" ErrorMessage="Telephone Number is required" ControlToValidate="TelephoneNumField"></asp:requiredfieldvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Bank RT:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="BankRTField" runat="server" cssclass="NormalTextBox" width="100" Columns="28" maxlength="9"></asp:textbox></td>
														<td class="Normal" width="250"><asp:regularexpressionvalidator id="Regularexpressionvalidator2" Display="Static" ErrorMessage="Invalid Routing Transit (NNNNNNNNN)" ControlToValidate="BankRTField" Runat="server" ValidationExpression="^\d{9}$"></asp:regularexpressionvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Bank Account:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="BankAcct" runat="server" cssclass="NormalTextBox" width="180" Columns="28" maxlength="14"></asp:textbox></td>
														<td class="Normal" width="250"><asp:regularexpressionvalidator id="Regularexpressionvalidator3" Display="Static" ErrorMessage="Invalid Account Number (14 digits)" ControlToValidate="BankAcct" Runat="server" ValidationExpression="^\d{14}$"></asp:regularexpressionvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Next of Kin:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="NextOfKinField" runat="server" cssclass="NormalTextBox" width="353" Columns="28" maxlength="300" TextMode="MultiLine" Rows="4"></asp:textbox></td>
														<td class="Normal" width="250"><asp:requiredfieldvalidator id="Requiredfieldvalidator6" runat="server" Display="Static" ErrorMessage="Next of Kin details are required" ControlToValidate="NextOfKinField"></asp:requiredfieldvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">GP Address:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="GPAddressField" runat="server" cssclass="NormalTextBox" width="353" Columns="28" maxlength="300" TextMode="MultiLine" Rows="4"></asp:textbox></td>
														<td class="Normal" width="250"><asp:requiredfieldvalidator id="Requiredfieldvalidator5" runat="server" Display="Static" ErrorMessage="Doctors Address is required" ControlToValidate="GPAddressField"></asp:requiredfieldvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">E-Mail:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="EMailField" runat="server" cssclass="NormalTextBox" width="273px" Columns="28" maxlength="255"></asp:textbox></td>
														<td class="Normal" width="250"><asp:regularexpressionvalidator id="Regularexpressionvalidator5" Display="Static" ErrorMessage="Invalid E-Mail Address" ControlToValidate="EMailField" Runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:regularexpressionvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="150">Site:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:dropdownlist id="SiteDDL" CssClass="Normal" DataTextField="Description" DataValueField="ID" Runat="server" Width="150"></asp:dropdownlist></td>
														<td class="Normal" width="250">&nbsp;
														</td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="150">Status:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:dropdownlist id="StatusDDL" CssClass="Normal" DataTextField="Description" DataValueField="ID" Runat="server" Width="150"></asp:dropdownlist></td>
														<td class="Normal" width="250">&nbsp;
														</td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="150">Job Title:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:dropdownlist id="JobTitleDDL" CssClass="Normal" DataTextField="Title" DataValueField="ID" Runat="server" Width="350"></asp:dropdownlist></td>
														<td class="Normal" width="250">&nbsp;
														</td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" noWrap>Photograph:&nbsp;
														</td>
														<td>&nbsp;
														</td>
														<td class="Normal"><asp:checkbox id="chkUploadPhoto" runat="server" Text="Upload photo to database (will overwrite existing photo)"></asp:checkbox><br>
															<input class="Normal" id="PhotographField" type="file" size="25" name="PhotographField" runat="server" width="300">
															<br>
															<br>
														</td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" noWrap>Contract:&nbsp;
														</td>
														<td>&nbsp;
														</td>
														<td class="Normal"><asp:checkbox id="chkUploadContract" runat="server" Text="Upload Contract to database (will overwrite existing Contract)"></asp:checkbox><br>
															<input class="Normal" id="ContractField" type="file" size="25" name="ContractField" runat="server" width="300">
															<br>
															<br>
														</td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Salary:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="SalaryField" runat="server" cssclass="NormalTextBox" width="100" Columns="28" maxlength="20"></asp:textbox></td>
														<td class="Normal" width="250"><asp:requiredfieldvalidator id="Requiredfieldvalidator7" runat="server" Display="Static" ErrorMessage="Salary is required" ControlToValidate="SalaryField"></asp:requiredfieldvalidator><br>
															<asp:comparevalidator id="CompareValidator3" runat="server" Display="Dynamic" ErrorMessage="Salary cannot be more than 100000" ControlToValidate="SalaryField" Type="Currency" Operator="LessThanEqual" ValueToCompare="100000"></asp:comparevalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Notes:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="NotesField" runat="server" cssclass="NormalTextBox" width="353" Columns="28" maxlength="1000" TextMode="MultiLine" Rows="5"></asp:textbox></td>
														<td class="Normal" width="250"><asp:requiredfieldvalidator id="Requiredfieldvalidator8" runat="server" Display="Static" ErrorMessage="Notes are required" ControlToValidate="NotesField"></asp:requiredfieldvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Health Notes:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="HealthNotesField" runat="server" cssclass="NormalTextBox" width="353" Columns="28" maxlength="1000" TextMode="MultiLine" Rows="5"></asp:textbox></td>
														<td class="Normal" width="250"><asp:requiredfieldvalidator id="Requiredfieldvalidator9" runat="server" Display="Static" ErrorMessage="Health Notes are required" ControlToValidate="HealthNotesField"></asp:requiredfieldvalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Date of Birth:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="DateOfBirthField" runat="server" cssclass="NormalTextBox" width="120" Columns="28"></asp:textbox></td>
														<td class="Normal" width="250"><asp:comparevalidator id="CompareValidator1" runat="server" Display="Static" ErrorMessage="Must be a valid Date" ControlToValidate="DateOfBirthField" Type="Date" Operator="DataTypeCheck"></asp:comparevalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Start Date:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="ReviewBaseDateField" runat="server" cssclass="NormalTextBox" width="120" Columns="28"></asp:textbox></td>
														<td class="Normal" width="250"><asp:comparevalidator id="Comparevalidator2" runat="server" Display="Dynamic" ErrorMessage="Must be a valid Date" ControlToValidate="ReviewBaseDateField" Type="Date" Operator="DataTypeCheck"></asp:comparevalidator></td>
													</tr>
													<tr vAlign="top">
														<td class="SubHead" width="100">Leaving Date:
														</td>
														<td>&nbsp;
														</td>
														<td><asp:textbox id="LeavingDateField" runat="server" cssclass="NormalTextBox" width="120" Columns="28"></asp:textbox></td>
														<td class="Normal" width="250"><asp:comparevalidator id="Comparevalidator4" runat="server" Display="Dynamic" ErrorMessage="Must be a valid Date" ControlToValidate="LeavingDateField" Type="Date" Operator="DataTypeCheck"></asp:comparevalidator></td>
													</tr>
												</TBODY></table>
											<p><asp:linkbutton class="CommandButton" id="updateButton" runat="server" Text="Update" BorderStyle="none"></asp:linkbutton>&nbsp;
												<asp:linkbutton class="CommandButton" id="cancelButton" runat="server" Text="Cancel" BorderStyle="none" CausesValidation="False"></asp:linkbutton>&nbsp;
												<asp:linkbutton class="CommandButton" id="deleteButton" runat="server" Text="Delete this item" BorderStyle="none" CausesValidation="False"></asp:linkbutton>
												<hr width="500" noShade SIZE="1">
												<span class="Normal">Created by <asp:label id="CreatedBy" runat="server"></asp:label>&nbsp;on 
            &nbsp; <asp:label id="CreatedDate" runat="server"></asp:label><BR><br><asp:label id="lblError" runat="server" CssClass="NormalRed" Width="90%"></asp:label></span>
										</td>
									</tr>
								</TBODY></table>
						</td>
					</tr>
				</TBODY></table>
		</form>
		</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></FORM>
	</body>
</HTML>
