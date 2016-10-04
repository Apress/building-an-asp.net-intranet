Namespace ASPNetPortal

    Public MustInherit Class Users
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents Message As System.Web.UI.WebControls.Literal
        Protected WithEvents allUsers As System.Web.UI.WebControls.DropDownList
        Protected WithEvents addNew As System.Web.UI.WebControls.LinkButton
        Protected WithEvents EditBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents DeleteBtn As System.Web.UI.WebControls.ImageButton

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
        ' The DeleteUser_Click server event handler is used to add
        ' a new security role for this portal
        '
        '*******************************************************

        Private Sub DeleteUser_Click(ByVal Sender As Object, ByVal e As ImageClickEventArgs) Handles DeleteBtn.Click

            ' get user id from dropdownlist of users
            Dim users As New UsersDB()
            users.DeleteUser(Int32.Parse(allUsers.SelectedItem.Value))

            ' Rebind list
            BindData()

        End Sub


        '*******************************************************
        '
        ' The EditUser_Click server event handler is used to add
        ' a new security role for this portal
        '
        '*******************************************************
        Private Sub EditUser_Click(ByVal Sender As Object, ByVal e As CommandEventArgs) Handles EditBtn.Command, addNew.Command

            ' get user id from dropdownlist of users
            Dim userId As Integer = -1
            Dim _userName As String = ""

            If e.CommandName = "edit" Then

                userId = Int32.Parse(allUsers.SelectedItem.Value)
                _userName = allUsers.SelectedItem.Text

            End If

            ' redirect to edit page
            Response.Redirect(("~/Admin/ManageUsers.aspx?userId=" & userId & "&username=" & _userName & "&tabindex=" & tabIndex & "&tabid=" & tabId))

        End Sub


        '*******************************************************
        '
        ' The BindData helper method is used to bind the list of
        ' users for this portal to an asp:DropDownList server control
        '
        '*******************************************************

        Sub BindData()

            ' change the message between Windows and Forms authentication
            If Context.User.Identity.AuthenticationType <> "Forms" Then

                Message.Text = "Users must be registered to view secure content.  Users may add themselves using the Register form, and Administrators may add users to specific roles using the Security Roles function above.  This section permits Administrators to manage users and their security roles directly."

            Else

                Message.Text = "Domain users do not need to be registered to access portal content that is available to ""All Users"".  Administrators may add domain users to specific roles using the Security Roles function above.  This section permits Administrators to manage users and their security roles directly."

            End If

            ' Get the list of registered users from the database
            Dim admin As New AdminDB()

            ' bind all portal users to dropdownlist
            allUsers.DataSource = admin.GetUsers()
            allUsers.DataBind()

        End Sub

    End Class

End Namespace
