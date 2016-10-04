Namespace ASPNetPortal

    Public Class ManageUsers
        Inherits System.Web.UI.Page

        Protected WithEvents Email As System.Web.UI.WebControls.TextBox
        Protected WithEvents Password As System.Web.UI.WebControls.TextBox
        Protected WithEvents allRoles As System.Web.UI.WebControls.DropDownList
        Protected WithEvents addExisting As System.Web.UI.WebControls.LinkButton
        Protected WithEvents userRoles As System.Web.UI.WebControls.DataList
        Protected WithEvents saveBtn As System.Web.UI.WebControls.LinkButton
        Protected WithEvents title As System.Web.UI.HtmlControls.HtmlGenericControl
        Protected WithEvents UpdateUserBtn As System.Web.UI.WebControls.LinkButton

        Private userId As Integer = -1
        Private userName As String = ""
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

            ' Calculate userid
            If Not (Request.Params("userid") Is Nothing) Then
                userId = Int32.Parse(Request.Params("userid"))
            End If

            If Not (Request.Params("username") Is Nothing) Then
                userName = CStr(Request.Params("username"))
            End If

            If Not (Request.Params("tabid") Is Nothing) Then
                tabId = Int32.Parse(Request.Params("tabid"))
            End If

            If Not (Request.Params("tabindex") Is Nothing) Then
                tabIndex = Int32.Parse(Request.Params("tabindex"))
            End If


            ' If this is the first visit to the page, bind the role data to the datalist
            If Page.IsPostBack = False Then

                ' new user?
                If userName = "" Then

                    Dim users As New UsersDB()

                    ' make a unique new user record
                    Dim uid As Integer = -1
                    Dim i As Integer = 0

                    While uid = -1

                        Dim friendlyName As String = "New User created " & DateTime.Now.ToString()
                        userName = "New User" & i.ToString()
                        uid = users.AddUser(friendlyName, userName, "")
                        i += 1
                    End While

                    ' redirect to this page with the corrected querystring args
                    Response.Redirect(("~/Admin/ManageUsers.aspx?userId=" & uid & "&username=" & userName & "&tabindex=" & tabIndex & "&tabid=" & tabId))

                End If

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

            ' Navigate back to admin page
            Response.Redirect(("~/DesktopDefault.aspx?tabindex=" & tabIndex & "&tabid=" & tabId))

        End Sub


        '*******************************************************
        '
        ' The AddRole_Click server event handler is used to add
        ' the user to this security role
        '
        '*******************************************************

        Private Sub AddRole_Click(ByVal sender As Object, ByVal e As EventArgs) Handles addExisting.Click

            Dim roleId As Integer

            'get user id from dropdownlist of existing users
            roleId = Int32.Parse(allRoles.SelectedItem.Value)

            ' Add a new userRole to the database
            Dim admin As New AdminDB()
            admin.AddUserRole(roleId, userId)

            ' Rebind list
            BindData()

        End Sub


        '*******************************************************
        '
        ' The UpdateUser_Click server event handler is used to add
        ' the update the user settings
        '
        '*******************************************************

        Private Sub UpdateUser_Click(ByVal sender As Object, ByVal e As EventArgs) Handles UpdateUserBtn.Click

            ' update the user record in the database
            Dim users As New UsersDB()
            users.UpdateUser(userId, Email.Text, Password.Text)

            ' redirect to this page with the corrected querystring args
            Response.Redirect(("~/Admin/ManageUsers.aspx?userId=" & userId & "&username=" & Email.Text & "&tabindex=" & tabIndex & "&tabid=" & tabId))

        End Sub


        '*******************************************************
        '
        ' The UserRoles_ItemCommand server event handler on this page
        ' is used to handle deleting the user from roles
        ' from the userRoles asp:datalist control
        '
        '*******************************************************

        Private Sub UserRoles_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles userRoles.ItemCommand

            Dim admin As New AdminDB()
            Dim roleId As Integer = CInt(userRoles.DataKeys(e.Item.ItemIndex))

            ' update database
            admin.DeleteUserRole(roleId, userId)

            ' Ensure that item is not editable
            userRoles.EditItemIndex = -1

            ' Repopulate list
            BindData()

        End Sub


        '*******************************************************
        '
        ' The BindData helper method is used to bind the list of
        ' security roles for this portal to an asp:datalist server control
        '
        '*******************************************************

        Sub BindData()

            ' Bind the Email and Password
            Dim users As New UsersDB()
            Dim dr As SqlDataReader = users.GetSingleUser(userName)

            ' Read first row from database
            dr.Read()

            Email.Text = CStr(dr("Email"))
            Password.Text = CStr(dr("Password"))

            dr.Close()

            ' add the user name to the title
            If userName <> "" Then
                title.InnerText = "Manage User: " & userName
            End If

            ' bind users in role to DataList
            userRoles.DataSource = users.GetRolesByUser(userName)
            userRoles.DataBind()

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            ' Get the portal's roles from the database
            Dim admin As New AdminDB()

            ' bind all portal roles to dropdownlist
            allRoles.DataSource = admin.GetPortalRoles(_portalSettings.PortalId)
            allRoles.DataBind()

        End Sub

    End Class

End Namespace