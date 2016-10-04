Imports ASPNetPortal

Namespace Wrox.Intranet.ContentManagement.Pages

    Public Class RelatedContent
        Inherits System.Web.UI.Page

        Protected WithEvents updateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents cancelButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents deleteButton As System.Web.UI.WebControls.LinkButton

        Private itemId As Integer = 0
        Protected WithEvents ErrorMessage As System.Web.UI.WebControls.Label
        Protected WithEvents myDataList As System.Web.UI.WebControls.DataList
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

            If itemId <> 0 Then
                'Get the contents and bind to the DataList Control
                Dim cm As New Wrox.Intranet.ContentManagement.Components.ContentManagement()
                Dim datareader As SqlDataReader
                datareader = cm.ViewRelatedContent(itemId)
                myDataList.DataSource = datareader
                If IsNothing(datareader) Then
                    ErrorMessage.Text = cm.ErrorMessage
                Else
                    myDataList.DataBind()
                    datareader.Close()
                End If
            End If
        End Sub
    End Class

End Namespace