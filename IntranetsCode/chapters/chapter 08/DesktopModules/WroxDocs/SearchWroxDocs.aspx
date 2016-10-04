<%@ Register TagPrefix="portal" TagName="DesktopPortalBanner" Src="../../DesktopPortalBanner.ascx" %>
<%@ Register TagPrefix="Wrox" TagName="DocumentDetails" Src="DocumentDetails.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SearchWroxDocs.aspx.vb" Inherits="ASPNetPortal.SearchWroxDocs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
   <HEAD>
      <title>SearchWroxDocs</title>
      <% response.write("<link rel=""stylesheet"" href='" & Request.ApplicationPath & "/Portal.css" & "' type=""text/css"">")%>
   </HEAD>
   <BODY leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0" marginheight="0" marginwidth="0">
      <FORM id="Form1" method="post" runat="server">
         <portal:desktopportalbanner id="DesktopPortalBanner1" runat="server" /><BR>
         <TABLE width="100%">
            <TBODY>
               <TR>
                  <TD class="head">Search&nbsp;WroxDocs
                  </TD>
               </TR>
               <TR>
                  <TD>
                     <HR noShade SIZE="1">
                  </TD>
               </TR>
               <TR>
                  <TD width="100%"></TD>
               </TR>
               <TR>
                  <TD class="subhead" width="100%" vAlign="top">
                     Enter a search criteria and Click Search
                  </TD>
               </TR>
               <TR>
                  <TD>
                     <TABLE width="100%">
                        <TR>
                           <TD class="Normal" vAlign="top" width="141">
                              Search for Titles
                           </TD>
                           <TD><asp:textbox id="txtFilter" runat="server" width="108px" columns="20" cssclass="NormalTextBox" />&nbsp;
                              <asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" ErrorMessage="You must enter a Search Term" ControlToValidate="txtFilter" /><BR>
                              <asp:checkbox id="chkExact" runat="server" Text="Exact" />
                        <TR>
                           <TD class="Normal" width="141">
                              <asp:linkbutton id="SearchButton" runat="server" Width="4px" CssClass="commandbutton" text="Search" />&nbsp;
                              <asp:linkbutton id="CancelButton" runat="server" Width="4px" CssClass="commandbutton" CausesValidation="False" text="Cancel" />
                           </TD>
                           <TD></TD>
                        </TR>
                     </TABLE>
                     <HR>
                     <TABLE cellSpacing="0" width="100%">
                        <TR>
                           <TD>
                              <asp:label id="ErrorMessage" CssClass="NormalRed" Runat="server" />
                              <asp:datagrid id="dgListing" runat="server" CssClass="normal" Width="100%" Height="101px" AutoGenerateColumns="False" AllowPaging="True" OnItemCommand="SelectItemCommand" OnPageIndexChanged="PageChange" ShowHeader="False" DataKeyField="ItemID">
                                 <FooterStyle BackColor="Silver" />
                                 <Columns>
                                    <asp:TemplateColumn>
                                       <ItemTemplate>
                                          <!-- table begin -->
                                          <TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#eeeecc" border="0">
                                             <TR>
                                                <TD class="SubHead" colSpan="2">&nbsp;
                                                   <asp:Image id="imgFormat" runat="server" ImageUrl="images/wordsmall.gif" />&nbsp;
                                                   <B>
                                                      <%# Container.DataItem("FileDescription") %>
                                                   </B>
                                                </TD> <!-- submitted date -->
                                                <TD align="right"><FONT size="2">Submitted on
                                                      <%# DataBinder.Eval(Container.DataItem, "CreatedDate", "{0:d}") %>
                                                      by
                                                      <%# Container.DataItem("CreatedbyUser") %>
                                                   </FONT>
                                                   <BR>
                                                </TD>
                                             </TR>
                                          </TABLE>
                                          <TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
                                             <TR>
                                                <TD width="100%">
                                                   <TABLE width="100%">
                                                      <TR>
                                                         <TD vAlign="top" width="20">
                                                            <asp:HyperLink id=lnkEdit runat="server" ImageUrl="~/images/edit.gif" NavigateUrl='<%# "~/DesktopModules/WroxDocs/WroxDocEdit.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId %>' Visible="false" /><BR>
                                                         </TD>
                                                         <TD vAlign="top" align="right">
                                                            <!-- Middle Table -->
                                                            <TABLE class="normal" width="100%">
                                                               <TR>
                                                                  <TD><B>Status:</B>
                                                                     <asp:Label id="lblStatus" runat="server" />&nbsp;
                                                                     <BR>
                                                                     <B>Current File name:</B>
                                                                     <%# Container.DataItem("FileName") %>
                                                                     &nbsp;<FONT size="1">(<%# Container.DataItem("ContentSize") %>
                                                                        bytes) </FONT>
                                                                  </TD>
                                                                  <TD vAlign="top" align="right"><B>Previous Versions:</B>
                                                                     <asp:Label id="lblVersions" runat="server" EnableViewState="False">
                                                                        <%# Container.DataItem("VersionCount") %>
                                                                     </asp:Label><BR>
                                                                     <asp:ImageButton id="ImgCheck" runat="server" ImageUrl="images/checkin.gif" commandname="DocumentAction" />
                                                                     <asp:LinkButton id="CheckButton" runat="server" CssClass="CommandButton" commandname="DocumentAction" text="Check Out" />&nbsp;&nbsp;
                                                                     <asp:Image id="ImgView" ImageUrl="~/DesktopModules/WroxDocs/images/Browsesmall.gif" border="0" Runat="server" />
                                                                     <asp:hyperlink id=lnkView runat="server" CssClass="CommandButton" NavigateUrl='<%# "~/DesktopModules/WroxDocs/ServeWroxDocument.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId & "&key=" & Container.DataItem("ItemID")%>' Target="_blank" text="View Only" /></TD>
                                                               </TR>
                                                            </TABLE>
                                                         </TD>
                                                      </TR>
                                                      <TR>
                                                         <TD colSpan="2">
                                                            <asp:ImageButton id=PlusButton runat="server" ImageUrl="images/plus.gif" Visible='<%# Container.DataItem("VersionCount") %>' CommandName="View" />
                                                            <asp:Label id="Label3" runat="server" Visible='<%# Container.DataItem("VersionCount") %>'>
                                                               <font color="red" size="1">More..</font></asp:Label>
                                                         </TD>
                                                      </TR>
                                                   </TABLE>
                                                </TD>
                                             </TR>
                                          </TABLE> <!-- End of Table -->
                                       </ItemTemplate>
                                       <EditItemTemplate> <!-- Child Table begin -->
                                          <TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#eeeecc" border="0">
                                             <TR>
                                                <TD class="SubHead" colSpan="2">&nbsp;
                                                   <asp:Image id="imgFormat_Edit" runat="server" ImageUrl="images/wordsmall.gif" />&nbsp;
                                                   <B>
                                                      <%# Container.DataItem("FileDescription") %>
                                                   </B>
                                                </TD>
                                                <!-- submitted date -->
                                                <TD align="right"><FONT size="2">Submitted on
                                                      <%# DataBinder.Eval(Container.DataItem, "CreatedDate", "{0:d}") %>
                                                      by
                                                      <%# Container.DataItem("CreatedbyUser") %>
                                                   </FONT>
                                                   <BR>
                                                </TD>
                                             </TR>
                                          </TABLE>
                                          <TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
                                             <TR>
                                                <TD width="100%">
                                                   <TABLE width="100%">
                                                      <TR>
                                                         <TD vAlign="top" width="20">
                                                            <asp:HyperLink id=lnkEdit_Edit runat="server" ImageUrl="~/images/edit.gif" NavigateUrl='<%# "~/DesktopModules/WroxDocs/WroxDocEdit.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId %>' Visible="false" /><BR>
                                                         </TD>
                                                         <TD vAlign="top" align="right">
                                                            <!-- Middle Table -->
                                                            <TABLE class="normal" width="100%">
                                                               <TR>
                                                                  <TD><B>Status:</B>
                                                                     <asp:Label id="lblStatus_Edit" runat="server" />&nbsp;
                                                                     <BR>
                                                                     <B>Current File Name:</B>
                                                                     <%# Container.DataItem("FileName") %>
                                                                     &nbsp; <FONT size="1">(<%# Container.DataItem("ContentSize") %>
                                                                        bytes) </FONT>
                                                                  </TD>
                                                                  <TD vAlign="top" align="right"><B>Previous Versions:</B>
                                                                     <asp:Label id="lblVersions_Edit" runat="server" EnableViewState="False" text = '<%# Container.DataItem("VersionCount") %>' /><BR>
                                                                     <asp:ImageButton id="ImgCheck_Edit" runat="server" ImageUrl="images/checkin.gif" commandname="DocumentAction" />
                                                                     <asp:LinkButton id="CheckButton_Edit" runat="server" CssClass="CommandButton" commandname="DocumentAction" text="Check Out" />&nbsp;&nbsp;
                                                                     <asp:Image id="ImgView_Edit" ImageUrl="~/DesktopModules/WroxDocs/images/Browsesmall.gif" border="0" Runat="server" />
                                                                     <asp:hyperlink id=lnkView_Edit runat="server" CssClass="CommandButton" NavigateUrl='<%# "~/DesktopModules/WroxDocs/ServeWroxDocument.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId & "&key=" & Container.DataItem("ItemID")%>' Target="_blank" text="View Only" />
                                                                  </TD>
                                                               </TR>
                                                            </TABLE>
                                                         </TD>
                                                      </TR>
                                                   </TABLE>
                                                </TD>
                                             </TR>
                                          </TABLE>
                                          <!-- Marker for Child Grid -->
                                          <TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="lightyellow">
                                             <TR>
                                                <TD bgColor="silver" align="center">
                                                   <asp:ImageButton id="ImgMinus" runat="server" ImageUrl="images/minus.gif" CommandName="View" /></TD>
                                                <TD align="left" bgColor="silver" Class="normal"><%# Container.DataItem("VersionCount") %>
                                                   Previous Versions Listed Below:</TD>
                                             </TR>
                                             <TR>
                                                <TD>&nbsp;</TD>
                                                <TD align="middle">
                                                   <Wrox:DocumentDetails id=Documentdetails2 runat="server" mid='<%# moduleID %>' DocumentID='<%# Container.DataItem("ItemID") %>' />
                                                   <asp:Panel id="Panel1" runat="server" CssClass="normal" Height="59px" BackColor="#FFFFC0" BorderWidth="1" BorderColor="Maroon">
                              <BR>NOTE: Previous versions of documents are available for download only.<BR>You may only check in/out the current document.
                              </asp:Panel>
                                                </TD>
                                             </TR>
                                          </TABLE>
                                       </EditItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:BoundColumn Visible="False" DataField="ContentType" />
                                 </Columns>
                                 <PagerStyle HorizontalAlign="Right" BackColor="Silver" Mode="NumericPages" />
                              </asp:datagrid></TD>
                        </TR>
                     </TABLE>
      </FORM>
      </TD></TR></TBODY></TABLE>
   </BODY>
</HTML>
