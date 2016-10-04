Namespace ASPNetPortal

    Public MustInherit Class ModuleDefs
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents defsList As System.Web.UI.WebControls.DataList
        Protected WithEvents AddDefBtn As System.Web.UI.WebControls.LinkButton

        Private tabIndex As Integer = 0
        Private tabId As Integer = 0

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
        ' to populate the current defs settings from the configuration system
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Verify that the current user has access to access this page
            If PortalSecurity.IsInRoles("Admins") = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            If Not (Request.Params("tabid") Is Nothing) Then
                tabId = Int32.Parse(Request.Params("tabid"))
            End If
            If Not (Request.Params("tabindex") Is Nothing) Then
                tabIndex = Int32.Parse(Request.Params("tabindex"))
            End If

            ' If this is the first visit to the page, bind the definition data to the datalist
            If Page.IsPostBack = False Then
                BindData()
            End If

        End Sub


        '*******************************************************
        '
        ' The AddDef_Click server event handler is used to add
        ' a new module definition for this portal
        '
        '*******************************************************

        Private Sub AddDef_Click(ByVal Sender As Object, ByVal e As EventArgs) Handles AddDefBtn.Click

            ' redirect to edit page
            Response.Redirect(("~/Admin/ModuleDefinitions.aspx?defId=-1&tabindex=" & tabIndex & "&tabid=" & tabId))

        End Sub


        '*******************************************************
        '
        ' The DefsList_ItemCommand server event handler on this page
        ' is used to handle the user editing module definitions
        ' from the DefsList asp:datalist control
        '
        '*******************************************************

        Private Sub DefsList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles defsList.ItemCommand

            Dim moduleDefId As Integer = CInt(defsList.DataKeys(e.Item.ItemIndex))

            ' redirect to edit page
            Response.Redirect(("~/Admin/ModuleDefinitions.aspx?defId=" & moduleDefId & "&tabindex=" & tabIndex & "&tabid=" & tabId))

        End Sub


        '*******************************************************
        '
        ' The BindData helper method is used to bind the list of
        ' module definitions for this portal to an asp:datalist server control
        '
        '*******************************************************

        Sub BindData()

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            ' Get the portal's defs from the database
            Dim admin As New AdminDB()

            defsList.DataSource = admin.GetModuleDefinitions(_portalSettings.PortalId)
            defsList.DataBind()

        End Sub

    End Class

End Namespace
