Namespace ASPNetPortal

    Public MustInherit Class Events
        Inherits ASPNetPortal.PortalModuleControl
        Protected WithEvents eventsMessage As System.Web.UI.WebControls.Label
        Protected WithEvents ViewByList As System.Web.UI.WebControls.DropDownList
        Protected dataListTitle As String
        Protected WithEvents myDataList As System.Web.UI.WebControls.DataList
        Protected WithEvents myCalendar As System.Web.UI.WebControls.Calendar
        Protected dateDR() As DateTime


#Region " Web Form Designer Generated Code "

        'This call is required by the Web Form Designer.
        <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

        End Sub

        Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
            'CODEGEN: This method call is required by the Web Form Designer
            'Do not modify it using the code editor.
            InitializeComponent()
        End Sub

#End Region

        

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' Check if page is loaded for first time
            If Not Page.IsPostBack Then
                ' Call a method to fill the calendar
                FillCalendar(myCalendar.TodaysDate)
                BuildList()
            End If

        End Sub

        Private Sub myCalendar_DayRender(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.DayRenderEventArgs) Handles myCalendar.DayRender
            ' Check for dates array
            If Not IsNothing(dateDR) Then
                ' Serach for the current date in the Array
                If Array.BinarySearch(dateDR, e.Day.Date) < 0 Then
                    ' If not found then make the Cell un-selectable
                    e.Day.IsSelectable = False
                Else
                    ' Setup some Cell properties
                    e.Cell.BorderColor = Color.Maroon
                    e.Cell.BorderWidth = Unit.Pixel(2)
                End If
            End If

            ' Set special background for Today's date
            If e.Day.IsToday Then
                e.Cell.BackColor = Color.LightGray
            End If

        End Sub

        Private Sub myCalendar_VisibleMonthChanged(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.MonthChangedEventArgs) Handles myCalendar.VisibleMonthChanged
            ' Fill the Calendar
            FillCalendar(e.NewDate)
        End Sub

        Private Sub myCalendar_SelectionChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles myCalendar.SelectionChanged
            FillCalendar(myCalendar.SelectedDate)
        End Sub

        Private Sub FillCalendar(ByVal showDate As System.DateTime)
            Dim events As New ASPNetPortal.EventsDB()
            Dim monthlyEvents As New DataSet()
            ' Get events for the month
            monthlyEvents = events.GetMonthlyEvents(ModuleId, showDate)
            If monthlyEvents.Tables(0).Rows.Count <> 0 Then
                ' Create a DataView out of the DataSet
                Dim dayView As New DataView(monthlyEvents.Tables(0))
                If Me.myCalendar.SelectedDate = Nothing Then
                    ' Filter the events for the current date
                    'removed #s
                    dayView.RowFilter = "EventDate = '" & Me.myCalendar.TodaysDate.ToString() & "'"

                    dataListTitle = "Events for Today!"
                Else
                    ' Filter the events for the selected date
                    dayView.RowFilter = "EventDate = '" & myCalendar.SelectedDate.ToString() & "'"
                    dataListTitle = "Events for the date :" & myCalendar.SelectedDate.ToShortDateString()
                    ViewByList.ClearSelection()
                End If
                If dayView.Count > 0 Then
                    ' Databind the DataList
                    myDataList.DataSource = dayView
                    myDataList.DataBind()
                End If
            End If

            If (monthlyEvents.Tables(0).Rows.Count) Then
                ' Populate an Array with the Dates for Events
                ReDim dateDR(monthlyEvents.Tables(0).Rows.Count)
                Dim i As Integer
                For i = 0 To (monthlyEvents.Tables(0).Rows.Count - 1)
                    dateDR(i) = monthlyEvents.Tables(0).Rows(i)("EventDate")
                Next i
            End If
        End Sub

        Private Sub BuildList()
            Dim viewOptions As New ArrayList()
            ' Add Custom options
            viewOptions.Add("Select Option")
            viewOptions.Add("All Events")
            viewOptions.Add("Current Month's Events")
            viewOptions.Add("Events for All Users")

            ' Get all roles for the current user
            Dim userRoles As New UsersDB()
            Dim roles As SqlDataReader = userRoles.GetRolesByUser(Context.User.Identity.Name)
            ' Add the roles
            While roles.Read
                viewOptions.Add("Events for " & CType(roles("RoleName"), String))
            End While
            roles.Close()
            ' Databind the DropDownList
            ViewByList.DataSource = viewOptions
            ViewByList.DataBind()

        End Sub


        Private Sub ViewByList_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ViewByList.SelectedIndexChanged
            Dim events As New ASPNetPortal.EventsDB()
            ' Select a case
            Select Case ViewByList.SelectedItem.Text
                Case "Select Option"
                    ' Default option
                    Exit Select
                Case "All Events"
                    ' Show all Events
                    dataListTitle = "All Events"
                    myDataList.DataSource = events.GetAllEvents(ModuleId)
                    myDataList.DataBind()
                Case "Current Month's Events"
                    ' Show current month's events
                    dataListTitle = "Current Month's Events"
                    myDataList.DataSource = events.GetMonthlyEvents(ModuleId, Me.myCalendar.VisibleDate)
                    myDataList.DataBind()
                Case "Events for All Users"
                    ' Filter the events based on role
                    dataListTitle = "Events for All Users"
                    Dim userView As New DataView(events.GetAllEvents(ModuleId).Tables(0))
                    userView.RowFilter = "AuthorizedViewRoles LIKE '%All Users%'"
                    myDataList.DataSource = userView
                    myDataList.DataBind()
                Case Else
                    ' Filter the events based on role selected
                    dataListTitle = ViewByList.SelectedItem.Text
                    ' Extract the Role name from the item
                    Dim userView As New DataView(events.GetAllEvents(ModuleId).Tables(0))
                    userView.RowFilter = "AuthorizedViewRoles LIKE '%" & ViewByList.SelectedItem.Text.Substring(11) & "%'"
                    myDataList.DataSource = userView
                    myDataList.DataBind()
            End Select

        End Sub

    End Class

End Namespace
