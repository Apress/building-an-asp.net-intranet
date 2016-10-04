
Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal
Imports Wrox.Intranet.DataTools

Namespace ASPNetPortal.Hris '<Group>>
    '*********************************************************************
    ' SiteBiz Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' Sites within the database.
    '
    '*********************************************************************
    Public Class SitesBiz

        '*********************************************************************
        ' GetSites Method
        '
        ' The GetSites method returns a DataSet containing all of the
        ' Entities for a specific portal module from the Hris
        ' database.
        '
        '*********************************************************************
        Public Shared Function GetSites() As DataSet

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Dim db As New Database()

            db.RunProcedure("up_Hris_GetSites", myDataSet)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataSet Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataSet
        End Function

        '*********************************************************************
        ' GetSingleSite Method
        '
        ' The GetSingleSite method returns a SqlDataReader containing details
        ' about a specific Site from the tblHris_Sites database table.
        '*********************************************************************
        Public Shared Function GetSingleSite(ByVal itemId As Integer) As SqlDataReader

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemId)
            db.RunProcedure("up_Hris_GetSingleSite", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataReader
        End Function

        '*********************************************************************
        ' DeleteSite Method
        '
        ' The DeleteSite method deletes the specified Site from
        ' the Sites database table.
        '*********************************************************************
        Public Shared Sub DeleteSite(ByVal itemID As Integer)
            Dim result As Integer
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemID)
            result = db.RunProcedure("up_Hris_DeleteSite", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

        '*********************************************************************
        ' AddSite Method
        '
        ' The AddSite method adds a new Site to the tblHris_Sites
        ' database table, and returns the ItemId value as a result.
        '*********************************************************************
        Public Shared Function AddSite(ByVal Code As String, ByVal Description As String, ByVal UserName As String) As Integer

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(3) As SqlParameter
            Dim itemId As Integer

            params(0) = db.MakeParameter("@ID", ParameterDirection.Output, itemId)
            params(1) = db.MakeParameter("@Code", Code)
            params(2) = db.MakeParameter("@Description", Description)

            If UserName.Length < 1 Then
                UserName = "unknown"
            End If
            params(3) = db.MakeParameter("@UserName", UserName)
            db.RunProcedure("up_Hris_InsertSite", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return CInt(params(0).Value)
        End Function

        '*********************************************************************
        ' UpdateSite Method
        '
        ' The UpdateSite method updates the specified Site within
        ' the tblHris_Sites database table.
        '*********************************************************************
        Public Shared Sub UpdateSite(ByVal ID As Integer, ByVal Code As String, ByVal Description As String, ByVal UserName As String)

            Dim result As Integer
            Dim db As New Database()
            Dim params(3) As SqlParameter

            params(0) = db.MakeParameter("@ID", ID)
            params(1) = db.MakeParameter("@Code", Code)
            params(2) = db.MakeParameter("@Description", Description)

            If UserName.Length < 1 Then
                UserName = "unknown"
            End If
            params(3) = db.MakeParameter("@UserName", UserName)
            result = db.RunProcedure("up_Hris_UpdateSite", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub
    End Class
End Namespace

