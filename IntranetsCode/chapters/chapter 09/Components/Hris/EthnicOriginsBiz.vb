Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal
Imports Wrox.Intranet.DataTools

Namespace ASPNetPortal.Hris '<Group>>

    '*********************************************************************
    ' EthnicOriginBiz Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' EthnicOrigins within the database.
    '
    '*********************************************************************
    Public Class EthnicOriginsBiz

        '*********************************************************************
        ' GetEthnicOrigins Method
        '
        ' The GetEthnicOrigins method returns a DataSet containing all of the
        ' Entities for a specific portal module from the Hris
        ' database.
        '
        ' NOTE: A DataSet is returned from this method to allow this method to support
        ' both desktop and mobile Web UI.
        '
        '*********************************************************************

        Public Shared Function GetEthnicOrigins() As DataSet

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Dim db As New Database()

            db.RunProcedure("up_Hris_GetEthnicOrigins", myDataSet)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataSet Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataSet
        End Function

        '*********************************************************************
        ' GetSingleEthnicOrigin Method
        '
        ' The GetSingleEthnicOrigin method returns a SqlDataReader containing details
        ' about a specific EthnicOrigin from the tblHris_EthnicOrigins database table.
        '
        '*********************************************************************

        Public Shared Function GetSingleEthnicOrigin(ByVal itemId As Integer) As SqlDataReader

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemId)
            db.RunProcedure("up_Hris_GetSingleEthnicOrigin", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return myDataReader
        End Function

        '*********************************************************************
        ' DeleteEthnicOrigin Method
        '
        ' The DeleteEthnicOrigin method deletes the specified EthnicOrigin from
        ' the EthnicOrigins database table.
        '
        '*********************************************************************

        Public Shared Sub DeleteEthnicOrigin(ByVal itemID As Integer)

            Dim result As Integer
            Dim db As New Database()
            Dim params(0) As SqlParameter

            params(0) = db.MakeParameter("@ID", itemID)
            result = db.RunProcedure("up_Hris_DeleteEthnicOrigin", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

        '*********************************************************************
        ' AddEthnicOrigin Method
        '
        ' The AddEthnicOrigin method adds a new EthnicOrigin to the tblHris_EthnicOrigins
        ' database table, and returns the ItemId value as a result.
        '
        '*********************************************************************

        Public Shared Function AddEthnicOrigin(ByVal Description As String) As Integer

            ' Create and Fill the DataReader
            Dim myDataReader As SqlDataReader
            Dim db As New Database()
            Dim params(1) As SqlParameter
            Dim itemId As Integer

            params(0) = db.MakeParameter("@ID", ParameterDirection.Output, itemId)
            params(1) = db.MakeParameter("@Description", Description)
            db.RunProcedure("up_Hris_InsertEthnicOrigin", params, myDataReader)

            'Since the Database class traps all data exceptions we can pass the ErrorMessage back
            'to the user controls
            If myDataReader Is Nothing Then
                Throw New Exception(db.ErrorMessage)
            End If

            ' Return the DataSet
            Return CInt(params(0).Value)
        End Function

        '*********************************************************************
        ' UpdateEthnicOrigin Method
        '
        ' The UpdateEthnicOrigin method updates the specified EthnicOrigin within
        ' the tblHris_EthnicOrigins database table.
        '
        '*********************************************************************

        Public Shared Sub UpdateEthnicOrigin(ByVal ID As Integer, ByVal Description As String)

            Dim result As Integer
            Dim db As New Database()
            Dim params(1) As SqlParameter

            params(0) = db.MakeParameter("@ID", ID)
            params(1) = db.MakeParameter("@Description", Description)
            result = db.RunProcedure("up_Hris_UpdateEthnicOrigin", params)
            If result < 0 Then
                Throw New Exception(db.ErrorMessage)
            End If
        End Sub

    End Class

End Namespace






