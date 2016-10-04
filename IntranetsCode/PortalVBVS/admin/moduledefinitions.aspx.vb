Namespace ASPNetPortal

    Public Class ModuleDefinitions
        Inherits System.Web.UI.Page

        Protected WithEvents FriendlyName As System.Web.UI.WebControls.TextBox
        Protected WithEvents Req1 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents DesktopSrc As System.Web.UI.WebControls.TextBox
        Protected WithEvents Req2 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents MobileSrc As System.Web.UI.WebControls.TextBox
        Protected WithEvents updateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents cancelButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents deleteButton As System.Web.UI.WebControls.LinkButton

        Private defId As Integer = -1
        Private tabIndex As Integer = 0
        Private tabId As Integer = 0

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
        ' The Page_Load server event handler on this page is used
        ' to populate the role information for the page
        '
        '*******************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Verify that the current user has access to access this page
            If PortalSecurity.IsInRoles("Admins") = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            ' Calculate security defId
            If Not (Request.Params("defid") Is Nothing) Then
                defId = Int32.Parse(Request.Params("defid"))
            End If
            If Not (Request.Params("tabid") Is Nothing) Then
                tabId = Int32.Parse(Request.Params("tabid"))
            End If
            If Not (Request.Params("tabindex") Is Nothing) Then
                tabIndex = Int32.Parse(Request.Params("tabindex"))
            End If


            ' If this is the first visit to the page, bind the definition data 
            If Page.IsPostBack = False Then

                If defId = -1 Then

                    ' new module definition
                    FriendlyName.Text = "New Definition"
                    DesktopSrc.Text = "DesktopModules/SomeModule.ascx"
                    MobileSrc.Text = "MobileModules/SomeModule.ascx"

                Else

                    ' Obtain the module definition to edit from the database
                    Dim admin As New ASPNetPortal.AdminDB()
                    Dim dr As SqlDataReader = admin.GetSingleModuleDefinition(defId)

                    ' Read in first row from database
                    dr.Read()

                    FriendlyName.Text = CType(dr("FriendlyName"), String)
                    DesktopSrc.Text = CType(dr("DesktopSrc"), String)
                    MobileSrc.Text = CType(dr("MobileSrc"), String)

                    ' Close datareader
                    dr.Close()

                End If

            End If

        End Sub


        '****************************************************************
        '
        ' The UpdateBtn_Click event handler on this Page is used to either
        ' create or update a link.  It  uses the ASPNetPortal.LinkDB()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************

        Private Sub UpdateBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles updateButton.Click

            If Page.IsValid = True Then

                Dim admin As New AdminDB()

                If defId = -1 Then

                    ' Obtain PortalSettings from Current Context
                    Dim _portalSettings As PortalSettings = CType(Context.Items("PortalSettings"), PortalSettings)

                    ' Add a new module definition to the database
                    admin.AddModuleDefinition(_portalSettings.PortalId, FriendlyName.Text, DesktopSrc.Text, MobileSrc.Text)

                Else

                    ' update the module definition
                    admin.UpdateModuleDefinition(defId, FriendlyName.Text, DesktopSrc.Text, MobileSrc.Text)

                End If

                ' Redirect back to the portal admin page
                Response.Redirect(("~/DesktopDefault.aspx?tabindex=" & tabIndex & "&tabid=" & tabId))

            End If

        End Sub


        '****************************************************************
        '
        ' The DeleteBtn_Click event handler on this Page is used to delete an
        ' a link.  It  uses the ASPNetPortal.LinksDB()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************

        Private Sub DeleteBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles deleteButton.Click

            ' delete definition
            Dim admin As New ASPNetPortal.AdminDB()
            admin.DeleteModuleDefinition(defId)

            ' Redirect back to the portal admin page
            Response.Redirect(("~/DesktopDefault.aspx?tabindex=" & tabIndex & "&tabid=" & tabId))

        End Sub


        '****************************************************************
        '
        ' The CancelBtn_Click event handler on this Page is used to cancel
        ' out of the page -- and return the user back to the portal home
        ' page.
        '
        '****************************************************************'

        Private Sub CancelBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cancelButton.Click

            ' Redirect back to the portal home page
            Response.Redirect(("~/DesktopDefault.aspx?tabindex=" & tabIndex & "&tabid=" & tabId))

        End Sub

    End Class

End Namespace
