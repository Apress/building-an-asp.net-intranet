<%@ Control Language="VB" Inherits="ASPNetPortal.MobilePortalModuleControl" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>
<%@ Register TagPrefix="portal" TagName="Title" Src="~/MobileModuleTitle.ascx" %>
<%@ Register TagPrefix="portal" Namespace="ASPNetPortal.MobileControls" Assembly="Portal" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%--

    The Text Mobile User Control renders text modules in the mobile portal. 

    The control consists of two pieces: a summary panel that is rendered when
    portal view shows a summarized view of all modules, and a multi-part panel 
    that renders the module details.

--%>

<script runat="server">

    Private mobileSummary As String = ""
    Private mobileDetails As String = ""

    '*********************************************************************
    '
    ' Page_Load Event Handler
    '
    ' The Page_Load event handler on this User Control is used to
    ' load the contents of the text message from a file, and databind
    ' the message to the module contents.
    '
    '*********************************************************************

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ' Obtain the selected item from the HtmlText table
        Dim [text] As New ASPNetPortal.HtmlTextDB()
        Dim dr As SqlDataReader = [text].GetHtmlText(ModuleId)

        If dr.Read() Then

            ' Dynamically add the file content into the page
            mobileSummary = Server.HtmlDecode(CStr(dr("MobileSummary")))
            mobileDetails = Server.HtmlDecode(CStr(dr("MobileDetails")))

        End If

        DataBind()

        ' Close the datareader
        dr.Close()

    End Sub
        
</script>

<mobile:Panel id="summary" runat="server">
    <DeviceSpecific>
        <Choice Filter="isJScript">
            <ContentTemplate>
                <portal:Title runat="server" />
                <font face="Verdana" size="-2">
                    <%# mobileSummary %>
                    <asp:LinkButton runat="server" Visible="<%# mobileDetails <> String.Empty %>" Text="more" CommandName="Details" />
                </font>
                <br>
                <br>
            </ContentTemplate>
        </Choice>
    </DeviceSpecific>
</mobile:Panel>

<portal:Title runat="server" />
<mobile:TextView runat="server" Text="<%# mobileDetails %>" Font-Name="Verdana" Font-Size="Small" />
<portal:LinkCommand runat="server" Text="back" CommandName="summary" Font-Name="Verdana" Font-Size="Small" />
