Namespace ASPNetPortal
    Public MustInherit Class DocumentDetails
        Inherits ASPNetPortal.PortalModuleControl
        Protected WithEvents dgDetails As System.Web.UI.WebControls.DataGrid

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
      Public mid As Integer
      Private ItemID As Integer

      Public Property DocumentID() As Integer
         Get
            Return ItemID
         End Get
         Set(ByVal Value As Integer)
            ItemID = Value
            BindDetails()
         End Set
      End Property


      Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load


      End Sub

      Private Sub BindDetails()
         Dim DocsDB As New ASPNetPortal.WroxDocsDB()
         Dim ds As DataSet
         ds = DocsDB.GetChildDocuments(ItemID)

         If ds.Tables(0).Rows.Count <> 0 Then
            dgDetails.DataSource = ds.Tables(0).DefaultView
            dgDetails.DataBind()
            dgDetails.Visible = True

         Else
            dgDetails.Visible = False

         End If
      End Sub


   End Class
End Namespace

