<%@ Control language="vb" Inherits="ASPNetPortal.Hris.HrisEmployeesDisplaySummary" CodeBehind="HrisEmployeesDisplaySummary.ascx.vb" AutoEventWireup="false" %>
<%@ Register TagPrefix="Portal" TagName="Title" Src="~/DesktopModuleTitle.ascx"%>
<P><portal:title id="Title1" EditText="" runat="server"></portal:title><BR>
</P>
<P><asp:label id="lblNewEmployees" runat="server" CssClass="NormalBold">New Employees</asp:label><BR>
	<asp:datagrid id="myDataGrid" runat="server" OnPageIndexChanged="Employees_PageIndexChanged" AllowPaging="True" Border="0" width="100%" AutoGenerateColumns="false" AllowSorting="True" EnableViewState="false" PageSize="5">
		<Columns>
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
	</asp:datagrid></P>
<P id="P1" runat="server"><asp:label id="Label2" runat="server" CssClass="NormalBold">Employee Handbook</asp:label><BR>
	<table width="70%" cellpadding="0" cellspacing="0">
		<asp:datalist id="dlHandbookFiles" width="80%" runat="server">
			<AlternatingItemStyle CssClass="Normal"></AlternatingItemStyle>
			<ItemStyle CssClass="Normal"></ItemStyle>
			<ItemTemplate>
				<tr>
					<td>
						<asp:HyperLink id=HyperLink2 CssClass="Normal" Target="_new" runat="server" Text='<%#  DataBinder.Eval(Container.DataItem,"Name") %>' NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"FullName") %>'>
						</asp:HyperLink></td>
					<td align="right">
						<asp:Label CssClass="Normal" id="Label3" Text='<%#  " (Last written to on: " & Cstr(DataBinder.Eval(Container.DataItem,"LastWriteTime")) & ")" %>' runat="server">
						</asp:Label>
					</td>
				</tr>
			</ItemTemplate>
			<AlternatingItemTemplate>
				<tr>
					<td>
						<asp:HyperLink CssClass="Normal" id=Hyperlink3 Target="_new" runat="server" Text='<%#  DataBinder.Eval(Container.DataItem,"Name") %>' NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"FullName") %>'>
						</asp:HyperLink></td>
					<td align="right">
						<asp:Label CssClass="Normal" id="Label4" Text='<%#  " (Last written to on: " & Cstr(DataBinder.Eval(Container.DataItem,"LastWriteTime")) & ")" %>' runat="server">
						</asp:Label>
					</td>
				</tr>
			</AlternatingItemTemplate>
		</asp:datalist>
	</table>
</P>
