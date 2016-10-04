Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal
Imports Wrox.Intranet.DataTools

Namespace ASPNetPortal.Hris '<Group>>
    '*********************************************************************
    ' EmployeeBiz Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' Employees within the database.
    '
    '*********************************************************************
    Public Class EmployeesBiz

        '*********************************************************************
        ' SearchEmployees Method
        '
        ' The SearchEmployees method returns a DataSet containing the search results
        ' from a full text search on the Employees table.
        '
        '*********************************************************************
        Public Shared Function SearchEmployees(ByVal SearchText As String) As DataSet

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@SearchText", SearchText)
            db.RunProcedure("up_Hris_SearchEmployeesFT", params, myDataSet)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataSet Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataSet

        End Function

        '*******************************************************
        '
        ' GetBrowsePathDetails() is a helper method used to create the url   
        ' to view the details of an entity
        '
        ' This method is used in the databinding expression for
        ' the browse Hyperlink within the DataGrid, and is called 
        ' for each row when DataGrid.DataBind() is called.  It is 
        ' defined as a helper method here (as opposed to inline 
        ' within the template) to improve code organization and
        ' avoid embedding logic within the content template.
        '
        '*******************************************************'

        Public Shared Function GetBrowsePathDetails(ByVal Entity As String, ByVal ID As Integer) As String

            ' if there is content in the database, create an 
            ' url to browse it
            Select Case Entity
                Case "Employee"
                    Return "~/DesktopModules/HrisViewEmployeeDetails.aspx?ID=" & ID.ToString()
                Case "JobTitle"
                    Return "~/DesktopModules/HrisViewJobTitles.aspx?ID=" & ID.ToString()
                Case "Photo"
                    Return "~/DesktopModules/HrisViewPhoto.aspx?ID=" & ID.ToString()
                Case "Contract"
                    Return "~/DesktopModules/HrisViewContract.aspx?ID=" & ID.ToString()
            End Select
        End Function

        '*********************************************************************
        ' GetEmployees Method
        '
        ' The GetEmployees method returns a DataSet containing all of the
        ' Entities for a specific portal module from the Hris
        ' database.
        '
        '*********************************************************************
        Public Shared Function GetEmployees(ByVal InstanceID As Integer) As DataSet

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@InstanceID", InstanceID)
            db.RunProcedure("up_Hris_GetEmployees", params, myDataSet)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataSet Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataSet
        End Function

        '*********************************************************************
        ' GetEmployeesSummary Method
        '
        ' The GetEmployeesSummary method returns a DataSet containing all of the
        ' some of the details about an Employee
        '
        '*********************************************************************
        Public Shared Function GetEmployeesSummary(ByVal InstanceID As Integer) As DataSet

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@InstanceID", InstanceID)
            db.RunProcedure("up_Hris_GetEmployeesFull", params, myDataSet)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataSet Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataSet
        End Function

        '*********************************************************************
        ' GetNewEmployees Method
        '
        ' The GetNewEmployees method returns a DataSet containing all of the
        ' details about newly employed Employees. The stored procedure
        ' accepts a single parameter of the number of months for which an employee
        ' is treated as new (it defaults to 3)
        '
        '*********************************************************************
        Public Shared Function GetNewEmployees(ByVal Months As Integer) As DataSet

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@Months", Months)
            db.RunProcedure("up_Hris_GetNewEmployees", params, myDataSet)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataSet Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataSet

        End Function

        '*********************************************************************
        ' GetSingleEmployee Method
        '
        ' The GetSingleEmployee method returns a SqlDataReader containing details
        ' about a specific Employee from the tblHris_Employees database table.
        '*********************************************************************
        Public Shared Function GetSingleEmployee(ByVal itemId As Integer) As SqlDataReader

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemId)
            db.RunProcedure("up_Hris_GetSingleEmployee", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataReader
        End Function

        '*********************************************************************
        ' DeleteEmployee Method
        '
        ' The DeleteEmployee method deletes the specified Employee from
        ' the Employees database table.
        '*********************************************************************
        Public Shared Sub DeleteEmployee(ByVal itemID As Integer)

            Dim result As Integer
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemID)
            result = db.RunProcedure("up_Hris_DeleteEmployee", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

        '*********************************************************************
        ' AddEmployee Method
        '
        ' The AddEmployee method adds a new Employee to the tblHris_Employees
        ' database table, and returns the ItemId value as a result.
        '*********************************************************************
        Public Shared Function AddEmployee(ByVal InstanceID As Integer, ByVal FirstName As String, ByVal MiddleNames As String, _
            ByVal LastName As String, ByVal Title As String, ByVal EthnicOriginID As Integer, ByVal SSN As String, _
            ByVal HomeAddress As String, ByVal TelephoneNum As String, ByVal BankRT As String, ByVal BankAcct As String, _
            ByVal NextOfKin As String, ByVal GPAddress As String, ByVal EMail As String, ByVal SiteID As Integer, _
            ByVal StatusID As Integer, ByVal JobID As Integer, ByVal Photograph() As Byte, ByVal PhotoContentType As String, _
            ByVal PhotoContentSize As Integer, ByVal Contract() As Byte, ByVal ContractContentType As String, _
            ByVal ContractContentSize As Integer, ByVal Salary As Single, ByVal Notes As String, ByVal HealthNotes As String, _
            ByVal DateOfBirth As String, ByVal ReviewBaseDate As String, ByVal LeavingDate As String, ByVal UserName As String) As Integer

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(30) As SqlParameter
            Dim itemId As Integer

            params(0) = db.MakeParameter("@ID", ParameterDirection.Output, itemId)
            params(1) = db.MakeParameter("@InstanceID", InstanceID)
            params(2) = db.MakeParameter("@FirstName", FirstName)
            params(3) = db.MakeParameter("@MiddleNames", MiddleNames)
            params(4) = db.MakeParameter("@LastName", LastName)
            params(5) = db.MakeParameter("@Title", Title)
            params(6) = db.MakeParameter("@EthnicOriginID", EthnicOriginID)
            params(7) = db.MakeParameter("@SSN", SSN)
            params(8) = db.MakeParameter("@HomeAddress", HomeAddress)
            params(9) = db.MakeParameter("@TelephoneNum", TelephoneNum)
            params(10) = db.MakeParameter("@BankRT", BankRT)
            params(11) = db.MakeParameter("@BankAcct", BankAcct)
            params(12) = db.MakeParameter("@NextOfKin", NextOfKin)
            params(13) = db.MakeParameter("@GPAddress", GPAddress)
            params(14) = db.MakeParameter("@EMail", EMail)
            params(15) = db.MakeParameter("@SiteID", SiteID)
            params(16) = db.MakeParameter("@StatusID", StatusID)
            params(17) = db.MakeParameter("@JobID", JobID)
            params(18) = db.MakeParameter("@Photograph", Photograph)
            params(19) = db.MakeParameter("@PhotoContentType", PhotoContentType)
            params(20) = db.MakeParameter("@PhotoContentSize", PhotoContentSize)
            params(21) = db.MakeParameter("@Contract", Contract)
            params(22) = db.MakeParameter("@ContractContentType", ContractContentType)
            params(23) = db.MakeParameter("@ContractContentSize", ContractContentSize)
            params(24) = db.MakeParameter("@Salary", Salary)
            params(25) = db.MakeParameter("@Notes", Notes)
            params(26) = db.MakeParameter("@HealthNotes", HealthNotes)
            params(27) = db.MakeParameter("@DateOfBirth", CType(DateOfBirth, System.DateTime))
            params(28) = db.MakeParameter("@ReviewBaseDate", CType(ReviewBaseDate, System.DateTime))

            If UserName.Length < 1 Then
                UserName = "unknown"
            End If
            params(29) = db.MakeParameter("@UserName", UserName)
            Try
                If IsDate(LeavingDate) Then
                    params(30) = db.MakeParameter("@LeavingDate", LeavingDate)
                Else
                    params(30) = db.MakeParameter("@LeavingDate", System.DBNull.Value)
                End If
            Catch
                params(30) = db.MakeParameter("@LeavingDate", System.DBNull.Value)
            End Try

            db.RunProcedure("up_Hris_InsertEmployee", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return CInt(params(0).Value)
        End Function

        '*********************************************************************
        ' UpdateEmployee Method
        '
        ' The UpdateEmployee method updates an Employee to the tblHris_Employees
        ' database table
        '*********************************************************************
        Public Shared Sub UpdateEmployee(ByVal InstanceID As Integer, ByVal ID As Integer, ByVal FirstName As String, ByVal MiddleNames As String, _
            ByVal LastName As String, ByVal Title As String, ByVal EthnicOriginID As Integer, ByVal SSN As String, _
            ByVal HomeAddress As String, ByVal TelephoneNum As String, ByVal BankRT As String, ByVal BankAcct As String, _
            ByVal NextOfKin As String, ByVal GPAddress As String, ByVal EMail As String, ByVal SiteID As Integer, _
            ByVal StatusID As Integer, ByVal JobID As Integer, ByVal Photograph() As Byte, ByVal PhotoContentType As String, _
            ByVal PhotoContentSize As Integer, ByVal Contract() As Byte, ByVal ContractContentType As String, _
            ByVal ContractContentSize As Integer, ByVal Salary As Single, ByVal Notes As String, ByVal HealthNotes As String, _
            ByVal DateOfBirth As String, ByVal ReviewBaseDate As String, ByVal LeavingDate As String, ByVal UserName As String)

            Dim result As Integer
            Dim db As New Database()
            Dim params(30) As SqlParameter

            params(0) = db.MakeParameter("@ID", ID)
            params(1) = db.MakeParameter("@InstanceID", InstanceID)
            params(2) = db.MakeParameter("@FirstName", FirstName)
            params(3) = db.MakeParameter("@MiddleNames", MiddleNames)
            params(4) = db.MakeParameter("@LastName", LastName)
            params(5) = db.MakeParameter("@Title", Title)
            params(6) = db.MakeParameter("@EthnicOriginID", EthnicOriginID)
            params(7) = db.MakeParameter("@SSN", SSN)
            params(8) = db.MakeParameter("@HomeAddress", HomeAddress)
            params(9) = db.MakeParameter("@TelephoneNum", TelephoneNum)
            params(10) = db.MakeParameter("@BankRT", BankRT)
            params(11) = db.MakeParameter("@BankAcct", BankAcct)
            params(12) = db.MakeParameter("@NextOfKin", NextOfKin)
            params(13) = db.MakeParameter("@GPAddress", GPAddress)
            params(14) = db.MakeParameter("@EMail", EMail)
            params(15) = db.MakeParameter("@SiteID", SiteID)
            params(16) = db.MakeParameter("@StatusID", StatusID)
            params(17) = db.MakeParameter("@JobID", JobID)
            params(18) = db.MakeParameter("@Photograph", Photograph)
            params(19) = db.MakeParameter("@PhotoContentType", PhotoContentType)
            params(20) = db.MakeParameter("@PhotoContentSize", PhotoContentSize)
            params(21) = db.MakeParameter("@Contract", Contract)
            params(22) = db.MakeParameter("@ContractContentType", ContractContentType)
            params(23) = db.MakeParameter("@ContractContentSize", ContractContentSize)
            params(24) = db.MakeParameter("@Salary", Salary)
            params(25) = db.MakeParameter("@Notes", Notes)
            params(26) = db.MakeParameter("@HealthNotes", HealthNotes)
            params(27) = db.MakeParameter("@DateOfBirth", CType(DateOfBirth, System.DateTime))
            params(28) = db.MakeParameter("@ReviewBaseDate", CType(ReviewBaseDate, System.DateTime))

            If UserName.Length < 1 Then
                UserName = "unknown"
            End If
            params(29) = db.MakeParameter("@UserName", UserName)
            Try
                If IsDate(LeavingDate) Then
                    params(30) = db.MakeParameter("@LeavingDate", LeavingDate)
                Else
                    params(30) = db.MakeParameter("@LeavingDate", System.DBNull.Value)
                End If
            Catch
                params(30) = db.MakeParameter("@LeavingDate", System.DBNull.Value)
            End Try
            result = db.RunProcedure("up_Hris_UpdateEmployee", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub
    End Class
End Namespace
