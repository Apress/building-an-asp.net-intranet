


Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal
Imports Wrox.Intranet.DataTools

Namespace ASPNetPortal.Hris '<Group>>

    '*********************************************************************
    ' JobStatusBiz Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' JobStatuses within the database.
    '
    '*********************************************************************
    Public Class JobStatusesBiz

        '*********************************************************************
        ' GetJobStatuses Method
        '
        ' The GetJobStatuses method returns a DataSet containing all of the
        ' Entities for a specific portal module from the Hris
        ' database.
        '
        ' NOTE: A DataSet is returned from this method to allow this method to support
        ' both desktop and mobile Web UI.
        '
        '*********************************************************************

        Public Shared Function GetJobStatuses() As DataSet

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Dim db As New Database()

            db.RunProcedure("up_Hris_GetJobStatuses", myDataSet)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataSet Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataSet
        End Function

        '*********************************************************************
        ' GetSingleJobStatus Method
        '
        ' The GetSingleJobStatus method returns a SqlDataReader containing details
        ' about a specific JobStatus from the tblHris_JobStatuses database table.
        '
        '*********************************************************************

        Public Shared Function GetSingleJobStatus(ByVal itemId As Integer) As SqlDataReader

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemId)
            db.RunProcedure("up_Hris_GetSingleJobStatus", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataReader
        End Function

        '*********************************************************************
        ' DeleteJobStatus Method
        '
        ' The DeleteJobStatus method deletes the specified JobStatus from
        ' the JobStatuses database table.
        '
        '*********************************************************************

        Public Shared Sub DeleteJobStatus(ByVal itemID As Integer)

            Dim result As Integer
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemID)
            result = db.RunProcedure("up_Hris_DeleteJobStatus", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

        '*********************************************************************
        ' AddJobStatus Method
        '
        ' The AddJobStatus method adds a new JobStatus to the tblHris_JobStatuses
        ' database table, and returns the ItemId value as a result.
        '
        '*********************************************************************

        Public Shared Function AddJobStatus(ByVal Description As String) As Integer

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(1) As SqlParameter
            Dim itemId As Integer

            params(0) = db.MakeParameter("@ID", ParameterDirection.Output, itemId)
            params(1) = db.MakeParameter("@Description", Description)
            db.RunProcedure("up_Hris_InsertJobStatus", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return CInt(params(0).Value)
        End Function

        '*********************************************************************
        ' UpdateJobStatus Method
        '
        ' The UpdateJobStatus method updates the specified JobStatus within
        ' the tblHris_JobStatuses database table.
        '
        '*********************************************************************

        Public Shared Sub UpdateJobStatus(ByVal ID As Integer, ByVal Description As String)

            Dim result As Integer
            Dim db As New Database()
            Dim params(1) As SqlParameter

            params(0) = db.MakeParameter("@ID", ID)
            params(1) = db.MakeParameter("@Description", Description)
            result = db.RunProcedure("up_Hris_UpdateJobStatus", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

    End Class

End Namespace






