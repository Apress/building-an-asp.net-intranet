<%@ Page CodeBehind="NotImplemented.aspx.vb" language="vb" AutoEventWireup="false" Inherits="ASPNetPortal.NotImplemented" %>
<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ OutputCache Duration="600" VaryByParam="title" %>

<%--

   This page is the target for the fictious links in the sample data.

--%>

<HTML>
  <HEAD>
        <title>IBuySpy Portal: Content Not Implemented</title>
        <link rel="stylesheet" href='<%= Request.ApplicationPath & "/Portal.css" %>' type="text/css">
  </HEAD>
    <body leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0" marginheight="0" marginwidth="0">
        <form runat="server">
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr valign="top">
                    <td colspan="2">
                        <portal:Banner runat="server" id="Banner1" />
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <center>
                            <br>
                            <table width="500" border="0">
                                <tr>
                                    <td class="Normal">
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <span id="title" class="Head" runat="server">Linked Content Not Provided</span>
                                        <br>
                                        <br>
                                        <hr noshade size="1">
                                        <br>
                                        The link you clicked was provided as a part of the sample data for the <b>IBuySpy</b>
                                        company portal. The content for this link is not provided as part of the sample
                                        application.
                                        <br>
                                        <br>
                                        <a href="<%=Request.ApplicationPath%>/DesktopDefault.aspx">Return to Portal Home</a>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</HTML>
