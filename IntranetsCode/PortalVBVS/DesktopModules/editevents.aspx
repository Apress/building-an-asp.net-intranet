<%@ Page language="vb" CodeBehind="editevents.aspx.vb" AutoEventWireup="false" Inherits="ASPNetPortal.EditEvents" %>
<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<HTML>
  <HEAD>
    <link href='<%= Request.ApplicationPath & "/Portal.css" %>' type=text/css 
rel=stylesheet>
  </HEAD>
  <body bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0" marginheight="0" marginwidth="0">
    <form runat="server">
      <table cellSpacing="0" cellPadding="0" width="100%" border="0">
        <tr vAlign="top">
          <td colSpan="2"><portal:banner id="SiteHeader" runat="server"></portal:banner></td>
        </tr>
        <tr>
          <td><br>
            <table cellSpacing="0" cellPadding="4" width="98%" border="0">
              <tr vAlign="top">
                <td width="100">&nbsp;
                </td>
                <td width="*">
                  <table cellSpacing="0" cellPadding="0" width="500">
                    <tr>
                      <td class="Head" align="left">Event Details
                      </td>
                    </tr>
                    <tr>
                      <td colSpan="2">
                        <hr noShade SIZE="1">
                      </td>
                    </tr>
                  </table>
                  <table cellSpacing="0" cellPadding="0" width="750">
                    <tr vAlign="top">
                      <td class="SubHead" width="100">Title:
                      </td>
                      <td rowSpan="5">&nbsp;
                      </td>
                      <td><asp:textbox id="TitleField" runat="server" cssclass="NormalTextBox" width="390" Columns="30" maxlength="150"></asp:textbox></td>
                      <td width="25" colSpan="1" rowSpan="5">&nbsp;
                      </td>
                      <td class="Normal" width="250"><asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" Display="Static" ErrorMessage="You Must Enter a Valid Title" ControlToValidate="TitleField"></asp:requiredfieldvalidator></td>
                    </tr>
                    <tr vAlign="top">
                      <td class="SubHead">Description:
                      </td>
                      <td><asp:textbox id="DescriptionField" runat="server" width="390" Columns="44" TextMode="Multiline" Rows="6"></asp:textbox></td>
                      <td class="Normal"><asp:requiredfieldvalidator id="RequiredFieldValidator2" runat="server" Display="Static" ErrorMessage="You Must Enter a Valid Description" ControlToValidate="DescriptionField"></asp:requiredfieldvalidator></td>
                    </tr>
                    <tr vAlign="top">
                      <td class="SubHead">Time/Location :
                      </td>
                      <td><asp:textbox id="WhereWhenField" runat="server" cssclass="NormalTextBox" width="390" Columns="30" maxlength="150"></asp:textbox></td>
                      <td class="Normal"><asp:requiredfieldvalidator id="RequiredFieldValidator3" runat="server" Display="Static" ErrorMessage="You Must Enter a Valid Time/Location" ControlToValidate="WhereWhenField"></asp:requiredfieldvalidator></td>
                    </tr>
                    <TR>
                      <TD class="SubHead">Authorized View Roles:</TD>
                      <TD><asp:checkboxlist id="AuthViewRoles" runat="server" RepeatColumns="2" Font-Names="Verdana" Font-Size="9px"></asp:checkboxlist></TD>
                      <TD class="Normal"></TD>
                    </TR>
                    <TR>
                      <TD class="SubHead">Event Date:</TD>
                      <TD><asp:textbox id="EventDateField" runat="server" Columns="8" Width="100px" CssClass="NormalTextBox"></asp:textbox></TD>
                      <TD class="Normal"><asp:requiredfieldvalidator id="RequiredFieldValidator4" runat="server" Display="Static" ErrorMessage="You Must Enter a Valid Event Date" ControlToValidate="EventDateField"></asp:requiredfieldvalidator><asp:comparevalidator id="VerifyEventDate" runat="server" Display="Static" ErrorMessage="You Must Enter a Valid EventDate" ControlToValidate="EventDateField" Operator="DataTypeCheck" Type="Date"></asp:comparevalidator></TD>
                    </TR>
                  </table>
                  <p><asp:linkbutton class="CommandButton" id="updateButton" runat="server" BorderStyle="none" Text="Update"></asp:linkbutton>&nbsp;
                    <asp:linkbutton class="CommandButton" id="cancelButton" runat="server" BorderStyle="none" Text="Cancel" CausesValidation="False"></asp:linkbutton>&nbsp;
                    <asp:linkbutton class="CommandButton" id="deleteButton" runat="server" BorderStyle="none" Text="Delete this item" CausesValidation="False"></asp:linkbutton>
                    <hr width="500" noShade SIZE="1">
                    <span class="Normal">Created by <asp:label id="CreatedBy" runat="server"></asp:label> on 
<asp:label id="CreatedDate" runat="server"></asp:label><br></span>
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
