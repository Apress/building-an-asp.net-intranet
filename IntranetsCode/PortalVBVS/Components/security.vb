Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Imports Wrox.Intranet.DataTools

Namespace ASPNetPortal

  '*********************************************************************
  '
  ' PortalSecurity Class
  '
  ' The PortalSecurity class encapsulates two helper methods that enable
  ' developers to easily check the role status of the current browser client.
  '
  '*********************************************************************

  Public Class PortalSecurity

    '*********************************************************************
    '
    ' PortalSecurity.IsInRole() Method
    '
    ' The IsInRole method enables developers to easily check the role
    ' status of the current browser client.
    '
    '*********************************************************************

    Public Shared Function IsInRole(ByVal role As String) As Boolean

      Return HttpContext.Current.User.IsInRole(role)

    End Function


    '*********************************************************************
    '
    ' PortalSecurity.IsInRoles() Method
    '
    ' The IsInRoles method enables developers to easily check the role
    ' status of the current browser client against an array of roles
    '
    '*********************************************************************

    Public Shared Function IsInRoles(ByVal roles As String) As Boolean

      Dim context As HttpContext = HttpContext.Current

      Dim role As String
      For Each role In roles.Split(New Char() {";"c})

        If role <> "" And Not role Is Nothing And (role = "All Users" Or context.User.IsInRole(role)) Then
          Return True
        End If

      Next role

      Return False

    End Function


    '*********************************************************************
    '
    ' PortalSecurity.HasEditPermissions() Method (Modified by Wrox)
    '
    ' The HasEditPermissions method enables developers to easily check 
    ' whether the current browser client has access to edit the settings
    ' of a specified portal module.
    '
    ' NOTE: We've modified this to be a wrapper to a call to the new 
    ' CheckPermissions sub-procedure.
    '
    '*********************************************************************

    Public Shared Function HasEditPermissions(ByVal moduleId As Integer) _
                                                As Boolean

      Call CheckPermissions(moduleId, HasEditPermissions, False)
    End Function

    ''*** Original HasEditPermissions Function ***
    'Public Shared Function HasEditPermissions(ByVal moduleId As Integer) _
    '                                            As Boolean

    '  ' Obtain PortalSettings from Current Context
    '  Dim _portalSettings As PortalSettings = CType( _
    '                    HttpContext.Current.Items("PortalSettings"), _
    '                    PortalSettings)

    '  ' Create Instance of Connection and Command Object
    '  Dim myConnection As New SqlConnection( _
    '              ConfigurationSettings.AppSettings("connectionString"))
    '  Dim myCommand As New SqlCommand("GetAuthRoles", myConnection)

    '  ' Mark the Command as a SPROC
    '  myCommand.CommandType = CommandType.StoredProcedure

    '  ' Add Parameters to SPROC
    '  Dim parameterModuleID As New _
    '                        SqlParameter("@ModuleID", SqlDbType.Int, 4)
    '  parameterModuleID.Value = moduleId
    '  myCommand.Parameters.Add(parameterModuleID)

    '  Dim parameterPortalID As New _
    '                        SqlParameter("@PortalID", SqlDbType.Int, 4)
    '  parameterPortalID.Value = _portalSettings.PortalId
    '  myCommand.Parameters.Add(parameterPortalID)

    '  ' Add out parameters to Sproc
    '  Dim parameterAccessRoles As New _
    '              SqlParameter("@AccessRoles", SqlDbType.NVarChar, 256)
    '  parameterAccessRoles.Direction = ParameterDirection.Output
    '  myCommand.Parameters.Add(parameterAccessRoles)

    '  Dim parameterEditRoles As New _
    '                SqlParameter("@EditRoles", SqlDbType.NVarChar, 256)
    '  parameterEditRoles.Direction = ParameterDirection.Output
    '  myCommand.Parameters.Add(parameterEditRoles)

    '  ' Open the database connection and execute the command
    '  myConnection.Open()
    '  myCommand.ExecuteNonQuery()
    '  myConnection.Close()

    '  If PortalSecurity.IsInRoles(CStr(parameterAccessRoles.Value)) _
    '        = False _
    '      Or PortalSecurity.IsInRoles(CStr(parameterEditRoles.Value)) _
    '        = False Then
    '    Return False
    '  Else
    '    Return True
    '  End If
    'End Function



    '*********************************************************************
    '
    ' PortalSecurity.CheckPermissions() Method (Added by Wrox)
    '
    ' The CheckPermissions method enables developers to easily check 
    ' both the viewing and editing permissions of the current user for
    ' a specified portal module
    '
    ' NOTE: This procedure was added to allow for efficiently checking
    ' both types of permissions with a single hit to the database. The
    ' HasEditPermissions function was re-written as a wrapper function
    ' that calls this procedure.
    '*********************************************************************

    Public Shared Sub CheckPermissions( _
                                ByVal moduleId As Integer, _
                                ByRef EditPermission As Boolean, _
                                ByRef ViewPermission As Boolean)

      ' Obtain PortalSettings from Current Context
      Dim _portalSettings As PortalSettings = CType( _
                        HttpContext.Current.Items("PortalSettings"), _
                        PortalSettings)

      ' Create the database class object
      Dim db As New Database()

      ' Create the parameter array for the stored procedure we want to call
      Dim params As SqlParameter() = { _
        db.MakeParameter("@ModuleID", moduleId), _
        db.MakeParameter("@PortalID", _portalSettings.PortalId), _
        db.MakeParameter("@AccessRoles", ParameterDirection.Output, Nothing), _
        db.MakeParameter("@EditRoles", ParameterDirection.Output, Nothing)}

      'Set the type & size of the output parameters
      With params(2)
        .SqlDbType = SqlDbType.NVarChar
        .Size = 256
      End With
      With params(3)
        .SqlDbType = SqlDbType.NVarChar
        .Size = 256
      End With

      ' Call the stored procedure
      db.RunProcedure("GetAuthRoles", params)

      ' Clean up any resources associated with the Database class
      db.Dispose()

      ' Check to see whether they have viewing permission
      ViewPermission = IsInRoles(CStr(params(2).Value))

      If ViewPermission Then
        ' They may also have edit permission, so let's check
        EditPermission = IsInRoles(CStr(params(3).Value))
      Else
        ' If they can't see it then by default they can't edit it,
        ' so we can skip the call to PortalSecurity.IsInRoles and
        ' set the value of EditPermission directly 
        EditPermission = False
      End If
    End Sub

    '*********************************************************************
    '
    ' PortalSecurity.HasViewPermissions() Method (Added by Wrox)
    '
    ' The HasViewPermissions method enables developers to easily check 
    ' whether the current browser client has access to edit the settings
    ' of a specified portal module.  This function is a wrapper to a
    ' call to the CheckPermissions sub-procedure.
    '
    '*********************************************************************

    Public Shared Function HasViewPermissions(ByVal moduleId As Integer) _
                                                As Boolean
      Call CheckPermissions(moduleId, False, HasViewPermissions)
    End Function

  End Class


  '*********************************************************************
  '
  ' UsersDB Class
  '
  ' The UsersDB class encapsulates all data logic necessary to add/login/query
  ' users within the Portal Users database.
  '
  ' Important Note: The UsersDB class is only used when forms-based cookie
  ' authentication is enabled within the portal.  When windows based
  ' authentication is used instead, then either the Windows SAM or Active Directory
  ' is used to store and validate all username/password credentials.
  '
  '*********************************************************************

  Public Class UsersDB

    '*********************************************************************
    '
    ' UsersDB.AddUser() Method <a name="AddUser"></a>
    '
    ' The AddUser method inserts a new user record into the "Users" database table.
    '
    ' Other relevant sources:
    '     + <a href="AddUser.htm" style="color:green">AddUser Stored Procedure</a>
    '
    '*********************************************************************

    Public Function AddUser(ByVal fullName As String, ByVal email As String, ByVal password As String) As Integer

      ' Create Instance of Connection and Command Object
      Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
      Dim myCommand As New SqlCommand("AddUser", myConnection)

      ' Mark the Command as a SPROC
      myCommand.CommandType = CommandType.StoredProcedure

      ' Add Parameters to SPROC
      Dim parameterFullName As New SqlParameter("@Name", SqlDbType.NVarChar, 50)
      parameterFullName.Value = fullName
      myCommand.Parameters.Add(parameterFullName)

      Dim parameterEmail As New SqlParameter("@Email", SqlDbType.NVarChar, 100)
      parameterEmail.Value = email
      myCommand.Parameters.Add(parameterEmail)

      Dim parameterPassword As New SqlParameter("@Password", SqlDbType.NVarChar, 20)
      parameterPassword.Value = password
      myCommand.Parameters.Add(parameterPassword)

      Dim parameterUserId As New SqlParameter("@UserID", SqlDbType.Int)
      parameterUserId.Direction = ParameterDirection.Output
      myCommand.Parameters.Add(parameterUserId)

      ' Execute the command in a try/catch to catch duplicate username errors
      Try

        ' Open the connection and execute the Command
        myConnection.Open()
        myCommand.ExecuteNonQuery()

      Catch

        ' failed to create a new user
        Return -1

      Finally

        ' Close the Connection
        If myConnection.State = ConnectionState.Open Then
          myConnection.Close()
        End If

      End Try

      Return CInt(parameterUserId.Value)

    End Function


    '*********************************************************************
    '
    ' UsersDB.DeleteUser() Method <a name="DeleteUser"></a>
    '
    ' The DeleteUser method deleted a  user record from the "Users" database table.
    '
    ' Other relevant sources:
    '     + <a href="DeleteUser.htm" style="color:green">DeleteUser Stored Procedure</a>
    '
    '*********************************************************************

    Public Sub DeleteUser(ByVal userId As Integer)

      ' Create Instance of Connection and Command Object
      Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
      Dim myCommand As New SqlCommand("DeleteUser", myConnection)

      ' Mark the Command as a SPROC
      myCommand.CommandType = CommandType.StoredProcedure

      Dim parameterUserId As New SqlParameter("@UserID", SqlDbType.Int)
      parameterUserId.Value = userId
      myCommand.Parameters.Add(parameterUserId)

      ' Open the database connection and execute the command
      myConnection.Open()
      myCommand.ExecuteNonQuery()
      myConnection.Close()

    End Sub


    '*********************************************************************
    '
    ' UsersDB.UpdateUser() Method <a name="DeleteUser"></a>
    '
    ' The UpdateUser method deleted a  user record from the "Users" database table.
    '
    ' Other relevant sources:
    '     + <a href="UpdateUser.htm" style="color:green">UpdateUser Stored Procedure</a>
    '
    '*********************************************************************

    Public Sub UpdateUser(ByVal userId As Integer, ByVal email As String, ByVal password As String)

      ' Create Instance of Connection and Command Object
      Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
      Dim myCommand As New SqlCommand("UpdateUser", myConnection)

      ' Mark the Command as a SPROC
      myCommand.CommandType = CommandType.StoredProcedure

      Dim parameterUserId As New SqlParameter("@UserID", SqlDbType.Int)
      parameterUserId.Value = userId
      myCommand.Parameters.Add(parameterUserId)

      Dim parameterEmail As New SqlParameter("@Email", SqlDbType.NVarChar, 100)
      parameterEmail.Value = email
      myCommand.Parameters.Add(parameterEmail)

      Dim parameterPassword As New SqlParameter("@Password", SqlDbType.NVarChar, 20)
      parameterPassword.Value = password
      myCommand.Parameters.Add(parameterPassword)

      ' Open the database connection and execute the command
      myConnection.Open()
      myCommand.ExecuteNonQuery()
      myConnection.Close()

    End Sub


    '*********************************************************************
    '
    ' UsersDB.GetRolesByUser() Method <a name="GetRolesByUser"></a>
    '
    ' The DeleteUser method deleted a  user record from the "Users" database table.
    '
    ' Other relevant sources:
    '     + <a href="GetRolesByUser.htm" style="color:green">GetRolesByUser Stored Procedure</a>
    '
    '*********************************************************************

    Public Function GetRolesByUser(ByVal email As String) As SqlDataReader

      ' Create Instance of Connection and Command Object
      Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
      Dim myCommand As New SqlCommand("GetRolesByUser", myConnection)

      ' Mark the Command as a SPROC
      myCommand.CommandType = CommandType.StoredProcedure

      Dim parameterEmail As New SqlParameter("@Email", SqlDbType.NVarChar, 100)
      parameterEmail.Value = email
      myCommand.Parameters.Add(parameterEmail)

      ' Open the database connection and execute the command
      myConnection.Open()
      Dim dr As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

      ' Return the datareader
      Return dr

    End Function


    '*********************************************************************
    '
    ' GetSingleUser Method
    '
    ' The GetSingleUser method returns a SqlDataReader containing details
    ' about a specific user from the Users database table.
    '
    '*********************************************************************

    Public Function GetSingleUser(ByVal email As String) As SqlDataReader

      ' Create Instance of Connection and Command Object
      Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
      Dim myCommand As New SqlCommand("GetSingleUser", myConnection)

      ' Mark the Command as a SPROC
      myCommand.CommandType = CommandType.StoredProcedure

      ' Add Parameters to SPROC
      Dim parameterEmail As New SqlParameter("@Email", SqlDbType.NVarChar, 100)
      parameterEmail.Value = email
      myCommand.Parameters.Add(parameterEmail)

      ' Open the database connection and execute the command
      myConnection.Open()
      Dim dr As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

      ' Return the datareader
      Return dr

    End Function

    '*********************************************************************
    '
    ' GetRoles() Method <a name="GetRoles"></a>
    '
    ' The GetRoles method returns a list of role names for the user.
    '
    ' Other relevant sources:
    '     + <a href="GetRolesByUser.htm" style="color:green">GetRolesByUser Stored Procedure</a>
    '
    '*********************************************************************

    Public Function GetRoles(ByVal email As String) As String()

      ' Create Instance of Connection and Command Object
      Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
      Dim myCommand As New SqlCommand("GetRolesByUser", myConnection)

      ' Mark the Command as a SPROC
      myCommand.CommandType = CommandType.StoredProcedure

      ' Add Parameters to SPROC
      Dim parameterEmail As New SqlParameter("@Email", SqlDbType.NVarChar, 100)
      parameterEmail.Value = email
      myCommand.Parameters.Add(parameterEmail)

      ' Open the database connection and execute the command
      Dim dr As SqlDataReader

      myConnection.Open()
      dr = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

      ' create a String array from the data
      Dim userRoles As New ArrayList()

      While dr.Read()
        userRoles.Add(dr("RoleName"))
      End While

      dr.Close()

      ' Return the String array of roles
      Return CType(userRoles.ToArray(GetType(String)), String())

    End Function

    '*********************************************************************
    '
    ' UsersDB.Login() Method <a name="Login"></a>
    '
    ' The Login method validates a email/password pair against credentials
    ' stored in the users database.  If the email/password pair is valid,
    ' the method returns user's name.
    '
    ' Other relevant sources:
    '     + <a href="UserLogin.htm" style="color:green">UserLogin Stored Procedure</a>
    '
    '*********************************************************************

    Public Function Login(ByVal email As String, ByVal password As String) As String

      ' Create Instance of Connection and Command Object
      Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
      Dim myCommand As New SqlCommand("UserLogin", myConnection)

      ' Mark the Command as a SPROC
      myCommand.CommandType = CommandType.StoredProcedure

      ' Add Parameters to SPROC
      Dim parameterEmail As New SqlParameter("@Email", SqlDbType.NVarChar, 100)
      parameterEmail.Value = email
      myCommand.Parameters.Add(parameterEmail)

      Dim parameterPassword As New SqlParameter("@Password", SqlDbType.NVarChar, 20)
      parameterPassword.Value = password
      myCommand.Parameters.Add(parameterPassword)

      Dim parameterUserName As New SqlParameter("@UserName", SqlDbType.NVarChar, 100)
      parameterUserName.Direction = ParameterDirection.Output
      myCommand.Parameters.Add(parameterUserName)

      ' Open the database connection and execute the command
      myConnection.Open()
      myCommand.ExecuteNonQuery()
      myConnection.Close()

      If Not parameterUserName.Value Is Nothing And Not parameterUserName.Value Is System.DBNull.Value Then
        Return CStr(parameterUserName.Value).Trim()
      Else
        Return String.Empty
      End If

    End Function

  End Class

End Namespace