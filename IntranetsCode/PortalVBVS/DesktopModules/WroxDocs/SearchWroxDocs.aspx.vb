Namespace ASPNetPortal
   Public Class SearchWroxDocs
      Inherits System.Web.UI.Page
      Protected WithEvents ErrorMessage As System.Web.UI.WebControls.Label
      Protected WithEvents dgListing As System.Web.UI.WebControls.DataGrid
      Protected WithEvents txtFilter As System.Web.UI.WebControls.TextBox
      Protected WithEvents Label1 As System.Web.UI.WebControls.Label
      Protected WithEvents Label2 As System.Web.UI.WebControls.Label
      Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator
      Protected WithEvents chkExact As System.Web.UI.WebControls.CheckBox
      Protected WithEvents SearchButton As System.Web.UI.WebControls.LinkButton
      Protected WithEvents CancelButton As System.Web.UI.WebControls.LinkButton
      Protected WithEvents pnlResults As System.Web.UI.WebControls.Panel

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

      Public ModuleID As Integer = 0
      Dim DocsDB As New WroxDocsDB()
      Dim DocsUtil As New WroxDocUtilBiz()
      Dim DocsSec As New WroxDocSecurity()
      Dim IsAnonymous As Boolean

      Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

         ModuleID = Int32.Parse(Request.Params("Mid"))
         IsAnonymous = Not (context.User.Identity.IsAuthenticated())
         If Not IsPostBack Then

            'first load is a new search
            viewstate.Add("filter", "")
            If Not (Request.UrlReferrer Is Nothing) Then ViewState.Add("UrlReferrer", Request.UrlReferrer.ToString())
         End If

      End Sub


      Private Sub SearchButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SearchButton.Click
         Dim SearchFilter As String

         If txtFilter.Text <> "" Then
            Dim SearchWild As String = ""
            Dim SearchLike As String = "="

            If Not chkExact.Checked Then
               SearchWild = "*"
               SearchLike = "LIKE"
            End If

            SearchFilter = "FileDescription " & SearchLike & " '" & SearchWild & _
            txtFilter.Text & _
            SearchWild & "'"
         End If
         ' add to the page viewstate
         ViewState.Add("filter", SearchFilter)

         BindMasterGrid()
      End Sub


      Sub BindMasterGrid()

         Dim ds As New DataSet()
         ds = DocsDB.GetDocuments(ModuleID)

         If IsNothing(ds) Then
            ErrorMessage.Text = DocsDB.ErrorMessage
            Exit Sub
         End If

         Dim dv As DataView = ds.Tables(0).DefaultView

         dv.RowFilter = ViewState("filter")

         If dv.Count = 0 Then
            ErrorMessage.Text = "No Documents Listed Yet!"
            dgListing.DataBind()
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
                                         ItemID & "&Action=checkin&mid=" & ModuleID)
                  Case "checkout"
                     'check out 
                     Response.Redirect("~/DesktopModules/WroxDocs/WroxDocAction.aspx?ItemID=" & _
                                         ItemID & "&Action=checkout&mid=" & ModuleID)

                  Case Else

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
         ' Our helper method that sets the icons to match the document type
         DocsUtil.HandleItemBound(e, IsAnonymous)
      End Sub



      Private Sub CancelButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CancelButton.Click
         ' Go back
         If Not (ViewState("UrlReferrer") Is Nothing) Then Response.Redirect(CType(ViewState("UrlReferrer"), String))
      End Sub

   End Class
End Namespace
