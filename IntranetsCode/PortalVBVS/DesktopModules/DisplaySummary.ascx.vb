Namespace ASPNetPortal
    Public MustInherit Class DisplaySummary
        Inherits ASPNetPortal.PortalModuleControl
        Protected WithEvents dgListing As System.Web.UI.WebControls.DataGrid
        Protected WithEvents tblResults As System.Web.UI.HtmlControls.HtmlTable
        Protected WithEvents EditButton As System.Web.UI.WebControls.HyperLink
        Protected WithEvents ModuleTitle As System.Web.UI.WebControls.Label
        Protected WithEvents ErrorMessage As System.Web.UI.WebControls.Label

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

      Dim DocsDB As New WroxDocsDB()
      Dim DocsUtil As New WroxDocUtilBiz()
      Dim DocsSec As New WroxDocSecurity()
      Dim IsAnonymous As Boolean

      'Search Text
      Public SearchText As String = Nothing
      Public SearchUrl As String = Nothing
      Public SearchTarget As String = Nothing

      'Add Document text
      Public EditText As String = Nothing
      Public EditUrl As String = Nothing
      Public EditTarget As String = Nothing

      Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
         If Not Page.IsPostBack Then
            IsAnonymous = Not (context.User.Identity.IsAuthenticated())

            'set the module title
            Dim _portalSettings As PortalSettings = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

            ' Obtain reference to parent portal module
            Dim portalModule As PortalModuleControl = CType(Me, PortalModuleControl)

            ' Display Module Title and Buttons
            ModuleTitle.Text = portalModule.ModuleConfiguration.ModuleTitle

            'set the add link
            If Not IsAnonymous And PortalSecurity.HasEditPermissions(ModuleId) = True Then
               'show Add Document Link
               EditButton.Text = "Add Document"
               EditButton.NavigateUrl = "~/DesktopModules/WroxDocs/WroxDocEdit.aspx" & "?mid=" & ModuleId
            End If

            BindMasterGrid()
         End If

      End Sub

      Sub BindMasterGrid()

         Dim ds As New DataSet()
         ds = DocsDB.GetDocuments(ModuleId)

         If IsNothing(ds) Then
            ErrorMessage.Text = DocsDB.ErrorMessage
            Exit Sub
         End If

         Dim dv As DataView = ds.Tables(0).DefaultView

         If dv.Count = 0 Then
            ErrorMessage.Text = "No Documents Listed Yet!"
         Else
            dgListing.DataSource = dv
            dgListing.DataBind()
         End If

      End Sub

      Public Sub SelectItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs)
         Select Case e.CommandName
            Case "DocumentAction"
               Dim ItemID As Integer
               ItemID = dgListing.DataKeys(e.Item.ItemIndex)
               'perform check in/out Action
               Select Case e.CommandArgument
                  Case "checkin"
                     'check in
                     Response.Redirect("~/DesktopModules/WroxDocs/WroxDocAction.aspx?ItemID=" & _
                                         ItemID & "&Action=checkin&mid=" & ModuleId)
                  Case "checkout"
                     'check out 
                     Response.Redirect("~/DesktopModules/WroxDocs/WroxDocAction.aspx?ItemID=" & _
                                         ItemID & "&Action=checkout&mid=" & ModuleId)

                  Case Else
                     'nothing
               End Select

            Case "View"
               ' Plus sign clicked
               If Not (dgListing.EditItemIndex = e.Item.ItemIndex) Then
                  dgListing.EditItemIndex = e.Item.ItemIndex
               Else
                  ' Minus sign clicked, deselect selected row
                  dgListing.EditItemIndex = -1
               End If
               BindMasterGrid()
            Case Else

         End Select

      End Sub

      'hook into Page Change
      Public Sub PageChange(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs)
         dgListing.CurrentPageIndex = e.NewPageIndex
         dgListing.SelectedIndex = -1
         BindMasterGrid()
      End Sub


      Private Sub dgListing_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgListing.ItemDataBound

         DocsUtil.HandleItemBound(e, IsAnonymous)

      End Sub

   End Class
End Namespace