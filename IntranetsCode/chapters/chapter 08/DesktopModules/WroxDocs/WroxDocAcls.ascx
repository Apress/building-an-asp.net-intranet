<%@ Control Language="vb" AutoEventWireup="false" Codebehind="WroxDocAcls.ascx.vb" Inherits="ASPNetPortal.WroxDocAcls" TargetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" %>
<asp:dropdownlist id="DlRoles" runat="server" DataTextField="RoleName" DataValueField="RoleID" />&nbsp;
<asp:linkbutton class="CommandButton" id="AddRoleButton" runat="server" text="Add This Role" /><BR>
<asp:datagrid id="dgRoles" runat="server" Width="500px" AutoGenerateColumns="False" OnCancelCommand="CancelCommand" OnEditCommand="EditCommand" OnUpdateCommand="UpdateCommand" OnDeleteCommand="DeleteCommand" DataKeyField="RoleID" CssClass="normal">
   <EditItemStyle BackColor="LightYellow" />
   <HeaderStyle ForeColor="Black" BackColor="Silver" />
   <Columns>
      <asp:BoundColumn DataField="RoleName" ReadOnly="True" HeaderText="Role" />
      <asp:TemplateColumn HeaderText="Permissions">
         <ItemTemplate>
            <asp:Label id="lblAcls" runat="server" />
         </ItemTemplate>
         <EditItemTemplate>
            <asp:DropDownList id="dlPermissions" runat="server">
               <asp:ListItem Value="1">View Listing Only</asp:ListItem>
               <asp:ListItem Value="2">View and Download Only</asp:ListItem>
               <asp:ListItem Value="3">Check In/Out Rights</asp:ListItem>
            </asp:DropDownList>
         </EditItemTemplate>
      </asp:TemplateColumn>
      <asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel" EditText="Edit" />
      <asp:ButtonColumn Text="Remove" CommandName="Delete" />
   </Columns>
</asp:datagrid>
<asp:label id="lblMsg" runat="server" Visible="False" CssClass="NormalRed" text="** There are no Roles Associated with this Document yet **" />
