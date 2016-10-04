<%@ Page language="vb" CodeBehind="RelatedContent.aspx.vb" AutoEventWireup="false" Inherits="Wrox.Intranet.ContentManagement.Pages.RelatedContent" %>
<%@ Register TagPrefix="portal" TagName="Banner" Src="~/DesktopPortalBanner.ascx" %>
<%@ Register TagPrefix="Wrox" TagName="Actions" Src="ContentActionTabs.ascx"%>
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
											<td class="Head" vAlign="top" width="100%">Related Content
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
												Using this page you can view all related content for a selected content item.
											</td>
										</tr>
										<tr>
											<td vAlign="top" width="100%">
												<asp:DataList id="myDataList" CellPadding="4" Width="98%" EnableViewState="false" runat="server">
													<ItemTemplate>
														<span class="ItemTitle">
															<asp:Label Text='<%# DataBinder.Eval(Container.DataItem,"Title") %>' runat="server" ID="Label1"/>
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
														<br>
														<p align="right">
															<Wrox:Actions Id="Actions2" runat=server ReadText="Read" ReadUrl='<%# "GetContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & DataBinder.Eval(Container.DataItem,"ModuleID")  %>' RelatedContentText="Related Content" RelatedContentUrl='<%# "RelatedContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & DataBinder.Eval(Container.DataItem,"ModuleID")  %>' />
														</p>
													</ItemTemplate>
													<AlternatingItemStyle BackColor="lightGray"></AlternatingItemStyle>
													<AlternatingItemTemplate>
														<span class="ItemTitle">
															<asp:Label Text='<%# DataBinder.Eval(Container.DataItem,"Title") %>' runat="server" ID="Label2"/>
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
														<br>
														<p align="right">
															<Wrox:Actions Id="Actions1" runat=server ReadText="Read" ReadUrl='<%# "GetContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & DataBinder.Eval(Container.DataItem,"ModuleID")  %>' RelatedContentText="Related Content" RelatedContentUrl='<%# "RelatedContent.aspx?ItemID=" & DataBinder.Eval(Container.DataItem,"ID") & "&mid=" & DataBinder.Eval(Container.DataItem,"ModuleID")  %>' />
														</p>
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
