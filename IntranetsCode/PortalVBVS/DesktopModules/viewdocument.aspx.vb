Namespace ASPNetPortal

    Public Class ViewDocument
        Inherits System.Web.UI.Page

        Private documentId As Integer = -1

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
        ' The Page_Load event handler on this Page is used to
        ' obtain obtain the contents of a document from the
        ' Documents table, construct an HTTP Response of the
        ' correct type for the document, and then stream the
        ' document contents to the response.  It uses the
        ' ASPNetPortal.DocumentDB() data component to encapsulate
        ' the data access functionality.
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            If Not (Request.Params("DocumentId") Is Nothing) Then
                documentId = Int32.Parse(Request.Params("DocumentId"))
            End If

            If documentId <> -1 Then

                ' Obtain Document Data from Documents table
                Dim documents As New ASPNetPortal.DocumentDB()

                Dim dBContent As SqlDataReader = documents.GetDocumentContent(documentId)
                dBContent.Read()

                ' Serve up the file by name
                Response.AppendHeader("content-disposition", "filename=" & CStr(dBContent("FileFriendlyName")))

                ' set the content type for the Response to that of the
                ' document to display.  For example. "application/msword"
                Response.ContentType = CType(dBContent("ContentType"), String)

                ' output the actual document contents to the response output stream
                Response.OutputStream.Write(CType(dBContent("Content"), Byte()), 0, CInt(dBContent("ContentSize")))

                ' end the response
                Response.End()

            End If

        End Sub

    End Class

End Namespace