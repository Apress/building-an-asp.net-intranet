<%@ Control language="vb" Inherits="ASPNetPortal.XmlModule" CodeBehind="xmlmodule.ascx.vb" AutoEventWireup="false" %>
<%@ Register TagPrefix="Portal" TagName="Title" Src="~/DesktopModuleTitle.ascx"%>

<portal:title EditText="Edit" EditUrl="~/DesktopModules/EditXml.aspx" runat="server" id=Title1 />

<span class="Normal">
    <asp:xml id="xml1" runat="server" />
</span>
