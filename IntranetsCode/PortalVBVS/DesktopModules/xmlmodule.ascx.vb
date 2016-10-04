Imports System.IO

Namespace ASPNetPortal

   MustInherit Public Class XmlModule
        Inherits ASPNetPortal.PortalModuleControl

        Protected WithEvents xml1 As System.Web.UI.WebControls.Xml
      
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
        ' the Portal configuration system to obtain an xml document
        ' and xsl/t transform file location.  It then sets these
        ' properties on an <asp:Xml> server control.
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            Dim xmlsrc As String = CType(Settings("xmlsrc"), String)

            If Not (xmlsrc Is Nothing) And xmlsrc <> "" Then

                If File.Exists(Server.MapPath(xmlsrc)) Then

                    xml1.DocumentSource = xmlsrc

                Else

                    Controls.Add(New LiteralControl("<" & "br" & "><" & "span class=NormalRed" & ">" & "File " & xmlsrc & " not found.<" & "br" & ">"))

                End If

            End If

            Dim xslsrc As String = CType(Settings("xslsrc"), String)

            If Not (xslsrc Is Nothing) And xslsrc <> "" Then

                If File.Exists(Server.MapPath(xslsrc)) Then

                    xml1.TransformSource = xslsrc

                Else

                    Controls.Add(New LiteralControl("<" & "br" & "><" & "span class=NormalRed>File " & xslsrc & " not found.<" & "br" & ">"))

                End If

            End If

        End Sub

    End Class

End Namespace
