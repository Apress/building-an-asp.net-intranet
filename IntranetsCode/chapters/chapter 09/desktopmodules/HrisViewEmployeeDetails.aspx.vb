Imports System.IO
Imports System.Configuration
Imports ASPNetPortal

Namespace ASPNetPortal.Hris

    Public Class HrisViewEmployeeDetails
        Inherits System.Web.UI.Page


        Private itemId As Integer = 0
        Protected WithEvents Image1 As System.Web.UI.WebControls.Image
        Protected WithEvents pnlHRAdmin As System.Web.UI.WebControls.Panel
        Protected WithEvents hlnkTitle As System.Web.UI.WebControls.HyperLink
        Protected WithEvents lblStatus As System.Web.UI.WebControls.Label
        Protected WithEvents lblSite As System.Web.UI.WebControls.Label
        Protected WithEvents lblAge As System.Web.UI.WebControls.Label
        Protected WithEvents lblStartDate As System.Web.UI.WebControls.Label
        Protected WithEvents hlnkEMail As System.Web.UI.WebControls.HyperLink
        Protected WithEvents lblTelephoneNum As System.Web.UI.WebControls.Label
        Protected WithEvents txtNotes As System.Web.UI.WebControls.TextBox
        Protected WithEvents lblSalary As System.Web.UI.WebControls.Label
        Protected WithEvents lblSSN As System.Web.UI.WebControls.Label
        Protected WithEvents lblEthnicOrigin As System.Web.UI.WebControls.Label
        Protected WithEvents txtHomeAddress As System.Web.UI.WebControls.TextBox
        Protected WithEvents txtHealthNotes As System.Web.UI.WebControls.TextBox
        Protected WithEvents lblBankRT As System.Web.UI.WebControls.Label
        Protected WithEvents lblBankAcct As System.Web.UI.WebControls.Label
        Protected WithEvents lblReviewDate As System.Web.UI.WebControls.Label
        Protected WithEvents txtNextOfKin As System.Web.UI.WebControls.TextBox
        Protected WithEvents lblName As System.Web.UI.WebControls.Label
        Protected WithEvents hlnkContract As System.Web.UI.WebControls.HyperLink
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
        ' and ItemId of the document to edit.
        '
        ' It then uses the ASPNetPortal.DocumentDB() data component
        ' to populate the page's edit controls with the document details.
        '
        '****************************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Determine ItemId of Document to Update
            If Not (Request.Params("ID") Is Nothing) Then
                itemId = Int32.Parse(Request.Params("ID"))
            End If

            ' If the page is being requested the first time, determine if an
            ' document ID value is specified, and if so populate page
            ' contents with the Employee details
            If Page.IsPostBack = False Then

                If itemId <> 0 Then

                    ' Obtain a single row of Employee information
                    Dim dr As SqlDataReader = EmployeesBiz.GetSingleEmployee(itemId)

                    ' Load first row into Datareader
                    dr.Read()

                    ' If the User is a member of the HRAdminRole specified in the web.config file
                    ' role then they are able to see the HR related information
                    If PortalSecurity.IsInRole(ConfigurationSettings.AppSettings("HRISAdminRole")) _
                        Or HttpContext.Current.User.Identity().Name() = CStr(dr("EMail")) Then
                        pnlHRAdmin.Visible = True
                    Else
                        pnlHRAdmin.Visible = False
                    End If

                    lblName.Text = CStr(dr("FirstName"))
                    If Len(CStr(dr("MiddleNames"))) > 0 Then
                        lblName.Text = lblName.Text & " " & CStr(dr("MiddleNames"))
                    End If
                    lblName.Text = lblName.Text & " " & CStr(dr("LastName"))

                    hlnkTitle.Text = CStr(dr("JobTitle"))
                    hlnkTitle.NavigateUrl = EmployeesBiz.GetBrowsePathDetails("JobTitle", CInt(dr("JobID")))

                    lblStatus.Text = CStr(dr("StatusDescription"))
                    lblSite.Text = CStr(dr("SiteDescription"))
                    lblAge.Text = CStr(dr("Age"))
                    lblStartDate.Text = CStr(dr("ReviewBaseDate"))

                    hlnkEMail.Text = CStr(dr("EMail"))
                    hlnkEMail.NavigateUrl = "mailto:" & CStr(dr("EMail"))

                    If IsDBNull(dr("Contract")) Then
                        hlnkContract.Visible = False
                    Else
                        hlnkContract.Text = "View Contract"
                        hlnkContract.NavigateUrl = EmployeesBiz.GetBrowsePathDetails("Contract", itemId)
                    End If

                    lblTelephoneNum.Text = CStr(dr("TelephoneNum"))
                    txtNotes.Text = CStr(dr("Notes"))
                    lblReviewDate.Text = CStr(dr("NextReviewDate"))

                    lblSalary.Text = CStr(dr("Salary"))
                    lblSSN.Text = CStr(dr("SSN"))
                    lblEthnicOrigin.Text = CStr(dr("EthnicOrigin"))
                    txtHomeAddress.Text = CStr(dr("HomeAddress"))
                    txtHealthNotes.Text = CStr(dr("HealthNotes"))
                    txtNextOfKin.Text = CStr(dr("NextOfKin"))
                    lblBankRT.Text = CStr(dr("BankRT"))
                    lblBankAcct.Text = CStr(dr("BankAccT"))
                    Image1.ImageUrl = EmployeesBiz.GetBrowsePathDetails("Photo", itemId)


                    dr.Close()

                End If

                ' Store URL Referrer to return to portal
                ViewState("UrlReferrer") = Request.UrlReferrer.ToString()

            End If


        End Sub




    End Class

End Namespace