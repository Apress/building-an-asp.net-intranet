Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal
Imports Wrox.Intranet.DataTools

Namespace ASPNetPortal.Hris '<Group>>
    '*********************************************************************
    ' EmployeeSkillLevelBiz Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' EmployeeSkillLevels within the database.
    '
    '*********************************************************************
    Public Class EmployeeSkillLevelBiz

        '*********************************************************************
        ' GetEmployeeSkillLevels Method
        '
        ' The GetEmployeeSkillLevels method returns a DataSet containing all of the
        ' Entities for a specific portal module from the Hris
        ' database.
        '
        '*********************************************************************
        Public Shared Function GetEmployeeSkillLevels() As DataSet

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Dim db As New Database()

            db.RunProcedure("up_Hris_GetEmployeeSkillLevels", myDataSet)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataSet Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataSet
        End Function

        '*********************************************************************
        ' GetSingleEmployeeSkillLevel Method
        '
        ' The GetSingleEmployeeSkillLevel method returns a SqlDataReader containing details
        ' about a specific EmployeeSkillLevel from the tblHris_EmployeeSkillLevels database table.
        '*********************************************************************
        Public Shared Function GetSingleEmployeeSkillLevel(ByVal itemId As Integer) As SqlDataReader

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemId)
            db.RunProcedure("up_Hris_GetSingleEmployeeSkillLevel", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataReader
        End Function

        '*********************************************************************
        ' DeleteEmployeeSkillLevel Method
        '
        ' The DeleteEmployeeSkillLevel method deletes the specified EmployeeSkillLevel from
        ' the EmployeeSkillLevels database table.
        '*********************************************************************
        Public Shared Sub DeleteEmployeeSkillLevel(ByVal itemID As Integer)

            Dim result As Integer
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemID)
            result = db.RunProcedure("up_Hris_DeleteEmployeeSkillLevel", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

        '*********************************************************************
        ' AddEmployeeSkillLevel Method
        '
        ' The AddEmployeeSkillLevel method adds a new EmployeeSkillLevel to the tblHris_EmployeeSkillLevels
        ' database table, and returns the ItemId value as a result.
        '*********************************************************************
        Public Shared Function AddEmployeeSkillLevel(ByVal SkillID As Integer, ByVal SkillLevel As Integer) As Integer

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(2) As SqlParameter
            Dim itemId As Integer

            params(0) = db.MakeParameter("@ID", ParameterDirection.Output, itemId)
            params(1) = db.MakeParameter("@SkillID", SkillID)
            params(2) = db.MakeParameter("@SkillLevel", SkillLevel)
            db.RunProcedure("up_Hris_InsertEmployeeSkillLevel", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return CInt(params(0).Value)
        End Function

        '*********************************************************************
        ' UpdateEmployeeSkillLevel Method
        '
        ' The UpdateEmployeeSkillLevel method updates the specified EmployeeSkillLevel within
        ' the tblHris_EmployeeSkillLevels database table.
        '*********************************************************************
        Public Shared Sub UpdateEmployeeSkillLevel(ByVal ID As Integer, ByVal SkillID As Integer, ByVal SkillLevel As Integer)

            Dim result As Integer
            Dim db As New Database()
            Dim params(2) As SqlParameter

            params(0) = db.MakeParameter("@ID", ID)
            params(1) = db.MakeParameter("@SkillID", SkillID)
            params(2) = db.MakeParameter("@SkillLevel", SkillLevel)
            result = db.RunProcedure("up_Hris_UpdateEmployeeSkillLevel", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub
    End Class
End Namespace

