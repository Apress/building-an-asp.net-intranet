Namespace ASPNetPortal

    Public MustInherit Class Roles
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents rolesList As System.Web.UI.WebControls.DataList
        Protected WithEvents AddRoleBtn As System.Web.UI.WebControls.LinkButton

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
        ' to populate the current roles settings from the configuration system
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

            ' If this is the first visit to the page, bind the role data to the datalist
            If Page.IsPostBack = False Then
                BindData()
            End If

        End Sub


        '*******************************************************
        '
        ' The AddRole_Click server event handler is used to add
        ' a new security role for this portal
        '
        '*******************************************************

        Private Sub AddRole_Click(ByVal Sender As Object, ByVal e As EventArgs) Handles AddRoleBtn.Click

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            ' Add a new role to the database
            Dim admin As New AdminDB()
            admin.AddRole(_portalSettings.PortalId, "New Role")

            ' set the edit item index to the last item
            rolesList.EditItemIndex = rolesList.Items.Count

            ' Rebind list
            BindData()

        End Sub


        '*******************************************************
        '
        ' The RolesList_ItemCommand server event handler on this page
        ' is used to handle the user editing and deleting roles
        ' from the RolesList asp:datalist control
        '
        '*******************************************************

        Private Sub RolesList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles rolesList.ItemCommand

            Dim admin As New AdminDB()
            Dim roleId As Integer = CInt(rolesList.DataKeys(e.Item.ItemIndex))

            If e.CommandName = "edit" Then

                ' Set editable list item index if "edit" button clicked next to the item
                rolesList.EditItemIndex = e.Item.ItemIndex

                ' Repopulate the datalist control
                BindData()

            Else

                If e.CommandName = "apply" Then

                    ' Apply changes
                    Dim _roleName As String = CType(e.Item.FindControl("roleName"), TextBox).Text

                    ' update database
                    admin.UpdateRole(roleId, _roleName)

                    ' Disable editable list item access
                    rolesList.EditItemIndex = -1

                    ' Repopulate the datalist control
                    BindData()

                Else

                    If e.CommandName = "delete" Then

                        ' update database
                        admin.DeleteRole(roleId)

                        ' Ensure that item is not editable
                        rolesList.EditItemIndex = -1

                        ' Repopulate list
                        BindData()
                    Else

                        If e.CommandName = "members" Then

                            ' Save role name changes first
                            Dim _roleName As String = CType(e.Item.FindControl("roleName"), TextBox).Text
                            admin.UpdateRole(roleId, _roleName)

                            ' redirect to edit page
                            Response.Redirect(("~/Admin/SecurityRoles.aspx?roleId=" & roleId & "&rolename=" & _roleName & "&tabindex=" & tabIndex & "&tabid=" & tabId))

                        End If

                    End If

                End If

            End If

        End Sub


        '*******************************************************
        '
        ' The BindData helper method is used to bind the list of
        ' security roles for this portal to an asp:datalist server control
        '
        '*******************************************************'

        Sub BindData()

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            ' Get the portal's roles from the database
            Dim admin As New AdminDB()

            rolesList.DataSource = admin.GetPortalRoles(_portalSettings.PortalId)
            rolesList.DataBind()

        End Sub

    End Class

End Namespace
