Namespace ASPNetPortal

    Public MustInherit Class Document
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents myDataGrid As System.Web.UI.WebControls.DataGrid

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
        ' The Page_Load event handler on this User Control is used to
        ' obtain a SqlDataReader of document information from the 
        ' Documents table, and then databind the results to a DataGrid
        ' server control.  It uses the ASPNetPortal.DocumentDB()
        ' data component to encapsulate all data functionality.
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Obtain Document Data from Documents table
            ' and bind to the datalist control
            Dim documents As New ASPNetPortal.DocumentDB()

            myDataGrid.DataSource = documents.GetDocuments(ModuleId)
            myDataGrid.DataBind()

        End Sub


        '*******************************************************
        '
        ' GetBrowsePath() is a helper method used to create the url   
        ' to the document.  If the size of the content stored in the   
        ' database is non-zero, it creates a path to browse that.   
        ' Otherwise, the FileNameUrl value is used.
        '
        ' This method is used in the databinding expression for
        ' the browse Hyperlink within the DataGrid, and is called 
        ' for each row when DataGrid.DataBind() is called.  It is 
        ' defined as a helper method here (as opposed to inline 
        ' within the template) to improve code organization and
        ' avoid embedding logic within the content template.
        '
        '*******************************************************'

        Function GetBrowsePath(ByVal url As String, ByVal size As Object, ByVal documentId As Integer) As String

            Dim hasSize As Boolean = True

            If size Is DBNull.Value Then

                hasSize = False

            ElseIf CInt(size) < 1 Then

                hasSize = False

            End If

            If hasSize = False Then

                ' return the FileNameUrl
                Return url

            End If

            ' if there is content in the database, create an 
            ' url to browse it
            Return "~/DesktopModules/ViewDocument.aspx?DocumentID=" & documentId.ToString()

        End Function

    End Class

End Namespace