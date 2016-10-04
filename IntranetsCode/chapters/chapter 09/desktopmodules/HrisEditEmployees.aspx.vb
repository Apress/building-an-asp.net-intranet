Imports System.IO
Imports ASPNetPortal

Namespace ASPNetPortal.Hris

    Public Class HrisEditEmployees
        Inherits System.Web.UI.Page


        Private itemId As Integer = 0
        Protected WithEvents Textbox2 As System.Web.UI.WebControls.TextBox
        Protected WithEvents PhotographField As System.Web.UI.HtmlControls.HtmlInputFile
        Protected WithEvents ContractField As System.Web.UI.HtmlControls.HtmlInputFile
        Protected WithEvents chk As System.Web.UI.WebControls.CheckBox
        Protected WithEvents TitleDDL As System.Web.UI.WebControls.DropDownList
        Protected WithEvents FirstNameField As System.Web.UI.WebControls.TextBox
        Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents MiddleNamesField As System.Web.UI.WebControls.TextBox
        Protected WithEvents LastNameField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Requiredfieldvalidator2 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents EthnicOriginDDL As System.Web.UI.WebControls.DropDownList
        Protected WithEvents SSNField As System.Web.UI.WebControls.TextBox
        Protected WithEvents RegularExpressionValidator1 As System.Web.UI.WebControls.RegularExpressionValidator
        Protected WithEvents HomeAddField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Requiredfieldvalidator3 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents TelephoneNumField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Requiredfieldvalidator4 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents BankRTField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Regularexpressionvalidator2 As System.Web.UI.WebControls.RegularExpressionValidator
        Protected WithEvents BankAcct As System.Web.UI.WebControls.TextBox
        Protected WithEvents Regularexpressionvalidator3 As System.Web.UI.WebControls.RegularExpressionValidator
        Protected WithEvents NextOfKinField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Requiredfieldvalidator6 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents GPAddressField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Requiredfieldvalidator5 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents EMailField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Regularexpressionvalidator5 As System.Web.UI.WebControls.RegularExpressionValidator
        Protected WithEvents SiteDDL As System.Web.UI.WebControls.DropDownList
        Protected WithEvents StatusDDL As System.Web.UI.WebControls.DropDownList
        Protected WithEvents JobTitleDDL As System.Web.UI.WebControls.DropDownList
        Protected WithEvents chkUploadPhoto As System.Web.UI.WebControls.CheckBox
        Protected WithEvents chkUploadContract As System.Web.UI.WebControls.CheckBox
        Protected WithEvents SalaryField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Requiredfieldvalidator7 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents NotesField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Requiredfieldvalidator8 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents HealthNotesField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Requiredfieldvalidator9 As System.Web.UI.WebControls.RequiredFieldValidator
        Protected WithEvents DateOfBirthField As System.Web.UI.WebControls.TextBox
        Protected WithEvents CompareValidator1 As System.Web.UI.WebControls.CompareValidator
        Protected WithEvents ReviewBaseDateField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Comparevalidator2 As System.Web.UI.WebControls.CompareValidator
        Protected WithEvents LeavingDateField As System.Web.UI.WebControls.TextBox
        Protected WithEvents Comparevalidator4 As System.Web.UI.WebControls.CompareValidator
        Protected WithEvents updateButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents cancelButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents deleteButton As System.Web.UI.WebControls.LinkButton
        Protected WithEvents CreatedBy As System.Web.UI.WebControls.Label
        Protected WithEvents CreatedDate As System.Web.UI.WebControls.Label
        Protected WithEvents lblError As System.Web.UI.WebControls.Label
        Protected WithEvents CompareValidator3 As System.Web.UI.WebControls.CompareValidator
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
        ' It then uses the ASPNetPortal.EmployeesBiz() data component
        ' to populate the page's edit controls with the Employees details.
        '
        '****************************************************************

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Determine ModuleId of Announcements Portal Module
            moduleId = Int32.Parse(Request.Params("Mid"))

            ' Verify that the current user has access to edit this module
            If PortalSecurity.HasEditPermissions(moduleId) = False Then
                Response.Redirect("~/Admin/EditAccessDenied.aspx")
            End If

            ' Determine ItemId of Document to Update
            If Not (Request.Params("ItemId") Is Nothing) Then
                itemId = Int32.Parse(Request.Params("ItemId"))
            End If

            ' Add a javascript confirmation request to the deleteButton
            deleteButton.Attributes.Add("onClick", "javascript: return confirm('Are you sure?');")

            ' If the page is being requested the first time, determine if an
            ' document itemId value is specified, and if so populate page
            ' contents with the document details
            If Page.IsPostBack = False Then

                'Populate the EthnicOriginDDL dropdownlist
                EthnicOriginDDL.DataSource = EthnicOriginsBiz.GetEthnicOrigins()
                EthnicOriginDDL.DataBind()

                'Populate the SiteDDL dropdownlist
                SiteDDL.DataSource = SitesBiz.GetSites()
                SiteDDL.DataBind()

                'Populate the SiteDDL dropdownlist
                StatusDDL.DataSource = JobStatusesBiz.GetJobStatuses()
                StatusDDL.DataBind()

                'Populate the JobTitleDDL dropdownlist
                JobTitleDDL.DataSource = JobTitlesBiz.GetJobTitles()
                JobTitleDDL.DataBind()

                If itemId <> 0 Then

                    ' Obtain a single row of document information
                    Dim dr As SqlDataReader = EmployeesBiz.GetSingleEmployee(itemId)

                    ' Load first row into Datareader
                    dr.Read()

                    'Ensure the correct Title is Selected
                    Dim li As ListItem
                    For Each li In TitleDDL.Items
                        If (li.Text = CStr(dr("Title"))) Then
                            li.Selected = True
                        End If
                    Next

                    'Ensure the correct EthnicOrigin is Selected
                    For Each li In EthnicOriginDDL.Items
                        If (li.Value = CStr(dr("EthnicOriginID"))) Then
                            li.Selected = True
                        End If
                    Next

                    'Ensure the correct Site is Selected
                    For Each li In SiteDDL.Items
                        If (li.Value = CStr(dr("SiteID"))) Then
                            li.Selected = True
                        End If
                    Next

                    'Ensure the correct Status is Selected
                    For Each li In StatusDDL.Items
                        If (li.Value = CStr(dr("StatusID"))) Then
                            li.Selected = True
                        End If
                    Next

                    'Ensure the correct JobTitle is Selected
                    For Each li In JobTitleDDL.Items
                        If (li.Value = CStr(dr("JobID"))) Then
                            li.Selected = True
                        End If
                    Next

                    FirstNameField.Text = CStr(dr("FirstName"))
                    MiddleNamesField.Text = CStr(dr("MiddleNames"))
                    LastNameField.Text = CStr(dr("LastName"))
                    SSNField.Text = CStr(dr("SSN"))
                    HomeAddField.Text = CStr(dr("HomeAddress"))
                    TelephoneNumField.Text = CStr(dr("TelephoneNum"))
                    BankRTField.Text = CStr(dr("BankRT"))
                    BankAcct.Text = CStr(dr("BankAcct"))
                    NextOfKinField.Text = CStr(dr("NextOfKin"))
                    GPAddressField.Text = CStr(dr("GPAddress"))
                    EMailField.Text = CStr(dr("EMail"))
                    SalaryField.Text = CStr(dr("Salary"))
                    NotesField.Text = CStr(dr("Notes"))
                    HealthNotesField.Text = CStr(dr("HealthNotes"))
                    DateOfBirthField.Text = CStr(dr("DateOfBirth"))
                    ReviewBaseDateField.Text = CStr(dr("ReviewBaseDate"))
                    CreatedBy.Text = CStr(dr("LastAlteredByUser"))
                    CreatedDate.Text = CType(dr("AlteredDate"), DateTime).ToShortDateString()

                    If IsDBNull(dr("LeavingDate")) Then
                        LeavingDateField.Text = ""
                    Else
                        LeavingDateField.Text = CStr(dr("LeavingDate"))
                    End If

                    dr.Close()

                End If

                ' Store URL Referrer to return to portal
                ViewState("UrlReferrer") = Request.UrlReferrer.ToString()

            End If

        End Sub


        '****************************************************************
        '
        ' The UpdateBtn_Click event handler on this Page is used to either
        ' create or update an JobTitle document.  It  uses the ASPNetPortal.JobTitlesBiz()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************

        Private Sub UpdateBtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles updateButton.Click


            'Only Update if Input Data is Valid
            If Page.IsValid = True Then

                Dim PhotoLength As Integer
                Dim PhotoContentType As String
                Dim PhotoContent() As Byte

                Dim ContractLength As Integer
                Dim ContractContentType As String
                Dim ContractContent() As Byte

                ' Determine whether a photo file was uploaded
                If chkUploadPhoto.Checked = True And Not (PhotographField.PostedFile Is Nothing) Then
                    ' Loading to the server for security and web farm support
                    PhotoLength = CInt(PhotographField.PostedFile.InputStream.Length)
                    ReDim PhotoContent(PhotoLength)
                    PhotoContentType = PhotographField.PostedFile.ContentType

                    PhotographField.PostedFile.InputStream.Read(PhotoContent, 0, PhotoLength)
                Else
                    ' Setup acceptable 0 values for the Photo
                    PhotoLength = 0
                    'Create a zero length byte array
                    ReDim PhotoContent(0)
                    PhotoContentType = ""
                End If

                ' Determine whether a Contract file was uploaded
                If chkUploadContract.Checked = True And Not (ContractField.PostedFile Is Nothing) Then
                    ' Loading to the server for security and web farm support
                    ContractLength = CInt(ContractField.PostedFile.InputStream.Length)
                    ReDim ContractContent(ContractLength)
                    ContractContentType = ContractField.PostedFile.ContentType

                    ContractField.PostedFile.InputStream.Read(ContractContent, 0, ContractLength)
                Else
                    ' Setup acceptable 0 values for the Photo
                    ContractLength = 0
                    'Create a zero length byte array
                    ReDim ContractContent(0)
                    ContractContentType = ""
                End If

                Try
                    ' Update the Employee information within the Employees table
                    EmployeesBiz.UpdateEmployee(moduleId, itemId, FirstNameField.Text, MiddleNamesField.Text, LastNameField.Text, _
                            TitleDDL.SelectedItem.Text, CInt(EthnicOriginDDL.SelectedItem.Value), SSNField.Text, HomeAddField.Text, _
                            TelephoneNumField.Text, BankRTField.Text, BankAcct.Text, NextOfKinField.Text, GPAddressField.Text, _
                            EMailField.Text, CInt(SiteDDL.SelectedItem.Value), CInt(StatusDDL.SelectedItem.Value), CInt(JobTitleDDL.SelectedItem.Value), _
                            PhotoContent, PhotoContentType, PhotoLength, ContractContent, ContractContentType, ContractLength, SalaryField.Text, NotesField.Text, _
                            HealthNotesField.Text, DateOfBirthField.Text, ReviewBaseDateField.Text, LeavingDateField.Text, Context.User.Identity.Name)

                    ' Redirect back to the portal home page
                    Response.Redirect(CType(ViewState("UrlReferrer"), String))
                Catch exc As Exception
                    lblError.Text = "Update failed. Please check the values you entered. (" & exc.Message.ToString() & ")"
                End Try

            End If

        End Sub


        '****************************************************************
        '
        ' The DeleteBtn_Click event handler on this Page is used to delete an
        ' an Employee record.  It  uses the ASPNetPortal.EmployeesBiz()
        ' data component to encapsulate all data functionality.
        '
        '****************************************************************
        Private Sub DeleteBtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles deleteButton.Click

            Try
                ' Only attempt to delete the item if it is an existing item
                ' (new items will have "ItemId" of 0)
                If itemId <> 0 Then

                    EmployeesBiz.DeleteEmployee(itemId)


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
        ' out of the page, and return the user back to the portal home
        ' page.
        '
        '****************************************************************
        Private Sub CancelBtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cancelButton.Click

            ' Redirect back to the portal home page
            Response.Redirect(CType(ViewState("UrlReferrer"), String))

        End Sub



        Private Sub CustomValidator1_ServerValidate(ByVal source As System.Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)

        End Sub
    End Class

End Namespace