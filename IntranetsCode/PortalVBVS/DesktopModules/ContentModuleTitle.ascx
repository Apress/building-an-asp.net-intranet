<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ContentModuleTitle.ascx.vb" Inherits="Wrox.Intranet.ContentManagement.Controls.ContentModuleTitle" TargetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" %>
<table width="98%" cellspacing="0" cellpadding="2">
	<tr>
		<td align="left" width="80%">
			<asp:label id="ModuleTitle" cssclass="Head" EnableViewState="false" runat="server" />
		</td>
		<td align="right" nowrap>
			<asp:hyperlink id="EditButton" cssclass="CommandButton" EnableViewState="false" runat="server" />
		</td>
		<td align="right" nowrap>
			<asp:hyperlink id="SearchButton" cssclass="CommandButton" EnableViewState="false" runat="server" />
		</td>
		<td align="right" nowrap>
			<asp:hyperlink id="MyContentButton" cssclass="CommandButton" EnableViewState="false" runat="server" />
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<hr noshade size="4">
		</td>
	</tr>
</table>
