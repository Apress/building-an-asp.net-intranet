Imports ASPNetPortal

Namespace ASPNetPortal.Hris

    Public Class HrisViewPhoto
        Inherits System.Web.UI.Page

        Private EmployeeId As Integer = -1

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
        ' tblHris_JobTitles table, construct an HTTP Response of the
        ' correct type for the document, and then stream the
        ' document contents to the response.  It uses the
        ' ASPNetPortal.JobTitlesBiz() data component to encapsulate
        ' the data access functionality.
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            If Not (Request.Params("ID") Is Nothing) Then
                EmployeeId = Int32.Parse(Request.Params("ID"))
            End If

            If EmployeeId <> -1 Then

                ' Obtain image data from the Employees table
                Dim dBContent As SqlDataReader = EmployeesBiz.GetSingleEmployee(EmployeeId)
                dBContent.Read()

                ' Serve up the file by name
                Response.AppendHeader("content-disposition", "filename=" & CStr(dBContent("FirstName")))

                ' set the content type for the Response to that of the
                ' document to display.  For example. "application/msword"
                Response.ContentType = CType(dBContent("PhotoContentType"), String)

                ' output the actual contents to the response output stream
                Response.OutputStream.Write(CType(dBContent("Photograph"), Byte()), 0, CInt(dBContent("PhotoContentSize")))

                ' end the response
                Response.End()
                ' close the SqlDataReader
                dBContent.Close()

            End If

        End Sub

    End Class

End Namespace