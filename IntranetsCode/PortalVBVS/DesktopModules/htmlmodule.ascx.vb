Namespace ASPNetPortal

    Public MustInherit Class HtmlModule
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents t1 As System.Web.UI.HtmlControls.HtmlTable
        Protected WithEvents HtmlHolder As System.Web.UI.HtmlControls.HtmlTableCell

#Region " Web Form Designer Generated Code "

        'This call is required by the Web Form Designer.
        <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

        End Sub

        Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
            'CODEGEN: This method call is required by the Web Form Designer
            'Do not modify it using the code editor.
            InitializeComponent()
        End Sub

#End Region

        '*******************************************************
        '
        ' The Page_Load event handler on this User Control is
        ' used to render a block of HTML or text to the page.  
        ' The text/HTML to render is stored in the HtmlText 
        ' database table.  This method uses the ASPNetPortal.HtmlTextDB()
        ' data component to encapsulate all data functionality.
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Obtain the selected item from the HtmlText table
            Dim [text] As New ASPNetPortal.HtmlTextDB()
            Dim dr As SqlDataReader = [text].GetHtmlText(ModuleId)

            If dr.Read() Then

                ' Dynamically add the file content into the page
                Dim content As String = Server.HtmlDecode(CType(dr("DesktopHtml"), String))
                HtmlHolder.Controls.Add(New LiteralControl(content))

            End If

            ' Close the datareader
            dr.Close()

        End Sub

    End Class

End Namespace
