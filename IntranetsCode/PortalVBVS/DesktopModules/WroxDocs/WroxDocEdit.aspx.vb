Imports System.IO

Namespace ASPNetPortal

    Public Class WroxDocEdit
        Inherits System.Web.UI.Page

        Protected WithEvents CancelButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents Upload As System.Web.UI.HtmlControls.HtmlInputFile


        Protected WithEvents pnlFile As System.Web.UI.WebControls.Panel
        Protected WithEvents txtDes As System.Web.UI.WebControls.TextBox
        Protected WithEvents txtCat As System.Web.UI.WebControls.TextBox
        Protected WithEvents UploadButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents UpdateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents ArchiveButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents ErrorMessage As System.Web.UI.WebControls.Label
        Protected WithEvents pnlAcls As System.Web.UI.WebControls.Panel

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
      Private ItemID As Integer = 0
      Private ModuleID As Integer = 0

      '****************************************************************
      ' The Page_Load event sets our inital variables
      '****************************************************************

      Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

         ' Grab the module ID of this particuar module
         ModuleID = Int32.Parse(Request.Params("Mid"))

         ' Verify that the current user has access to edit this module
         If PortalSecurity.HasEditPermissions(ModuleID) = False Then
            Response.Redirect("~/Admin/EditAccessDenied.aspx")
         End If

         ' Determine ItemID of Document to Update
         If Not (Request.Params("ItemID") Is Nothing) Then
            ItemID = Int32.Parse(Request.Params("ItemID"))
         End If

         If Not IsPostBack Then

            If Not (Request.Params("ItemID") Is Nothing) Then  'Update Action

               ' Obtain a single row of document information
               Dim DocsDB As New WroxDocsDB()

               'dont show the file upload on edits
               pnlFile.Visible = False
               pnlAcls.Visible = True
               UploadButton.Visible = False
               ArchiveButton.Attributes.Add("onclick", _
               "return (confirm('Are you sure you want to archive this document?'));")

               Dim dr As SqlDataReader = DocsDB.GetSingleDocument(ItemID)
               ' Load first row into Datareader
               dr.Read()
               txtDes.Text = CStr(dr("FileDescription"))
               txtCat.Text = CStr(dr("Category"))
               dr.Close()

            Else
               'The action is a new document
               pnlAcls.Visible = False
               pnlFile.Visible = True
               UpdateButton.Visible = False
               ArchiveButton.Visible = False

            End If

            ' Store URL Referrer to return to portal
            ViewState("UrlReferrer") = Request.UrlReferrer.ToString()

         End If

      End Sub




      '****************************************************************
      ' Upload will submit a new document
      '****************************************************************

      Private Sub UploadButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles UploadButton.Click
        
            Dim DocsDB As New WroxDocsDB()

            ' Determine whether a file was uploaded
            If Not (Upload.PostedFile.ContentLength = 0) Then

               'parse path out of filename
               Dim filename As String = _
               Upload.PostedFile.FileName.Substring _
               (Upload.PostedFile.FileName.LastIndexOf("\") + 1)

               'get the byte array and len
               Dim length As Integer = CInt(Upload.PostedFile.ContentLength)
               Dim contentType As String = Upload.PostedFile.ContentType
               Dim content(length) As Byte

               'read into the byte array
               Upload.PostedFile.InputStream.Read(content, 0, length)

               ' Upload a new document with a file attached
               DocsDB.UploadDocument(ModuleID, _
                                             ItemID, _
                                             Context.User.Identity.Name, _
                                             filename, _
                                             txtDes.Text, _
                                             txtCat.Text, _
                                             content, _
                                             length, _
                                             contentType)
            Else
               ErrorMessage.Text = "You  must select a valid file to upload."
               Return
            End If

            ' go back
            Response.Redirect(CType(ViewState("UrlReferrer"), String))
  
      End Sub


      '****************************************************************
      '  Update will update any info changed in the form
      '****************************************************************

      Private Sub UpdateButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles UpdateButton.Click
         If Not (Request.Params("ItemID") Is Nothing) Then

            Dim DocsDB As New WroxDocsDB()

            ' Update information about a document
            DocsDB.UpdateDocument(ItemID, _
                                         txtDes.Text, _
                                         txtCat.Text)

            ' go back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))
         End If
      End Sub

      '****************************************************************
      '  Archive will change the archived bit.
      '****************************************************************

      Private Sub ArchiveButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ArchiveButton.Click
         If Not (Request.Params("ItemID") Is Nothing) Then

            Dim DocsDB As New WroxDocsDB()
            DocsDB.ArchiveDocument(ItemID)

         End If

         ' Redirect back to the portal home page
         Response.Redirect(CType(ViewState("UrlReferrer"), String))
      End Sub


      '****************************************************************
      '  Cancel
      '****************************************************************

      Private Sub CancelButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CancelButton.Click
         Response.Redirect(CType(ViewState("UrlReferrer"), String))
      End Sub

   End Class

End Namespace