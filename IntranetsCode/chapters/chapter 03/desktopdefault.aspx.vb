Namespace ASPNetPortal

    Public Class DesktopDefault
        Inherits System.Web.UI.Page

        Protected LeftPane As System.Web.UI.HtmlControls.HtmlTableCell
        Protected ContentPane As System.Web.UI.HtmlControls.HtmlTableCell
      Protected WithEvents FooterPane As System.Web.UI.HtmlControls.HtmlTableCell
      Protected RightPane As System.Web.UI.HtmlControls.HtmlTableCell

#Region " Web Form Designer Generated Code "

        'This call is required by the Web Form Designer.
        <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

      End Sub

#End Region

        Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
            '
            ' CODEGEN: This call is required by the ASP.NET Web Form Designer.
            '
            InitializeComponent()

            '*********************************************************************
            '
            ' Page_Init Event Handler
            '
            ' The Page_Init event handler executes at the very beginning of each page
            ' request (immediately before Page_Load).
            '
            ' The Page_Init event handler below determines the tab index of the currently
            ' requested portal view, and then calls the PopulatePortalSection utility
            ' method to dynamically populate the left, center and right hand sections
            ' of the portal tab.
            '
            '*********************************************************************
            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

            ' Ensure that the visiting user has access to the current page
            If PortalSecurity.IsInRoles(_portalSettings.ActiveTab.AuthorizedRoles) = False Then
                Response.Redirect("~/Admin/AccessDenied.aspx")
            End If

            ' Dynamically inject a signin login module into the top left-hand corner
            ' of the home page if the client is not yet authenticated
            If Request.IsAuthenticated = False And _portalSettings.ActiveTab.TabIndex = 0 Then
                LeftPane.Controls.Add(Page.LoadControl("~/DesktopModules/SignIn.ascx"))
                LeftPane.Visible = True
            End If

            ' Dynamically Populate the Left, Center and Right pane sections of the portal page
            If _portalSettings.ActiveTab.Modules.Count > 0 Then

                ' Loop through each entry in the configuration system for this tab
                Dim _moduleSettings As ModuleSettings
                For Each _moduleSettings In _portalSettings.ActiveTab.Modules

                    Dim parent As Control = Page.FindControl(_moduleSettings.PaneName)

                    ' If no caching is specified, create the user control instance and dynamically
                    ' inject it into the page.  Otherwise, create a cached module instance that
                    ' may or may not optionally inject the module into the tree
                    If _moduleSettings.CacheTime = 0 Then

                        Dim portalModule As PortalModuleControl = CType(Page.LoadControl(_moduleSettings.DesktopSrc), PortalModuleControl)

                        portalModule.PortalId = _portalSettings.PortalId
                        portalModule.ModuleConfiguration = _moduleSettings

                        parent.Controls.Add(portalModule)

                    Else

                        Dim portalModule As New CachedPortalModuleControl()

                        portalModule.PortalId = _portalSettings.PortalId
                        portalModule.ModuleConfiguration = _moduleSettings

                        parent.Controls.Add(portalModule)

                    End If

                    ' Dynamically inject separator break between portal modules
                    parent.Controls.Add(New LiteralControl("<" + "br" + ">"))
                    parent.Visible = True

                Next _moduleSettings

            End If

        End Sub

    End Class

End Namespace