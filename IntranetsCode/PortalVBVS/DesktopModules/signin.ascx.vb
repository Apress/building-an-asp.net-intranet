Imports System.Web.Security

Namespace ASPNetPortal

    Public MustInherit Class Signin
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents email As System.Web.UI.WebControls.TextBox
        Protected WithEvents password As System.Web.UI.WebControls.TextBox
      Protected WithEvents RememberCheckbox As System.Web.UI.WebControls.CheckBox
      Protected WithEvents SigninBtn As System.Web.UI.WebControls.LinkButton
      Protected WithEvents SigninBtnPic As System.Web.UI.WebControls.ImageButton
      Protected WithEvents RegisterLink As System.Web.UI.WebControls.HyperLink
      Protected WithEvents Message As System.Web.UI.WebControls.Label

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

      Private Sub SigninBtnPic_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SigninBtnPic.Click
         Signin()
      End Sub

      Private Sub SigninBtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SigninBtn.Click
         Signin()
      End Sub

      Private Sub Signin()
         ' Attempt to Validate User Credentials using UsersDB
         Dim accountSystem As New UsersDB()
         Dim userId As String = accountSystem.Login(email.Text, password.Text)

         If Not (userId Is Nothing) And userId <> "" Then

            ' Use security system to set the UserID within a client-side Cookie
            FormsAuthentication.SetAuthCookie(email.Text, RememberCheckbox.Checked)

            ' Redirect browser back to originating page
            Response.Redirect(Request.ApplicationPath)

         Else

            Message.Text = "<" & "br" & ">Login Failed!" & "<" & "br" & ">"

         End If
      End Sub
   End Class

End Namespace
