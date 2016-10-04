<%@ Control language="vb" Inherits="Wrox.Intranet.ContentManagement.Controls.DisplayContentSummary" CodeBehind="DisplayContentSummary.ascx.vb" AutoEventWireup="false" %>
<%@ Register TagPrefix="Wrox" TagName="Title" Src="ContentModuleTitle.ascx"%>
<%@ Register TagPrefix="Wrox" TagName="Actions" Src="ContentActionTabs.ascx"%>
<Wrox:Title EditText="Add Content" EditUrl="~/ContentManagement/EditContent.aspx"   SearchText="Search" SearchUrl="~/ContentManagement/ContentSearch.aspx" MyContentText="My Content" MyContentUrl="~/ContentManagement/MyContent.aspx"  runat="server" id="Title1" />
<br>
<asp:Label ID="ErrorMessage" Runat="server" CssClass="NormalRed"></asp:Label>
<asp:DataList id="myDataList" CellPadding="4" Width="98%" EnableViewState="false" runat="server">
	<ItemTemplate>
		<span class="ItemTitle">
			<asp:Label Text='<%# DataBinder.Eval(Container.DataItem,"Title") %>' runat="server" ID="Label1"/>
		</span>
		<br>
		<span class="Normal">
			<i>
				<%# DataBinder.Eval(Container.DataItem,"BeginDate", "{0:d}") %>
			</i>
		</span>
		<br>
		<span class="Normal">
			<%# DataBinder.Eval(Container.DataItem,"Summary") %>
		</span>
		<br>
		<p align="right">
			<Wrox:Actions Id="Actions2" runat=server EditVisible=<%# IsEditable %> EditText="Edit" EditUrl='<%# "EditContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & ModuleID  %>' ReadText="Read" ReadUrl='<%# "GetContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & ModuleID  %>' RelatedContentText="Related Content" RelatedContentUrl='<%# "RelatedContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & ModuleId  %>' />
		</p>
	</ItemTemplate>
	<AlternatingItemStyle BackColor="lightGray"></AlternatingItemStyle>
	<AlternatingItemTemplate>
		<span class="ItemTitle">
			<asp:Label Text='<%# DataBinder.Eval(Container.DataItem,"Title") %>' runat="server" ID="Label2"/>
		</span>
		<br>
		<span class="Normal">
			<i>
				<%# DataBinder.Eval(Container.DataItem,"BeginDate", "{0:d}") %>
			</i>
		</span>
		<br>
		<span class="Normal">
			<%# DataBinder.Eval(Container.DataItem,"Summary") %>
		</span>
		<br>
		<p align="right">
			<Wrox:Actions Id="Actions1" runat=server EditVisible=<%# IsEditable %> EditText="Edit" EditUrl='<%# "EditContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & ModuleID  %>' ReadText="Read" ReadUrl='<%# "GetContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & ModuleID  %>' RelatedContentText="Related Content" RelatedContentUrl='<%# "RelatedContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & ModuleId  %>' />
		</p>
	</AlternatingItemTemplate>
</asp:DataList>
