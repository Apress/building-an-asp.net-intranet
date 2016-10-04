<%@ Control language="vb" Inherits="ASPNetPortal.Hris.HrisEmployeesDisplayFull" CodeBehind="HrisEmployeesDisplayFull.ascx.vb" AutoEventWireup="false" %>
<%@ Register TagPrefix="Portal" TagName="Title" Src="~/DesktopModuleTitle.ascx"%>
<p><portal:title id="Title1" runat="server" EditUrl="~/DesktopModules/HrisEditEmployees.aspx" EditText="Add New Employee"></portal:title></p>
<p><asp:datagrid id="myDataGrid" runat="server" EnableViewState="false" AllowSorting="True" AutoGenerateColumns="false" width="100%" Border="0" AllowPaging="True" OnPageIndexChanged="Employees_PageIndexChanged" PageSize="5">
		<Columns>
			<asp:TemplateColumn>
				<ItemTemplate>
					<asp:HyperLink ImageUrl="~/images/edit.gif" NavigateUrl='<%# "~/DesktopModules/HrisEditEmployees.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & ModuleId %>' Visible="<%# IsEditable %>" runat="server" />
				</ItemTemplate>
			</asp:TemplateColumn>
			<asp:TemplateColumn SortExpression="*" HeaderText="Sort by ">
				<HeaderStyle CssClass="NormalBold"></HeaderStyle>
				<ItemStyle CssClass="Normal"></ItemStyle>
				<ItemTemplate>
					<asp:Label runat="server" Text='<%#  DataBinder.Eval(Container.DataItem,"EmpTitle") & " " & DataBinder.Eval(Container.DataItem,"LastName") & ", " & DataBinder.Eval(Container.DataItem,"FirstName")%>' />
				</ItemTemplate>
			</asp:TemplateColumn>
			<asp:BoundColumn DataField="SiteCode" SortExpression="SiteCode" HeaderText="Site">
				<HeaderStyle CssClass="NormalBold"></HeaderStyle>
				<ItemStyle CssClass="Normal"></ItemStyle>
			</asp:BoundColumn>
			<asp:BoundColumn DataField="JobTitle" HeaderText="Job Title">
				<HeaderStyle CssClass="NormalBold"></HeaderStyle>
				<ItemStyle CssClass="Normal"></ItemStyle>
			</asp:BoundColumn>
			<asp:BoundColumn DataField="Service" HeaderText="Service">
				<HeaderStyle CssClass="NormalBold"></HeaderStyle>
				<ItemStyle CssClass="Normal"></ItemStyle>
			</asp:BoundColumn>
			<asp:HyperLinkColumn Target="_new" DataNavigateUrlField="ID" DataNavigateUrlFormatString="javascript:window.open('DesktopModules/HrisViewPhoto.aspx?ID={0}','_new','width=400;height=400;');" DataTextField="PhotoAvail" HeaderText="Photo" DataTextFormatString="{0}">
				<HeaderStyle CssClass="NormalBold"></HeaderStyle>
				<ItemStyle CssClass="Normal"></ItemStyle>
			</asp:HyperLinkColumn>
			<asp:TemplateColumn HeaderText="Details">
				<HeaderStyle CssClass="NormalBold"></HeaderStyle>
				<ItemTemplate>
					<asp:HyperLink id="Hyperlink1" Text='Show Details' NavigateUrl='<%# GetBrowsePathDetails("Employee", CInt(DataBinder.Eval(Container.DataItem,"ID"))) %>' CssClass="Normal" Target="_new" runat="server" />
				</ItemTemplate>
			</asp:TemplateColumn>
		</Columns>
		<PagerStyle CssClass="Normal" Mode="NumericPages"></PagerStyle>
	</asp:datagrid>
</p>
