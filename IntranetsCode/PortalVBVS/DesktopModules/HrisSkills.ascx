<%@ Control language="vb" Inherits="ASPNetPortal.Hris.HrisSkills" CodeBehind="HrisSkills.ascx.vb" AutoEventWireup="false" %>
<%@ Register TagPrefix="Portal" TagName="Title" Src="~/DesktopModuleTitle.ascx"%>
<portal:title EditText="Add New Skill" EditUrl="~/DesktopModules/HrisEditSkills.aspx" runat="server" id="Title1" />
<asp:datagrid id="myDataGrid" Border="0" width="100%" AutoGenerateColumns="false" EnableViewState="false" runat="server">
	<Columns>
		<asp:TemplateColumn ItemStyle-Width="40">
			<ItemTemplate>
				<asp:HyperLink ImageUrl="~/images/edit.gif" NavigateUrl='<%# "~/DesktopModules/HrisEditSkills.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & ModuleId %>' Visible="<%# IsEditable %>" runat="server" />
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:BoundColumn HeaderText="Description" DataField="Description" ItemStyle-CssClass="Normal" HeaderStyle-Cssclass="NormalBold" />
	</Columns>
</asp:datagrid>
