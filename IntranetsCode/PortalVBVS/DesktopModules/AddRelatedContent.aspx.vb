Imports ASPNetPortal

Namespace Wrox.Intranet.ContentManagement.Pages

    Public Class AddRelatedContent
        Inherits System.Web.UI.Page


        Private itemId As Integer = 0
        Protected WithEvents ErrorMessage As System.Web.UI.WebControls.Label
        Protected WithEvents question As System.Web.UI.WebControls.Label
        Protected WithEvents AssignRelated As System.Web.UI.WebControls.RadioButtonList
        Protected WithEvents relContent As System.Web.UI.WebControls.CheckBoxList
        Protected WithEvents relCon As System.Web.UI.WebControls.LinkButton
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

            ' Verify that the current user has access to edit this module
            If PortalSecurity.HasEditPermissions(moduleId) = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            ' Determine ItemId of Events to Update
            If Not (Request.Params("ItemId") Is Nothing) Then
                itemId = Int32.Parse(Request.Params("ItemId"))
            End If

            If Page.IsPostBack = False Then

                If itemId <> 0 Then
                    question.Visible = True
                    AssignRelated.Visible = True
                    relContent.Visible = False
                    relCon.Visible = False

                End If

            End If

        End Sub

        Public Sub AssignRelated_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AssignRelated.SelectedIndexChanged
            If AssignRelated.SelectedItem.Value = "1" Then
                'Get all available content
                GetContent()
                'Now select the content that's already related
                SetRelatedContent()

                question.Visible = False
                AssignRelated.Visible = False
            Else
                Response.Redirect("~/Desktopdefault.aspx")
            End If
        End Sub


        Private Sub GetContent()

            Dim cm As New Components.ContentManagement()
            Dim datareader As System.Data.SqlClient.SqlDataReader

            Try
                relContent.Visible = True
                relCon.Visible = True

                datareader = cm.ViewContent(moduleId)
                relContent.DataSource = datareader
                relContent.DataBind()

                relContent.Items.Remove(relContent.Items.FindByValue(CType(itemId, String)))
            Catch
                ErrorMessage.Text = "Unable to retrieve the content at this time."
            Finally
                If Not IsNothing(datareader) Then
                    datareader.Close()
                End If

            End Try

            datareader = Nothing
            cm = Nothing

        End Sub

        Private Sub SetRelatedContent()

            Dim cm As New Components.ContentManagement()
            Dim datareader As System.Data.SqlClient.SqlDataReader
            Dim objListItem As ListItem

            relContent.Visible = True
            relCon.Visible = True

            Try
                datareader = cm.ViewRelatedContent(CType(itemId, Integer))

                If datareader Is Nothing Then
                    ErrorMessage.Text = cm.ErrorMessage
                Else
                    Do While (datareader.Read())
                        objListItem = relContent.Items.FindByValue(CType(datareader.Item(0), String))
                        If objListItem Is Nothing Then
                        Else
                            objListItem.Selected = True
                        End If
                    Loop
                End If
            Catch
                ErrorMessage.Text = "Unable to set the related content."
            Finally
                If Not IsNothing(datareader) Then
                    datareader.Close()
                End If
            End Try

            datareader = Nothing
            cm = Nothing

        End Sub

        Private Sub relCon_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles relCon.Click
            Dim cm As New Wrox.Intranet.ContentManagement.Components.ContentManagement()
            Dim aL As New ArrayList()
            Dim objListItem As ListItem
            Dim result As Integer
            Try
                For Each objListItem In relContent.Items
                    If objListItem.Selected Then
                        aL.Add(objListItem.Value)
                    End If
                Next

                result = cm.AddRelatedContent(itemId, aL.ToArray())

                If result >= 0 Then
                    Response.Redirect("~/Desktopdefault.aspx")
                Else
                    ErrorMessage.Text = cm.ErrorMessage
                End If
            Catch
                ErrorMessage.Text = "Unable to Add related content at this time."
            End Try

            cm = Nothing

        End Sub
    End Class

End Namespace