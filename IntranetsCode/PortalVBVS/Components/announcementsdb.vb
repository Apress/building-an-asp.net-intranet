Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient


Namespace ASPNetPortal

   '*********************************************************************
   '
   ' AnnounceDB Class
   '
   ' Class that encapsulates all data logic necessary to add/query/delete
   ' announcements within the Portal database.
   '
   '*********************************************************************

    Public Class AnnouncementsDB

        '*********************************************************************
        '
        ' GetAnnouncements Method
        '
        ' The GetAnnouncements method returns a DataSet containing all of the
        ' announcements for a specific portal module from the Announcements
        ' database table.
        '
        ' NOTE: A DataSet is returned from this method to allow this method to support
        ' both desktop and mobile Web UI.
        '
        ' Other relevant sources:
        '     + <a href="GetAnnouncements.htm" style="color:green">GetAnnouncements Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetAnnouncements(ByVal moduleId As Integer) As DataSet

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlDataAdapter("GetAnnouncements", myConnection)

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
        ' GetSingleAnnouncement Method
        '
        ' The GetSingleAnnouncement method returns a SqlDataReader containing details
        ' about a specific announcement from the Announcements database table.
        '
        ' Other relevant sources:
        '     + <a href="GetSingleAnnouncement.htm" style="color:green">GetSingleAnnouncement Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetSingleAnnouncement(ByVal itemId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetSingleAnnouncement", myConnection)

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
        ' DeleteAnnouncement Method
        '
        ' The DeleteAnnouncement method deletes the specified announcement from
        ' the Announcements database table.
        '
        ' Other relevant sources:
        '     + <a href="DeleteAnnouncement.htm" style="color:green">DeleteAnnouncement Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub DeleteAnnouncement(ByVal itemID As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("DeleteAnnouncement", myConnection)

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
        ' AddAnnouncement Method
        '
        ' The AddAnnouncement method adds a new announcement to the
        ' Announcements database table, and returns the ItemId value as a result.
        '
        ' Other relevant sources:
        '     + <a href="AddAnnouncement.htm" style="color:green">AddAnnouncement Stored Procedure</a>
        '
        '*********************************************************************

        Public Function AddAnnouncement(ByVal moduleId As Integer, ByVal itemId As Integer, ByVal userName As String, ByVal title As String, ByVal expireDate As DateTime, ByVal description As String, ByVal moreLink As String, ByVal mobileMoreLink As String) As Integer

            If userName.Length < 1 Then
                userName = "unknown"
            End If

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("AddAnnouncement", myConnection)

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

            Dim parameterTitle As New SqlParameter("@Title", SqlDbType.NVarChar, 150)
            parameterTitle.Value = title
            myCommand.Parameters.Add(parameterTitle)

            Dim parameterMoreLink As New SqlParameter("@MoreLink", SqlDbType.NVarChar, 150)
            parameterMoreLink.Value = moreLink
            myCommand.Parameters.Add(parameterMoreLink)

            Dim parameterMobileMoreLink As New SqlParameter("@MobileMoreLink", SqlDbType.NVarChar, 150)
            parameterMobileMoreLink.Value = mobileMoreLink
            myCommand.Parameters.Add(parameterMobileMoreLink)

            Dim parameterExpireDate As New SqlParameter("@ExpireDate", SqlDbType.DateTime, 8)
            parameterExpireDate.Value = expireDate
            myCommand.Parameters.Add(parameterExpireDate)

            Dim parameterDescription As New SqlParameter("@Description", SqlDbType.NVarChar, 2000)
            parameterDescription.Value = description
            myCommand.Parameters.Add(parameterDescription)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

            Return CInt(parameterItemID.Value)

        End Function


        '*********************************************************************
        '
        ' UpdateAnnouncement Method
        '
        ' The UpdateAnnouncement method updates the specified announcement within
        ' the Announcements database table.
        '
        ' Other relevant sources:
        '     + <a href="UpdateAnnouncement.htm" style="color:green">UpdateAnnouncement Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdateAnnouncement(ByVal moduleId As Integer, ByVal itemId As Integer, ByVal userName As String, ByVal title As String, ByVal expireDate As DateTime, ByVal description As String, ByVal moreLink As String, ByVal mobileMoreLink As String)

            If userName.Length < 1 Then
                userName = "unknown"
            End If
            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateAnnouncement", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterItemID As New SqlParameter("@ItemID", SqlDbType.Int, 4)
            parameterItemID.Value = itemId
            myCommand.Parameters.Add(parameterItemID)

            Dim parameterUserName As New SqlParameter("@UserName", SqlDbType.NVarChar, 100)
            parameterUserName.Value = userName
            myCommand.Parameters.Add(parameterUserName)

            Dim parameterTitle As New SqlParameter("@Title", SqlDbType.NVarChar, 150)
            parameterTitle.Value = title
            myCommand.Parameters.Add(parameterTitle)

            Dim parameterMoreLink As New SqlParameter("@MoreLink", SqlDbType.NVarChar, 150)
            parameterMoreLink.Value = moreLink
            myCommand.Parameters.Add(parameterMoreLink)

            Dim parameterMobileMoreLink As New SqlParameter("@MobileMoreLink", SqlDbType.NVarChar, 150)
            parameterMobileMoreLink.Value = mobileMoreLink
            myCommand.Parameters.Add(parameterMobileMoreLink)

            Dim parameterExpireDate As New SqlParameter("@ExpireDate", SqlDbType.DateTime, 8)
            parameterExpireDate.Value = expireDate
            myCommand.Parameters.Add(parameterExpireDate)

            Dim parameterDescription As New SqlParameter("@Description", SqlDbType.NVarChar, 2000)
            parameterDescription.Value = description
            myCommand.Parameters.Add(parameterDescription)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub

    End Class

End Namespace

