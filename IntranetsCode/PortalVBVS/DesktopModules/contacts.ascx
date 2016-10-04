<%@ Control language="vb" Inherits="ASPNetPortal.Contacts" CodeBehind="contacts.ascx.vb" AutoEventWireup="false" %>
<%@ Register TagPrefix="Portal" TagName="Title" Src="~/DesktopModuleTitle.ascx"%>

<portal:title EditText="Add New Contact" EditUrl="~/DesktopModules/EditContacts.aspx" runat="server" />
<asp:datagrid id="myDataGrid" Border="0" width="100%" AutoGenerateColumns="false" EnableViewState="false" runat="server">
    <Columns>
        <asp:TemplateColumn>
            <ItemTemplate>
                <asp:HyperLink ImageUrl="~/images/edit.gif" NavigateUrl='<%# "~/DesktopModules/EditContacts.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ItemID") & "&mid=" & ModuleId %>' Visible="<%# IsEditable %>" runat="server" />
            </ItemTemplate>
        </asp:TemplateColumn>
        <asp:BoundColumn HeaderText="Name" DataField="Name" ItemStyle-CssClass="Normal" HeaderStyle-Cssclass="NormalBold" />
        <asp:BoundColumn HeaderText="Role" DataField="Role" ItemStyle-CssClass="Normal" HeaderStyle-Cssclass="NormalBold" />
        <asp:BoundColumn HeaderText="Email" DataField="Email" ItemStyle-CssClass="Normal" HeaderStyle-Cssclass="NormalBold" />
        <asp:BoundColumn HeaderText="Contact 1" DataField="Contact1" ItemStyle-CssClass="Normal" HeaderStyle-Cssclass="NormalBold" />
        <asp:BoundColumn HeaderText="Contact 2" DataField="Contact2" ItemStyle-CssClass="Normal" HeaderStyle-Cssclass="NormalBold" />
    </Columns>
</asp:datagrid>

