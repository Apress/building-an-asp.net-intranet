Imports ASPNetPortal

Namespace Wrox.Intranet.ContentManagement.Controls

    Public MustInherit Class ContentActionTabs
        Inherits System.Web.UI.UserControl

        Protected ReadLink As System.Web.UI.WebControls.HyperLink
        Protected EditLink As System.Web.UI.WebControls.HyperLink
        Protected RelatedContentLink As System.Web.UI.WebControls.HyperLink

        Public EditText As [String] = Nothing
        Public EditUrl As [String] = Nothing
        Public EditVisible As [Boolean] = False

        Public ReadText As [String] = Nothing
        Public ReadUrl As [String] = Nothing

        Public RelatedContentText As [String] = Nothing
        Protected WithEvents ReadButton As System.Web.UI.WebControls.HyperLink
        Protected WithEvents RelatedContentButton As System.Web.UI.WebControls.HyperLink
        Protected WithEvents EditButton As System.Web.UI.WebControls.HyperLink
        Public RelatedContentUrl As [String] = Nothing



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


            'Check the read text and display the read button
            If Not Me.Page.IsPostBack Then
                If Not (ReadText Is Nothing) Then
                    ReadLink.Text = ReadText
                    ReadLink.NavigateUrl = ReadUrl
                End If

                'Check the permissions and display the related content button
                If Not (RelatedContentText Is Nothing) Then
                    RelatedContentLink.Text = RelatedContentText
                    RelatedContentLink.NavigateUrl = RelatedContentUrl
                End If

                'Check the permissions and display the edit button
                If EditVisible And (Not IsNothing(EditText)) Then
                    EditLink.Text = EditText
                    EditLink.NavigateUrl = EditUrl
                End If
            End If

        End Sub

    End Class

End Namespace