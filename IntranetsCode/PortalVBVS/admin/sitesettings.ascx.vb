Namespace ASPNetPortal

    Public Class SiteSettings
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents siteName As System.Web.UI.WebControls.TextBox
        Protected WithEvents showEdit As System.Web.UI.WebControls.CheckBox
        Protected WithEvents applyBtn As System.Web.UI.WebControls.LinkButton

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
        ' The Page_Load server event handler on this user control is used
        ' to populate the current site settings from the config system
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Verify that the current user has access to access this page
            If PortalSecurity.IsInRoles("Admins") = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            ' If this is the first visit to the page, populate the site data
            If Page.IsPostBack = False Then

                ' Obtain PortalSettings from Current Context
                Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

                siteName.Text = _portalSettings.PortalName
                showEdit.Checked = _portalSettings.AlwaysShowEditButton

            End If

        End Sub


        '*******************************************************
        '
        ' The Apply_Click server event handler is used
        ' to update the Site Name within the Portal Config System
        '
        '*******************************************************

        Private Sub Apply_Click(ByVal sender As Object, ByVal e As EventArgs) Handles applyBtn.Click

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            ' update Tab info in the database
            Dim admin As New AdminDB()
            admin.UpdatePortalInfo(_portalSettings.PortalId, siteName.Text, showEdit.Checked)

            ' Redirect to this site to refresh
            Response.Redirect(Request.RawUrl)

        End Sub

    End Class

End Namespace

