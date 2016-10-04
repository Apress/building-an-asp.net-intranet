Imports System
Imports System.IO
Imports System.ComponentModel
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls


Namespace ASPNetPortal

    '*********************************************************************
    '
    ' PortalModuleControl Class
    '
    ' The PortalModuleControl class defines a custom base class inherited by all
    ' desktop portal modules within the Portal.
    ' 
    ' The PortalModuleControl class defines portal specific properties
    ' that are used by the portal framework to correctly display portal modules
    '
    '*********************************************************************

    Public Class PortalModuleControl
        Inherits UserControl

        ' Private field variables
        Private _moduleConfiguration As ModuleSettings
        Private _isEditable As Integer = 0
        Private _portalId As Integer = 0
        Private _settings As Hashtable

        ' Public property accessors
        <Browsable(False), DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)> _
        Public ReadOnly Property ModuleId() As Integer

            Get
                Return CInt(_moduleConfiguration.ModuleId)
            End Get

        End Property


        <Browsable(False), DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)> _
        Public Property PortalId() As Integer

            Get
                Return _portalId
            End Get
            Set(ByVal Value As Integer)
                _portalId = Value
            End Set

        End Property


        <Browsable(False), DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)> _
        Public ReadOnly Property IsEditable() As Boolean

            Get

                ' Perform tri-state switch check to avoid having to perform a security
                ' role lookup on every property access (instead caching the result)
                If _isEditable = 0 Then

                    ' Obtain PortalSettings from Current Context
                    Dim _portalSettings As PortalSettings = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

                    If _portalSettings.AlwaysShowEditButton = True Or PortalSecurity.IsInRoles(_moduleConfiguration.AuthorizedEditRoles) Then
                        _isEditable = 1
                    Else
                        _isEditable = 2
                    End If
                End If

                Return _isEditable = 1
            End Get

        End Property


        <Browsable(False), DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)> _
        Public Property ModuleConfiguration() As ModuleSettings

            Get
                Return _moduleConfiguration
            End Get
            Set(ByVal Value As ModuleSettings)
                _moduleConfiguration = Value
            End Set

        End Property


        <Browsable(False), DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)> _
        Public ReadOnly Property Settings() As Hashtable

            Get

                If _settings Is Nothing Then

                    _settings = PortalSettings.GetModuleSettings(ModuleId)
                End If

                Return _settings
            End Get

        End Property

    End Class
    _

    '*********************************************************************
    '
    ' CachedPortalModuleControl Class
    '
    ' The CachedPortalModuleControl class is a custom server control that
    ' the Portal framework uses to optionally enable output caching of 
    ' individual portal module's content.
    '
    ' If a CacheTime value greater than 0 seconds is specified within the 
    ' Portal.Config configuration file, then the CachePortalModuleControl
    ' will automatically capture the output of the Portal Module User Control
    ' it wraps.  It will then store this captured output within the ASP.NET
    ' Cache API.  On subsequent requests (either by the same browser -- or
    ' by other browsers visiting the same portal page), the CachedPortalModuleControl
    ' will attempt to resolve the cached output out of the cache.
    '
    ' Note: In the event that previously cached output can't be found in the
    ' ASP.NET Cache, the CachedPortalModuleControl will automatically instatiate
    ' the appropriate portal module user control and place it within the
    ' portal page.
    '
    '*********************************************************************

    Public Class CachedPortalModuleControl
        Inherits Control

        ' Private field variables
        Private _moduleConfiguration As ModuleSettings
        Private _cachedOutput As String = ""
        Private _portalId As Integer = 0

        ' Public property accessors
        Public Property ModuleConfiguration() As ModuleSettings

            Get
                Return _moduleConfiguration
            End Get
            Set(ByVal Value As ModuleSettings)
                _moduleConfiguration = Value
            End Set

        End Property


        Public ReadOnly Property ModuleId() As Integer

            Get
                Return _moduleConfiguration.ModuleId
            End Get

        End Property


        Public Property PortalId() As Integer

            Get
                Return _portalId
            End Get
            Set(ByVal Value As Integer)
                _portalId = Value
            End Set

        End Property


        '*********************************************************************
        '
        ' CacheKey Property
        '
        ' The CacheKey property is used to calculate a "unique" cache key
        ' entry to be used to store/retrieve the portal module's content
        ' from the ASP.NET Cache.
        '
        '*********************************************************************

        Public ReadOnly Property CacheKey() As String

            Get
                Return "Key:" & Me.GetType().ToString() & Me.ModuleId & PortalSecurity.IsInRoles(_moduleConfiguration.AuthorizedEditRoles)
            End Get

        End Property


        '*********************************************************************
        '
        ' CreateChildControls Method
        '
        ' The CreateChildControls method is called when the ASP.NET Page Framework
        ' determines that it is time to instantiate a server control.
        ' 
        ' The CachedPortalModuleControl control overrides this method and attempts
        ' to resolve any previously cached output of the portal module from the 
        ' ASP.NET cache.  
        '
        ' If it doesn't find cached output from a previous request, then the
        ' CachedPortalModuleControl will instantiate and add the portal module's
        ' User Control instance into the page tree.
        '
        '*********************************************************************

        Protected Overrides Sub CreateChildControls()

            ' Attempt to resolve previously cached content from the ASP.NET Cache
            If _moduleConfiguration.CacheTime > 0 Then
                _cachedOutput = CStr(Context.Cache(CacheKey))
            End If

            ' If no cached content is found, then instantiate and add the portal
            ' module user control into the portal's page server control tree
            If _cachedOutput Is Nothing Then

                MyBase.CreateChildControls()

                Dim [module] As PortalModuleControl = CType(Page.LoadControl(_moduleConfiguration.DesktopSrc), PortalModuleControl)

                [module].ModuleConfiguration = Me.ModuleConfiguration
                [module].PortalId = Me.PortalId

                Me.Controls.Add([module])

            End If

        End Sub


        '*********************************************************************
        '
        ' Render Method
        '
        ' The Render method is called when the ASP.NET Page Framework
        ' determines that it is time to render content into the page output stream.
        ' 
        ' The CachedPortalModuleControl control overrides this method and captures
        ' the output generated by the portal module user control.  It then 
        ' adds this content into the ASP.NET Cache for future requests.
        '
        '*********************************************************************

        Protected Overrides Sub Render(ByVal output As HtmlTextWriter)

            ' If no caching is specified, render the child tree and return 
            If _moduleConfiguration.CacheTime = 0 Then
                MyBase.Render(output)
                Return
            End If

            ' If no cached output was found from a previous request, render
            ' child controls into a TextWriter, and then cache the results
            ' in the ASP.NET Cache for future requests.
            If _cachedOutput Is Nothing Then

                Dim tempWriter = New StringWriter()
                MyBase.Render(New HtmlTextWriter(tempWriter))
                _cachedOutput = tempWriter.ToString()

                Context.Cache.Insert(CacheKey, _cachedOutput, Nothing, DateTime.Now.AddSeconds(_moduleConfiguration.CacheTime), TimeSpan.Zero)

            End If

            ' Output the user control's content
            output.Write(_cachedOutput)

        End Sub

    End Class

End Namespace