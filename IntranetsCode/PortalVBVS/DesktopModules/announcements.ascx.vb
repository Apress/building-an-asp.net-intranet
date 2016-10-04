Namespace ASPNetPortal

    Public MustInherit Class Announcements
        Inherits ASPNetPortal.PortalModuleControl

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

        '*******************************************************
        '
        ' The Page_Load event handler on this User Control is used to
        ' obtain a DataSet of announcement information from the Announcements
        ' table, and then databind the results to a templated DataList
        ' server control.  It uses the ASPNetPortal.AnnouncementsDB()
        ' data component to encapsulate all data functionality.
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Obtain announcement information from Announcements table
            ' and bind to the datalist control
            Dim announcements As New ASPNetPortal.AnnouncementsDB()

            ' DataBind Announcements to DataList Control
            myDataList.DataSource = announcements.GetAnnouncements(ModuleId)
            myDataList.DataBind()

        End Sub

    End Class
End Namespace
