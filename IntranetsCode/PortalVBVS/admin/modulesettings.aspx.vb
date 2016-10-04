Namespace ASPNetPortal

    Public Class ModuleSettingsPage
        Inherits System.Web.UI.Page

        Protected WithEvents moduleTitle As System.Web.UI.WebControls.TextBox
        Protected WithEvents cacheTime As System.Web.UI.WebControls.TextBox
        Protected WithEvents authEditRoles As System.Web.UI.WebControls.CheckBoxList
        Protected WithEvents showMobile As System.Web.UI.WebControls.CheckBox
        Protected WithEvents ApplyButton As System.Web.UI.WebControls.LinkButton

        Private moduleId As Integer = 0
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
        ' to populate the module settings on the page
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Verify that the current user has access to access this page
            If PortalSecurity.IsInRoles("Admins") = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            ' Determine Module to Edit
            If Not (Request.Params("mid") Is Nothing) Then
                moduleId = Int32.Parse(Request.Params("mid"))
            End If
            ' Determine Tab to Edit
            If Not (Request.Params("tabid") Is Nothing) Then
                tabId = Int32.Parse(Request.Params("tabid"))
            End If

            If Page.IsPostBack = False Then
                BindData()
            End If

        End Sub


        '*******************************************************
        '
        ' The ApplyChanges_Click server event handler on this page is used
        ' to save the module settings into the portal configuration system
        '
        '*******************************************************

        Private Sub ApplyChanges_Click(ByVal Sender As Object, ByVal e As EventArgs) Handles ApplyButton.Click

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

            Dim value As Object = GetModule()
            If Not (value Is Nothing) Then

                Dim m As ModuleSettings = CType(value, ModuleSettings)

                ' Construct Authorized User Roles String
                Dim editRoles As String = ""

                Dim item As ListItem
                For Each item In authEditRoles.Items

                    If item.Selected = True Then
                        editRoles = editRoles & item.Text & ";"
                    End If

                Next item

                ' update module
                Dim admin As New AdminDB()
                admin.UpdateModule(moduleId, m.ModuleOrder, m.PaneName, moduleTitle.Text, Int32.Parse(cacheTime.Text), editRoles, showMobile.Checked)

                ' Update Textbox Settings
                moduleTitle.Text = m.ModuleTitle
                cacheTime.Text = m.CacheTime.ToString()

                ' Populate checkbox list with all security roles for this portal
                ' and "check" the ones already configured for this module
                Dim roles As SqlDataReader = admin.GetPortalRoles(_portalSettings.PortalId)

                ' Clear existing items in checkboxlist
                authEditRoles.Items.Clear()

                Dim allItem As New ListItem()
                allItem.Text = "All Users"

                If m.AuthorizedEditRoles.LastIndexOf("All Users") > -1 Then
                    allItem.Selected = True
                End If

                authEditRoles.Items.Add(allItem)

                While roles.Read()

                    item = New ListItem()
                    item.Text = CType(roles("RoleName"), String)
                    item.Value = roles("RoleID").ToString()

                    If m.AuthorizedEditRoles.LastIndexOf(item.Text) > -1 Then
                        item.Selected = True
                    End If

                    authEditRoles.Items.Add(item)

                End While

            End If

            ' Navigate back to admin page
            Response.Redirect(("TabLayout.aspx?tabid=" & tabId))

        End Sub


        '*******************************************************
        '
        ' The BindData helper method is used to populate a asp:datalist
        ' server control with the current "edit access" permissions
        ' set within the portal configuration system
        '
        '*******************************************************

        Sub BindData()

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

            Dim value As Object = GetModule()
            If Not (value Is Nothing) Then

                Dim m As ModuleSettings = CType(value, ModuleSettings)

                ' Update Textbox Settings
                moduleTitle.Text = m.ModuleTitle
                cacheTime.Text = m.CacheTime.ToString()
                showMobile.Checked = m.ShowMobile

                ' Populate checkbox list with all security roles for this portal
                ' and "check" the ones already configured for this module
                Dim admin As New AdminDB()
                Dim roles As SqlDataReader = admin.GetPortalRoles(_portalSettings.PortalId)

                ' Clear existing items in checkboxlist
                authEditRoles.Items.Clear()

                Dim allItem As New ListItem()
                allItem.Text = "All Users"

                If m.AuthorizedEditRoles.LastIndexOf("All Users") > -1 Then
                    allItem.Selected = True
                End If

                authEditRoles.Items.Add(allItem)

                While roles.Read()

                    Dim item As New ListItem()
                    item.Text = CType(roles("RoleName"), String)
                    item.Value = roles("RoleID").ToString()

                    If m.AuthorizedEditRoles.LastIndexOf(item.Text) > -1 Then
                        item.Selected = True
                    End If

                    authEditRoles.Items.Add(item)

                End While

            End If

        End Sub


        Function GetModule() As ModuleSettings

            ' Obtain PortalSettings for this tab
            Dim _portalSettings As PortalSettings = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

            ' Obtain selected module data'
            Dim _module As ModuleSettings
            For Each _module In _portalSettings.ActiveTab.Modules

                If _module.ModuleId = moduleId Then
                    Return _module
                End If

            Next _module

            Return Nothing

        End Function

    End Class

End Namespace
