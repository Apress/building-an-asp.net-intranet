<%@ Register TagPrefix="uc1" TagName="HrisSkills" Src="HrisSkills.ascx" %>
<%@ Control language="vb" Inherits="ASPNetPortal.Hris.HrisEmployeesDisplaySearchResults" CodeBehind="HrisEmployeesDisplaySearchResults.ascx.vb" AutoEventWireup="false" %>
<%@ Register TagPrefix="Portal" TagName="Title" Src="~/DesktopModuleTitle.ascx"%>
<p><portal:title id="Title1" runat="server" EditUrl="" EditText=""></portal:title></p>
<p>
	<table width="80%">
		<tr>
			<td>
				<P>
					<asp:TextBox ID="txtSearchPhrase" Columns="50" Runat="Server" CssClass="Normal" />
					<asp:Button Text="Search" Runat="Server" ID="Button1" CssClass="Normal" />
					&nbsp;&nbsp;<asp:Label id="lblCount" class="Normal" runat="server" EnableViewState="false" CssClass="Normal" />
					<BR>
					<asp:RadioButton id="rdoSearchHrisFiles" runat="server" Text="Search the Employee Handbook" GroupName="Search" CssClass="Normal"></asp:RadioButton><BR>
					<asp:RadioButton id="rdoSearchEmployeesTable" runat="server" Text="Search the Employees Information" GroupName="Search" Checked="True" CssClass="Normal"></asp:RadioButton></P>
			</td>
		</tr>
		<tr>
			<td class="Normal">
				<br>
				<span class="Normal">
					<b>Search Tips:</b></span><br>
				You can use the expressions AND, AND NOT, OR (the + and - symbols can also be 
				used in place of AND and AND NOT).<br>
				To search for a particular phrase enclose the phrase in either single or double 
				quotes.<br>
				<br>
				e.g.&nbsp;intranet +&nbsp;employee - "job vacancies" searches documents 
				containing&nbsp;intranet and&nbsp;employee but not the phrase "job vacancies".
				<br>
			</td>
		</tr>
		<tr>
			<td>
				<asp:DataGrid id="ResultsDataGrid" AllowPaging="True" width="100%" runat="server" AutoGenerateColumns="False" GridLines="None">
					<Columns>
						<asp:TemplateColumn HeaderText="Name">
							<HeaderStyle CssClass="NormalBold"></HeaderStyle>
							<ItemStyle CssClass="Normal"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%#  DataBinder.Eval(Container.DataItem,"EmpTitle") & " " & DataBinder.Eval(Container.DataItem,"LastName") & ", " & DataBinder.Eval(Container.DataItem,"FirstName")%>' ID="Label1"/>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:BoundColumn DataField="SiteCode" HeaderText="Site">
							<HeaderStyle CssClass="NormalBold"></HeaderStyle>
							<ItemStyle CssClass="Normal"></ItemStyle>
						</asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Title">
							<HeaderStyle CssClass="NormalBold"></HeaderStyle>
							<ItemTemplate>
								<asp:HyperLink id="JobDocLink" Text='<%# DataBinder.Eval(Container.DataItem,"JobTitle") %>' NavigateUrl='<%# GetBrowsePathDetails("JobTitle", CInt(DataBinder.Eval(Container.DataItem,"JobID"))) %>' CssClass="Normal" Target="_new" runat="server" />
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Details">
							<HeaderStyle CssClass="NormalBold"></HeaderStyle>
							<ItemTemplate>
								<asp:HyperLink id="Hyperlink1" Text='Show Details' NavigateUrl='<%# GetBrowsePathDetails("Employee", CInt(DataBinder.Eval(Container.DataItem,"ID"))) %>' CssClass="Normal" Target="_new" runat="server" />
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
					<PagerStyle CssClass="Normal" Mode="NumericPages"></PagerStyle>
				</asp:DataGrid><BR>
				<asp:Label ID="lblResults" EnableViewState="False" Width="400px" class="Normal" Runat="Server" CssClass="NormalRed" />
			</td>
		</tr>
	</table>
</p>
