Namespace ASPNetPortal

    Public Class TabLayout
        Inherits System.Web.UI.Page

        Protected WithEvents tabName As System.Web.UI.WebControls.TextBox
        Protected WithEvents authRoles As System.Web.UI.WebControls.CheckBoxList
        Protected WithEvents showMobile As System.Web.UI.WebControls.CheckBox
        Protected WithEvents mobileTabName As System.Web.UI.WebControls.TextBox
        Protected WithEvents moduleType As System.Web.UI.WebControls.DropDownList
        Protected WithEvents moduleTitle As System.Web.UI.WebControls.TextBox
        Protected WithEvents leftPane As System.Web.UI.WebControls.ListBox
        Protected WithEvents contentPane As System.Web.UI.WebControls.ListBox
        Protected WithEvents rightPane As System.Web.UI.WebControls.ListBox
        Protected WithEvents applyBtn As System.Web.UI.WebControls.LinkButton
        Protected WithEvents AddModuleBtn As System.Web.UI.WebControls.LinkButton
        Protected WithEvents LeftUpBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents LeftRightBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents LeftDownBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents LeftEditBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents LeftDeleteBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents ContentUpBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents ContentLeftBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents ContentRightBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents ContentDownBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents ContentEditBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents ContentDeleteBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents RightUpBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents RightLeftBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents RightDownBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents RightEditBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents RightDeleteBtn As System.Web.UI.WebControls.ImageButton

        Private tabId As Integer = 0
        Protected leftList As ArrayList
        Protected contentList As ArrayList
      Protected WithEvents footerPane As System.Web.UI.WebControls.ListBox
      Protected WithEvents FooterUpBtn As System.Web.UI.WebControls.ImageButton
      Protected WithEvents FooterLeftBtn As System.Web.UI.WebControls.ImageButton
      Protected WithEvents FooterDownBtn As System.Web.UI.WebControls.ImageButton
      Protected WithEvents FooterEditBtn As System.Web.UI.WebControls.ImageButton
      Protected WithEvents FooterDeleteBtn As System.Web.UI.WebControls.ImageButton
      Protected rightList As ArrayList
      Protected WithEvents RightRightBtn As System.Web.UI.WebControls.ImageButton
      Protected footerList As ArrayList

        '*******************************************************
        '
        ' The Page_Load server event handler on this page is used
        ' to populate a tab's layout settings on the page
        '
        '*******************************************************

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
        ' to populate a tab's layout settings on the page
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Verify that the current user has access to access this page
            If PortalSecurity.IsInRoles("Admins") = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            ' Determine Tab to Edit
            If Not (Request.Params("tabid") Is Nothing) Then
                tabId = Int32.Parse(Request.Params("tabid"))
            End If

            ' If first visit to the page, update all entries
            If Page.IsPostBack = False Then
                BindData()
            End If

        End Sub


        '*******************************************************
        '
        ' The AddModuleToPane_Click server event handler on this page is used
        ' to add a new portal module into the tab
        '
        '*******************************************************

        Private Sub AddModuleToPane_Click(ByVal sender As Object, ByVal e As EventArgs) Handles AddModuleBtn.Click

            ' All new modules go to the end of the contentpane
            Dim m As New ModuleItem()
            m.ModuleTitle = moduleTitle.Text
            m.ModuleDefId = Int32.Parse(moduleType.SelectedItem.Value)
            m.ModuleOrder = 999

            ' save to database
            Dim admin As New AdminDB()
            m.ModuleId = admin.AddModule(tabId, m.ModuleOrder, "ContentPane", m.ModuleTitle, m.ModuleDefId, 0, "Admins", False)

            ' Obtain portalId from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            ' reload the _portalSettings from the database
            HttpContext.Current.Items("PortalSettings") = New PortalSettings(_portalSettings.PortalId, tabId)

            ' reorder the modules in the content pane
            Dim modules As ArrayList = GetModules("ContentPane")
            OrderModules(modules)

            ' resave the order
            Dim item As ModuleItem
            For Each item In modules
                admin.UpdateModuleOrder(item.ModuleId, item.ModuleOrder, "ContentPane")
            Next item

            ' Redirect to the same page to pick up changes
            Response.Redirect(Request.RawUrl)

        End Sub


        '*******************************************************
        '
        ' The UpDown_Click server event handler on this page is
        ' used to move a portal module up or down on a tab's layout pane
        '
        '*******************************************************

      Private Sub UpDown_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles LeftDownBtn.Click, LeftUpBtn.Click, ContentDownBtn.Click, ContentUpBtn.Click, RightDownBtn.Click, RightUpBtn.Click, FooterDownBtn.Click, FooterUpBtn.Click

         Dim cmd As String = CType(sender, ImageButton).CommandName
         Dim pane As String = CType(sender, ImageButton).CommandArgument
         Dim _listbox As ListBox = CType(Page.FindControl(pane), ListBox)

         Dim modules As ArrayList = GetModules(pane)

         If _listbox.SelectedIndex <> -1 Then

            Dim delta As Integer
            Dim selection As Integer = -1

            ' Determine the delta to apply in the order number for the module
            ' within the list.  +3 moves down one item; -3 moves up one item
            If cmd = "down" Then

               delta = 3
               If _listbox.SelectedIndex < _listbox.Items.Count - 1 Then
                  selection = _listbox.SelectedIndex + 1
               End If

            Else

               delta = -3
               If _listbox.SelectedIndex > 0 Then
                  selection = _listbox.SelectedIndex - 1
               End If

            End If

            Dim m As ModuleItem
            m = CType(modules(_listbox.SelectedIndex), ModuleItem)
            m.ModuleOrder += delta

            ' reorder the modules in the content pane
            OrderModules(modules)

            ' resave the order
            Dim admin As New AdminDB()
            Dim item As ModuleItem
            For Each item In modules
               admin.UpdateModuleOrder(item.ModuleId, item.ModuleOrder, pane)
            Next item

         End If

         ' Redirect to the same page to pick up changes
         Response.Redirect(Request.RawUrl)

      End Sub


      '*******************************************************
      '
      ' The RightLeft_Click server event handler on this page is
      ' used to move a portal module between layout panes on
      ' the tab page
      '
      '*******************************************************

      Private Sub RightLeft_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles LeftRightBtn.Click, ContentLeftBtn.Click, ContentRightBtn.Click, RightLeftBtn.Click, RightRightBtn.Click, FooterLeftBtn.Click

         Dim sourcePane As String = CType(sender, ImageButton).Attributes("sourcepane")
         Dim targetPane As String = CType(sender, ImageButton).Attributes("targetpane")
         Dim sourceBox As ListBox = CType(Page.FindControl(sourcePane), ListBox)
         Dim targetBox As ListBox = CType(Page.FindControl(targetPane), ListBox)

         If sourceBox.SelectedIndex <> -1 Then

            ' get source arraylist
            Dim sourceList As ArrayList = GetModules(sourcePane)

            ' get a reference to the module to move
            ' and assign a high order number to send it to the end of the target list
            Dim m As ModuleItem = CType(sourceList(sourceBox.SelectedIndex), ModuleItem)

            ' add it to the database
            Dim admin As New AdminDB()
            admin.UpdateModuleOrder(m.ModuleId, 998, targetPane)

            ' delete it from the source list
            sourceList.RemoveAt(sourceBox.SelectedIndex)

            ' Obtain portalId from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            ' reload the _portalSettings from the database
            HttpContext.Current.Items("PortalSettings") = New PortalSettings(_portalSettings.PortalId, tabId)

            ' reorder the modules in the source pane
            sourceList = GetModules(sourcePane)
            OrderModules(sourceList)

            ' resave the order
            Dim item As ModuleItem
            For Each item In sourceList
               admin.UpdateModuleOrder(item.ModuleId, item.ModuleOrder, sourcePane)
            Next item

            ' reorder the modules in the target pane
            Dim targetList As ArrayList = GetModules(targetPane)
            OrderModules(targetList)

            ' resave the order
            For Each item In targetList
               admin.UpdateModuleOrder(item.ModuleId, item.ModuleOrder, targetPane)
            Next item

            ' Redirect to the same page to pick up changes
            Response.Redirect(Request.RawUrl)

         End If

      End Sub


      '*******************************************************
      '
      ' The Apply_Click server event handler on this page is
      ' used to save the current tab settings to the database and
      ' then redirect back to the main admin page.
      '
      '*******************************************************

      Private Sub Apply_Click(ByVal Sender As Object, ByVal e As EventArgs) Handles applyBtn.Click

         ' Save changes then navigate back to admin.
         Dim lb As LinkButton = CType(Sender, LinkButton)
         Dim id As String = CType(lb.ID, String)

         SaveTabData()

         ' redirect back to the admin page
         ' Obtain PortalSettings from Current Context
         Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)
         Dim adminIndex As Integer = _portalSettings.DesktopTabs.Count - 1

         Response.Redirect(("~/DesktopDefault.aspx?tabindex=" & adminIndex.ToString() & "&tabid=" & CType(_portalSettings.DesktopTabs(adminIndex), TabStripDetails).TabId))

      End Sub


      '*******************************************************
      '
      ' The TabSettings_Change server event handler on this page is
      ' invoked any time the tab name or access security settings
      ' change.  The event handler in turn calls the "SaveTabData"
      ' helper method to ensure that these changes are persisted
      ' to the portal configuration file.
      '
      '*******************************************************

      Private Sub TabSettings_Change(ByVal sender As Object, ByVal e As EventArgs) Handles authRoles.SelectedIndexChanged, tabName.TextChanged, showMobile.CheckedChanged, mobileTabName.TextChanged

         ' Ensure that settings are saved
         SaveTabData()

      End Sub


      '*******************************************************
      '
      ' The SaveTabData helper method is used to persist the
      ' current tab settings to the database.
      '
      '*******************************************************

      Sub SaveTabData()

         ' Construct Authorized User Roles String
         Dim authorizedRoles As String = ""

         Dim item As ListItem
         For Each item In authRoles.Items

            If item.Selected = True Then
               authorizedRoles = authorizedRoles & item.Text & ";"
            End If
         Next item

         ' Obtain PortalSettings from Current Context
         Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

         ' update Tab info in the database
         Dim admin As New AdminDB()
         admin.UpdateTab(_portalSettings.PortalId, tabId, tabName.Text, _portalSettings.ActiveTab.TabOrder, authorizedRoles, mobileTabName.Text, showMobile.Checked)

      End Sub


      '*******************************************************
      '
      ' The EditBtn_Click server event handler on this page is
      ' used to edit an individual portal module's settings
      '
      '*******************************************************

      Private Sub EditBtn_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles LeftEditBtn.Click, ContentEditBtn.Click, RightEditBtn.Click, FooterEditBtn.Click

         Dim pane As String = CType(sender, ImageButton).CommandArgument
         Dim _listbox As ListBox = CType(Page.FindControl(pane), ListBox)

         If _listbox.SelectedIndex <> -1 Then

            Dim mid As Integer = Int32.Parse(_listbox.SelectedItem.Value)

            ' Redirect to module settings page
            Response.Redirect(("ModuleSettings.aspx?mid=" & mid & "&tabid=" & tabId))

         End If

      End Sub


      '*******************************************************
      '
      ' The DeleteBtn_Click server event handler on this page is
      ' used to delete an portal module from the page
      '
      '*******************************************************

      Private Sub DeleteBtn_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles LeftDeleteBtn.Click, ContentDeleteBtn.Click, RightDeleteBtn.Click, FooterDeleteBtn.Click

         Dim pane As String = CType(sender, ImageButton).CommandArgument
         Dim _listbox As ListBox = CType(Page.FindControl(pane), ListBox)
         Dim modules As ArrayList = GetModules(pane)

         If _listbox.SelectedIndex <> -1 Then

            Dim m As ModuleItem = CType(modules(_listbox.SelectedIndex), ModuleItem)
            If m.ModuleId > -1 Then

               ' must delete from database too
               Dim admin As New AdminDB()
               admin.DeleteModule(m.ModuleId)

            End If

         End If

         ' Redirect to the same page to pick up changes
         Response.Redirect(Request.RawUrl)

      End Sub


      '*******************************************************
      '
      ' The BindData helper method is used to update the tab's
      ' layout panes with the current configuration information
      '
      '*******************************************************
      Sub BindData()

         ' Obtain PortalSettings from Current Context
         Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)
         Dim tab As TabSettings = _portalSettings.ActiveTab

         ' Populate Tab Names, etc.
         tabName.Text = tab.TabName
         mobileTabName.Text = tab.MobileTabName
         showMobile.Checked = tab.ShowMobile

         ' Populate checkbox list with all security roles for this portal
         ' and "check" the ones already configured for this tab
         Dim admin As New AdminDB()
         Dim roles As SqlDataReader = admin.GetPortalRoles(_portalSettings.PortalId)

         ' Clear existing items in checkboxlist
         authRoles.Items.Clear()

         Dim allItem As New ListItem()
         allItem.Text = "All Users"

         If tab.AuthorizedRoles.LastIndexOf("All Users") > -1 Then
            allItem.Selected = True
         End If

         authRoles.Items.Add(allItem)

         While roles.Read()

            Dim item As New ListItem()
            item.Text = CType(roles("RoleName"), String)
            item.Value = roles("RoleID").ToString()

            If tab.AuthorizedRoles.LastIndexOf(item.Text) > -1 Then
               item.Selected = True
            End If

            authRoles.Items.Add(item)

         End While

         ' Populate the "Add Module" Data
         moduleType.DataSource = admin.GetModuleDefinitions(_portalSettings.PortalId)
         moduleType.DataBind()

         ' Populate Right Hand Module Data
         rightList = GetModules("RightPane")
         rightPane.DataBind()

         ' Populate Content Pane Module Data
         contentList = GetModules("ContentPane")
         contentPane.DataBind()

         ' Populate Left Hand Pane Module Data
         leftList = GetModules("LeftPane")
         leftPane.DataBind()

         ' Populate Footer Pane Module Data
         footerList = GetModules("FooterPane")
         footerPane.DataBind()

      End Sub


      '*******************************************************
      '
      ' The GetModules helper method is used to get the modules
      ' for a single pane within the tab
      '
      '*******************************************************

      Function GetModules(ByVal pane As String) As ArrayList

         ' Obtain PortalSettings from Current Context
         Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)
         Dim paneModules As New ArrayList()

         Dim _module As ModuleSettings
         For Each _module In _portalSettings.ActiveTab.Modules

            If _module.PaneName.ToLower() = pane.ToLower() Then

               Dim m As New ModuleItem()
               m.ModuleTitle = _module.ModuleTitle
               m.ModuleId = _module.ModuleId
               m.ModuleDefId = _module.ModuleDefId
               m.ModuleOrder = _module.ModuleOrder
               paneModules.Add(m)

            End If

         Next _module

         Return paneModules

      End Function


      '*******************************************************
      '
      ' The OrderModules helper method is used to reset the display
      ' order for modules within a pane
      '
      '*******************************************************

      Sub OrderModules(ByVal list As ArrayList)

         Dim i As Integer = 1

         ' sort the arraylist
         list.Sort()

         ' renumber the order
         Dim m As ModuleItem
         For Each m In list

            ' number the items 1, 3, 5, etc. to provide an empty order
            ' number when moving items up and down in the list.
            m.ModuleOrder = i
            i += 2

         Next m

      End Sub
   End Class

End Namespace
