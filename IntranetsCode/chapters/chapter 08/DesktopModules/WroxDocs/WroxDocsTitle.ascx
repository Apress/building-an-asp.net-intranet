<%@ Control Language="vb" AutoEventWireup="false" Codebehind="WroxDocsTitle.ascx.vb" Inherits="ASPNetPortal.WroxDocsTitle" TargetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" %>
<TABLE width="100%" cellspacing="0" cellpadding="2">
   <TR>
      <TD align="left">
         <asp:label id="ModuleTitle" cssclass="Head" EnableViewState="false" runat="server" />
      </TD>
      <TD align="right" nowrap>
         <asp:hyperlink id="SearchButton" cssclass="CommandButton" EnableViewState="false" runat="server" />
         <asp:hyperlink id="EditButton" cssclass="CommandButton" EnableViewState="false" runat="server" />
      </TD>
   </TR>
   <TR>
      <TD colspan="4">
         <HR noshade size="4">
      </TD>
   </TR>
</TABLE>
