Namespace ASPNetPortal

    Public MustInherit Class ImageModule
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents Image1 As System.Web.UI.WebControls.Image

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
        ' The Page_Load event handler on this User Control uses
        ' the Portal configuration system to obtain image details.
        ' It then sets these properties on an <asp:Image> server control.
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            Dim imageSrc As String = CType(Settings("src"), String)
            Dim imageHeight As String = CType(Settings("height"), String)
            Dim imageWidth As String = CType(Settings("width"), String)

            ' Set Image Source, Width and Height Properties
            If Not (imageSrc Is Nothing) And imageSrc <> "" Then
                Image1.ImageUrl = imageSrc
            End If

            If Not (imageWidth Is Nothing) And imageWidth <> "" Then
                Image1.Width = System.Web.UI.WebControls.Unit.Parse(imageWidth)
            End If

            If Not (imageHeight Is Nothing) And imageHeight <> "" Then
                Image1.Height = System.Web.UI.WebControls.Unit.Parse(imageHeight)
            End If

        End Sub

    End Class

End Namespace