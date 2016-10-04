<%@ Control language="vb" Inherits="ASPNetPortal.Hris.HrisJobTitles" CodeBehind="HrisJobTitles.ascx.vb" AutoEventWireup="false" %>
<%@ Register TagPrefix="Portal" TagName="Title" Src="~/DesktopModuleTitle.ascx"%>
<portal:title EditText="Add New Job Title" EditUrl="~/DesktopModules/HrisEditJobTitles.aspx" runat="server" id="Title1" />
<asp:datagrid id="myDataGrid" Border="0" width="100%" AutoGenerateColumns="false" EnableViewState="false" runat="server">
	<Columns>
		<asp:TemplateColumn  ItemStyle-Width="40">
			<ItemTemplate>
				<asp:HyperLink id="editLink" ImageUrl="~/images/edit.gif" NavigateUrl='<%# "~/DesktopModules/HrisEditJobTitles.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID")  & "&mid=" & ModuleId %>' Visible="<%# IsEditable %>" runat="server" />
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:TemplateColumn HeaderText="Title" HeaderStyle-CssClass="NormalBold">
			<ItemTemplate>
				<asp:HyperLink id="docLink" Text='<%# DataBinder.Eval(Container.DataItem,"Title") %>' NavigateUrl='<%# GetBrowsePathDetails("JobTitle", CInt(DataBinder.Eval(Container.DataItem,"ID"))) %>' CssClass="Normal" Target="_new" runat="server" />
			</ItemTemplate>
		</asp:TemplateColumn>
	</Columns>
</asp:datagrid>
