<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Page language="vb" CodeBehind="TabLayout.aspx.vb" AutoEventWireup="false" Inherits="ASPNetPortal.TabLayout" %>
<HTML>
	<HEAD>
		<%--
     The TabLayout.aspx page is used to control the layout settings of an
     individual tab within the portal.
--%>
		<link href='<%= Request.ApplicationPath & "/Portal.css" %>' type=text/css 
rel=stylesheet>
	</HEAD>
	<body bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0" marginwidth="0" marginheight="0">
		<form runat="server">
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="top">
					<td colSpan="2"><portal:banner id="Banner1" runat="server" ShowTabs="false"></portal:banner></td>
				</tr>
				<tr>
					<td><br>
						<table cellSpacing="0" cellPadding="4" width="98%">
							<tr vAlign="top">
								<td width="150">&nbsp;
								</td>
								<td width="*">
									<table cellSpacing="1" cellPadding="2" border="0">
										<tr>
											<td colSpan="5">
												<table cellSpacing="0" cellPadding="0" width="100%">
													<tr>
														<td class="Head" align="left">Tab Name and Layout
														</td>
													</tr>
													<tr>
														<td>
															<hr noShade SIZE="1">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td class="Normal" width="100">Tab Name:
											</td>
											<td colSpan="4"><asp:textbox id="tabName" runat="server" cssclass="NormalTextBox" width="300"></asp:textbox></td>
										</tr>
										<tr>
											<td class="Normal" noWrap>Authorized Roles:
											</td>
											<td colSpan="4"><asp:checkboxlist id="authRoles" runat="server" width="300" Font-Size="8pt" Font-Names="Verdana,Arial" RepeatColumns="2"></asp:checkboxlist></td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td colSpan="4">
												<hr noShade SIZE="1">
											</td>
										</tr>
										<tr>
											<td class="Normal" noWrap>Show to mobile users?:
											</td>
											<td colSpan="4"><asp:checkbox id="showMobile" runat="server" Font-Size="8pt" Font-Names="Verdana,Arial"></asp:checkbox></td>
										</tr>
										<tr>
											<td class="Normal" noWrap>Mobile Tab Name:
											</td>
											<td colSpan="4"><asp:textbox id="mobileTabName" runat="server" cssclass="NormalTextBox" width="300"></asp:textbox></td>
										</tr>
										<tr>
											<td colSpan="5">
												<hr noShade SIZE="1">
											</td>
										</tr>
										<tr>
											<td class="Normal">Add Module:
											</td>
											<td class="Normal">Module Type
											</td>
											<td colSpan="3"><asp:dropdownlist id="moduleType" runat="server" DataTextField="FriendlyName" DataValueField="ModuleDefID"></asp:dropdownlist></td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td class="Normal">Module Name:
											</td>
											<td colSpan="3"><asp:textbox id="moduleTitle" runat="server" cssclass="NormalTextBox" width="250" Text="New Module Name" EnableViewState="false"></asp:textbox></td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td colSpan="4"><asp:linkbutton class="CommandButton" id="AddModuleBtn" runat="server" Text='<img src="../images/dn.gif" border=0> Add to "Organize Modules" Below'></asp:linkbutton></td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td colSpan="4">
												<hr noShade SIZE="1">
											</td>
										</tr>
										<tr vAlign="top">
											<td class="Normal">Organize Modules:
											</td>
											<td width="120">
												<table cellSpacing="0" cellPadding="2" width="100%" border="0">
													<tr>
														<td class="NormalBold">&nbsp;Left Mini Pane
														</td>
													</tr>
													<tr vAlign="top">
														<td>
															<table cellSpacing="2" cellPadding="0" border="0">
																<tr vAlign="top">
																	<td rowSpan="2"><asp:listbox id=leftPane runat="server" width="110" DataTextField="ModuleTitle" DataValueField="ModuleId" rows="7" DataSource="<%# leftList %>"></asp:listbox></td>
																	<td vAlign="top" noWrap><asp:imagebutton id="LeftUpBtn" runat="server" AlternateText="Move selected module up in list" CommandArgument="leftPane" CommandName="up" ImageUrl="~/images/up.gif"></asp:imagebutton><br>
																		<asp:imagebutton id="LeftRightBtn" runat="server" AlternateText="Move selected module to the content pane" CommandName="right" ImageUrl="~/images/rt.gif" targetpane="contentPane" sourcepane="leftPane"></asp:imagebutton><br>
																		<asp:imagebutton id="LeftDownBtn" runat="server" AlternateText="Move selected module down in list" CommandArgument="leftPane" CommandName="down" ImageUrl="~/images/dn.gif"></asp:imagebutton>&nbsp;&nbsp;
																	</td>
																</tr>
																<tr>
																	<td vAlign="bottom" noWrap><asp:imagebutton id="LeftEditBtn" runat="server" AlternateText="Edit this item" CommandArgument="leftPane" CommandName="edit" ImageUrl="~/images/edit.gif"></asp:imagebutton><br>
																		<asp:imagebutton id="LeftDeleteBtn" runat="server" AlternateText="Delete this item" CommandArgument="leftPane" CommandName="delete" ImageUrl="~/images/delete.gif"></asp:imagebutton></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
											<td width="120">
												<table cellSpacing="0" cellPadding="2" width="100%" border="0">
													<tr>
														<td class="NormalBold">&nbsp;Content Pane
														</td>
													</tr>
													<tr>
														<td align="middle">
															<table cellSpacing="2" cellPadding="0" border="0">
																<tr vAlign="top">
																	<td rowSpan="2"><asp:listbox id=contentPane runat="server" width="110" DataTextField="ModuleTitle" DataValueField="ModuleId" rows="7" DataSource="<%# contentList %>"></asp:listbox></td>
																	<td vAlign="top" noWrap><asp:imagebutton id="ContentUpBtn" runat="server" AlternateText="Move selected module up in list" CommandArgument="contentPane" CommandName="up" ImageUrl="~/images/up.gif"></asp:imagebutton><br>
																		<asp:imagebutton id="ContentLeftBtn" runat="server" AlternateText="Move selected module to the left pane" ImageUrl="~/images/lt.gif" targetpane="leftPane" sourcepane="contentPane"></asp:imagebutton><br>
																		<asp:imagebutton id="ContentRightBtn" runat="server" AlternateText="Move selected module to the right pane" ImageUrl="~/images/rt.gif" targetpane="rightPane" sourcepane="contentPane"></asp:imagebutton><br>
																		<asp:imagebutton id="ContentDownBtn" runat="server" AlternateText="Move selected module down in list" CommandArgument="contentPane" CommandName="down" ImageUrl="~/images/dn.gif"></asp:imagebutton>&nbsp;&nbsp;
																	</td>
																</tr>
																<tr>
																	<td vAlign="bottom" noWrap><asp:imagebutton id="ContentEditBtn" runat="server" AlternateText="Edit this item" CommandArgument="contentPane" CommandName="edit" ImageUrl="~/images/edit.gif"></asp:imagebutton><br>
																		<asp:imagebutton id="ContentDeleteBtn" runat="server" AlternateText="Delete this item" CommandArgument="contentPane" CommandName="delete" ImageUrl="~/images/delete.gif"></asp:imagebutton></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
											<td width="120">
												<table cellSpacing="0" cellPadding="2" width="100%" border="0">
													<tr>
														<td class="NormalBold">&nbsp;Right Mini Pane
														</td>
													</tr>
													<tr>
														<td>
															<table cellSpacing="2" cellPadding="0" border="0">
																<tr vAlign="top">
																	<td rowSpan="2"><asp:listbox id=rightPane runat="server" width="110" DataTextField="ModuleTitle" DataValueField="ModuleId" rows="7" DataSource="<%# rightList %>"></asp:listbox></td>
																	<td vAlign="top" noWrap><asp:imagebutton id="RightUpBtn" runat="server" AlternateText="Move selected module up in list" CommandArgument="rightPane" CommandName="up" ImageUrl="~/images/up.gif"></asp:imagebutton><br>
																		<asp:imagebutton id="RightLeftBtn" runat="server" AlternateText="Move selected module to the content pane" ImageUrl="~/images/lt.gif" targetpane="contentPane" sourcepane="rightPane"></asp:imagebutton><br>
																		<asp:imagebutton id="RightRightBtn" runat="server" AlternateText="Move selected module to the footer pane" ImageUrl="~/images/rt.gif" targetpane="footerPane" sourcepane="rightPane"></asp:imagebutton><br>
																		<asp:imagebutton id="RightDownBtn" runat="server" AlternateText="Move selected module down in list" CommandArgument="rightPane" CommandName="down" ImageUrl="~/images/dn.gif"></asp:imagebutton></td>
																</tr>
																<tr>
																	<td vAlign="bottom" noWrap><asp:imagebutton id="RightEditBtn" runat="server" AlternateText="Edit this item" CommandArgument="rightPane" CommandName="edit" ImageUrl="~/images/edit.gif"></asp:imagebutton><br>
																		<asp:imagebutton id="RightDeleteBtn" runat="server" AlternateText="Delete this item" CommandArgument="rightPane" CommandName="delete" ImageUrl="~/images/delete.gif"></asp:imagebutton></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
											<td width="120">
												<table cellSpacing="0" cellPadding="2" width="100%" border="0">
													<tr>
														<td class="NormalBold">&nbsp;Footer Pane
														</td>
													</tr>
													<tr>
														<td>
															<table cellSpacing="2" cellPadding="0" border="0">
																<tr vAlign="top">
																	<td rowSpan="2"><asp:listbox id=footerPane runat="server" width="110" DataTextField="ModuleTitle" DataValueField="ModuleId" rows="7" DataSource="<%# footerList %>"></asp:listbox></td>
																	<td vAlign="top" noWrap><asp:imagebutton id="FooterUpBtn" runat="server" AlternateText="Move selected module up in list" CommandArgument="footerPane" CommandName="up" ImageUrl="~/images/up.gif"></asp:imagebutton><br>
																		<asp:imagebutton id="FooterLeftBtn" runat="server" AlternateText="Move selected module to the right pane" ImageUrl="~/images/lt.gif" targetpane="rightPane" sourcepane="footerPane"></asp:imagebutton><br>
																		<asp:imagebutton id="FooterDownBtn" runat="server" AlternateText="Move selected module down in list" CommandArgument="footerPane" CommandName="down" ImageUrl="~/images/dn.gif"></asp:imagebutton></td>
																</tr>
																<tr>
																	<td vAlign="bottom" noWrap><asp:imagebutton id="FooterEditBtn" runat="server" AlternateText="Edit this item" CommandArgument="footerPane" CommandName="edit" ImageUrl="~/images/edit.gif"></asp:imagebutton><br>
																		<asp:imagebutton id="FooterDeleteBtn" runat="server" AlternateText="Delete this item" CommandArgument="footerPane" CommandName="delete" ImageUrl="~/images/delete.gif"></asp:imagebutton></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colSpan="5">
												<hr noShade SIZE="1">
											</td>
										</tr>
										<tr>
											<td colspan="5">
												<asp:LinkButton id="applyBtn" class="CommandButton" Text="Apply Changes" runat="server" />
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
