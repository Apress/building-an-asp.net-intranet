Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal
Imports Wrox.Intranet.DataTools

Namespace ASPNetPortal

    '*********************************************************************
    '
    ' EventDB Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' events within the Portal database.
    '
    '*********************************************************************

    Public Class EventsDB

        '*********************************************************************
        '
        ' GetMonthlyEvents Method
        '
        ' The GetMonthlyEvents method returns a DataSet containing all of the
        ' events for a specific portal module and the speficied month from the events
        ' table.
        '
        '
        '
        '*********************************************************************

        Public Function GetMonthlyEvents(ByVal moduleId As Integer, _
                                ByVal showDate As DateTime) _
                                As DataSet

            ' Create Instance of Database object
            Dim dataCon As New Database()
            ' Create an Array of SqlParameters
            Dim params(2) As SqlParameter

            ' Load the Parameters
            params(0) = dataCon.MakeParameter("@ModuleID", SqlDbType.Int, 4, moduleId)

            params(1) = dataCon.MakeParameter("@ShowDate", SqlDbType.DateTime, 8, showDate)

            params(2) = dataCon.MakeParameter("@CurrentDate", SqlDbType.DateTime, 8, DateTime.Today)

            Dim myDataSet As New DataSet()

            Try
                ' Fill the DataSet
                dataCon.RunProcedure("up_Events_GetMonthlyEvents", params, myDataSet)
            Finally
                dataCon.Close()
                dataCon.Dispose()
            End Try

            ' Check if the Module Admin's Role
            If Not PortalSecurity.HasEditPermissions(moduleId) Then
                ' Code to filter out the events based on the user roles
                Dim dr As DataRow
                Dim roleStr As String
                ' Loop through the DataSet
                For Each dr In myDataSet.Tables(0).Rows
                    roleStr = CType(dr("AuthorizedViewRoles"), String)
                    ' Check if the user role is present in the event's 
                    ' AuthorizedViewRoles value
                    If (Not PortalSecurity.IsInRoles(roleStr)) Then
                        ' If the user is not allowed to view the event 
                        ' delete it from the DataSet
                        dr.Delete()
                    End If
                Next
                'Make the changes to the DataSet permanent
                myDataSet.AcceptChanges()
            End If

            ' Return the DataSet
            Return myDataSet

        End Function



        '*********************************************************************
        '
        ' GetEvents Method
        '
        ' The GetEvents method returns a DataSet containing all of the
        ' events for a specific portal module from the events
        ' table.
        '
        '
        '*********************************************************************

        Public Function GetAllEvents(ByVal moduleId As Integer) As DataSet

            ' Create a new Database object
            Dim dataCon As New Database()

            Dim params(1) As SqlParameter

            params(0) = dataCon.MakeParameter("@ModuleID", SqlDbType.Int, 4, moduleId)

            params(1) = dataCon.MakeParameter("@CurrentDate", SqlDbType.DateTime, 8, DateTime.Today)



            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            Try
                dataCon.RunProcedure("up_Events_GetAllEvents", params, myDataSet)
            Finally
                dataCon.Close()
                dataCon.Dispose()
            End Try

            ' Check if the Module Admin's Role
            If Not PortalSecurity.HasEditPermissions(moduleId) Then
                ' Code to filter out the events based on the user roles
                Dim dr As DataRow
                Dim roleStr As String
                ' Loop through the DataSet
                For Each dr In myDataSet.Tables(0).Rows
                    roleStr = CType(dr("AuthorizedViewRoles"), String)
                    ' Check if the user role is present in the event's AuthorizedViewRoles value
                    If (Not PortalSecurity.IsInRoles(roleStr)) Then
                        ' If the user is not allowed to view the event delete it from the DataSet
                        dr.Delete()
                    End If
                Next
                'Make the changes to the DataSet permanent
                myDataSet.AcceptChanges()
            End If
            ' Return the DataSet
            Return myDataSet

        End Function


        '*********************************************************************
        '
        ' GetSingleEvent Method
        '
        ' The GetSingleEvent method returns a SqlDataReader containing details
        ' about a specific event from the events table.
        '
        '
        '*********************************************************************

        Public Function GetSingleEvent(ByVal moduleId As Integer, _
                                    ByVal itemId As Integer) _
                                    As SqlDataReader

            ' Create Instance of Database Object
            Dim dataCon As New Database()

            Dim params(1) As SqlParameter

            params(0) = dataCon.MakeParameter("@ItemID", SqlDbType.Int, 4, itemId)

            params(1) = dataCon.MakeParameter("@ModuleID", SqlDbType.Int, 4, moduleId)

            Dim result As SqlDataReader
            dataCon.RunProcedure("up_Events_GetSingleEvent", params, result)

            ' Return the datareader 
            Return result

        End Function


        '*********************************************************************
        '
        ' DeleteEvent Method
        '
        ' The DeleteEvent method deletes a specified event from
        ' the events table.
        '
        '
        '*********************************************************************

        Public Sub DeleteEvent(ByVal itemID As Integer)

            ' Create Instance of Database object
            Dim dataCon As New Database()

            Dim params(0) As SqlParameter

            params(0) = dataCon.MakeParameter("@ItemID", SqlDbType.Int, 4, itemID)

            Try
                dataCon.RunProcedure("up_Events_DeleteEvent", params)
            Finally
                dataCon.Close()
                dataCon.Dispose()
            End Try
        End Sub


        '*********************************************************************
        '
        ' AddEvent Method
        '
        ' The AddEvent method adds a new event within the Events database table.
        '
        '*********************************************************************

        Public Function AddEvent(ByVal moduleId As Integer, ByVal itemId As Integer, ByVal userName As String, ByVal title As String, ByVal eventDate As DateTime, ByVal description As String, ByVal wherewhen As String, ByVal viewRoles As String)

            ' Check if the user exists
            If userName.Length < 1 Then
                userName = "unknown"
            End If

            ' Creatre Instance of Database object
            Dim dataCon As New Database()

            Dim params(6) As SqlParameter

            params(0) = dataCon.MakeParameter("@ModuleID", SqlDbType.Int, 4, moduleId)

            params(1) = dataCon.MakeParameter("@UserName", SqlDbType.NVarChar, 100, userName)

            params(2) = dataCon.MakeParameter("@Title", SqlDbType.NVarChar, 100, title)

            params(3) = dataCon.MakeParameter("@WhereWhen", SqlDbType.NVarChar, 100, wherewhen)

            params(4) = dataCon.MakeParameter("@ViewRoles", SqlDbType.NVarChar, 256, viewRoles)

            params(5) = dataCon.MakeParameter("@EventDate", SqlDbType.DateTime, 8, eventDate)

            params(6) = dataCon.MakeParameter("@Description", SqlDbType.NVarChar, 2000, description)

            Try
                dataCon.RunProcedure("up_Events_AddEvent", params)
            Finally
                dataCon.Close()
                dataCon.Dispose()
            End Try

        End Function


        '*********************************************************************
        '
        ' UpdateEvent Method
        '
        ' The UpdateEvent method updates the specified event within
        ' the Events database table.
        '
        ' 
        '*********************************************************************

        Public Sub UpdateEvent(ByVal moduleId As Integer, _
                                ByVal itemId As Integer, _
                                ByVal userName As String, _
                                ByVal title As String, _
                                ByVal eventDate As DateTime, _
                                ByVal description As String, _
                                ByVal wherewhen As String, _
                                ByVal viewRoles As String)

            If userName.Length < 1 Then
                userName = "unknown"
            End If

            ' Create Instance of Database Object
            Dim dataCon As New Database()

            Dim params(6) As SqlParameter

            params(0) = dataCon.MakeParameter("@ItemID", SqlDbType.Int, 4, itemId)

            params(1) = dataCon.MakeParameter("@UserName", SqlDbType.NVarChar, 100, userName)

            params(2) = dataCon.MakeParameter("@Title", SqlDbType.NVarChar, 100, title)

            params(3) = dataCon.MakeParameter("@WhereWhen", SqlDbType.NVarChar, 100, wherewhen)

            params(4) = dataCon.MakeParameter("@ViewRoles", SqlDbType.NVarChar, 256, viewRoles)

            params(5) = dataCon.MakeParameter("@EventDate", SqlDbType.DateTime, 8, eventDate)

            params(6) = dataCon.MakeParameter("@Description", SqlDbType.NVarChar, 2000, description)

            Try
                dataCon.RunProcedure("up_Events_UpdateEvent", params)
            Finally
                dataCon.Close()
                dataCon.Dispose()
            End Try

        End Sub

    End Class

End Namespace