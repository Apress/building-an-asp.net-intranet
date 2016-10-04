Namespace ASPNetPortal

    Public Class NotImplemented
        Inherits System.Web.UI.Page

        Protected WithEvents title As System.Web.UI.HtmlControls.HtmlGenericControl

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

        '****************************************************************
        '
        ' The Page_Load event on this Page is used to obtain the title
        ' of the fictious content item.
        '
        '****************************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            If Not (Request.Params("title") Is Nothing) Then
                title.InnerHtml = Request.Params("title").ToString()
            End If

        End Sub

    End Class

End Namespace
