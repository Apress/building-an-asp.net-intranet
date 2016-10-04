<%@ Page language="vb" CodeBehind="discussdetails.aspx.vb" AutoEventWireup="false" Inherits="ASPNetPortal.DiscussDetails" %>
<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<HTML>
  <HEAD>
    <link href='<%= Request.ApplicationPath & "/Portal.css" %>' type="text/css" rel="stylesheet">
  </HEAD>
  <body bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0" marginwidth="0" marginheight="0">
    <form runat="server" name="form1">
      <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tr valign="top">
          <td colspan="2">
            <portal:Banner ShowTabs="false" runat="server" id="Banner1" />
          </td>
        </tr>
        <tr valign="top">
          <td width="10%">
            &nbsp;
          </td>
          <td>
            <br>
            <table width="600" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left">
                  <span class="Head">Message Detail</span>
                </td>
                <td align="right">
                  <asp:Panel id="ButtonPanel" runat="server"><A class="CommandButton" id="prevItem" title="Previous Message" runat="server">
                      <IMG 
            src='<%=Request.ApplicationPath & "/images/rew.gif"  %>' 
            border="0"></A>&nbsp; <A class="CommandButton" id="nextItem" title="Next Message" runat="server"><IMG 
            src='<%=Request.ApplicationPath & "/images/fwd.gif"  %>' 
            border="0"></A>&nbsp; 
<asp:LinkButton id="ReplyBtn" runat="server" Text="Reply to this Message" Cssclass="CommandButton" EnableViewState="false"></asp:LinkButton>
                              </asp:Panel>
                </td>
              </tr>
              <tr>
                <td colspan="2">
                  <hr noshade size="1">
                </td>
              </tr>
            </table>
            <asp:panel id="EditPanel" Visible="false" runat="server">
              <TABLE cellSpacing="0" cellPadding="4" width="600" border="0">
                <TR vAlign="top">
                  <TD class="SubHead" width="150">
                    <asp:RequiredFieldValidator 
                        id="TitleRequired" 
                        runat="server" 
                        ErrorMessage="The title can't be blank" 
                        ControlToValidate="TitleField" 
                        Display="Dynamic">*</asp:RequiredFieldValidator>
                    Title:
                  </TD>
                  <TD rowSpan="4">&nbsp;
                  </TD>
                  <TD width="*">
                    <asp:TextBox 
                        id="TitleField" 
                        runat="server" 
                        cssclass="NormalTextBox" 
                        width="500" 
                        columns="40" 
                        maxlength="100" />
                  </TD>
                </TR>
                <TR vAlign="top">
                  <TD class="SubHead">
                    <asp:RequiredFieldValidator
                        id="BodyRequired" 
                        runat="server" 
                        ErrorMessage="The message body can't be blank" 
                        ControlToValidate="BodyField" 
                        Display="Dynamic">*</asp:RequiredFieldValidator>
                    Body:
                  </TD>
                  <TD width="*">
                    <asp:TextBox 
                        id="BodyField" 
                        runat="server" 
                        width="500" 
                        columns="59" 
                        Height="75px" 
                        TextMode="Multiline"
                        Rows="15" />
                    </TD>
                </TR>
                <TR vAlign="top">
                  <TD>&nbsp;
                  </TD>
                  <TD>
                    <asp:LinkButton 
                        class="CommandButton" 
                        id="updateButton" 
                        runat="server" 
                        Text="Submit" />&nbsp;
                    <asp:LinkButton 
                        class="CommandButton" 
                        id="cancelButton" 
                        runat="server" 
                        Text="Cancel" 
                        CausesValidation="False" />&nbsp;
                    <asp:ValidationSummary 
                        id="ValidationSummary1" 
                        runat="server" 
                        ShowMessageBox="True" 
                        ShowSummary="False" 
                        HeaderText="Please correct the following items
                          (marked with a red '*' in the page):" />
                  </TD>
                </TR>
                <TR vAlign="top">
                  <TD class="SubHead">Original Message:
                  </TD>
                  <TD>&nbsp;
                  </TD>
                </TR>
              </TABLE>
            </asp:panel>
            <table width="600" cellspacing="0" cellpadding="4" border="0">
              <tr valign="top">
                <td align="left" class="Message">
                  <b>Subject: </b>
                  <asp:Literal id="Title" runat="server" />
                  <br>
                  <b>Author: </b>
                  <asp:Literal id="CreatedByUser" runat="server" />
                  <br>
                  <b>Date: </b>
                  <asp:Literal id="CreatedDate" runat="server" />
                  <br>
                  <br>
                  <asp:Literal id="Body" runat="server" />
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </form>
  </body>
</HTML>
