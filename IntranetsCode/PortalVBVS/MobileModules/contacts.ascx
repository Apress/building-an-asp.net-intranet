<%@ Control Language="VB" Inherits="ASPNetPortal.MobilePortalModuleControl" Debug="true" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>
<%@ Register TagPrefix="portal" TagName="Title" Src="~/MobileModuleTitle.ascx" %>
<%@ Register TagPrefix="portal" Namespace="ASPNetPortal.MobileControls" Assembly="Portal" %>
<%@ Import Namespace="System.Data" %>

<%--

    The Contacts Mobile User Control renders Contacts modules in the
    mobile portal. 

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
    ' obtain a DataSet of contact information from the Contacts
    ' database, and then databind the results to the module contents.
    '
    '*********************************************************************

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ' Obtain announcement information from Contacts table
        Dim ct As New ASPNetPortal.ContactsDB()
        ds = ct.GetContacts(ModuleId)

        ' DataBind User Control
        DataBind()

    End Sub


    '*********************************************************************
    '
    ' SummaryView_OnClick Event Handler
    '
    ' The SummaryView_OnClick event handler is called when the user
    ' clicks on the link in the summary view. It shows the list of
    ' contacts.
    '
    '*********************************************************************

    Sub SummaryView_OnClick(ByVal sender As Object, ByVal e As EventArgs)

        ' Switch the visible pane of the multi-panel view to show
        ' the list of contacts.
        MainView.ActivePane = ContactsList

        ' Make the parent tab switch to details mode, showing this module.
        Tab.ShowDetails(Me)

    End Sub


    '*********************************************************************
    '
    ' ContactsList_OnItemCommand Event Handler
    '
    ' The ContactsList_OnItemCommand event handler is called when the user
    ' clicks on a contact in the contact list. It shows the details of the
    ' contact.
    '
    '*********************************************************************

    Sub ContactsList_OnItemCommand(ByVal sender As Object, ByVal e As ListCommandEventArgs)

        currentIndex = e.ListItem.Index
        ContactDetails.DataBind()

        ' Switch the visible pane of the multi-panel view to show
        ' contact details.
        MainView.ActivePane = ContactDetails

        ' rebind the details panel
        ContactDetails.DataBind()

    End Sub


    '*********************************************************************
    '
    ' DetailsView_OnClick Event Handler
    '
    ' The DetailsView_OnClick event handler is called when the user
    ' clicks on a link in the contact details view to return to the
    ' list of contacts.
    '
    '*********************************************************************

    Sub DetailsView_OnClick(ByVal sender As Object, ByVal e As EventArgs)

        ContactsList.DataBind()

        ' Switch the visible pane of the multi-panel view to show
        ' the list of contacts.
        MainView.ActivePane = ContactsList

    End Sub



    '*********************************************************************
    '
    ' GetPhoneNumber Method
    '
    ' The GetPhoneNumber method extracts a phone number from a contact
    ' entry, if possible, using a regular expression search.
    '
    '*********************************************************************'

    Private Function GetPhoneNumber(ByVal s As String) As String

        If Not (s Is String.Empty) Then

            ' Look for a phone number.
            Dim phoneMatch As Match = Regex.Match(s, "\+?(\d\(\)\.-)+")
            If phoneMatch.Success Then
                s = phoneMatch.ToString()
            Else
                s = String.Empty
            End If

        End If

        Return s

    End Function
     
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
                <font face="Verdana" size="-2">Click <a runat="server" OnServerClick="SummaryView_OnClick">
                        here</a> to access the directory of contacts. </font>
                <br>
            </ContentTemplate>
        </Choice>
    </DeviceSpecific>
</mobile:Panel>

<portal:MultiPanel runat="server" id="MainView" Font-Name="Verdana" Font-Size="Small">

    <portal:ChildPanel id="ContactsList" runat="server">
        <portal:Title runat="server" />
        <mobile:List runat="server" OnItemCommand="ContactsList_OnItemCommand" DataTextField="Name" DataSource="<%# ds %>">
            <DeviceSpecific>
                <Choice Filter="isJScript">
                    <HeaderTemplate>
                        <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <font face="Verdana" size="-2"><a href='<%# "mailto:" & DataBinder.Eval(CType(Container,MobileListItem).DataItem, "Email") %>'>
                                        <%# DataBinder.Eval(CType(Container,MobileListItem).DataItem, "Name") %>
                                    </a></font>
                            </td>
                            <td align="right">
                                <font face="Verdana" size="-2">
                                    <asp:LinkButton runat="server" Text="more" />
                                </font>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </Choice>
            </DeviceSpecific>
        </mobile:List>
    </portal:ChildPanel>
    
    <portal:ChildPanel id="ContactDetails" runat="server">
        <portal:Title runat="server" Text='<%# FormatChildField("Name") %>' />
        <b>Role: </b>
        <mobile:Label runat="server" Text='<%# FormatChildField("Role") %>' />
        <b>Email: </b>
        <mobile:Link runat="server" NavigateUrl='<%# "mailto:" & FormatChildField("Email") %>' Text='<%# FormatChildField("Email") %>' />
        <b>Contacts: </b>
        <br>
        <mobile:PhoneCall runat="server" Visible='<%# Not FormatChildField("Contact1") Is String.Empty %>' PhoneNumber='<%# GetPhoneNumber(FormatChildField("Contact1")) %>' Text='<%# FormatChildField("Contact1") %>' AlternateFormat="{0}" />
        <mobile:PhoneCall runat="server" Visible='<%# Not FormatChildField("Contact2") Is String.Empty %>' PhoneNumber='<%# GetPhoneNumber(FormatChildField("Contact2")) %>' Text='<%# FormatChildField("Contact2") %>' AlternateFormat="{0}" />
        <portal:LinkCommand runat="server" OnClick="DetailsView_OnClick" Text="back to list" />
    </portal:ChildPanel>
    
</portal:MultiPanel>
