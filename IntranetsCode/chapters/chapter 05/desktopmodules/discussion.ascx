<%@ Control language="vb"
            AutoEventWireup="false"
            Inherits="ASPNetPortal.Discussion" 
            CodeBehind="Discussion.ascx.vb" %>
<%@ Register
            TagPrefix="Portal"
            TagName="Title" 
            Src="~/DesktopModuleTitle.ascx"%>
<portal:title id="Title1" runat="server" EditTarget="_new" EditUrl="~/DesktopModules/DiscussDetails.aspx" EditText="Add New Thread"></portal:title>
<%-- discussion list --%>
<asp:DataList 
    id="TopLevelList" 
    width="98%" 
    ItemStyle-Cssclass="Normal" 
    DataKeyField="ThreadID" 
    runat="server">
  <ItemTemplate>
    <asp:ImageButton
        id="btnSelect" 
        ImageUrl='<%# NodeImage(Cint(DataBinder.Eval( _
                                     Container.DataItem, "ChildCount"))) %>'
        Enabled='<%# CBool(DataBinder.Eval( _
                             Container.DataItem, "ChildCount")).ToString %>' 
        runat="server" />
    <!--
    <asp:hyperlink 
        Text='<%# DataBinder.Eval(Container.DataItem, "Title") %>' 
        NavigateUrl='<%# 
            FormatUrl(CInt(DataBinder.Eval( _
                            Container.DataItem, "ItemID"))) %>'
        Target="_new" runat="server" />
    -->
    <a
        title='Click to read the post'
        href='<%# FormatUrl(CInt(DataBinder.Eval( _
                                  Container.DataItem, "ItemID"))) %>'
        target='_new'>
      <%# DataBinder.Eval(Container.DataItem, "Title") %>
    </a>, from
    <%# DataBinder.Eval(Container.DataItem,"CreatedByUser") %>
    , posted
    <%# DataBinder.Eval(Container.DataItem,"CreatedDate", "{0:g}") %>
  </ItemTemplate>
  <SelectedItemTemplate>
    <asp:ImageButton id="btnCollapse" ImageUrl="~/images/minus.gif" CommandName="collapse" runat="server" />
    <!-- 
    <asp:hyperlink 
        Text='<%# DataBinder.Eval(Container.DataItem, "Title") %>' 
        NavigateUrl='<%# FormatUrl(CInt(DataBinder.Eval( _
                                        Container.DataItem, "ItemID"))) %>'
        Target="_new" runat="server" />
    -->
    <a  title='Click to read the post'
        href='<%# FormatUrl(CInt(DataBinder.Eval( _
                                  Container.DataItem, "ItemID"))) %>'
        target='_new'>
      <%# DataBinder.Eval(Container.DataItem, "Title") %>
    </a>, from
    <%# DataBinder.Eval(Container.DataItem,"CreatedByUser") %>
    , posted
    <%# DataBinder.Eval(Container.DataItem,"CreatedDate", "{0:g}") %>
    <asp:DataList
        id="DetailList"
        ItemStyle-Cssclass="Normal"
        datasource="<%# GetThreadMessages() %>"
        runat="server">
      <ItemTemplate>
        <%# FormatIndent(CInt(DataBinder.Eval(Container.DataItem, "Indent")), _
                           5, _
                           "&nbsp;") %>
        <img src="<%=Request.ApplicationPath%>/images/1x1.gif" height="15"> 
        <!--
        <asp:hyperlink 
            Text='<%# DataBinder.Eval(Container.DataItem, "Title") %>' 
            NavigateUrl='<%# FormatUrl(CInt(DataBinder.Eval( _
                                        Container.DataItem, "ItemID"))) %>' 
            Target="_new" runat="server" />
        -->
        <a  title='Click to read the post'
            href='<%# FormatUrl(CInt( _
                DataBinder.Eval(Container.DataItem, "ItemID"))) %>'
            target='_new'>
          <%# DataBinder.Eval(Container.DataItem, "Title") %>
        </a>, from
        <%# DataBinder.Eval(Container.DataItem,"CreatedByUser") %>
        , posted
        <%# DataBinder.Eval(Container.DataItem,"CreatedDate", "{0:g}") %>
      </ItemTemplate>
    </asp:DataList>
  </SelectedItemTemplate>
</asp:DataList>
