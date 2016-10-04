Namespace ASPNetPortal

    Public MustInherit Class Tabs
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents addBtn As System.Web.UI.WebControls.LinkButton
        Protected WithEvents tabList As System.Web.UI.WebControls.ListBox
        Protected WithEvents upBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents downBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents editBtn As System.Web.UI.WebControls.ImageButton
        Protected WithEvents deleteBtn As System.Web.UI.WebControls.ImageButton

        Private tabIndex As Integer = 0
        Private tabId As Integer = 0
        Protected portalTabs As ArrayList

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
        ' to populate the current tab settings from the database
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

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            portalTabs = New ArrayList()
            Dim tab As TabStripDetails
            For Each tab In _portalSettings.DesktopTabs

                Dim t As New TabItem()
                t.TabName = tab.TabName
                t.TabId = tab.TabId
                t.TabOrder = tab.TabOrder
                portalTabs.Add(t)

            Next tab

            ' Give the admin tab a big sort order number, to ensure it's
            ' always at the end
            Dim adminTab As TabItem = CType(portalTabs((portalTabs.Count - 1)), TabItem)
            adminTab.TabOrder = 99999

            ' If this is the first visit to the page, bind the tab data to the page listbox
            If Page.IsPostBack = False Then

                tabList.DataBind()

            End If

        End Sub

        '*******************************************************
        '
        ' The UpDown_Click server event handler on this page is
        ' used to move a portal module up or down on a tab's layout pane
        '
        '*******************************************************

        Private Sub UpDown_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles downBtn.Click, upBtn.Click

            Dim cmd As String = CType(sender, ImageButton).CommandName

            If tabList.SelectedIndex <> -1 Then

                Dim delta As Integer

                ' Determine the delta to apply in the order number for the module
                ' within the list.  +3 moves down one item; -3 moves up one item
                If cmd = "down" Then

                    delta = 3
                Else

                    delta = -3
                End If

                Dim t As TabItem
                t = CType(portalTabs(tabList.SelectedIndex), TabItem)
                t.TabOrder += delta

                ' Reset the order numbers for the tabs within the portal
                OrderTabs()

                ' Redirect to this site to refresh
                Response.Redirect(("~/DesktopDefault.aspx?tabindex=" & (portalTabs.Count - 1).ToString() & "&tabid=" & tabId))

            End If

        End Sub


        '*******************************************************
        '
        ' The DeleteBtn_Click server event handler is used to delete
        ' the selected tab from the portal
        '
        '*******************************************************

        Private Sub DeleteBtn_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles deleteBtn.Click

            If tabList.SelectedIndex <> -1 Then

                ' must delete from database too
                Dim t As TabItem = CType(portalTabs(tabList.SelectedIndex), TabItem)
                Dim admin As New AdminDB()
                admin.DeleteTab(t.TabId)

                ' remove item from list
                portalTabs.RemoveAt(tabList.SelectedIndex)

                ' reorder list
                OrderTabs()

                ' Redirect to this site to refresh
                Response.Redirect(("~/DesktopDefault.aspx?tabindex=" & tabIndex & "&tabid=" & tabId))

            End If

        End Sub



        '*******************************************************
        '
        ' The AddTab_Click server event handler is used to add
        ' a new security tab for this portal
        '
        '*******************************************************

        Private Sub AddTab_Click(ByVal Sender As Object, ByVal e As EventArgs) Handles addBtn.Click

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            ' New tabs go to the end of the list
            Dim t As New TabItem()
            t.TabName = "New Tab"
            t.TabId = -1
            t.TabOrder = 999
            portalTabs.Add(t)

            ' write tab to database
            Dim admin As New AdminDB()
            t.TabId = admin.AddTab(_portalSettings.PortalId, t.TabName, t.TabOrder)

            ' Reset the order numbers for the tabs within the list
            OrderTabs()

            ' Redirect to edit page
            Response.Redirect(("~/Admin/TabLayout.aspx?tabid=" & t.TabId))

        End Sub


        '*******************************************************
        '
        ' The EditBtn_Click server event handler is used to edit
        ' the selected tab within the portal
        '
        '*******************************************************

        Private Sub EditBtn_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles editBtn.Click

            ' Redirect to edit page of currently selected tab
            If tabList.SelectedIndex <> -1 Then

                ' Redirect to module settings page
                Dim t As TabItem = CType(portalTabs(tabList.SelectedIndex), TabItem)

                Response.Redirect(("~/Admin/TabLayout.aspx?tabid=" & t.TabId))

            End If

        End Sub


        '*******************************************************
        '
        ' The OrderTabs helper method is used to reset the display
        ' order for tabs within the portal
        '
        '*******************************************************'

        Sub OrderTabs()

            Dim i As Integer = 1

            ' sort the arraylist
            portalTabs.Sort()

            ' renumber the order and save to database
            Dim t As TabItem
            For Each t In portalTabs

                ' number the items 1, 3, 5, etc. to provide an empty order
                ' number when moving items up and down in the list.
                t.TabOrder = i
                i += 2

                ' rewrite tab to database
                Dim admin As New AdminDB()
                admin.UpdateTabOrder(t.TabId, t.TabOrder)

            Next t

        End Sub

    End Class

End Namespace
