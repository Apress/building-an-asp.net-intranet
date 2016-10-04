<%@ Control Language="vb" AutoEventWireup="false" Codebehind="DisplayFull.ascx.vb" Inherits="ASPNetPortal.DisplayFull" targetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" %>
<%@ Register TagPrefix="Wrox" TagName="WroxDocsTitle" Src="WroxDocsTitle.ascx" %>
<%@ Register TagPrefix="Wrox" TagName="DocumentDetails" Src="DocumentDetails.ascx" %>
<!-- Component Title -->
<WROX:WROXDOCSTITLE id="WroxDocsTitle1" runat="server" SearchUrl="~/DesktopModules/WroxDocs/SearchWroxDocs.aspx" SearchText="Search" EditUrl="~/DesktopModules/WroxDocs/WroxDocEdit.aspx" EditText="Add Document" />
<!-- Our Datagrid of Documents -->
<TABLE id="tblResults" borderColor="#000000" cellSpacing="0" width="100%" border="1" runat="server">
   <TR>
      <TD>
         <asp:label id="ErrorMessage" Runat="server" CssClass="NormalRed" />
         <asp:datagrid id="dgListing" runat="server" CssClass="normal" Width="100%" Height="101px" AutoGenerateColumns="False" AllowPaging="True" OnItemCommand="SelectItemCommand" PageSize="5" OnPageIndexChanged="PageChange" ShowHeader="False" DataKeyField="ItemID">
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
                                       <asp:HyperLink id=lnkEdit runat="server" ImageUrl="~/images/edit.gif" NavigateUrl='<%# "~/DesktopModules/WroxDocs/WroxDocEdit.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId %>' Visible="<%# IsEditable %>" /><BR>
                                    </TD>
                                    <TD vAlign="top" align="right">
                                       <!-- Middle Table -->
                                       <TABLE class="normal" width="100%">
                                          <TR>
                                             <TD><B>Status:</B>
                                                <asp:Label id="lblStatus" runat="server" />&nbsp;
                                                <BR>
                                                <B>Current File Name:</B>
                                                <%# Container.DataItem("FileName") %>
                                                &nbsp; <FONT size="1">(<%# Container.DataItem("ContentSize") %>
                                                   bytes) </FONT>
                                             </TD>
                                             <TD vAlign="top" align="right"><B>Previous Versions:</B>
                                                <asp:Label id="lblVersions" runat="server" EnableViewState="False" text = '<%# Container.DataItem("VersionCount") %>' /><BR>
                                                <asp:ImageButton id="ImgCheck" runat="server" ImageUrl="images/checkin.gif" commandname="DocumentAction" />
                                                <asp:LinkButton id="CheckButton" runat="server" CssClass="CommandButton" commandname="DocumentAction" text="Check Out" />&nbsp;&nbsp;
                                                <asp:Image id="ImgView" ImageUrl="~/DesktopModules/WroxDocs/images/Browsesmall.gif" border="0" Runat="server" />
                                                <asp:hyperlink id=lnkView runat="server" CssClass="CommandButton" NavigateUrl='<%# "~/DesktopModules/WroxDocs/ServeWroxDocument.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId & "&key=" & Container.DataItem("ItemID")%>' Target="_blank" text="View Only" />
                                             </TD>
                                          </TR>
                                       </TABLE>
                                    </TD>
                                 </TR>
                                 <TR>
                                    <TD colSpan="2">
                                       <asp:ImageButton id=PlusButton runat="server" ImageUrl="images/plus.gif" Visible='<%# Container.DataItem("VersionCount") %>' CommandName="View" />
                                       <asp:Label id=Label1 runat="server" Visible='<%# Container.DataItem("VersionCount") %>'>
                                          <font color="red" size="1">More..</font></asp:Label>
                                    </TD>
                                 </TR>
                              </TABLE>
                           </TD>
                        </TR>
                     </TABLE>
                     <!-- End of Table -->
                  </ItemTemplate>
                  <EditItemTemplate>
                     <!-- Child Table begin -->
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
                                       <asp:HyperLink id=lnkEdit_Edit runat="server" ImageUrl="~/images/edit.gif" NavigateUrl='<%# "~/DesktopModules/WroxDocs/WroxDocEdit.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId %>' Visible="<%# IsEditable %>" /><BR>
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
         </asp:datagrid>
      </TD>
   </TR>
</TABLE>
