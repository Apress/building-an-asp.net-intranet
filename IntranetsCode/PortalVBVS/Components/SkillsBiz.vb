Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal
Imports Wrox.Intranet.DataTools

Namespace ASPNetPortal.Hris '<Group>>

    '*********************************************************************
    ' SkillBiz Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' Skills within the database.
    '
    '*********************************************************************
    Public Class SkillsBiz

        '*********************************************************************
        ' GetSkills Method
        '
        ' The GetSkills method returns a DataSet containing all of the
        ' Entities for a specific portal module from the Hris
        ' database.
        '
        ' NOTE: A DataSet is returned from this method to allow this method to support
        ' both desktop and mobile Web UI.
        '
        '*********************************************************************

        Public Shared Function GetSkills() As DataSet

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Dim db As New Database()

            db.RunProcedure("up_Hris_GetSkills", myDataSet)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataSet Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataSet

        End Function

        '*********************************************************************
        ' GetSingleSkill Method
        '
        ' The GetSingleSkill method returns a SqlDataReader containing details
        ' about a specific Skill from the tblHris_Skills database table.
        '
        '*********************************************************************

        Public Shared Function GetSingleSkill(ByVal itemId As Integer) As SqlDataReader

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemId)
            db.RunProcedure("up_Hris_GetSingleSkill", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataReader
        End Function

        '*********************************************************************
        ' DeleteSkill Method
        '
        ' The DeleteSkill method deletes the specified Skill from
        ' the Skills database table.
        '
        '*********************************************************************

        Public Shared Sub DeleteSkill(ByVal itemID As Integer)
            Dim result As Integer
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemID)
            result = db.RunProcedure("up_Hris_DeleteSkill", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

        '*********************************************************************
        ' AddSkill Method
        '
        ' The AddSkill method adds a new Skill to the tblHris_Skills
        ' database table, and returns the ItemId value as a result.
        '
        '*********************************************************************

        Public Shared Function AddSkill(ByVal Description As String) As Integer

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(1) As SqlParameter
            Dim itemId As Integer

            params(0) = db.MakeParameter("@ID", ParameterDirection.Output, itemId)
            params(1) = db.MakeParameter("@Description", Description)
            db.RunProcedure("up_Hris_InsertSkill", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return CInt(params(0).Value)

        End Function

        '*********************************************************************
        ' UpdateSkill Method
        '
        ' The UpdateSkill method updates the specified Skill within
        ' the tblHris_Skills database table.
        '
        '*********************************************************************

        Public Shared Sub UpdateSkill(ByVal ID As Integer, ByVal Description As String)

            Dim result As Integer
            Dim db As New Database()
            Dim params(1) As SqlParameter

            params(0) = db.MakeParameter("@ID", ID)
            params(1) = db.MakeParameter("@Description", Description)
            result = db.RunProcedure("up_Hris_UpdateSkill", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

    End Class

End Namespace



