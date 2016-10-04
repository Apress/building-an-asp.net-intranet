
Namespace ASPNetPortal
   Public MustInherit Class WroxDocAcls
      Inherits ASPNetPortal.PortalModuleControl
      Protected WithEvents DlRoles As System.Web.UI.WebControls.DropDownList
      Protected WithEvents AddRoleButton As System.Web.UI.WebControls.LinkButton
      Protected WithEvents dgRoles As System.Web.UI.WebControls.DataGrid
      Protected WithEvents lblMsg As System.Web.UI.WebControls.Label

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
         'Put user code to initialize the page here
         If Page.IsPostBack = False Then

            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)
            Dim tab As TabSettings = _portalSettings.ActiveTab

            Dim admin As New AdminDB()
            Dim roles As SqlDataReader = admin.GetPortalRoles(_portalSettings.PortalId)

            DlRoles.DataSource = roles
            DlRoles.DataBind()

            BindRoles()
         End If
      End Sub


      Private Sub BindRoles()
         Dim DocsDB As New WroxDocSecurity()

         Dim ds As DataSet
         ds = DocsDB.GetDocAcls(Request.Params("ItemID"))
         dgRoles.DataSource = ds
         dgRoles.DataBind()
         If ds.Tables(0).Rows.Count = 0 Then
            lblMsg.Visible = True
         Else
            lblMsg.Visible = False
         End If

      End Sub


      '*********************************************************************
      ' Editcommand - fires when Edit is clicked
      '*********************************************************************

      Sub EditCommand(ByVal Sender As Object, ByVal E As DataGridCommandEventArgs)
         dgRoles.EditItemIndex = E.Item.ItemIndex

         'hide the remove column while in edit mode
         dgRoles.Columns(3).Visible = False
         BindRoles()
      End Sub


      '*********************************************************************
      ' Updatecommand - fires when Update is clicked
      '*********************************************************************

      Sub UpdateCommand(ByVal Sender As Object, ByVal E As DataGridCommandEventArgs)
         Dim DocsDB As New WroxDocSecurity()

         Dim dlAcls As DropDownList
         dlAcls = CType(E.Item.Cells(1).FindControl("dlPermissions"), DropDownList)
         DocsDB.UpdateDocAcls(Request.Params("ItemID"), _
                                     dgRoles.DataKeys(E.Item.ItemIndex), _
                                     dlAcls.SelectedItem.Value)
         'Deselect the grid
         dgRoles.EditItemIndex = -1

         'show the remove column
         dgRoles.Columns(3).Visible = True
         BindRoles()
      End Sub

      '*********************************************************************
      ' Cancelcommand - fires when cancel is clicked
      '*********************************************************************

      Sub CancelCommand(ByVal Sender As Object, ByVal E As DataGridCommandEventArgs)
         dgRoles.Columns(3).Visible = True
         dgRoles.EditItemIndex = -1
         BindRoles()
      End Sub

      '*********************************************************************
      ' Deletecommand - fires when Remove is clicked
      '*********************************************************************

      Sub DeleteCommand(ByVal Sender As Object, ByVal E As DataGridCommandEventArgs)
         Dim DocsDB As New WroxDocSecurity()

         DocsDB.DeleteDocAcls(Request.Params("ItemID"), dgRoles.DataKeys(E.Item.ItemIndex))
         BindRoles()

      End Sub


      '*********************************************************************
      ' AddRoleButton_Click - fires when Add this Role is clicked
      '*********************************************************************

      Private Sub AddRoleButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AddRoleButton.Click
         Dim DocsDB As New WroxDocSecurity()

         DocsDB.AddDocAcls(Request.Params("ItemID"), DlRoles.SelectedItem.Value)
         BindRoles()

      End Sub


      Sub dgRoles_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgRoles.ItemDataBound

         'If row is not in edit mode and not a pager or header bar
         If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim Acl As DocumentPermissions
            Dim lblAcl As Label
            lblAcl = CType(e.Item.Cells(1).FindControl("lblAcls"), Label)
            lblAcl.ForeColor = Color.Red

            Select Case DataBinder.Eval(e.Item.DataItem, "Acl")
               Case Acl.ViewListingOnly
                  lblAcl.Text = "View Listing Only"
               Case Acl.DownloadandViewOnly
                  lblAcl.Text = "Download and View Only"
               Case Acl.CheckInOutRights
                  lblAcl.Text = "Check In/Out Rights on Document"

            End Select

         End If

         ' handle the edit state
         If e.Item.ItemType = ListItemType.EditItem Then
            Dim dlAcls As DropDownList
            dlAcls = CType(e.Item.Cells(1).FindControl("dlPermissions"), DropDownList)
            dlAcls.SelectedIndex = dlAcls.Items.IndexOf(dlAcls.Items.FindByValue(e.Item.DataItem("Acl")))
         End If

      End Sub


   End Class
End Namespace