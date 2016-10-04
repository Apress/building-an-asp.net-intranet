


Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal
Imports Wrox.Intranet.DataTools

Namespace ASPNetPortal.Hris '<Group>>

    '*********************************************************************
    ' JobTitleBiz Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' JobTitles within the database.
    '
    '*********************************************************************
    Public Class JobTitlesBiz

        '*********************************************************************
        ' GetJobTitles Method
        '
        ' The GetJobTitles method returns a DataSet containing all of the
        ' Entities for a specific portal module from the Hris
        ' database.
        '
        ' NOTE: A DataSet is returned from this method to allow this method to support
        ' both desktop and mobile Web UI.
        '
        '*********************************************************************

        Public Shared Function GetJobTitles() As DataSet

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Dim db As New Database()

            db.RunProcedure("up_Hris_GetJobTitles", myDataSet)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataSet Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataSet
        End Function

        '*********************************************************************
        ' GetSingleJobTitle Method
        '
        ' The GetSingleJobTitle method returns a SqlDataReader containing details
        ' about a specific JobTitle from the tblHris_JobTitles database table.
        '
        '*********************************************************************

        Public Shared Function GetSingleJobTitle(ByVal itemId As Integer) As SqlDataReader

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemId)
            db.RunProcedure("up_Hris_GetSingleJobTitle", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataReader
        End Function

        '*********************************************************************
        ' DeleteJobTitle Method
        '
        ' The DeleteJobTitle method deletes the specified JobTitle from
        ' the JobTitles database table.
        '
        '*********************************************************************

        Public Shared Sub DeleteJobTitle(ByVal itemID As Integer)

            Dim result As Integer
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemID)
            result = db.RunProcedure("up_Hris_DeleteJobTitle", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

        '*********************************************************************
        ' UpdateJobTitle Method
        '
        ' The UpdateJobTitle method updates the specified JobTitle within
        ' the tblHris_JobTitles database table.
        '
        '*********************************************************************

        Public Shared Sub UpdateJobTitle(ByVal ID As Integer, ByVal Title As String, ByVal Content() As Byte, ByVal ContentType As String, ByVal ContentSize As Integer, ByVal UserName As String)

            Dim result As Integer
            Dim db As New Database()
            Dim params(5) As SqlParameter

            params(0) = db.MakeParameter("@ID", ID)
            params(1) = db.MakeParameter("@Title", Title)
            params(2) = db.MakeParameter("@Content", Content)
            params(3) = db.MakeParameter("@ContentType", ContentType)
            params(4) = db.MakeParameter("@ContentSize", ContentSize)

            If UserName.Length < 1 Then
                UserName = "unknown"
            End If
            params(5) = db.MakeParameter("@UserName", UserName)
            result = db.RunProcedure("up_Hris_UpdateJobTitle", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

    End Class

End Namespace





