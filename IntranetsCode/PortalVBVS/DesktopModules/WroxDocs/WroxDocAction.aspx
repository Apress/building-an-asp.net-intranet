<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Page language="vb" CodeBehind="WroxDocAction.aspx.vb" AutoEventWireup="false" Inherits="ASPNetPortal.WroxDocAction" %>
<HTML>
   <HEAD>
      <% response.write("<link rel=""stylesheet"" href='" & Request.ApplicationPath & "/Portal.css" & "' type=""text/css"">")%>
   </HEAD>
   <BODY bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0" marginwidth="0" marginheight="0">
      <FORM id="frmDocAction" encType="multipart/form-data" runat="server">
         <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
            <TR vAlign="top">
               <TD><portal:banner id="SiteHeader" runat="server"></portal:banner></TD>
            </TR>
         </TABLE>
         <TABLE cellSpacing="0" cellPadding="0" width="500">
            <TR>
               <TD>&nbsp;</TD>
               <TD class="Head">Document Check In / Check Out
               </TD>
            </TR>
            <TR>
               <TD>&nbsp;</TD>
               <TD>
                  <HR noShade SIZE="1">
               </TD>
            </TR>
            <TR>
               <TD>&nbsp;</TD>
               <TD>
                  <!-- Begin Panels --><asp:panel id="pnlShowDownload" runat="server" Height="70px" Width="100%" Visible="False">
                     <TABLE cellSpacing="0" cellPadding="2" width="100%" border="1">
                        <TR>
                           <TD align="middle" bgColor="lightyellow">
                              <P><BR>
                                 <asp:Image id="imgFormat" runat="server"></asp:Image>&nbsp;
                                 <asp:HyperLink id="lnkFileName" runat="server"></asp:HyperLink><BR>
                                 After Downloading and Saving the above File, please confirm the Check Out by 
                                 Clicking "Check Document Out"<BR>
                              </P>
                           </TD>
                        </TR>
                     </TABLE>
                  </asp:panel><asp:panel id="pnlShowCheckin" runat="server" Width="100%" Visible="False">
                     <TABLE cellSpacing="0" cellPadding="2" width="100%" border="1">
                        <TR>
                           <TD align="middle" bgColor="lightyellow"><BR>
                              To Check this file back in simply select the file below and click "Check 
                              Document In. The previous version will be saved to the database and can be 
                              viewed by clicking the "+" sign from the listing of documents.<BR>
                           </TD>
                        </TR>
                     </TABLE>
                  </asp:panel>
                  <!-- End Panels --></TD>
            </TR>
            <TR>
               <TD>&nbsp;</TD>
               <TD>
                  <!-- Begin Input Fields -->
                  <TABLE cellSpacing="0" cellPadding="0" width="100%">
                     <TR vAlign="top">
                        <TD class="SubHead" width="100">Title:
                        </TD>
                        <TD class="Normal"><asp:textbox id="txtDes" runat="server" Enabled="False" Columns="30" width="364px" cssclass="NormalTextBox"></asp:textbox></TD>
                     </TR>
                     <TR vAlign="top">
                        <TD class="SubHead">Original FileName:
                        </TD>
                        <TD><asp:textbox id="txtFilename" runat="server" Enabled="False" Columns="30" width="363px" cssclass="NormalTextBox"></asp:textbox></TD>
                     </TR>
                     <TR vAlign="top">
                        <TD class="SubHead" height="18">Owner:&nbsp;
                        </TD>
                        <TD height="18"><asp:label id="lblOwner" runat="server" EnableViewState="False"></asp:label></TD>
                     </TR>
                     <asp:panel id="pnlFile" Runat="server">
                        <TR>
                           <TD class="SubHead">Check In File:
                           </TD>
                           <TD>
                              <INPUT id="txtFile" style="WIDTH: 353px; FONT-FAMILY: verdana" type="file" name="txtFile" runat="server" width="300">
                           </TD>
                        </TR>
                     </asp:panel>
                     <TR>
                        <TD class="SubHead" colSpan="4">
                           <HR noShade SIZE="1">
                        </TD>
                     </TR>
                  </TABLE>
                  <!-- End Input Fields --></TD>
            </TR>
            <TR>
               <TD>&nbsp;</TD>
               <TD><asp:linkbutton class="CommandButton" id="CheckInButton" runat="server" Visible="False" Text="Check Document In"></asp:linkbutton>&nbsp;
                  <asp:linkbutton class="CommandButton" id="CheckOutButton" runat="server" Visible="False" Text="Check Document Out"></asp:linkbutton>&nbsp;
                  <asp:linkbutton class="CommandButton" id="CancelButton" runat="server" Text="Cancel" CausesValidation="False"></asp:linkbutton>&nbsp;
                  <asp:label id="ErrorMessage" Runat="server" CssClass="NormalRed"></asp:label></TD>
            </TR>
         </TABLE>
      </FORM>
   </BODY>
</HTML>
