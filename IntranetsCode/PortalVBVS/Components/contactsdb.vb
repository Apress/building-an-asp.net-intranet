Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal


Namespace ASPNetPortal

    '*********************************************************************
    '
    ' ContactDB Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' contacts within the Portal database.
    '
    '*********************************************************************

    Public Class ContactsDB


        '*********************************************************************
        '
        ' GetContacts Method
        '
        ' The GetContacts method returns a DataSet containing all of the
        ' contacts for a specific portal module from the contacts
        ' database.
        '
        ' NOTE: A DataSet is returned from this method to allow this method to support
        ' both desktop and mobile Web UI.
        '
        ' Other relevant sources:
        '     + <a href="GetContacts.htm" style="color:green">GetContacts Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetContacts(ByVal moduleId As Integer) As DataSet

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlDataAdapter("GetContacts", myConnection)

            ' Mark the Command as a SPROC
            myCommand.SelectCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleId As New SqlParameter("@ModuleId", SqlDbType.Int, 4)
            parameterModuleId.Value = moduleId
            myCommand.SelectCommand.Parameters.Add(parameterModuleId)

            ' Create and Fill the DataSet
            Dim myDataSet As New DataSet()
            myCommand.Fill(myDataSet)

            ' Return the DataSet
            Return myDataSet

        End Function


        '*********************************************************************
        '
        ' GetSingleContact Method
        '
        ' The GetSingleContact method returns a SqlDataReader containing details
        ' about a specific contact from the Contacts database table.
        '
        ' Other relevant sources:
        '     + <a href="GetSingleContact.htm" style="color:green">GetSingleContact Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetSingleContact(ByVal itemId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetSingleContact", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterItemId As New SqlParameter("@ItemId", SqlDbType.Int, 4)
            parameterItemId.Value = itemId
            myCommand.Parameters.Add(parameterItemId)

            ' Execute the command
            myConnection.Open()
            Dim result As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader 
            Return result

        End Function


        '*********************************************************************
        '
        ' DeleteContact Method
        '
        ' The DeleteContact method deletes the specified contact from
        ' the Contacts database table.
        '
        ' Other relevant sources:
        '     + <a href="DeleteContact.htm" style="color:green">DeleteContact Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub DeleteContact(ByVal itemID As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("DeleteContact", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterItemID As New SqlParameter("@ItemID", SqlDbType.Int, 4)
            parameterItemID.Value = itemID
            myCommand.Parameters.Add(parameterItemID)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' AddContact Method
        '
        ' The AddContact method adds a new contact to the Contacts
        ' database table, and returns the ItemId value as a result.
        '
        ' Other relevant sources:
        '     + <a href="AddContact.htm" style="color:green">AddContact Stored Procedure</a>
        '
        '*********************************************************************

        Public Function AddContact(ByVal moduleId As Integer, ByVal itemId As Integer, ByVal userName As String, ByVal name As String, ByVal role As String, ByVal email As String, ByVal contact1 As String, ByVal contact2 As String) As Integer

            If userName.Length < 1 Then
                userName = "unknown"
            End If

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("AddContact", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterItemID As New SqlParameter("@ItemID", SqlDbType.Int, 4)
            parameterItemID.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterItemID)

            Dim parameterModuleID As New SqlParameter("@ModuleID", SqlDbType.Int, 4)
            parameterModuleID.Value = moduleId
            myCommand.Parameters.Add(parameterModuleID)

            Dim parameterUserName As New SqlParameter("@UserName", SqlDbType.NVarChar, 100)
            parameterUserName.Value = userName
            myCommand.Parameters.Add(parameterUserName)

            Dim parameterName As New SqlParameter("@Name", SqlDbType.NVarChar, 100)
            parameterName.Value = name
            myCommand.Parameters.Add(parameterName)

            Dim parameterRole As New SqlParameter("@Role", SqlDbType.NVarChar, 100)
            parameterRole.Value = role
            myCommand.Parameters.Add(parameterRole)

            Dim parameterEmail As New SqlParameter("@Email", SqlDbType.NVarChar, 100)
            parameterEmail.Value = email
            myCommand.Parameters.Add(parameterEmail)

            Dim parameterContact1 As New SqlParameter("@Contact1", SqlDbType.NVarChar, 100)
            parameterContact1.Value = contact1
            myCommand.Parameters.Add(parameterContact1)

            Dim parameterContact2 As New SqlParameter("@Contact2", SqlDbType.NVarChar, 100)
            parameterContact2.Value = contact2
            myCommand.Parameters.Add(parameterContact2)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

            Return CInt(parameterItemID.Value)

        End Function


        '*********************************************************************
        '
        ' UpdateContact Method
        '
        ' The UpdateContact method updates the specified contact within
        ' the Contacts database table.
        '
        ' Other relevant sources:
        '     + <a href="UpdateContact.htm" style="color:green">UpdateContact Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdateContact(ByVal moduleId As Integer, ByVal itemId As Integer, ByVal userName As String, ByVal name As String, ByVal role As String, ByVal email As String, ByVal contact1 As String, ByVal contact2 As String)

            If userName.Length < 1 Then
                userName = "unknown"
            End If

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateContact", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterItemID As New SqlParameter("@ItemID", SqlDbType.Int, 4)
            parameterItemID.Value = itemId
            myCommand.Parameters.Add(parameterItemID)

            Dim parameterUserName As New SqlParameter("@UserName", SqlDbType.NVarChar, 100)
            parameterUserName.Value = userName
            myCommand.Parameters.Add(parameterUserName)

            Dim parameterName As New SqlParameter("@Name", SqlDbType.NVarChar, 100)
            parameterName.Value = name
            myCommand.Parameters.Add(parameterName)

            Dim parameterRole As New SqlParameter("@Role", SqlDbType.NVarChar, 100)
            parameterRole.Value = role
            myCommand.Parameters.Add(parameterRole)

            Dim parameterEmail As New SqlParameter("@Email", SqlDbType.NVarChar, 100)
            parameterEmail.Value = email
            myCommand.Parameters.Add(parameterEmail)

            Dim parameterContact1 As New SqlParameter("@Contact1", SqlDbType.NVarChar, 100)
            parameterContact1.Value = contact1
            myCommand.Parameters.Add(parameterContact1)

            Dim parameterContact2 As New SqlParameter("@Contact2", SqlDbType.NVarChar, 100)
            parameterContact2.Value = contact2
            myCommand.Parameters.Add(parameterContact2)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub

    End Class

End Namespace
