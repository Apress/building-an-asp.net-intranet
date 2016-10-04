Namespace ASPNetPortal

   Public Class ServeWroxDocument
      Inherits System.Web.UI.Page


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

         Dim ItemID As Integer = -1
         Dim strTable As String = "parent"
         Dim DocsSec As New WroxDocSecurity()

         'comment this code if you don't want to lock down the download process
          If Not (DocsSec.HasDocPermissions(DocumentPermissions.DownloadandViewOnly, Request.Params("key"))) _
               And Not (PortalSecurity.HasEditPermissions(Request.Params("mid"))) Then

              Response.Write("<script>alert('You do not have authority to download files.')</script>")
              Response.End()
          End If

         If Not (Request.Params("ItemID") Is Nothing) Then
            ItemID = Int32.Parse(Request.Params("ItemID"))
         ElseIf Not (Request.Params("SubItemID") Is Nothing) Then
            ItemID = Int32.Parse(Request.Params("SubItemID"))
            strTable = "child"
         End If

         If ItemID <> -1 Then

            ' Obtain Document Data from Documents table
            Dim DocsDB As New WroxDocsDB()
            DocsDB.RenderDocument(ItemID, strTable, Response)

         End If

      End Sub

   End Class

End Namespace