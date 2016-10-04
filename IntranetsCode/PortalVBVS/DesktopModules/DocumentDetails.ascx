<%@ Control Language="vb" AutoEventWireup="false" Codebehind="DocumentDetails.ascx.vb" Inherits="ASPNetPortal.DocumentDetails" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:datagrid id="dgDetails" HorizontalAlign="Left" GridLines="Vertical" CellPadding="3" BackColor="White" BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" runat="server" BorderStyle="Solid" CssClass="normal">
   <SelectedItemStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#738A9C" />
   <AlternatingItemStyle BackColor="#F7F7F7" />
   <ItemStyle ForeColor="#4A3C8C" BackColor="#E7E7FF" />
   <HeaderStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#4A3C8C" />
   <FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE" />
   <Columns>
      <asp:TemplateColumn HeaderText="Version">
         <ItemTemplate>
            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "ItemIndex")+1 %>' />
         </ItemTemplate>
         <EditItemTemplate>
            <asp:TextBox runat="server" Text='<%# Container.DataItem("VersionCounter") %>' />
         </EditItemTemplate>
      </asp:TemplateColumn>
      <asp:BoundColumn DataField="VersionedDate" HeaderText="Date Modified">
         <HeaderStyle CssClass="normal" />
         <ItemStyle CssClass="normal" />
      </asp:BoundColumn>
      <asp:BoundColumn DataField="filename" HeaderText="File Name">
         <HeaderStyle CssClass="normal" />
         <FooterStyle CssClass="normal" />
      </asp:BoundColumn>
      <asp:BoundColumn DataField="contentSize" HeaderText="File Size">
         <HeaderStyle CssClass="normal" />
         <ItemStyle CssClass="normal" />
      </asp:BoundColumn>
      <asp:TemplateColumn HeaderText="View">
         <ItemTemplate>
            <asp:HyperLink runat="server" Text="View" NavigateUrl='<%# "~/DesktopModules/WroxDocs/ServeWroxDocument.aspx?SubItemID=" &amp; Container.DataItem("SubItemID")  &amp; "&amp;mid=" &amp; mid & "&key=" & Container.DataItem("ItemID")%>' Target="_blank" />
         </ItemTemplate>
      </asp:TemplateColumn>
      <asp:BoundColumn Visible="False" DataField="ContentType">
         <HeaderStyle CssClass="normal" />
         <ItemStyle CssClass="normal" />
      </asp:BoundColumn>
   </Columns>
   <PagerStyle HorizontalAlign="Right" ForeColor="Black" BackColor="#999999" PageButtonCount="4" Mode="NumericPages" />
</asp:datagrid>
