Namespace ASPNetPortal

    Public Class EditHtml
        Inherits System.Web.UI.Page

        Protected WithEvents DesktopText As System.Web.UI.WebControls.TextBox
        Protected WithEvents MobileSummary As System.Web.UI.WebControls.TextBox
        Protected WithEvents MobileDetails As System.Web.UI.WebControls.TextBox
        Protected WithEvents updateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents cancelButton As System.Web.UI.WebControls.LinkButton

        Private moduleId As Integer = 0

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
        ' The Page_Load event on this Page is used to obtain the ModuleId
        ' of the xml module to edit.
        '
        ' It then uses the ASPNetPortal.HtmlTextDB() data component
        ' to populate the page's edit controls with the text details.
        '
        '****************************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Determine ModuleId of Announcements Portal Module
            moduleId = Int32.Parse(Request.Params("Mid"))

            ' Verify that the current user has access to edit this module
            If PortalSecurity.HasEditPermissions(moduleId) = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            If Page.IsPostBack = False Then

                ' Obtain a single row of text information
                Dim _text As New ASPNetPortal.HtmlTextDB()
                Dim dr As SqlDataReader = _text.GetHtmlText(moduleId)

                If dr.Read() Then

                    DesktopText.Text = Server.HtmlDecode(CType(dr("DesktopHtml"), String))
                    MobileSummary.Text = Server.HtmlDecode(CType(dr("MobileSummary"), String))
                    MobileDetails.Text = Server.HtmlDecode(CType(dr("MobileDetails"), String))

                Else

                    DesktopText.Text = "Todo: Add Content..."
                    MobileSummary.Text = "Todo: Add Content..."
                    MobileDetails.Text = "Todo: Add Content..."

                End If

                dr.Close()

                ' Store URL Referrer to return to portal
                ViewState("UrlReferrer") = Request.UrlReferrer.ToString()

            End If

        End Sub


        '****************************************************************
        '
        ' The UpdateBtn_Click event handler on this Page is used to save
        ' the text changes to the database.
        '
        '****************************************************************

        Private Sub UpdateBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles updateButton.Click

            ' Create an instance of the HtmlTextDB component
            Dim _text As New ASPNetPortal.HtmlTextDB()

            ' Update the text within the HtmlText table
            _text.UpdateHtmlText(moduleId, Server.HtmlEncode(DesktopText.Text), Server.HtmlEncode(MobileSummary.Text), Server.HtmlEncode(MobileDetails.Text))

            ' Redirect back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

        End Sub


        '****************************************************************
        '
        ' The CancelBtn_Click event handler on this Page is used to cancel
        ' out of the page, and return the user back to the portal home
        ' page.
        '
        '****************************************************************'
        Private Sub CancelBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cancelButton.Click

            ' Redirect back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

        End Sub

    End Class

End Namespace