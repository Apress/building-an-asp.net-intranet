Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal


Namespace ASPNetPortal
   
   '*********************************************************************
   '
   ' LinkDB Class
   '
   ' Class that encapsulates all data logic necessary to add/query/delete
   ' links within the Portal database.
   '
   '*********************************************************************

    Public Class LinkDB

        '*********************************************************************
        '
        ' GetLinks Method
        '
        ' The GetLinks method returns a SqlDataReader containing all of the
        ' links for a specific portal module from the announcements
        ' database.
        '
        ' Other relevant sources:
        '     + <a href="GetLinks.htm" style="color:green">GetLinks Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetLinks(ByVal moduleId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetLinks", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleId As New SqlParameter("@ModuleId", SqlDbType.Int, 4)
            parameterModuleId.Value = moduleId
            myCommand.Parameters.Add(parameterModuleId)

            ' Execute the command
            myConnection.Open()
            Dim result As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader 
            Return result

        End Function


        '*********************************************************************
        '
        ' GetSingleLink Method
        '
        ' The GetSingleLink method returns a SqlDataReader containing details
        ' about a specific link from the Links database table.
        '
        ' Other relevant sources:
        '     + <a href="GetSingleLink.htm" style="color:green">GetSingleLink Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetSingleLink(ByVal itemId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetSingleLink", myConnection)

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
        ' DeleteLink Method
        '
        ' The DeleteLink method deletes a specified link from
        ' the Links database table.
        '
        ' Other relevant sources:
        '     + <a href="DeleteLink.htm" style="color:green">DeleteLink Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub DeleteLink(ByVal itemID As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("DeleteLink", myConnection)

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
        ' AddLink Method
        '
        ' The AddLink method adds a new link within the
        ' links database table, and returns ItemID value as a result.
        '
        ' Other relevant sources:
        '     + <a href="AddLink.htm" style="color:green">AddLink Stored Procedure</a>
        '
        '*********************************************************************

        Public Function AddLink(ByVal moduleId As Integer, ByVal itemId As Integer, ByVal userName As String, ByVal title As String, ByVal url As String, ByVal mobileUrl As String, ByVal viewOrder As Integer, ByVal description As String) As Integer

            If userName.Length < 1 Then
                userName = "unknown"
            End If

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("AddLink", myConnection)

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

            Dim parameterTitle As New SqlParameter("@Title", SqlDbType.NVarChar, 100)
            parameterTitle.Value = title
            myCommand.Parameters.Add(parameterTitle)

            Dim parameterDescription As New SqlParameter("@Description", SqlDbType.NVarChar, 100)
            parameterDescription.Value = description
            myCommand.Parameters.Add(parameterDescription)

            Dim parameterUrl As New SqlParameter("@Url", SqlDbType.NVarChar, 100)
            parameterUrl.Value = url
            myCommand.Parameters.Add(parameterUrl)

            Dim parameterMobileUrl As New SqlParameter("@MobileUrl", SqlDbType.NVarChar, 100)
            parameterMobileUrl.Value = mobileUrl
            myCommand.Parameters.Add(parameterMobileUrl)

            Dim parameterViewOrder As New SqlParameter("@ViewOrder", SqlDbType.Int, 4)
            parameterViewOrder.Value = viewOrder
            myCommand.Parameters.Add(parameterViewOrder)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

            Return CInt(parameterItemID.Value)

        End Function


        '*********************************************************************
        '
        ' UpdateLink Method
        '
        ' The UpdateLink method updates a specified link within
        ' the Links database table.
        '
        ' Other relevant sources:
        '     + <a href="UpdateLink.htm" style="color:green">UpdateLink Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdateLink(ByVal moduleId As Integer, ByVal itemId As Integer, ByVal userName As String, ByVal title As String, ByVal url As String, ByVal mobileUrl As String, ByVal viewOrder As Integer, ByVal description As String)

            If userName.Length < 1 Then
                userName = "unknown"
            End If

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateLink", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterItemID As New SqlParameter("@ItemID", SqlDbType.Int, 4)
            parameterItemID.Value = itemId
            myCommand.Parameters.Add(parameterItemID)

            Dim parameterUserName As New SqlParameter("@UserName", SqlDbType.NVarChar, 100)
            parameterUserName.Value = userName
            myCommand.Parameters.Add(parameterUserName)

            Dim parameterTitle As New SqlParameter("@Title", SqlDbType.NVarChar, 100)
            parameterTitle.Value = title
            myCommand.Parameters.Add(parameterTitle)

            Dim parameterDescription As New SqlParameter("@Description", SqlDbType.NVarChar, 100)
            parameterDescription.Value = description
            myCommand.Parameters.Add(parameterDescription)

            Dim parameterUrl As New SqlParameter("@Url", SqlDbType.NVarChar, 100)
            parameterUrl.Value = url
            myCommand.Parameters.Add(parameterUrl)

            Dim parameterMobileUrl As New SqlParameter("@MobileUrl", SqlDbType.NVarChar, 100)
            parameterMobileUrl.Value = mobileUrl
            myCommand.Parameters.Add(parameterMobileUrl)

            Dim parameterViewOrder As New SqlParameter("@ViewOrder", SqlDbType.Int, 4)
            parameterViewOrder.Value = viewOrder
            myCommand.Parameters.Add(parameterViewOrder)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub

    End Class

End Namespace
