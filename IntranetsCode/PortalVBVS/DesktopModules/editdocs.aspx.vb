Imports System.IO

Namespace ASPNetPortal

    Public Class EditDocs
        Inherits System.Web.UI.Page

        Protected WithEvents NameField As System.Web.UI.WebControls.TextBox
        Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents CategoryField As System.Web.UI.WebControls.TextBox
        Protected WithEvents PathField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Upload As System.Web.UI.WebControls.CheckBox
        Protected WithEvents updateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents cancelButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents deleteButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents CreatedBy As System.Web.UI.WebControls.Label
        Protected WithEvents CreatedDate As System.Web.UI.WebControls.Label
        Protected WithEvents FileUpload As System.Web.UI.HtmlControls.HtmlInputFile
        Protected WithEvents storeInDatabase As System.Web.UI.WebControls.CheckBox

        Private itemId As Integer = 0
        Private moduleId As Integer = 0

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

        '****************************************************************
        '
        ' The Page_Load event on this Page is used to obtain the ModuleId
        ' and ItemId of the document to edit.
        '
        ' It then uses the ASPNetPortal.DocumentDB() data component
        ' to populate the page's edit controls with the document details.
        '
        '****************************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Determine ModuleId of Announcements Portal Module
            moduleId = Int32.Parse(Request.Params("Mid"))

            ' Verify that the current user has access to edit this module
            If PortalSecurity.HasEditPermissions(moduleId) = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            ' Determine ItemId of Document to Update
            If Not (Request.Params("ItemId") Is Nothing) Then
                itemId = Int32.Parse(Request.Params("ItemId"))
            End If

            ' If the page is being requested the first time, determine if an
            ' document itemId value is specified, and if so populate page
            ' contents with the document details
            If Page.IsPostBack = False Then

                If itemId <> 0 Then

                    ' Obtain a single row of document information
                    Dim documents As New ASPNetPortal.DocumentDB()
                    Dim dr As SqlDataReader = documents.GetSingleDocument(itemId)

                    ' Load first row into Datareader
                    dr.Read()

                    NameField.Text = CStr(dr("FileFriendlyName"))
                    PathField.Text = CStr(dr("FileNameUrl"))
                    CategoryField.Text = CStr(dr("Category"))
                    CreatedBy.Text = CStr(dr("CreatedByUser"))
                    CreatedDate.Text = CType(dr("CreatedDate"), DateTime).ToShortDateString()

                    dr.Close()

                End If

                ' Store URL Referrer to return to portal
                ViewState("UrlReferrer") = Request.UrlReferrer.ToString()

            End If

        End Sub


        '****************************************************************
        '
        ' The UpdateBtn_Click event handler on this Page is used to either
        ' create or update an document.  It  uses the ASPNetPortal.DocumentDB()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************

        Private Sub UpdateBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles updateButton.Click

            ' Only Update if Input Data is Valid
            If Page.IsValid = True Then

                ' Create an instance of the Document DB component
                Dim documents As New ASPNetPortal.DocumentDB()

                ' Determine whether a file was uploaded
                If storeInDatabase.Checked = True And Not (FileUpload.PostedFile Is Nothing) Then

                    ' for web farm support
                    Dim length As Integer = CInt(FileUpload.PostedFile.InputStream.Length)
                    Dim contentType As String = FileUpload.PostedFile.ContentType
                    Dim content(length) As Byte

                    FileUpload.PostedFile.InputStream.Read(content, 0, length)

                    ' Update the document within the Documents table
                    documents.UpdateDocument(moduleId, itemId, Context.User.Identity.Name, NameField.Text, PathField.Text, CategoryField.Text, content, length, contentType)

                Else

                    If Upload.Checked = True And Not (FileUpload.PostedFile Is Nothing) Then

                        ' Calculate virtualPath of the newly uploaded file
                        Dim virtualPath As String = "~/uploads/" + Path.GetFileName(FileUpload.PostedFile.FileName)

                        ' Calculate physical path of the newly uploaded file
                        Dim phyiscalPath As String = Server.MapPath(virtualPath)

                        ' Save file to uploads directory
                        FileUpload.PostedFile.SaveAs(phyiscalPath)

                        ' Update PathFile with uploaded virtual file location
                        PathField.Text = virtualPath

                    End If

                    documents.UpdateDocument(moduleId, itemId, Context.User.Identity.Name, NameField.Text, PathField.Text, CategoryField.Text, New Byte(0) {}, 0, "")

                End If

                ' Redirect back to the portal home page
                Response.Redirect(CType(ViewState("UrlReferrer"), String))

            End If

        End Sub


        '****************************************************************
        '
        ' The DeleteBtn_Click event handler on this Page is used to delete an
        ' a document.  It  uses the ASPNetPortal.DocumentsDB()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************
        Private Sub DeleteBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles deleteButton.Click

            ' Only attempt to delete the item if it is an existing item
            ' (new items will have "ItemId" of 0)
            If itemId <> 0 Then

                Dim documents As New ASPNetPortal.DocumentDB()
                documents.DeleteDocument(itemId)

            End If

            ' Redirect back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

        End Sub


        '****************************************************************
        '
        ' The CancelBtn_Click event handler on this Page is used to cancel
        ' out of the page, and return the user back to the portal home
        ' page.
        '
        '****************************************************************
        Private Sub CancelBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cancelButton.Click

            ' Redirect back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

        End Sub

    End Class

End Namespace