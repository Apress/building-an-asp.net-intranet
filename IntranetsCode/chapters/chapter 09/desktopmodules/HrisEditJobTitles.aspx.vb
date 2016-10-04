Imports System.IO
Imports ASPNetPortal

Namespace ASPNetPortal.Hris

    Public Class HrisEditJobTitles
        Inherits System.Web.UI.Page

        Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents updateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents cancelButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents deleteButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents FileUpload As System.Web.UI.HtmlControls.HtmlInputFile

        Private itemId As Integer = 0
        Protected WithEvents TitleField As System.Web.UI.WebControls.TextBox
        Protected WithEvents CreatedBy As System.Web.UI.WebControls.Label
        Protected WithEvents CreatedDate As System.Web.UI.WebControls.Label
        Protected WithEvents lblError As System.Web.UI.WebControls.Label
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

            ' Add a javascript confirmation request to the deleteButton
            deleteButton.Attributes.Add("onClick", "javascript: return confirm('Are you sure?');")

            ' If the page is being requested the first time, determine if an
            ' document itemId value is specified, and if so populate page
            ' contents with the document details
            If Page.IsPostBack = False Then

                If itemId <> 0 Then

                    ' Obtain a single row of document information
                    Dim dr As SqlDataReader = JobTitlesBiz.GetSingleJobTitle(itemId)

                    ' Load first row into Datareader
                    dr.Read()

                    TitleField.Text = CStr(dr("Title"))
                    CreatedBy.Text = CType(dr("LastAlteredByUser"), String)
                    CreatedDate.Text = CType(dr("AlteredDate"), DateTime).ToShortDateString()

                    dr.Close()

                End If

                ' Store URL Referrer to return to portal
                ViewState("UrlReferrer") = Request.UrlReferrer.ToString()

            End If

        End Sub


        '****************************************************************
        '
        ' The UpdateBtn_Click event handler on this Page is used to either
        ' create or update an JobTitle document.  It  uses the ASPNetPortal.JobTitlesBiz()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************

        Private Sub UpdateBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles updateButton.Click

            ' Only Update if Input Data is Valid
            If Page.IsValid = True Then

                ' Determine whether a file was uploaded
                If Not (FileUpload.PostedFile Is Nothing) Then

                    ' for web farm support
                    Dim length As Integer = CInt(FileUpload.PostedFile.InputStream.Length)
                    Dim contentType As String = FileUpload.PostedFile.ContentType
                    Dim content(length) As Byte

                    FileUpload.PostedFile.InputStream.Read(content, 0, length)
                    Try
                        ' Update the document within the Documents table
                        JobTitlesBiz.UpdateJobTitle(itemId, TitleField.Text, content, contentType, length, context.User.Identity.Name)
                        ' Redirect back to the portal home page
                        Response.Redirect(CType(ViewState("UrlReferrer"), String))
                    Catch exc As Exception
                        lblError.Text = "Update failed. Please check the values you entered. (" & exc.Message.ToString() & ")"
                    End Try
                Else
                    'Allows for updating of the Title without over writing previously uploaded documents
                    Dim content(0) As Byte
                    Try
                        ' Update the document within the Documents table
                        JobTitlesBiz.UpdateJobTitle(itemId, TitleField.Text, content, "", 0, context.User.Identity.Name)
                        ' Redirect back to the portal home page
                        Response.Redirect(CType(ViewState("UrlReferrer"), String))
                    Catch exc As Exception
                        lblError.Text = "Update failed. Please check the values you entered. (" & exc.Message.ToString() & ")"
                    End Try
                End If
            End If

        End Sub


        '****************************************************************
        '
        ' The DeleteBtn_Click event handler on this Page is used to delete an
        ' a Job Title document.  It  uses the ASPNetPortal.JobTitlesBiz()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************
        Private Sub DeleteBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles deleteButton.Click

            Try
                ' Only attempt to delete the item if it is an existing item
                ' (new items will have "ItemId" of 0)
                If itemId <> 0 Then

                    JobTitlesBiz.DeleteJobTitle(itemId)

                End If

                ' Redirect back to the portal home page
                Response.Redirect(CType(ViewState("UrlReferrer"), String))
                
            Catch exc As Exception
                lblError.Text = "Delete failed. (" & exc.Message.ToString() & ")"
            End Try

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