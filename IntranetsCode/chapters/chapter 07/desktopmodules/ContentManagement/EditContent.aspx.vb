Imports ASPNetPortal

Namespace Wrox.Intranet.ContentManagement.Pages

    Public Class EditContent
        Inherits System.Web.UI.Page

        Protected WithEvents updateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents cancelButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents deleteButton As System.Web.UI.WebControls.LinkButton

        Private itemId As Integer = 0
        Protected WithEvents ErrorMessage As System.Web.UI.WebControls.Label
        Protected WithEvents Title As System.Web.UI.WebControls.TextBox
        Protected WithEvents ValTitle As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents Summary As System.Web.UI.WebControls.TextBox
        Protected WithEvents ValSummary As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents BeginDate As System.Web.UI.WebControls.TextBox
        Protected WithEvents ValBDate As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents VerifyBeginDate As System.Web.UI.WebControls.CompareValidator
        Protected WithEvents EndDate As System.Web.UI.WebControls.TextBox
        Protected WithEvents ValEDate As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents VerifyEndDate As System.Web.UI.WebControls.CompareValidator
        Protected WithEvents ValBody As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents ContentBody As Wrox.Intranet.ContentManagement.Components.RTFEditor
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


        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Determine ModuleId of Events Portal Module
            moduleId = Int32.Parse(Request.Params("Mid"))

            ' Verify that the current user has access to edit this module
            If PortalSecurity.HasEditPermissions(moduleId) = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            ' Determine ItemId of Events to Update
            If Not (Request.Params("ItemId") Is Nothing) Then
                itemId = Int32.Parse(Request.Params("ItemId"))
            End If

            If Page.IsPostBack = False Then

                If itemId <> 0 Then

                    Dim cm As New Wrox.Intranet.ContentManagement.Components.ContentManagement()
                    Dim dr As SqlDataReader = cm.GetContent(itemId)

                    If IsNothing(dr) Then
                        ErrorMessage.Text = cm.ErrorMessage
                    Else
                        dr.Read()
                        Title.Text = CType(dr("Title"), String)
                        Summary.Text = CType(dr("Summary"), String)
                        ContentBody.RichText = CType(dr("Body"), String)
                        BeginDate.Text = CType(dr("BeginDate"), DateTime).ToShortDateString()
                        EndDate.Text = CType(dr("EndDate"), DateTime).ToShortDateString()
                        dr.Close()
                    End If
                Else
                    updateButton.Text = "Add"
                    deleteButton.Visible = False
                End If

                ' Store URL Referrer to return to portal
                ViewState("UrlReferrer") = Request.UrlReferrer.ToString()

            End If

        End Sub

        Private Sub updateButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles updateButton.Click


            Dim result As Integer

            If Page.IsValid = True Then

                Dim cm As New Wrox.Intranet.ContentManagement.Components.ContentManagement()

                If itemId = 0 Then

                    result = cm.AddContent(moduleId, Title.Text, Summary.Text, ContentBody.RichHtml, BeginDate.Text, EndDate.Text, Context.User.Identity.Name)

                Else

                    result = cm.EditContent(itemId, moduleId, Title.Text, Summary.Text, ContentBody.RichHtml, BeginDate.Text, EndDate.Text, Context.User.Identity.Name)

                End If

                If result > 0 Then

                    Response.Redirect("AddRelatedContent.aspx?ItemID=" & result.ToString() & "&Mid=" & moduleId.ToString())

                Else

                    ErrorMessage.Text = cm.ErrorMessage

                End If

                cm = Nothing

            End If

        End Sub

        Private Sub cancelButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cancelButton.Click
            Response.Redirect(CType(ViewState("UrlReferrer"), String))
        End Sub

        Private Sub deleteButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles deleteButton.Click

            Dim cm As New Wrox.Intranet.ContentManagement.Components.ContentManagement()
            Dim result As Integer

            If itemId <> 0 Then

                result = cm.DeleteContent(itemId, Context.User.Identity.Name)
                If result >= 0 Then
                    Response.Redirect(CType(ViewState("UrlReferrer"), String))
                Else
                    ErrorMessage.Text = cm.ErrorMessage
                End If

            End If

            cm = Nothing

        End Sub
    End Class

End Namespace