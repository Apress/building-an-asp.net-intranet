Namespace ASPNetPortal
    Public Class WroxDocAction
        Inherits System.Web.UI.Page
      Protected WithEvents Linkbutton1 As System.Web.UI.WebControls.LinkButton
      Protected WithEvents lblMessage As System.Web.UI.WebControls.Label
      Protected WithEvents imgFormat As System.Web.UI.WebControls.Image
      Protected WithEvents lnkFileName As System.Web.UI.WebControls.HyperLink
      Protected WithEvents pnlShowDownload As System.Web.UI.WebControls.Panel
      Protected WithEvents pnlShowCheckin As System.Web.UI.WebControls.Panel
      Protected WithEvents txtDes As System.Web.UI.WebControls.TextBox
      Protected WithEvents txtFilename As System.Web.UI.WebControls.TextBox
      Protected WithEvents lblOwner As System.Web.UI.WebControls.Label
      Protected WithEvents pnlFile As System.Web.UI.WebControls.Panel
      Protected WithEvents txtFile As System.Web.UI.HtmlControls.HtmlInputFile
      Protected WithEvents CheckOutButton As System.Web.UI.WebControls.LinkButton
      Protected WithEvents CancelButton As System.Web.UI.WebControls.LinkButton
      Protected WithEvents ErrorMessage As System.Web.UI.WebControls.Label
      Protected WithEvents CheckInButton As System.Web.UI.WebControls.LinkButton

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

      Private ModuleID As Integer = 0
      Private Action As String
      Private ItemID As Integer = 0
      Public Status As Boolean = False

      Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
         Dim DocsSec As New WroxDocSecurity()

         If Not (Request.Params("ItemID") Is Nothing) Then
            ItemID = Int32.Parse(Request.Params("ItemID"))
         End If

         If Not IsPostBack Then
            If Not (Request.Params("ItemID") Is Nothing) Then
               'Run our custom permission checks
               If Not (DocsSec.HasDocPermissions(DocumentPermissions.CheckInOutRights, ItemID)) _
               And Not (PortalSecurity.HasEditPermissions(Request.Params("mid"))) Then

                  'send the user back with a javascript alert
                  Response.Write("<script>alert('You do not have authority to perform this Action.');" & _
                                 "location.replace('" & Request.UrlReferrer.ToString() & "');</script>")
               End If

               Dim documents As New WroxDocsDB()
               Dim dr As SqlDataReader = documents.GetSingleDocument(ItemID)
               dr.Read()

               SetForm(CStr(Request.Params("Action")), dr)
               ' Store URL Referrer to return to portal
               ViewState.Add("UrlReferrer", Request.UrlReferrer.ToString())
            End If
         End If


      End Sub


      'Hide or display panels according to Action type
      Sub SetForm(ByVal strAction As String, ByRef dr As SqlClient.SqlDataReader)
         Select Case strAction
            Case "checkin" 'Check the Item back in
               pnlShowCheckin.Visible = True
               pnlShowDownload.Visible = False
               CheckInButton.Visible = True
               pnlFile.Visible = True
            Case "checkout" 'Check the Item out
               pnlShowCheckin.Visible = False
               pnlShowDownload.Visible = True
               CheckOutButton.Visible = True
               pnlFile.Visible = False
            Case Else
               'invalid Action passed
               Response.Redirect(viewstate("UrlReferrer"))

         End Select

         ' Utiltiy object
         Dim oDocUtil As New WroxDocUtilBiz()

         ' Fill the initial values in form
         txtDes.Text = dr("FileDescription")
         With lnkFileName
            .NavigateUrl = "~/DeskTopModules/WroxDocs/ServeWroxDocument.aspx?ItemID=" & ItemID & _
                            "&key=" & ItemID & "&mid=" & Request.Params("mid")
            .Text = dr("filename")
            .Target = "_blank"
         End With
         imgFormat.ImageUrl = "images/" & oDocUtil.GetImageFromMime(dr("ContentType"))

         lblOwner.Text = dr("CreatedByUser")
         txtFilename.Text = dr("Filename")

      End Sub


      Private Sub CheckInButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CheckInButton.Click
         If Page.IsValid = True Then

            Dim documents As New WroxDocsDB()

            ' Determine whether a file was uploaded
            If Not (txtFile.PostedFile.ContentLength = 0) Then

               'parse path out of filename
               Dim filename As String = _
               CStr(txtFile.PostedFile.FileName.Substring _
               (txtFile.PostedFile.FileName.LastIndexOf("\") + 1))

               'get the byte array and len
               Dim length As Integer = CInt(txtFile.PostedFile.InputStream.Length)
               Dim contentType As String = txtFile.PostedFile.ContentType
               Dim content(length) As Byte

               'read into the byte array
               txtFile.PostedFile.InputStream.Read(content, 0, length)

               ' Update the document within the Documents table
               documents.CheckInDocument(ItemID, _
                                        Context.User.Identity.Name, _
                                        filename, _
                                        content, _
                                        length, _
                                        contentType)

            Else
               ' no file selected display error message
               ErrorMessage.Text = "You must choose a file to check back in."
               Return

            End If

            ' go back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

         End If
      End Sub

      Private Sub CheckOutButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CheckOutButton.Click
         Dim documents As New ASPNetPortal.WroxDocsDB()
         documents.CheckOutDocument(Int32.Parse(Request.Params("ItemID")), context.Current.User.Identity.Name)
         Response.Redirect(CType(ViewState("UrlReferrer"), String))
      End Sub

      Private Sub CancelButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CancelButton.Click
         ' Send the user back
         Response.Redirect(CType(ViewState("UrlReferrer"), String))
      End Sub


   End Class
End Namespace