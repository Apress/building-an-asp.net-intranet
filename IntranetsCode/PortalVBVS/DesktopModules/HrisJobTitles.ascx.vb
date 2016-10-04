Imports ASPNetPortal

Namespace ASPNetPortal.Hris

    Public MustInherit Class HrisJobTitles
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
        ' obtain a SqlDataReader of document information from the 
        ' Documents table, and then databind the results to a DataGrid
        ' server control.  It uses the JobTitlesBiz
        ' data component to encapsulate all data functionality.
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Obtain JobTitle Data from JobTitles table
            ' and bind to the datalist control
            myDataGrid.DataSource = JobTitlesBiz.GetJobTitles()
            myDataGrid.DataBind()

        End Sub

        '*******************************************************
        '
        ' GetBrowsePathDetails() is a helper method used to create the url   
        ' to view the details of an entity
        '
        ' This method is used in the databinding expression for
        ' the browse Hyperlink within the DataGrid, and is called 
        ' for each row when DataGrid.DataBind() is called.  It is 
        ' defined as a helper method here (as opposed to inline 
        ' within the template) to improve code organization and
        ' avoid embedding logic within the content template.
        '
        '*******************************************************'
        Function GetBrowsePathDetails(ByVal Entity As String, ByVal ID As Integer) As String
            ' if there is content in the database, create an 
            ' url to browse it
            Return EmployeesBiz.GetBrowsePathDetails(Entity, ID)
        End Function

    End Class

End Namespace