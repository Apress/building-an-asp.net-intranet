<%@ Register TagPrefix="Wrox" TagName="DocumentDetails" Src="DocumentDetails.ascx" %>
<%@ Register TagPrefix="Wrox" TagName="WroxDocsTitle" Src="WroxDocsTitle.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="DisplaySummary.ascx.vb" Inherits="ASPNetPortal.DisplaySummary" TargetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" %>
<!-- Our Datagrid of Documents -->
<asp:label id="ModuleTitle" runat="server" EnableViewState="false" cssclass="Head" />&nbsp;
<asp:hyperlink id="EditButton" cssclass="CommandButton" EnableViewState="false" runat="server" /><BR>
<HR noShade SIZE="4">
<TABLE borderColor="#000000" cellSpacing="0" width="100%" border="1">
   <TR>
      <TD>
         <asp:label id="ErrorMessage" CssClass="NormalRed" Runat="server" />
         <asp:datagrid id="dgListing" runat="server" DataKeyField="ItemID" ShowHeader="False" OnPageIndexChanged="PageChange" PageSize="5" OnItemCommand="SelectItemCommand" AllowPaging="True" AutoGenerateColumns="False" Height="101px" Width="100%" CssClass="normal">
            <FooterStyle BackColor="Silver" />
            <Columns>
               <asp:TemplateColumn>
                  <ItemTemplate>
                     <!-- table begin -->
                     <TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#eeeecc" border="0">
                        <TR>
                           <TD class="SubHead" colSpan="3">&nbsp;
                              <asp:HyperLink id=Hyperlink1 runat="server" ImageUrl="~/images/edit.gif" Visible="<%# IsEditable %>" NavigateUrl='<%# "~/DesktopModules/WroxDocs/WroxDocEdit.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId %>' />
                              <asp:Image id="ImgFormat" runat="server" ImageUrl="images/wordsmall.gif" />&nbsp;
                              <B>
                                 <%# Container.DataItem("FileDescription") %>
                              </B>
                           </TD> <!-- submitted date -->
                        </TR>
                     </TABLE>
                     <TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
                        <TR>
                           <TD width="100%">
                              <TABLE width="100%">
                                 <TR>
                                    <TD colspan="3" vAlign="top" align="right">
                                       <!-- Middle Table -->
                                       <TABLE class="normal" width="100%">
                                          <TR>
                                             <TD><B>
                                                   <asp:Label id="lblStatus" runat="server" />
                                                </B>
                                                <BR>
                                                <B>File:</B>
                                                <%# Container.DataItem("FileName") %>
                                                &nbsp;<FONT size="1">(<%# Container.DataItem("ContentSize") %>
                                                   bytes)</FONT>
                                             </TD>
                                             <TD vAlign="top" align="right">
                                                <asp:ImageButton id="ImgCheck" runat="server" ImageUrl="images/checkin.gif" commandname="DocumentAction" />&nbsp;<BR>
                                                <asp:hyperlink ImageUrl="images/Browsesmall.gif" id=lnkView runat="server" CssClass="CommandButton" NavigateUrl='<%# "~/DesktopModules/WroxDocs/ServeWroxDocument.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId & "&key=" & Container.DataItem("ItemID")%>' Target="_blank" text ="View Only" />
                                             </TD>
                                          </TR>
                                       </TABLE>
                                    </TD>
                                 </TR>
                                 <TR>
                                    <TD>&nbsp;
                                       <asp:ImageButton id=ImgPlus runat="server" ImageUrl="images/plus.gif" Visible='<%# Container.DataItem("VersionCount") %>' CommandName="View" />&nbsp;
                                       <asp:Label id=Label4 runat="server" Visible='<%# Container.DataItem("VersionCount") %>'>
                                          <font color="red" size="1">More..</font></asp:Label>
                                    </TD>
                                    <TD align="right"></TD>
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
                           <TD class="SubHead" colSpan="3">&nbsp;
                              <asp:HyperLink id=Hyperlink1_Edit runat="server" ImageUrl="~/images/edit.gif" Visible="<%# IsEditable %>" NavigateUrl='<%# "~/DesktopModules/WroxDocs/WroxDocEdit.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId %>' />
                              <asp:Image id="ImgFormat_Edit" runat="server" ImageUrl="images/wordsmall.gif" />&nbsp;
                              <B>
                                 <%# Container.DataItem("FileDescription") %>
                              </B>
                           </TD> <!-- submitted date -->
                        </TR>
                     </TABLE>
                     <TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
                        <TR>
                           <TD width="100%">
                              <TABLE width="100%">
                                 <TR>
                                    <TD colspan="3" vAlign="top" align="right">
                                       <!-- Middle Table -->
                                       <TABLE class="normal" width="100%">
                                          <TR>
                                             <TD><B>
                                                   <asp:Label id="lblStatus_Edit" runat="server" />
                                                </B>
                                                <BR>
                                                <B>File:</B>
                                                <%# Container.DataItem("FileName") %>
                                                &nbsp;<FONT size="1">(<%# Container.DataItem("ContentSize") %>
                                                   bytes)</FONT>
                                             </TD>
                                             <TD vAlign="top" align="right">
                                                <asp:ImageButton id="ImgCheck_Edit" runat="server" ImageUrl="images/checkin.gif" commandname="DocumentAction" />&nbsp;<BR>
                                                <asp:hyperlink ImageUrl="images/Browsesmall.gif" id=lnkView_Edit runat="server" CssClass="CommandButton" NavigateUrl='<%# "~/DesktopModules/WroxDocs/ServeWroxDocument.aspx?ItemID=" &amp; Container.DataItem("ItemID")  &amp; "&amp;mid=" &amp; ModuleId & "&key=" & Container.DataItem("ItemID")%>' Target="_blank" text ="View Only" />
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
                           <TD align="left">
                              <Wrox:DocumentDetails id=Documentdetails2 runat="server" mid='<%# moduleID %>' DocumentID='<%# Container.DataItem("ItemID") %>' />
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
