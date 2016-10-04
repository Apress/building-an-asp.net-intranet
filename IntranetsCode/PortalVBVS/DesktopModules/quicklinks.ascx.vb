Namespace ASPNetPortal

    Public MustInherit Class QuickLinks
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents EditButton As System.Web.UI.WebControls.HyperLink
        Protected WithEvents myDataList As System.Web.UI.WebControls.DataList

        Protected linkImage As String = ""

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
        ' obtain a DataReader of link information from the Links
        ' table, and then databind the results to a templated DataList
        ' server control.  It uses the ASPNetPortal.LinkDB()
        ' data component to encapsulate all data functionality.
        '
        '*******************************************************'

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Set the link image type
            If IsEditable Then
                linkImage = "~/images/edit.gif"
            Else
                linkImage = "~/images/navlink.gif"
            End If

            ' Obtain links information from the Links table
            ' and bind to the list control
            Dim links As New ASPNetPortal.LinkDB()

            myDataList.DataSource = links.GetLinks(ModuleId)
            myDataList.DataBind()

            ' Ensure that only users in role may add links
            If PortalSecurity.IsInRoles(ModuleConfiguration.AuthorizedEditRoles) Then

                EditButton.Text = "Add Link"
                EditButton.NavigateUrl = "~/DesktopModules/EditLinks.aspx?mid=" & ModuleId.ToString()

            End If

        End Sub

    End Class

End Namespace
