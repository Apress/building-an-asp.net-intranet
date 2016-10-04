<%@ Register TagPrefix="Portal" TagName="Title" Src="~/DesktopModuleTitle.ascx"%>
<%@ Control Language="vb" Inherits="ASPNetPortal.Books" Codebehind="Books.ascx.vb" AutoEventWireup="false" %>
<portal:title id="Title1" runat="server" EditUrl="~/DesktopModules/EditBooks.aspx" EditText="Add New Book"></portal:title>
<asp:datalist id="myDataList" runat="server" EnableViewState="false" Width="98%" CellPadding="4">
	<ItemTemplate>
		<table>
			<tr>
				<td colspan="2">
					<asp:HyperLink id="editLink" ImageUrl="~/images/edit.gif" NavigateUrl='<%# "~/DesktopModules/EditBooks.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ItemID") & "&mid=" & ModuleId %>' Visible="<%# IsEditable %>" runat="server" />
					<span class="ItemTitle">
						<%# DataBinder.Eval(Container.DataItem,"Title") %>
					</span>
				</td>
			</tr>
			<tr>
				<td rowspan="6">
					<img src='<%# DataBinder.Eval(Container.DataItem,"ImageUrl") %>'>
				</td>
				<td>
					<span class="ItemTitle">
						Authors
			        </span>
				</td>
			</tr>
			<tr>
				<td>
					<span class="Normal">
						<%# DataBinder.Eval(Container.DataItem,"Authors") %>
					</span>
				</td>
			</tr>
			<tr>
				<td>
					<span class="ItemTitle">
						Price
					</span>
				</td>
			</tr>
			<tr>
				<td>
					<span class="Normal">
						$<%# DataBinder.Eval(Container.DataItem,"Price") %>
					</span>
				</td>
			</tr>
			<tr>
				<td>
					<span class="ItemTitle">
						ISBN
					</span>
				</td>
			</tr>
			<tr>
				<td>
					<span class="Normal">
						<%# DataBinder.Eval(Container.DataItem,"ISBN") %>
					</span>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<asp:HyperLink id="buyLink" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"BuyLink") %>' Visible='<%# DataBinder.Eval(Container.DataItem,"BuyLink") <> String.Empty %>' runat="server">
						Buy book
					</asp:HyperLink>
				</td>
			</tr>
		</table>
		<br>
	</ItemTemplate>
</asp:datalist>
