Imports ASPNetPortal

Namespace ASPNetPortal.Hris

    Public Class HrisEditSites
        Inherits System.Web.UI.Page

        Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents updateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents cancelButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents deleteButton As System.Web.UI.WebControls.LinkButton

        Private itemId As Integer = 0
        Protected WithEvents DescriptionField As System.Web.UI.WebControls.TextBox
        Protected WithEvents CodeField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Requiredfieldvalidator2 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents CreatedBy As System.Web.UI.WebControls.Label
        Protected WithEvents CreatedDate As System.Web.UI.WebControls.Label
        Protected WithEvents lblError As System.Web.UI.WebControls.Label
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

        '****************************************************************
        '
        ' The Page_Load event on this Page is used to obtain the ModuleId
        ' and ItemId of the Site to edit.
        '
        ' It then uses the ASPNetPortal.SitesBiz() data component
        ' to populate the page's edit controls with the site details.
        '
        '****************************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Determine ModuleId 
            moduleId = Int32.Parse(Request.Params("Mid"))

            ' Verify that the current user has access to edit this module
            If PortalSecurity.HasEditPermissions(moduleId) = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            ' Determine ItemId of Contacts to Update
            If Not (Request.Params("ItemId") Is Nothing) Then
                itemId = Int32.Parse(Request.Params("ItemId"))
            End If

            ' Add a javascript confirmation request to the deleteButton
            deleteButton.Attributes.Add("onClick", "javascript: return confirm('Are you sure?');")

            ' If the page is being requested the first time, determine if an
            ' Skill Id value is specified, and if so populate page
            ' contents with the Skill details
            If Page.IsPostBack = False Then

                If itemId <> 0 Then

                    ' Obtain a single row of contact information
                    Dim dr As SqlDataReader = SitesBiz.GetSingleSite(itemId)

                    ' Read first row from database
                    dr.Read()

                    CodeField.Text = CType(dr("Code"), String)
                    DescriptionField.Text = CType(dr("Description"), String)
                    CreatedBy.Text = CType(dr("LastAlteredByUser"), String)
                    CreatedDate.Text = CType(dr("AlteredDate"), DateTime).ToShortDateString()

                    ' Close datareader
                    dr.Close()

                End If

                ' Store URL Referrer to return to portal
                ViewState("UrlReferrer") = Request.UrlReferrer.ToString()

            End If

        End Sub


        '****************************************************************
        '
        ' The UpdateBtn_Click event handler on this Page is used to either
        ' create or update a Site definition.  It  uses the ASPNetPortal.SitesBiz()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************

        Private Sub UpdateBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles updateButton.Click

            ' Only Update if Entered data is Valid
            If Page.IsValid = True Then
                Try
                    If itemId = 0 Then

                        ' Add the Skill to the Skills table
                        SitesBiz.AddSite(CodeField.Text, DescriptionField.Text, Context.User.Identity.Name)

                    Else

                        ' Update the Site within the sites table
                        SitesBiz.UpdateSite(itemId, CodeField.Text, DescriptionField.Text, Context.User.Identity.Name)

                    End If

                    ' Redirect back to the intranet home page
                    Response.Redirect(CType(ViewState("UrlReferrer"), String))
                    
                Catch exc As Exception
                    lblError.Text = "Update failed. Please check the values you entered. (" & exc.Message.ToString() & ")"
                End Try

            End If

        End Sub


        '****************************************************************
        '
        ' The DeleteBtn_Click event handler on this Page is used to delete a
        ' site definition.  It  uses the ASPNetPortal.SitesBiz
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************

        Private Sub DeleteBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles deleteButton.Click
            Try
                ' Only attempt to delete the item if it is an existing item
                ' (new items will have "ItemId" of 0)
                If itemId <> 0 Then
                    SitesBiz.DeleteSite(itemId)
                End If

                ' Redirect back to the portal home page
                Response.Redirect(CType(ViewState("UrlReferrer"), String))

            Catch exc As Exception
                lblError.Text = "Delete failed. (" & exc.Message.ToString() & ")"
            End Try

        End Sub


        '****************************************************************
        '
        ' The CancelBtn_Click event handler on this Page is used to cancel
        ' out of the page, and return the user back to the Intranet home
        ' page.
        '
        '****************************************************************

        Private Sub CancelBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cancelButton.Click

            ' Redirect back to the intranet home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

        End Sub


    End Class

End Namespace