Namespace ASPNetPortal

    Public Class EditEvents
        Inherits System.Web.UI.Page

        Protected WithEvents TitleField As System.Web.UI.WebControls.TextBox
        Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents DescriptionField As System.Web.UI.WebControls.TextBox
        Protected WithEvents RequiredFieldValidator2 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents WhereWhenField As System.Web.UI.WebControls.TextBox
        Protected WithEvents RequiredFieldValidator3 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents updateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents cancelButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents deleteButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents CreatedBy As System.Web.UI.WebControls.Label
        Protected WithEvents CreatedDate As System.Web.UI.WebControls.Label

        Private itemId As Integer = 0
        Protected WithEvents EventDateField As System.Web.UI.WebControls.TextBox
        Protected WithEvents VerifyEventDate As System.Web.UI.WebControls.CompareValidator
        Protected WithEvents AuthViewRoles As System.Web.UI.WebControls.CheckBoxList
        Protected WithEvents RequiredFieldValidator4 As System.Web.UI.WebControls.RequiredFieldValidator
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
        ' and ItemId of the event to edit.
        '
        ' It then uses the ASPNetPortal.EventsDB() data component
        ' to populate the page's edit controls with the event details.
        '
        '****************************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Determine ModuleId of Events Portal Module
            If Not (Request.Params("Mid") Is Nothing) Then
                moduleId = Int32.Parse(Request.Params("Mid"))
            Else
                ' If mid is not present then return the user back
                Response.Redirect("~/Default.aspx")
            End If

            If Not (Request.Params("ItemID") Is Nothing) Then
                itemId = Int32.Parse(Request.Params("ItemID"))
            End If

            ' Verify that the current user has access to edit this module
            If PortalSecurity.HasEditPermissions(moduleId) = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            If Page.IsPostBack = False Then
                ' Call method to bind the controls
                Bind()
                ' Store URL Referrer to return to portal
                If IsNothing(Request.UrlReferrer) Then
                    ViewState("UrlReferrer") = "~/Default.aspx"
                Else
                    ViewState("UrlReferrer") = Request.UrlReferrer.ToString()
                End If



            End If

        End Sub


        '****************************************************************
        '
        ' The Bind method is used to bind the controls with the database.
        '  It uses the ASPNetPortal.EventsDB()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************
        Private Sub Bind()

            ' Obtain PortalSettings from Current Context
            Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

            ' Populate checkbox list with all security roles for this portal
            ' and "check" the ones already configured for this tab
            Dim admin As New AdminDB()
            Dim roles As SqlDataReader = admin.GetPortalRoles(_portalSettings.PortalId)

            ' Databind the checkboxlist
            AuthViewRoles.DataSource = roles
            AuthViewRoles.DataTextField = "RoleName"
            AuthViewRoles.DataValueField = "RoleID"
            AuthViewRoles.DataBind()
            roles.Close()

            ' Add a generic item to the checkboxlist
            Dim allItem As New ListItem()
            allItem.Text = "All Users"
            AuthViewRoles.Items.Add(allItem)

            If itemId <> 0 Then

                ' Obtain a single row of event information
                Dim events As New ASPNetPortal.EventsDB()
                Dim dr As SqlDataReader = events.GetSingleEvent(moduleId, itemId)

                ' Read first row from database
                dr.Read()
                ' Restore the values from the database to the controls
                TitleField.Text = CType(dr("Title"), String)
                DescriptionField.Text = CType(dr("Description"), String)
                CreatedBy.Text = CType(dr("CreatedByUser"), String)
                WhereWhenField.Text = CType(dr("WhereWhen"), String)
                EventDateField.Text = CType(dr("EventDate"), DateTime).ToShortDateString()
                CreatedDate.Text = CType(dr("CreatedDate"), DateTime).ToShortDateString()

                ' Code to select the appropriate checkboxes
                ' after reading the roles from the database
                Dim rolesStr As String()
                ' Split the roles into an array 
                rolesStr = CType(dr("AuthorizedViewRoles"), String).Split(";"c)
                Dim singleRole As String
                Dim roleItem As ListItem
                ' loop over the array
                For Each singleRole In rolesStr
                    ' Try to find a CheckBox with similar Text
                    roleItem = AuthViewRoles.Items.FindByText(singleRole)
                    If Not IsNothing(roleItem) Then
                        ' Select the CheckBox
                        roleItem.Selected = True
                    End If
                Next

                dr.Close()
            Else
                AuthViewRoles.Items.FindByText("All Users").Selected = True
                'Change the Text property of the Update Button
                updateButton.Text = "Add"
                'Hide the Delete button for a new event
                deleteButton.Visible = False
                'Set the Username label
                CreatedBy.Text = Context.User.Identity.Name
                'Set the creation date label
                CreatedDate.Text = DateTime.Now.ToShortDateString()

            End If

        End Sub

        '****************************************************************
        '
        ' The UpdateBtn_Click event handler on this Page is used to either
        ' create or update an event.  It uses the ASPNetPortal.EventsDB()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************

        Private Sub UpdateBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles updateButton.Click

            ' Only Update if the Entered Data is Valid
            If Page.IsValid = True Then

                Dim viewRoles As String = ""

                'Prepare the roles string
                If IsNothing(AuthViewRoles.SelectedItem) Or AuthViewRoles.Items.FindByText("All Users").Selected = True Then
                    ' Set the default to all users
                    viewRoles = "All Users"
                Else
                    Dim roleItem As ListItem
                    ' loop through the CheckBoxList
                    For Each roleItem In AuthViewRoles.Items
                        If roleItem.Selected = True Then
                            viewRoles = viewRoles & roleItem.Text & ";"
                        End If
                    Next
                End If

                ' Create an instance of the Event DB component
                Dim events As New ASPNetPortal.EventsDB()

                If itemId = 0 Then

                    ' Add the event within the Events table
                    events.AddEvent(moduleId, itemId, Context.User.Identity.Name, TitleField.Text, DateTime.Parse(EventDateField.Text), DescriptionField.Text, WhereWhenField.Text, viewRoles)

                Else

                    ' Update the event within the Events table
                    events.UpdateEvent(moduleId, itemId, Context.User.Identity.Name, TitleField.Text, DateTime.Parse(EventDateField.Text), DescriptionField.Text, WhereWhenField.Text, viewRoles)

                End If

                ' Redirect back to the portal home page
                Response.Redirect(CType(ViewState("UrlReferrer"), String))

            End If

        End Sub


        '****************************************************************
        '
        ' The DeleteBtn_Click event handler on this Page is used to delete an
        ' an event.  It  uses the ASPNetPortal.EventsDB() data component to
        ' encapsulate all data functionality.
        '
        '****************************************************************

        Private Sub DeleteBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles deleteButton.Click

            ' Only attempt to delete the item if it is an existing item
            ' (new items will have "ItemId" of 0)
            If itemId <> 0 Then

                Dim events As New ASPNetPortal.EventsDB()
                events.DeleteEvent(itemId)

            End If

            ' Redirect back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

        End Sub


        '****************************************************************
        '
        ' The CancelBtn_Click event handler on this Page is used to cancel
        ' out of the page, and return the user back to the portal home
        ' page.
        '
        '****************************************************************'

        Private Sub CancelBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cancelButton.Click

            ' Redirect back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

        End Sub

    End Class

End Namespace