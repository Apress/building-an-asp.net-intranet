Imports ASPNetPortal

Namespace Wrox.Intranet.ContentManagement.Pages

    Public Class GetContent
        Inherits System.Web.UI.Page


        Private itemId As Integer = 0
        Protected WithEvents ErrorMessage As System.Web.UI.WebControls.Label
        Protected WithEvents title As System.Web.UI.WebControls.Label
        Protected WithEvents summary As System.Web.UI.WebControls.Label
        Protected WithEvents body As System.Web.UI.HtmlControls.HtmlGenericControl
        Protected WithEvents Actions As Wrox.Intranet.ContentManagement.Controls.ContentActionTabs

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

            ' Determine ItemId of Events to Update
            If Not (Request.Params("ItemId") Is Nothing) Then
                itemId = Int32.Parse(Request.Params("ItemId"))
            End If

            If Page.IsPostBack = False Then
                If itemId <> 0 Then
                    ' Obtain a single row of event information
                    Dim cm As New Wrox.Intranet.ContentManagement.Components.ContentManagement()
                    Dim dr As SqlDataReader = cm.GetContent(itemId)

                    ' Read first row from database
                    If IsNothing(dr) Then
                        ErrorMessage.Text = cm.ErrorMessage
                    Else
                        dr.Read()
                        title.Text = CType(dr("Title"), String)
                        summary.Text = CType(dr("Summary"), String)
                        body.InnerHtml = CType(dr("Body"), String)
                        dr.Close()

                        'Now set the Action Tabs

                        ' Verify that the current user has access to edit this module
                        If PortalSecurity.HasEditPermissions(moduleId) Then
                            Actions.EditVisible = True
                            Actions.EditText = "Edit"
                            Actions.EditUrl = "EditContent.aspx?ItemID=" & itemId & "&mid=" & moduleId
                        End If

                        Actions.RelatedContentText = "Related Content"
                        Actions.RelatedContentUrl = "RelatedContent.aspx?ItemID=" & itemId & "&mid=" & moduleId
                    End If
                End If
            End If

        End Sub

    End Class

End Namespace