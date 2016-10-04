Namespace ASPNetPortal

    Public MustInherit Class Contacts
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
        ' obtain a DataReader of contact information from the Contacts
        ' table, and then databind the results to a DataGrid
        ' server control.  It uses the ASPNetPortal.ContactsDB()
        ' data component to encapsulate all data functionality.
        '
        '*******************************************************'

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Obtain contact information from Contacts table
            ' and bind to the DataGrid Control
            Dim contacts As New ASPNetPortal.ContactsDB()

            myDataGrid.DataSource = contacts.GetContacts(ModuleId)
            myDataGrid.DataBind()

        End Sub

    End Class

End Namespace