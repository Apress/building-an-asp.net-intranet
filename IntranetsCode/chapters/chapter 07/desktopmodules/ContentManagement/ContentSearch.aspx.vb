Imports ASPNetPortal

Namespace Wrox.Intranet.ContentManagement.Pages

    Public Class ContentSearch
        Inherits System.Web.UI.Page

        Protected WithEvents updateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents cancelButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents deleteButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents KeyWord As System.Web.UI.WebControls.TextBox

        Protected WithEvents ErrorMessage As System.Web.UI.WebControls.Label
        Protected WithEvents myDataList As System.Web.UI.WebControls.DataList
        Protected WithEvents valKeyWord As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents search As System.Web.UI.WebControls.Button
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


            ' Verify that the current user has access this module
            If PortalSecurity.HasEditPermissions(moduleId) = False Then
                Response.Redirect("~/Admin/AccessDenied.aspx")
            End If

            If Page.IsPostBack = False Then
                If moduleId <> 0 Then
                Else
                    ErrorMessage.Text = "Invalid Module Id"
                End If

            End If
        End Sub

        Private Sub search_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles search.Click
            'Get the contents and bind to the DataList Control
            Dim cm As New Wrox.Intranet.ContentManagement.Components.ContentManagement()
            Dim datareader As SqlDataReader
            datareader = cm.SearchContent(KeyWord.Text, moduleId)
            myDataList.DataSource = datareader
            If IsNothing(datareader) Then
                ErrorMessage.Text = cm.ErrorMessage
            Else
                myDataList.DataBind()
                datareader.Close()
            End If
        End Sub
    End Class

End Namespace