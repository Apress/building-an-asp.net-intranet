Namespace ASPNetPortal

   Public MustInherit Class Books
      Inherits ASPNetPortal.PortalModuleControl
      Protected WithEvents myDataList As System.Web.UI.WebControls.DataList

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

         ' Obtain book information from Books table
         ' and bind to the datalist control
         Dim booksDB As New ASPNetPortal.BooksDB()

         ' DataBind Announcements to DataList Control
         myDataList.DataSource = booksDB.GetBooks(ModuleId)
         myDataList.DataBind()

         Dim repeatColumns As Integer = CType(Settings("columns"), Integer)
         If repeatColumns = Nothing Then
            myDataList.RepeatColumns = 0
         Else
            myDataList.RepeatColumns = repeatColumns
         End If

      End Sub

   End Class

End Namespace
