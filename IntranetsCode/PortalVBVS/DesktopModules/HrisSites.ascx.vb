Imports ASPNetPortal

Namespace ASPNetPortal.Hris

    Public MustInherit Class HrisSites
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents myDataGrid As System.Web.UI.WebControls.DataGrid

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

        '*******************************************************
        '
        ' The Page_Load event handler on this User Control is used to
        ' obtain a DataReader of Site information for the Hris Component
        '
        '*******************************************************'

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Obtain Skills information
            ' and bind to the DataGrid Control
            myDataGrid.DataSource = SitesBiz.GetSites()
            myDataGrid.DataBind()

        End Sub

    End Class

End Namespace