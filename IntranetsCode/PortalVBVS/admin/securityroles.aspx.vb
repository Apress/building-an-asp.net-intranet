Namespace ASPNetPortal

    Public Class SecurityRoles
        Inherits System.Web.UI.Page

        Protected WithEvents Message As System.Web.UI.WebControls.Label
        Protected WithEvents windowsUserName As System.Web.UI.WebControls.TextBox
        Protected WithEvents addNew As System.Web.UI.WebControls.LinkButton
        Protected WithEvents allUsers As System.Web.UI.WebControls.DropDownList
        Protected WithEvents addExisting As System.Web.UI.WebControls.LinkButton
        Protected WithEvents usersInRole As System.Web.UI.WebControls.DataList
        Protected WithEvents saveBtn As System.Web.UI.WebControls.LinkButton
        Protected WithEvents title As System.Web.UI.HtmlControls.HtmlGenericControl

        Private roleId As Integer = -1
        Private roleName As String = ""
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
        ' The Page_Load server event handler on this page is used
        ' to populate the role information for the page
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Verify that the current user has access to access this page
            If PortalSecurity.IsInRoles("Admins") = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            ' Calculate security roleId
            If Not (Request.Params("roleid") Is Nothing) Then
                roleId = Int32.Parse(Request.Params("roleid"))
            End If
            If Not (Request.Params("rolename") Is Nothing) Then
                roleName = CType(Request.Params("rolename"), String)
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
        ' The Save_Click server event handler on this page is used
        ' to save the current security settings to the configuration system
        '
        '*******************************************************

        Private Sub Save_Click(ByVal Sender As Object, ByVal e As EventArgs) Handles saveBtn.Click

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            ' Navigate back to admin page
            Response.Redirect(("~/DesktopDefault.aspx?tabindex=" & tabIndex & "&tabid=" & tabId))

        End Sub


        '*******************************************************
        '
        ' The AddUser_Click server event handler is used to add
        ' a new user to this security role 
        '
        '*******************************************************

        Private Sub AddUser_Click(ByVal Sender As Object, ByVal e As EventArgs) Handles addExisting.Click

            ' get user id
            Dim userId As Integer = Int32.Parse(allUsers.SelectedItem.Value)

            ' Add a new userRole to the database
            Dim admin As New AdminDB()
            admin.AddUserRole(roleId, userId)

            ' Rebind list
            BindData()

        End Sub


        '*******************************************************
        '
        ' The usersInRole_ItemCommand server event handler on this page 
        ' is used to handle the user editing and deleting roles
        ' from the usersInRole asp:datalist control
        '
        '*******************************************************

        Private Sub usersInRole_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles usersInRole.ItemCommand

            Dim admin As New AdminDB()
            Dim userId As Integer = CInt(usersInRole.DataKeys(e.Item.ItemIndex))

            If e.CommandName = "delete" Then

                ' update database
                admin.DeleteUserRole(roleId, userId)

                ' Ensure that item is not editable
                usersInRole.EditItemIndex = -1

                ' Repopulate list
                BindData()
            End If

        End Sub


        '*******************************************************
        '
        ' The BindData helper method is used to bind the list of 
        ' security roles for this portal to an asp:datalist server control
        '
        '*******************************************************'

        Sub BindData()

            ' add the role name to the title
            If roleName <> "" Then
                title.InnerText = "Role Membership: " & roleName
            End If

            ' Get the portal's roles from the database
            Dim admin As New AdminDB()

            ' bind users in role to DataList
            usersInRole.DataSource = admin.GetRoleMembers(roleId)
            usersInRole.DataBind()

            ' bind all portal users to dropdownlist
            allUsers.DataSource = admin.GetUsers()
            allUsers.DataBind()

        End Sub

    End Class

End Namespace
