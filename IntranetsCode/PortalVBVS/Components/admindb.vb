Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal


Namespace ASPNetPortal

   
   '*********************************************************************
   '
   ' ModuleItem Class
   '
   ' This class encapsulates the basic attributes of a Module, and is used
   ' by the administration pages when manipulating modules.  ModuleItem implements 
   ' the IComparable interface so that an ArrayList of ModuleItems may be sorted
   ' by ModuleOrder, using the ArrayList's Sort() method.
   '
   '*********************************************************************

    Public Class ModuleItem
        Implements IComparable


        Private _moduleOrder As Integer
        Private _title As String
        Private _pane As String
        Private _id As Integer
        Private _defId As Integer


        Public Property ModuleOrder() As Integer

            Get
                Return _moduleOrder
            End Get
            Set(ByVal Value As Integer)
                _moduleOrder = Value
            End Set

        End Property


        Public Property ModuleTitle() As String

            Get
                Return _title
            End Get
            Set(ByVal Value As String)
                _title = Value
            End Set

        End Property


        Public Property PaneName() As String

            Get
                Return _pane
            End Get
            Set(ByVal Value As String)
                _pane = Value
            End Set

        End Property


        Public Property ModuleId() As Integer

            Get
                Return _id
            End Get
            Set(ByVal Value As Integer)
                _id = Value
            End Set

        End Property


        Public Property ModuleDefId() As Integer

            Get
                Return _defId
            End Get
            Set(ByVal Value As Integer)
                _defId = Value
            End Set

        End Property


        Protected Overridable Function CompareTo(ByVal value As Object) As Integer Implements IComparable.CompareTo

            If value Is Nothing Then
                Return 1
            End If

            Dim compareOrder As Integer = CType(value, ModuleItem).ModuleOrder

            If Me.ModuleOrder = compareOrder Then Return 0
            If Me.ModuleOrder < compareOrder Then Return -1
            If Me.ModuleOrder > compareOrder Then Return 1
            Return 0

        End Function

    End Class


    '*********************************************************************
    '
    ' TabItem Class
    '
    ' This class encapsulates the basic attributes of a Tab, and is used
    ' by the administration pages when manipulating tabs.  TabItem implements 
    ' the IComparable interface so that an ArrayList of TabItems may be sorted
    ' by TabOrder, using the ArrayList's Sort() method.
    '
    '*********************************************************************

    Public Class TabItem
        Implements IComparable

        Private _tabOrder As Integer
        Private _name As String
        Private _id As Integer


        Public Property TabOrder() As Integer

            Get
                Return _tabOrder
            End Get
            Set(ByVal Value As Integer)
                _tabOrder = Value
            End Set
        End Property


        Public Property TabName() As String

            Get
                Return _name
            End Get
            Set(ByVal Value As String)
                _name = Value
            End Set
        End Property


        Public Property TabId() As Integer

            Get
                Return _id
            End Get
            Set(ByVal Value As Integer)
                _id = Value
            End Set
        End Property

        Public Overridable Function CompareTo(ByVal value As Object) As Integer Implements IComparable.CompareTo

            If value Is Nothing Then
                Return 1
            End If

            Dim compareOrder As Integer = CType(value, TabItem).TabOrder

            If Me.TabOrder = compareOrder Then Return 0
            If Me.TabOrder < compareOrder Then Return -1
            If Me.TabOrder > compareOrder Then Return 1
            Return 0

        End Function

    End Class


    '*********************************************************************
    '
    ' AdminDB Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' configuration, layout and security settings values within the Portal database.
    '
    '*********************************************************************

    Public Class AdminDB

        '
        ' ROLES
        '
        '*********************************************************************
        '
        ' GetPortalRoles() Method <a name="GetPortalRoles"></a>
        '
        ' The GetPortalRoles method returns a list of all role names for the 
        ' specified portal.
        '
        ' Other relevant sources:
        '     + <a href="GetRolesByUser.htm" style="color:green">GetPortalRoles Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetPortalRoles(ByVal portalId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetPortalRoles", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterPortalID As New SqlParameter("@PortalID", SqlDbType.Int, 4)
            parameterPortalID.Value = portalId
            myCommand.Parameters.Add(parameterPortalID)

            ' Open the database connection and execute the command
            myConnection.Open()
            Dim dr As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader
            Return dr

        End Function


        '*********************************************************************
        '
        ' AddRole() Method <a name="AddRole"></a>
        '
        ' The AddRole method creates a new security role for the specified portal,
        ' and returns the new RoleID value.
        '
        ' Other relevant sources:
        '     + <a href="AddRole.htm" style="color:green">AddRole Stored Procedure</a>
        '
        '*********************************************************************

        Public Function AddRole(ByVal portalId As Integer, ByVal roleName As String) As Integer

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("AddRole", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterPortalID As New SqlParameter("@PortalID", SqlDbType.Int, 4)
            parameterPortalID.Value = portalId
            myCommand.Parameters.Add(parameterPortalID)

            Dim parameterRoleName As New SqlParameter("@RoleName", SqlDbType.NVarChar, 50)
            parameterRoleName.Value = roleName
            myCommand.Parameters.Add(parameterRoleName)

            Dim parameterRoleID As New SqlParameter("@RoleID", SqlDbType.Int, 4)
            parameterRoleID.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterRoleID)

            ' Open the database connection and execute the command
            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

            ' return the role id 
            Return CInt(parameterRoleID.Value)

        End Function


        '*********************************************************************
        '
        ' DeleteRole() Method <a name="DeleteRole"></a>
        '
        ' The DeleteRole deletes the specified role from the portal database.
        '
        ' Other relevant sources:
        '     + <a href="DeleteRole.htm" style="color:green">DeleteRole Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub DeleteRole(ByVal roleId As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("DeleteRole", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterRoleID As New SqlParameter("@RoleID", SqlDbType.Int, 4)
            parameterRoleID.Value = roleId
            myCommand.Parameters.Add(parameterRoleID)

            ' Open the database connection and execute the command
            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' UpdateRole() Method <a name="UpdateRole"></a>
        '
        ' The UpdateRole method updates the friendly name of the specified role.
        '
        ' Other relevant sources:
        '     + <a href="UpdateRole.htm" style="color:green">UpdateRole Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdateRole(ByVal roleId As Integer, ByVal roleName As String)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateRole", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterRoleID As New SqlParameter("@RoleID", SqlDbType.Int, 4)
            parameterRoleID.Value = roleId
            myCommand.Parameters.Add(parameterRoleID)

            Dim parameterRoleName As New SqlParameter("@RoleName", SqlDbType.NVarChar, 50)
            parameterRoleName.Value = roleName
            myCommand.Parameters.Add(parameterRoleName)

            ' Open the database connection and execute the command
            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub

        '
        ' USER ROLES
        '
        '*********************************************************************
        '
        ' GetRoleMembers() Method <a name="GetRoleMembers"></a>
        '
        ' The GetRoleMembers method returns a list of all members in the specified
        ' security role.
        '
        ' Other relevant sources:
        '     + <a href="GetRoleMembers.htm" style="color:green">GetRoleMembers Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetRoleMembers(ByVal roleId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetRoleMembership", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            Dim parameterRoleID As New SqlParameter("@RoleID", SqlDbType.Int, 4)
            parameterRoleID.Value = roleId
            myCommand.Parameters.Add(parameterRoleID)

            ' Open the database connection and execute the command
            myConnection.Open()
            Dim dr As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader
            Return dr

        End Function


        '*********************************************************************
        '
        ' AddUserRole() Method <a name="AddUserRole"></a>
        '
        ' The AddUserRole method adds the user to the specified security role.
        '
        ' Other relevant sources:
        '     + <a href="AddUserRole.htm" style="color:green">AddUserRole Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub AddUserRole(ByVal roleId As Integer, ByVal userId As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("AddUserRole", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterRoleID As New SqlParameter("@RoleID", SqlDbType.Int, 4)
            parameterRoleID.Value = roleId
            myCommand.Parameters.Add(parameterRoleID)

            Dim parameterUserID As New SqlParameter("@UserID", SqlDbType.Int, 4)
            parameterUserID.Value = userId
            myCommand.Parameters.Add(parameterUserID)

            ' Open the database connection and execute the command
            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' DeleteUserRole() Method <a name="DeleteUserRole"></a>
        '
        ' The DeleteUserRole method deletes the user from the specified role.
        '
        ' Other relevant sources:
        '     + <a href="DeleteUserRole.htm" style="color:green">DeleteUserRole Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub DeleteUserRole(ByVal roleId As Integer, ByVal userId As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("DeleteUserRole", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterRoleID As New SqlParameter("@RoleID", SqlDbType.Int, 4)
            parameterRoleID.Value = roleId
            myCommand.Parameters.Add(parameterRoleID)

            Dim parameterUserID As New SqlParameter("@UserID", SqlDbType.Int, 4)
            parameterUserID.Value = userId
            myCommand.Parameters.Add(parameterUserID)

            ' Open the database connection and execute the command
            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '
        ' USERS
        '
        '*********************************************************************
        '
        ' GetUsers() Method <a name="GetUsers"></a>
        '
        ' The GetUsers method returns returns the UserID, Name and Email for 
        ' all registered users.
        '
        ' Other relevant sources:
        '     + <a href="GetUsers.htm" style="color:green">GetUsers Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetUsers() As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetUsers", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Open the database connection and execute the command
            myConnection.Open()
            Dim dr As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader
            Return dr

        End Function


        '
        ' PORTAL
        '
        '*********************************************************************
        '
        ' UpdatePortalInfo() Method <a name="UpdatePortalInfo"></a>
        '
        ' The UpdatePortalInfo method updates the name and access settings for the portal.
        '
        ' Other relevant sources:
        '     + <a href="UpdatePortalInfo.htm" style="color:green">UpdatePortalInfo Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdatePortalInfo(ByVal portalId As Integer, ByVal portalName As String, ByVal alwaysShow As Boolean)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdatePortalInfo", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterPortalId As New SqlParameter("@PortalId", SqlDbType.Int, 4)
            parameterPortalId.Value = portalId
            myCommand.Parameters.Add(parameterPortalId)

            Dim parameterPortalName As New SqlParameter("@PortalName", SqlDbType.NVarChar, 128)
            parameterPortalName.Value = portalName
            myCommand.Parameters.Add(parameterPortalName)

            Dim parameterAlwaysShow As New SqlParameter("@AlwaysShowEditButton", SqlDbType.Bit, 1)
            parameterAlwaysShow.Value = alwaysShow
            myCommand.Parameters.Add(parameterAlwaysShow)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '
        ' TABS
        '
        '*********************************************************************
        '
        ' AddTab Method
        '
        ' The AddTab method adds a new tab to the portal.
        '
        ' Other relevant sources:
        '     + <a href="AddTab.htm" style="color:green">AddTab Stored Procedure</a>
        '
        '*********************************************************************

        Public Function AddTab(ByVal portalId As Integer, ByVal tabName As String, ByVal tabOrder As Integer) As Integer

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("AddTab", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterPortalId As New SqlParameter("@PortalId", SqlDbType.Int, 4)
            parameterPortalId.Value = portalId
            myCommand.Parameters.Add(parameterPortalId)

            Dim parameterTabName As New SqlParameter("@TabName", SqlDbType.NVarChar, 50)
            parameterTabName.Value = tabName
            myCommand.Parameters.Add(parameterTabName)

            Dim parameterTabOrder As New SqlParameter("@TabOrder", SqlDbType.Int, 4)
            parameterTabOrder.Value = tabOrder
            myCommand.Parameters.Add(parameterTabOrder)

            Dim parameterAuthRoles As New SqlParameter("@AuthorizedRoles", SqlDbType.NVarChar, 256)
            parameterAuthRoles.Value = "All Users"
            myCommand.Parameters.Add(parameterAuthRoles)

            Dim parameterMobileTabName As New SqlParameter("@MobileTabName", SqlDbType.NVarChar, 50)
            parameterMobileTabName.Value = ""
            myCommand.Parameters.Add(parameterMobileTabName)

            Dim parameterTabId As New SqlParameter("@TabId", SqlDbType.Int, 4)
            parameterTabId.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterTabId)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

            Return CInt(parameterTabId.Value)

        End Function


        '*********************************************************************
        '
        ' UpdateTab Method
        '
        ' The UpdateTab method updates the settings for the specified tab.
        '
        ' Other relevant sources:
        '     + <a href="UpdateTab.htm" style="color:green">UpdateTab Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdateTab(ByVal portalId As Integer, ByVal tabId As Integer, ByVal tabName As String, ByVal tabOrder As Integer, ByVal authorizedRoles As String, ByVal mobileTabName As String, ByVal showMobile As Boolean)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateTab", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterPortalId As New SqlParameter("@PortalId", SqlDbType.Int, 4)
            parameterPortalId.Value = portalId
            myCommand.Parameters.Add(parameterPortalId)

            Dim parameterTabId As New SqlParameter("@TabId", SqlDbType.Int, 4)
            parameterTabId.Value = tabId
            myCommand.Parameters.Add(parameterTabId)

            Dim parameterTabName As New SqlParameter("@TabName", SqlDbType.NVarChar, 50)
            parameterTabName.Value = tabName
            myCommand.Parameters.Add(parameterTabName)

            Dim parameterTabOrder As New SqlParameter("@TabOrder", SqlDbType.Int, 4)
            parameterTabOrder.Value = tabOrder
            myCommand.Parameters.Add(parameterTabOrder)

            Dim parameterAuthRoles As New SqlParameter("@AuthorizedRoles", SqlDbType.NVarChar, 256)
            parameterAuthRoles.Value = authorizedRoles
            myCommand.Parameters.Add(parameterAuthRoles)

            Dim parameterMobileTabName As New SqlParameter("@MobileTabName", SqlDbType.NVarChar, 50)
            parameterMobileTabName.Value = mobileTabName
            myCommand.Parameters.Add(parameterMobileTabName)

            Dim parameterShowMobile As New SqlParameter("@ShowMobile", SqlDbType.Bit, 1)
            parameterShowMobile.Value = showMobile
            myCommand.Parameters.Add(parameterShowMobile)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' UpdateTabOrder Method
        '
        ' The UpdateTabOrder method changes the position of the tab with respect
        ' to other tabs in the portal.
        '
        ' Other relevant sources:
        '     + <a href="UpdateTabOrder.htm" style="color:green">UpdateTabOrder Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdateTabOrder(ByVal tabId As Integer, ByVal tabOrder As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateTabOrder", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterTabId As New SqlParameter("@TabId", SqlDbType.Int, 4)
            parameterTabId.Value = tabId
            myCommand.Parameters.Add(parameterTabId)

            Dim parameterTabOrder As New SqlParameter("@TabOrder", SqlDbType.Int, 4)
            parameterTabOrder.Value = tabOrder
            myCommand.Parameters.Add(parameterTabOrder)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' DeleteTab() Method <a name="DeleteTab"></a>
        '
        ' The DeleteTab method deletes the selected tab from the portal.
        '
        ' Other relevant sources:
        '     + <a href="DeleteTab.htm" style="color:green">DeleteTab Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub DeleteTab(ByVal tabId As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("DeleteTab", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterTabID As New SqlParameter("@TabID", SqlDbType.Int, 4)
            parameterTabID.Value = tabId
            myCommand.Parameters.Add(parameterTabID)

            ' Open the database connection and execute the command
            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '
        ' MODULES
        '
        '*********************************************************************
        '
        ' UpdateModuleOrder Method
        '
        ' The AddUserRole method adds the user to the specified security role.
        '
        ' Other relevant sources:
        '     + <a href="UpdateModuleOrder.htm" style="color:green">UpdateModuleOrder Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdateModuleOrder(ByVal ModuleId As Integer, ByVal ModuleOrder As Integer, ByVal pane As String)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateModuleOrder", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleId As New SqlParameter("@ModuleId", SqlDbType.Int, 4)
            parameterModuleId.Value = ModuleId
            myCommand.Parameters.Add(parameterModuleId)

            Dim parameterModuleOrder As New SqlParameter("@ModuleOrder", SqlDbType.Int, 4)
            parameterModuleOrder.Value = ModuleOrder
            myCommand.Parameters.Add(parameterModuleOrder)

            Dim parameterPaneName As New SqlParameter("@PaneName", SqlDbType.NVarChar, 256)
            parameterPaneName.Value = pane
            myCommand.Parameters.Add(parameterPaneName)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' AddModule Method
        '
        ' The AddModule method updates a specified Module within
        ' the Modules database table.  If the module does not yet exist,
        ' the stored procedure adds it.
        '
        ' Other relevant sources:
        '     + <a href="AddModule.htm" style="color:green">AddModule Stored Procedure</a>
        '
        '*********************************************************************

        Public Function AddModule(ByVal tabId As Integer, ByVal moduleOrder As Integer, ByVal paneName As String, ByVal title As String, ByVal moduleDefId As Integer, ByVal cacheTime As Integer, ByVal editRoles As String, ByVal showMobile As Boolean) As Integer

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("AddModule", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleId As New SqlParameter("@ModuleId", SqlDbType.Int, 4)
            parameterModuleId.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterModuleId)

            Dim parameterModuleDefinitionId As New SqlParameter("@ModuleDefId", SqlDbType.Int, 4)
            parameterModuleDefinitionId.Value = moduleDefId
            myCommand.Parameters.Add(parameterModuleDefinitionId)

            Dim parameterTabId As New SqlParameter("@TabId", SqlDbType.Int, 4)
            parameterTabId.Value = tabId
            myCommand.Parameters.Add(parameterTabId)

            Dim parameterModuleOrder As New SqlParameter("@ModuleOrder", SqlDbType.Int, 4)
            parameterModuleOrder.Value = moduleOrder
            myCommand.Parameters.Add(parameterModuleOrder)

            Dim parameterTitle As New SqlParameter("@ModuleTitle", SqlDbType.NVarChar, 256)
            parameterTitle.Value = title
            myCommand.Parameters.Add(parameterTitle)

            Dim parameterPaneName As New SqlParameter("@PaneName", SqlDbType.NVarChar, 256)
            parameterPaneName.Value = paneName
            myCommand.Parameters.Add(parameterPaneName)

            Dim parameterCacheTime As New SqlParameter("@CacheTime", SqlDbType.Int, 4)
            parameterCacheTime.Value = cacheTime
            myCommand.Parameters.Add(parameterCacheTime)

            Dim parameterEditRoles As New SqlParameter("@EditRoles", SqlDbType.NVarChar, 256)
            parameterEditRoles.Value = editRoles
            myCommand.Parameters.Add(parameterEditRoles)

            Dim parameterShowMobile As New SqlParameter("@ShowMobile", SqlDbType.Bit, 1)
            parameterShowMobile.Value = showMobile
            myCommand.Parameters.Add(parameterShowMobile)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

            Return CInt(parameterModuleId.Value)

        End Function


        '*********************************************************************
        '
        ' UpdateModule Method
        '
        ' The UpdateModule method updates a specified Module within
        ' the Modules database table.  If the module does not yet exist,
        ' the stored procedure adds it.
        '
        ' Other relevant sources:
        '     + <a href="UpdateModule.htm" style="color:green">UpdateModule Stored Procedure</a>
        '
        '*********************************************************************

        Public Function UpdateModule(ByVal moduleId As Integer, ByVal moduleOrder As Integer, ByVal paneName As String, ByVal title As String, ByVal cacheTime As Integer, ByVal editRoles As String, ByVal showMobile As Boolean) As Integer

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateModule", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleId As New SqlParameter("@ModuleID", SqlDbType.Int, 4)
            parameterModuleId.Value = moduleId
            myCommand.Parameters.Add(parameterModuleId)

            Dim parameterModuleOrder As New SqlParameter("@ModuleOrder", SqlDbType.Int, 4)
            parameterModuleOrder.Value = moduleOrder
            myCommand.Parameters.Add(parameterModuleOrder)

            Dim parameterTitle As New SqlParameter("@ModuleTitle", SqlDbType.NVarChar, 256)
            parameterTitle.Value = title
            myCommand.Parameters.Add(parameterTitle)

            Dim parameterPaneName As New SqlParameter("@PaneName", SqlDbType.NVarChar, 256)
            parameterPaneName.Value = paneName
            myCommand.Parameters.Add(parameterPaneName)

            Dim parameterCacheTime As New SqlParameter("@CacheTime", SqlDbType.Int, 4)
            parameterCacheTime.Value = cacheTime
            myCommand.Parameters.Add(parameterCacheTime)

            Dim parameterEditRoles As New SqlParameter("@EditRoles", SqlDbType.NVarChar, 256)
            parameterEditRoles.Value = editRoles
            myCommand.Parameters.Add(parameterEditRoles)

            Dim parameterShowMobile As New SqlParameter("@ShowMobile", SqlDbType.Bit, 1)
            parameterShowMobile.Value = showMobile
            myCommand.Parameters.Add(parameterShowMobile)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

            Return CInt(parameterModuleId.Value)

        End Function


        '*********************************************************************
        '
        ' DeleteModule Method
        '
        ' The DeleteModule method deletes a specified Module from
        ' the Modules database table.
        '
        ' Other relevant sources:
        '     + <a href="DeleteModule.htm" style="color:green">DeleteModule Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub DeleteModule(ByVal moduleId As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("DeleteModule", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleId As New SqlParameter("@ModuleID", SqlDbType.Int, 4)
            parameterModuleId.Value = moduleId
            myCommand.Parameters.Add(parameterModuleId)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' UpdateModuleSetting Method
        '
        ' The UpdateModuleSetting Method updates a single module setting 
        ' in the ModuleSettings database table.
        '
        '*********************************************************************

        Public Sub UpdateModuleSetting(ByVal moduleId As Integer, ByVal key As String, ByVal value As String)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateModuleSetting", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleId As New SqlParameter("@ModuleID", SqlDbType.Int, 4)
            parameterModuleId.Value = moduleId
            myCommand.Parameters.Add(parameterModuleId)

            Dim parameterKey As New SqlParameter("@SettingName", SqlDbType.NVarChar, 50)
            parameterKey.Value = key
            myCommand.Parameters.Add(parameterKey)

            Dim parameterValue As New SqlParameter("@SettingValue", SqlDbType.NVarChar, 50)
            parameterValue.Value = value
            myCommand.Parameters.Add(parameterValue)

            ' Execute the command
            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '
        ' MODULE DEFINITIONS
        '
        '*********************************************************************
        '
        ' GetModuleDefinitions() Method <a name="GetModuleDefinitions"></a>
        '
        ' The GetModuleDefinitions method returns a list of all module type 
        ' definitions for the portal.
        '
        ' Other relevant sources:
        '     + <a href="GetModuleDefinitions.htm" style="color:green">GetModuleDefinitions Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetModuleDefinitions(ByVal portalId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetModuleDefinitions", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterPortalId As New SqlParameter("@PortalId", SqlDbType.Int, 4)
            parameterPortalId.Value = portalId
            myCommand.Parameters.Add(parameterPortalId)

            ' Open the database connection and execute the command
            myConnection.Open()
            Dim dr As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader
            Return dr

        End Function


        '*********************************************************************
        '
        ' AddModuleDefinition() Method <a name="AddModuleDefinition"></a>
        '
        ' The AddModuleDefinition add the definition for a new module type
        ' to the portal.
        '
        ' Other relevant sources:
        '     + <a href="AddModuleDefinition.htm" style="color:green">AddModuleDefinition Stored Procedure</a>
        '
        '*********************************************************************

        Public Function AddModuleDefinition(ByVal portalId As Integer, ByVal name As String, ByVal desktopSrc As String, ByVal mobileSrc As String) As Integer

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("AddModuleDefinition", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterPortalID As New SqlParameter("@PortalID", SqlDbType.Int, 4)
            parameterPortalID.Value = portalId
            myCommand.Parameters.Add(parameterPortalID)

            Dim parameterFriendlyName As New SqlParameter("@FriendlyName", SqlDbType.NVarChar, 128)
            parameterFriendlyName.Value = name
            myCommand.Parameters.Add(parameterFriendlyName)

            Dim parameterDesktopSrc As New SqlParameter("@DesktopSrc", SqlDbType.NVarChar, 256)
            parameterDesktopSrc.Value = desktopSrc
            myCommand.Parameters.Add(parameterDesktopSrc)

            Dim parameterMobileSrc As New SqlParameter("@MobileSrc", SqlDbType.NVarChar, 256)
            parameterMobileSrc.Value = mobileSrc
            myCommand.Parameters.Add(parameterMobileSrc)

            Dim parameterModuleDefID As New SqlParameter("@ModuleDefID", SqlDbType.Int, 4)
            parameterModuleDefID.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterModuleDefID)

            ' Open the database connection and execute the command
            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

            ' return the role id 
            Return CInt(parameterModuleDefID.Value)

        End Function


        '*********************************************************************
        '
        ' DeleteModuleDefinition() Method <a name="DeleteModuleDefinition"></a>
        '
        ' The DeleteModuleDefinition method deletes the specified module type 
        ' definition from the portal.
        '
        ' Other relevant sources:
        '     + <a href="DeleteModuleDefinition.htm" style="color:green">DeleteModuleDefinition Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub DeleteModuleDefinition(ByVal defId As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("DeleteModuleDefinition", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleDefID As New SqlParameter("@ModuleDefID", SqlDbType.Int, 4)
            parameterModuleDefID.Value = defId
            myCommand.Parameters.Add(parameterModuleDefID)

            ' Open the database connection and execute the command
            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' UpdateModuleDefinition() Method <a name="UpdateModuleDefinition"></a>
        '
        ' The UpdateModuleDefinition method updates the settings for the 
        ' specified module type definition.
        '
        ' Other relevant sources:
        '     + <a href="UpdateModuleDefinition.htm" style="color:green">UpdateModuleDefinition Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdateModuleDefinition(ByVal defId As Integer, ByVal name As String, ByVal desktopSrc As String, ByVal mobileSrc As String)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateModuleDefinition", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleDefID As New SqlParameter("@ModuleDefID", SqlDbType.Int, 4)
            parameterModuleDefID.Value = defId
            myCommand.Parameters.Add(parameterModuleDefID)

            Dim parameterFriendlyName As New SqlParameter("@FriendlyName", SqlDbType.NVarChar, 128)
            parameterFriendlyName.Value = name
            myCommand.Parameters.Add(parameterFriendlyName)

            Dim parameterDesktopSrc As New SqlParameter("@DesktopSrc", SqlDbType.NVarChar, 256)
            parameterDesktopSrc.Value = desktopSrc
            myCommand.Parameters.Add(parameterDesktopSrc)

            Dim parameterMobileSrc As New SqlParameter("@MobileSrc", SqlDbType.NVarChar, 256)
            parameterMobileSrc.Value = mobileSrc
            myCommand.Parameters.Add(parameterMobileSrc)

            ' Open the database connection and execute the command
            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' GetSingleModuleDefinition Method
        '
        ' The GetSingleModuleDefinition method returns a SqlDataReader containing details
        ' about a specific module definition from the ModuleDefinitions table.
        '
        ' Other relevant sources:
        '     + <a href="GetSingleModuleDefinition.htm" style="color:green">GetSingleModuleDefinition Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetSingleModuleDefinition(ByVal defId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetSingleModuleDefinition", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleDefID As New SqlParameter("@ModuleDefID", SqlDbType.Int, 4)
            parameterModuleDefID.Value = defId
            myCommand.Parameters.Add(parameterModuleDefID)

            ' Execute the command
            myConnection.Open()
            Dim result As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader 
            Return result

        End Function

    End Class

End Namespace
