<%@ Control Language="VB" Inherits="ASPNetPortal.MobilePortalModuleControl" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>
<%@ Register TagPrefix="portal" TagName="Title" Src="~/MobileModuleTitle.ascx" %>
<%@ Register TagPrefix="portal" Namespace="ASPNetPortal.MobileControls" Assembly="Portal" %>
<%@ Import Namespace="System.Data" %>

<%--

    The Events Mobile User Control renders event modules in the portal. 

    The control consists of two pieces: a summary panel that is rendered when
    portal view shows a summarized view of all modules, and a multi-part panel 
    that renders the module details.

--%>

<script runat="server">

    Private ds As DataSet = Nothing
    Private currentIndex As Integer = 0

    '*********************************************************************
    '
    ' Page_Load Event Handler
    '
    ' The Page_Load event handler on this User Control is used to
    ' obtain a DataSet of announcement information from the Events
    ' table, and then databind the results to the module contents.
    '
    '*******************************************************

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ' Obtain announcement information from Events table
        Dim ev As New ASPNetPortal.EventsDB()
        ds = ev.GetEvents(ModuleId)

        ' DataBind User Control
        DataBind()

    End Sub



    '*********************************************************************
    '
    ' SummaryView_OnItemCommand Event Handler
    '
    ' The SummaryView_OnItemCommand event handler is called when the user
    ' clicks on a "More" link in the summary view. It calls the 
    ' ShowEventDetails utility method to show details of the event.
    '
    '*********************************************************************

    Sub SummaryView_OnItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs)

        ShowEventDetails(e.Item.ItemIndex)

    End Sub


    '*********************************************************************
    '
    ' EventsList_OnItemCommand Event Handler
    '
    ' The EventsList_OnItemCommand event handler is called when the user
    ' clicks on an item in the list of events. It calls the
    ' ShowEventDetails utility method to show details of the event.
    '
    '*********************************************************************

    Sub EventsList_OnItemCommand(ByVal sender As Object, ByVal e As ListCommandEventArgs)

        ShowEventDetails(e.ListItem.Index)

    End Sub


    '*********************************************************************
    '
    ' DetailsView_OnClick Event Handler
    '
    ' The DetailsView_OnClick event handler is called when the user 
    ' clicks in the details view to return to the summary view.
    '
    '*********************************************************************

    Sub DetailsView_OnClick(ByVal sender As Object, ByVal e As EventArgs)

        ' Make the parent tab show module summaries again.
        Tab.SummaryView = True

    End Sub


    '*********************************************************************
    '
    ' ShowEventDetails Method
    '
    ' The ShowEventDetails method sets the active pane of
    ' the module to the details view, and shows the details of the
    ' given item.
    '
    '*********************************************************************'

    Sub ShowEventDetails(ByVal itemIndex As Integer)

        currentIndex = itemIndex

        ' Switch the visible pane of the multi-panel view to show
        ' event details.
        MainView.ActivePane = EventDetails

        ' rebind the details panel
        EventDetails.DataBind()

        ' Make the parent tab switch to details mode, showing this module.
        Tab.ShowDetails(Me)

    End Sub
    
    '*********************************************************************
    '
    ' FormatChildField Method
    '
    ' The FormatChildField method returns the selected field as a string,
    ' if the row is not empty.  If empty, it returns String.Empty.
    '
    '*********************************************************************

    Function FormatChildField (fieldName As String) As String
    
        If ds.Tables(0).Rows.Count > 0 Then 
            return ds.Tables(0).Rows(currentIndex)(fieldName).ToString()
        Else
            return String.Empty
        End If
            
    End Function            

</script>

<mobile:Panel runat="server" id="summary">
    <DeviceSpecific>
        <Choice Filter="isJScript">
        
            <ContentTemplate>
                <portal:Title runat="server" />
                <font face="Verdana" size="-2">
                <asp:Repeater runat="server" DataSource="<%# ds %>" OnItemCommand="SummaryView_OnItemCommand">
                    <ItemTemplate>
                        <b><%# DataBinder.Eval(Container.DataItem, "Title") %></b><br>
                        <i><%# DataBinder.Eval(Container.DataItem, "WhereWhen") %></i>&nbsp;
                        <asp:LinkButton runat="server" Text="more" /><br><br>
                    </ItemTemplate>
                </asp:Repeater>
                </font><br>
            </ContentTemplate>
                
        </Choice>
    </DeviceSpecific>
</mobile:Panel>

<portal:MultiPanel runat="server" id="MainView" Font-Name="Verdana" Font-Size="Small">

    <portal:ChildPanel id="EventsList" runat="server">
        <portal:Title runat="server" />
        <mobile:List runat="server" OnItemCommand="EventsList_OnItemCommand" DataTextField="Title" DataSource="<%# ds %>" />
    </portal:ChildPanel>

    <portal:ChildPanel id="EventDetails" runat="server">
        <portal:Title runat="server" Text='<%# FormatChildField("Title") %>' />
        <mobile:Label runat="server" Font-Italic="true" Text='<%# FormatChildField("WhereWhen") %>' />
        &nbsp;<br>
        <mobile:TextView runat="server" Text='<%# FormatChildField("Description") %>' />
        <portal:LinkCommand runat="server" OnClick="DetailsView_OnClick" Text="back" />
    </portal:ChildPanel>

</portal:MultiPanel>

