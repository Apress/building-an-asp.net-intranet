<%@ Page language="vb" CodeBehind="ContentSearch.aspx.vb" AutoEventWireup="false" Inherits="Wrox.Intranet.ContentManagement.Pages.ContentSearch" %>
<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<HTML>
	<HEAD>
		<link rel="stylesheet" href='<%= Request.ApplicationPath & "/Portal.css" %>' type="text/css" >
	</HEAD>
	<body leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0" marginheight="0" marginwidth="0">
		<form runat="server">
			<table width="100%" cellspacing="0" cellpadding="0" border="0">
				<tr valign="top">
					<td colspan="2">
						<portal:Banner id="SiteHeader" runat="server" />
					</td>
				</tr>
				<tr>
					<td>
						<br>
						<table width="98%" cellspacing="0" cellpadding="4" border="0">
							<tr valign="top">
								<td width="100">
									&nbsp;
								</td>
								<td width='*'>
									<table width="750">
										<!-- Add the main content here -->
										<tr>
											<td class="Head" vAlign="top" width="100%">Search Content
											</td>
										</tr>
										<tr>
											<td>
												<hr noshade size="1">
											</td>
										</tr>
										<tr>
											<td width="100%"><asp:label id="ErrorMessage" CssClass="NormalRed" Runat="server"></asp:label></td>
										</tr>
										<tr>
											<td width="100%" valign="top" class="Normal">
												This page let's you to search through the content and news items.
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%">
													<tr>
														<td class="Normal">
															Keyword
														</td>
														<td>
															<asp:TextBox id="KeyWord" columns="20" width="262px" cssclass="NormalTextBox" runat="server" />
															<br>
															<asp:RequiredFieldValidator Display="Dynamic" CssClass="normal" ControlToValidate="KeyWord" Runat="server" ID="valKeyWord" ErrorMessage="Enter a keyword"></asp:RequiredFieldValidator>
														</td>
													</tr>
													<tr class="CommandButton">
														<td colspan="2" align="right">
															<asp:Button ID="search" ForeColor="darkred" Runat="server" CssClass="CommandButton" Text="Search" BackColor="White" BorderColor="Transparent" BorderStyle="None"></asp:Button>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<hr noshade size="1">
											</td>
										</tr>
										<tr>
											<td vAlign="top" width="100%">
												<asp:DataList id="myDataList" CellPadding="4" Width="98%" EnableViewState="false" runat="server">
													<ItemTemplate>
														<span class="ItemTitle">
															<a href='<%# "GetContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & DataBinder.Eval(Container.DataItem,"ModuleID")  %>'>
																<asp:Label Text='<%# DataBinder.Eval(Container.DataItem,"Title") %>' runat="server" ID="Label1"/>
															</a>
														</span>
														<br>
														<span class="Normal">
															<i>
																<%# DataBinder.Eval(Container.DataItem,"BeginDate", "{0:d}") %>
															</i>
														</span>
														<br>
														<span class="Normal">
															<%# DataBinder.Eval(Container.DataItem,"Summary") %>
														</span>
													</ItemTemplate>
													<AlternatingItemStyle BackColor="lightGray"></AlternatingItemStyle>
													<AlternatingItemTemplate>
														<span class="ItemTitle">
															<a href='<%# "GetContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & DataBinder.Eval(Container.DataItem,"ModuleID")  %>'>
																<asp:Label Text='<%# DataBinder.Eval(Container.DataItem,"Title") %>' runat="server" ID="Label2"/>
															</a>
														</span>
														<br>
														<span class="Normal">
															<i>
																<%# DataBinder.Eval(Container.DataItem,"BeginDate", "{0:d}") %>
															</i>
														</span>
														<br>
														<span class="Normal">
															<%# DataBinder.Eval(Container.DataItem,"Summary") %>
														</span>
													</AlternatingItemTemplate>
												</asp:DataList>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
