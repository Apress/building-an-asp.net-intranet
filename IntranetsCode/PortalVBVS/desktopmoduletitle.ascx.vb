Namespace ASPNetPortal

    Public MustInherit Class DesktopModuleTitle
        Inherits System.Web.UI.UserControl

        Protected ModuleTitle As System.Web.UI.WebControls.Label
        Protected EditButton As System.Web.UI.WebControls.HyperLink

        Public EditText As [String] = Nothing
        Public EditUrl As [String] = Nothing
        Public EditTarget As [String] = Nothing


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

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

            ' Obtain reference to parent portal module
            Dim portalModule As PortalModuleControl = CType(Me.Parent, PortalModuleControl)

            ' Display Modular Title Text and Edit Buttons
            ModuleTitle.Text = portalModule.ModuleConfiguration.ModuleTitle

            ' Display the Edit button if the parent portalmodule has configured the PortalModuleTitle User Control
            ' to display it -- and the current client has edit access permissions
            If _portalSettings.AlwaysShowEditButton = True Or (PortalSecurity.IsInRoles(portalModule.ModuleConfiguration.AuthorizedEditRoles) And Not (EditText Is Nothing)) Then

                EditButton.Text = EditText
                EditButton.NavigateUrl = EditUrl + "?mid=" + portalModule.ModuleId.ToString()
                EditButton.Target = EditTarget
            End If

        End Sub

    End Class

End Namespace 