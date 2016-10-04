Imports ASPNetPortal

Namespace Wrox.Intranet.ContentManagement.Controls

    Public MustInherit Class ContentModuleTitle
        Inherits System.Web.UI.UserControl

        Protected ModuleTitle As System.Web.UI.WebControls.Label
        Protected EditButton As System.Web.UI.WebControls.HyperLink
        Protected SearchButton As System.Web.UI.WebControls.HyperLink
        Protected MyContentButton As System.Web.UI.WebControls.HyperLink


        'Edit Text
        Public EditText As [String] = Nothing
        Public EditUrl As [String] = Nothing
        Public EditTarget As [String] = Nothing

        'Search Text
        Public SearchText As [String] = Nothing
        Public SearchUrl As [String] = Nothing
        Public SearchTarget As [String] = Nothing

        'My Content Text
        Public MyContentText As [String] = Nothing
        Public MyContentUrl As [String] = Nothing
        Public MyContentTarget As [String] = Nothing


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
            Dim portalSettings As portalSettings = CType(HttpContext.Current.Items("PortalSettings"), portalSettings)

            ' Obtain reference to parent portal module
            Dim portalModule As PortalModuleControl = CType(Me.Parent, PortalModuleControl)

            ' Display Modular Title Text and Edit Buttons
            ModuleTitle.Text = portalModule.ModuleConfiguration.ModuleTitle

            ' Check the access rights to display the Add and My Content links
            If portalSettings.AlwaysShowEditButton = True Or (PortalSecurity.IsInRoles(portalModule.ModuleConfiguration.AuthorizedEditRoles)) Then

                If Not (EditText Is Nothing) Then
                    EditButton.Text = EditText
                    EditButton.NavigateUrl = EditUrl + "?mid=" + portalModule.ModuleId.ToString()
                    EditButton.Target = EditTarget
                End If

                'Set the My Content Button
                If Not IsNothing(MyContentText) Then
                    MyContentButton.Text = MyContentText
                    MyContentButton.NavigateUrl = MyContentUrl + "?mid=" + portalModule.ModuleId.ToString()
                    MyContentButton.Target = MyContentTarget
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