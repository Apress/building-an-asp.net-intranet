Imports System
Imports System.Configuration
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections


Namespace ASPNetPortal

    '*********************************************************************
    '
    ' TabStripDetails Class
    '
    ' Class that encapsulates the just the tabstrip details -- TabName, TabId and TabOrder 
    ' -- for a specific Tab in the Portal
    '
    '*********************************************************************

    Public Class TabStripDetails

        Public TabId As Integer
        Public TabName As String
        Public TabOrder As Integer
        Public AuthorizedRoles As String

    End Class


    '*********************************************************************
    '
    ' TabSettings Class
    '
    ' Class that encapsulates the detailed settings for a specific Tab 
    ' in the Portal
    '
    '*********************************************************************

    Public Class TabSettings

        Public TabIndex As Integer
        Public TabId As Integer
        Public TabName As String
        Public TabOrder As Integer
        Public MobileTabName As String
        Public AuthorizedRoles As String
        Public ShowMobile As Boolean
        Public Modules As New ArrayList()

    End Class


    '*********************************************************************
    '
    ' ModuleSettings Class
    '
    ' Class that encapsulates the detailed settings for a specific Tab 
    ' in the Portal
    '
    '*********************************************************************

    Public Class ModuleSettings

        Public ModuleId As Integer
        Public ModuleDefId As Integer
        Public TabId As Integer
        Public CacheTime As Integer
        Public ModuleOrder As Integer
        Public PaneName As String
        Public ModuleTitle As String
        Public AuthorizedEditRoles As String
        Public ShowMobile As Boolean
        Public DesktopSrc As String
        Public MobileSrc As String

    End Class


    '*********************************************************************
    '
    ' PortalSettings Class
    '
    ' This class encapsulates all of the settings for the Portal, as well
    ' as the configuration settings required to execute the current tab
    ' view within the portal.
    '
    '*********************************************************************

    Public Class PortalSettings

        Public PortalId As Integer
        Public PortalName As String
        Public AlwaysShowEditButton As Boolean
        Public DesktopTabs As New ArrayList()
        Public MobileTabs As New ArrayList()
        Public ActiveTab As New TabSettings()

        '*********************************************************************
        '
        ' PortalSettings Constructor
        '
        ' The PortalSettings Constructor encapsulates all of the logic
        ' necessary to obtain configuration settings necessary to render
        ' a Portal Tab view for a given request.
        '
        ' These Portal Settings are stored within a SQL database, and are
        ' fetched below by calling the "GetPortalSettings" stored procedure.
        ' This stored procedure returns values as SPROC output parameters,
        ' and using three result sets.
        '
        '*********************************************************************

        Public Sub New(ByVal tabIndex As Integer, ByVal tabId As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetPortalSettings", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterPortalAlias As New SqlParameter("@PortalAlias", SqlDbType.NVarChar, 50)
            parameterPortalAlias.Value = "p_default"
            myCommand.Parameters.Add(parameterPortalAlias)

            Dim parameterTabId As New SqlParameter("@TabId", SqlDbType.Int, 4)
            parameterTabId.Value = tabId
            myCommand.Parameters.Add(parameterTabId)

            ' Add out parameters to Sproc
            Dim parameterPortalID As New SqlParameter("@PortalID", SqlDbType.Int, 4)
            parameterPortalID.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterPortalID)

            Dim parameterPortalName As New SqlParameter("@PortalName", SqlDbType.NVarChar, 128)
            parameterPortalName.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterPortalName)

            Dim parameterEditButton As New SqlParameter("@AlwaysShowEditButton", SqlDbType.Bit, 1)
            parameterEditButton.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterEditButton)

            Dim parameterTabName As New SqlParameter("@TabName", SqlDbType.NVarChar, 50)
            parameterTabName.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterTabName)

            Dim parameterTabOrder As New SqlParameter("@TabOrder", SqlDbType.Int, 4)
            parameterTabOrder.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterTabOrder)

            Dim parameterMobileTabName As New SqlParameter("@MobileTabName", SqlDbType.NVarChar, 50)
            parameterMobileTabName.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterMobileTabName)

            Dim parameterAuthRoles As New SqlParameter("@AuthRoles", SqlDbType.NVarChar, 256)
            parameterAuthRoles.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterAuthRoles)

            Dim parameterShowMobile As New SqlParameter("@ShowMobile", SqlDbType.Bit, 1)
            parameterShowMobile.Direction = ParameterDirection.Output
            myCommand.Parameters.Add(parameterShowMobile)

            ' Open the database connection and execute the command
            myConnection.Open()
            Dim result As SqlDataReader = myCommand.ExecuteReader()

            ' Read the first resultset -- Desktop Tab Information
            While result.Read()

                Dim tabDetails As New TabStripDetails()
                tabDetails.TabId = CInt(result("TabId"))
                tabDetails.TabName = CStr(result("TabName"))
                tabDetails.TabOrder = CInt(result("TabOrder"))
                tabDetails.AuthorizedRoles = CStr(result("AuthorizedRoles"))

                Me.DesktopTabs.Add(tabDetails)

            End While

            If Me.ActiveTab.TabId = 0 Then
                Me.ActiveTab.TabId = CType(Me.DesktopTabs(0), TabStripDetails).TabId
            End If

            ' Read the second result --  Mobile Tab Information
            result.NextResult()

            While result.Read()

                Dim tabDetails As New TabStripDetails()
                tabDetails.TabId = CInt(result("TabId"))
                tabDetails.TabName = CStr(result("MobileTabName"))
                tabDetails.AuthorizedRoles = CStr(result("AuthorizedRoles"))

                Me.MobileTabs.Add(tabDetails)

            End While

            ' Read the third result --  Module Tab Information
            result.NextResult()

            While result.Read()

                Dim m As New ModuleSettings()
                m.ModuleId = CInt(result("ModuleID"))
                m.ModuleDefId = CInt(result("ModuleDefID"))
                m.TabId = CInt(result("TabID"))
                m.PaneName = CStr(result("PaneName"))
                m.ModuleTitle = CStr(result("ModuleTitle"))
                m.AuthorizedEditRoles = CStr(result("AuthorizedEditRoles"))
                m.CacheTime = CInt(result("CacheTime"))
                m.ModuleOrder = CInt(result("ModuleOrder"))
                m.ShowMobile = CBool(result("ShowMobile"))
                m.DesktopSrc = CStr(result("DesktopSrc"))
                m.MobileSrc = CStr(result("MobileSrc"))

                Me.ActiveTab.Modules.Add(m)

            End While

            ' Now read Portal out params 
            result.NextResult()

            Me.PortalId = CInt(parameterPortalID.Value)
            Me.PortalName = CStr(parameterPortalName.Value)
            Me.AlwaysShowEditButton = CBool(parameterEditButton.Value)
            Me.ActiveTab.TabIndex = tabIndex
            Me.ActiveTab.TabId = tabId
            Me.ActiveTab.TabOrder = CInt(parameterTabOrder.Value)
            Me.ActiveTab.MobileTabName = CStr(parameterMobileTabName.Value)
            Me.ActiveTab.AuthorizedRoles = CStr(parameterAuthRoles.Value)
            Me.ActiveTab.TabName = CStr(parameterTabName.Value)
            Me.ActiveTab.ShowMobile = CBool(parameterShowMobile.Value)

            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' GetModuleSettings Static Method
        '
        ' The PortalSettings.GetModuleSettings Method returns a hashtable of
        ' custom module specific settings from the database.  This method is
        ' used by some user control modules (Xml, Image, etc) to access misc
        ' settings.
        '
        '*********************************************************************

        Public Shared Function GetModuleSettings(ByVal moduleId As Integer) As Hashtable

            ' Get Settings for this module from the database
            Dim _settings As New Hashtable()

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetModuleSettings", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleId As New SqlParameter("@ModuleID", SqlDbType.Int, 4)
            parameterModuleId.Value = moduleId
            myCommand.Parameters.Add(parameterModuleId)

            ' Execute the command
            myConnection.Open()
            Dim dr As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            While dr.Read()

                _settings(dr.GetString(0)) = dr.GetString(1)
            End While

            dr.Close()

            Return _settings

        End Function

    End Class

End Namespace