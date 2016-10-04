<%@ Page language="vb" CodeBehind="WroxDocEdit.aspx.vb" AutoEventWireup="false" Inherits="ASPNetPortal.WroxDocEdit" %>
<%@ Register TagPrefix="Wrox" TagName="WroxDocAcls" Src="WroxDocAcls.ascx"%>
<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<HTML>
   <HEAD>
      <% response.write("<link rel=""stylesheet""	href='"	& Request.ApplicationPath & "/Portal.css" & "' type=""text/css"">")%>
   </HEAD>
   <BODY bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0" marginwidth="0" marginheight="0">
      <FORM encType="multipart/form-data" runat="server">
         &nbsp;
         <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
            <TBODY>
               <TR vAlign="top">
                  <TD colSpan="2"><portal:banner id="SiteHeader" runat="server" /></TD>
               </TR>
            </TBODY></TABLE>
         <TABLE cellSpacing="0" cellPadding="0" border="0" width="500">
            <TR>
               <TD width="14">&nbsp;</TD>
               <TD class="Head" colSpan="3">Document Details</TD>
            </TR>
            <TR>
               <TD width="14">&nbsp;</TD>
               <TD class="Head" colSpan="3">
                  <HR noShade SIZE="1">
                  <asp:label id="ErrorMessage" Runat="server" CssClass="NormalRed" />
               </TD>
            </TR>
            <TR>
               <TD width="14">&nbsp;</TD>
               <TD class="subhead">File:</TD>
               <TD>
                  <asp:textbox id="txtDes" runat="server" maxlength="150" Columns="28" width="353" cssclass="NormalTextBox" />
               </TD>
               <TD></TD>
            </TR>
            <TR>
               <TD width="14">&nbsp;</TD>
               <TD class="subhead">
                  Category:
               </TD>
               <TD>
                  <asp:textbox id="txtCat" runat="server" maxlength="50" Columns="28" width="353" cssclass="NormalTextBox" />
               </TD>
               <TD></TD>
            </TR>
            <!-- Acls Panel	-->
            <asp:panel id="pnlAcls" Runat="server">
               <TR>
                  <TD width="14">&nbsp;</TD>
                  <TD class="subhead" colSpan="2"><BR>
                     Adjust Permissions<BR>
                     <Wrox:WROXDOCACLS id="WroxDocAcls1" runat="server" /><BR>
                  </TD>
                  <TD>&nbsp;</TD>
               </TR>
            </asp:panel>
            <!-- End Acls Panel	-->
            <!--Begin File Panel -->
            <asp:panel id="pnlFile" Runat="server">
               <TR>
                  <TD width="14">&nbsp;</TD>
                  <TD class="subhead">File:</TD>
                  <TD>
                     <INPUT id="Upload" style="WIDTH: 353px; FONT-FAMILY: verdana" type="file" name="Upload" runat="server" width="300"></TD>
                  <TD>&nbsp;</TD>
               </TR>
            </asp:panel>
            <!-- End File panel	-->
            <TR>
               <TD width="14">&nbsp;</TD>
               <TD colSpan="2">
                  <HR>
                  <asp:linkbutton class="CommandButton" id="UploadButton" runat="server" Text="Upload New Document" />&nbsp;
                  <asp:linkbutton class="CommandButton" id="UpdateButton" runat="server" Text="Update Document" />&nbsp;
                  <asp:linkbutton class="CommandButton" id="CancelButton" runat="server" Text="Cancel" CausesValidation="False" />&nbsp;
                  <asp:linkbutton class="CommandButton" id="ArchiveButton" runat="server" Text="Archive Document" /></TD>
               <TD>&nbsp;</TD>
            </TR>
         </TABLE>
      </FORM>
   </BODY>
</HTML>
