Imports ASPNetPortal

Namespace Wrox.Intranet.ContentManagement.Controls

    Public MustInherit Class DisplayContentSummary
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents ErrorMessage As System.Web.UI.WebControls.Label
        Protected WithEvents myDataList As System.Web.UI.WebControls.DataList


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


            'Get the contents and bind to the DataList Control
            Dim cm As New Wrox.Intranet.ContentManagement.Components.ContentManagement()
            Dim datareader As SqlDataReader
            datareader = cm.ViewContent(ModuleId)
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
