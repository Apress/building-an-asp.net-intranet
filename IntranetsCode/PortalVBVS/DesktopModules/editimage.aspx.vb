Namespace ASPNetPortal

    Public Class EditImage
        Inherits System.Web.UI.Page

        Protected WithEvents Src As System.Web.UI.WebControls.TextBox
        Protected WithEvents Width As System.Web.UI.WebControls.TextBox
        Protected WithEvents Height As System.Web.UI.WebControls.TextBox
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
        ' of the image module to edit.
        '
        ' It then uses the ASP.NET configuration system to populate the page's
        ' edit controls with the image details.
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

                If moduleId > 0 Then

                    Dim settings As Hashtable

                    ' Get settings from the database
                    settings = PortalSettings.GetModuleSettings(moduleId)

                    Src.Text = CType(settings("src"), String)
                    Width.Text = CType(settings("width"), String)
                    Height.Text = CType(settings("height"), String)

                End If

                ' Store URL Referrer to return to portal
                ViewState("UrlReferrer") = Request.UrlReferrer.ToString()

            End If

        End Sub


        '****************************************************************
        '
        ' The UpdateBtn_Click event handler on this Page is used to save
        ' the settings to the ModuleSettings database table.  It  uses the
        ' ASPNetPortal.AdminDB() data component to encapsulate the data
        ' access functionality.
        '
        '****************************************************************

        Private Sub UpdateBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles updateButton.Click

            ' Update settings in the database
            Dim admin As New AdminDB()

            admin.UpdateModuleSetting(moduleId, "src", Src.Text)
            admin.UpdateModuleSetting(moduleId, "height", Height.Text)
            admin.UpdateModuleSetting(moduleId, "width", Width.Text)

            ' Redirect back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

        End Sub


        '****************************************************************
        '
        ' The CancelBtn_Click event handler on this Page is used to cancel
        ' out of the page, and return the user back to the portal home
        ' page.
        '
        '****************************************************************

        Private Sub CancelBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cancelButton.Click

            ' Redirect back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

        End Sub


    End Class

End Namespace