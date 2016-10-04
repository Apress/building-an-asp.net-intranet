<%@ Control CodeBehind="ContentActionTabs.ascx.vb" language="vb" AutoEventWireup="false" Inherits="Wrox.Intranet.ContentManagement.Controls.ContentActionTabs" %>
<table width="98%" cellspacing="0" cellpadding="3">
	<tr>
		<td width="100%"></td>
		<td align="right" nowrap>
			<asp:hyperlink id="ReadLink" cssclass="CommandButton" EnableViewState="false" runat="server" />
		</td>
		<td align="right" nowrap>
			<asp:hyperlink id="RelatedContentLink" cssclass="CommandButton" EnableViewState="false" runat="server" />
		</td>
		<td align="right" nowrap>
			<asp:hyperlink id="EditLink" cssclass="CommandButton" EnableViewState="false" runat="server" />
		</td>
	</tr>
</table>
