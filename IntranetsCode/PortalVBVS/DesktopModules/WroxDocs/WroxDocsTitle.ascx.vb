Namespace ASPNetPortal
   Public MustInherit Class WroxDocsTitle
      Inherits ASPNetPortal.PortalModuleControl

      Protected WithEvents ModuleTitle As System.Web.UI.WebControls.Label
      Protected WithEvents EditButton As System.Web.UI.WebControls.HyperLink
      Protected WithEvents SearchButton As System.Web.UI.WebControls.HyperLink
      Protected WithEvents AddDocumentButton As System.Web.UI.WebControls.HyperLink

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

      'Search Text
      Public SearchText As String = Nothing
      Public SearchUrl As String = Nothing
      Public SearchTarget As String = Nothing

      'Add Document text
      Public EditText As String = Nothing
      Public EditUrl As String = Nothing
      Public EditTarget As String = Nothing

      Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

         ' Obtain PortalSettings from Current Context
         Dim _portalSettings As PortalSettings = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

         ' Obtain reference to parent portal module
         Dim portalModule As PortalModuleControl = CType(Me.Parent, PortalModuleControl)

         ' Display Module Title and Buttons
         ModuleTitle.Text = portalModule.ModuleConfiguration.ModuleTitle

         ' Display the Edit button if the parent portalmodule has configured the PortalModuleTitle User Control
         ' to display it -- and the current client has edit access permissions
         If _portalSettings.AlwaysShowEditButton = True Or (PortalSecurity.IsInRoles(portalModule.ModuleConfiguration.AuthorizedEditRoles)) Then

            'Set the Add Document Button
            If Not IsNothing(EditText) Then
               EditButton.Text = EditText
               EditButton.NavigateUrl = EditUrl + "?mid=" + portalModule.ModuleId.ToString()
               EditButton.Target = EditTarget
            End If

         End If

         'Set the Search Button
         If Not IsNothing(SearchText) Then
            SearchButton.Text = SearchText
            SearchButton.NavigateUrl = SearchUrl + "?mid=" + portalModule.ModuleId.ToString()
            SearchButton.Target = SearchTarget
         End If



      End Sub

   End Class
End Namespace