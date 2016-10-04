Imports System
Imports System.Web
Imports System.Text
Imports System.Web.UI
Imports System.Drawing
Imports System.Web.UI.WebControls
Imports System.Web.UI.HtmlControls
Imports System.Collections.Specialized
Imports Microsoft.VisualBasic


Namespace Wrox.Intranet.ContentManagement.Components

    Public Class RTFEditor
        Inherits System.Web.UI.Control
        Implements INamingContainer, IPostBackDataHandler

        Private ph As New PlaceHolder()

        Public ReadOnly Property RichHtml() As String
            Get
                Return CType(ViewState.Item("_text2html"), String)
            End Get
        End Property


        Public Property RichText() As String
            Get
                Dim text As String = CType(ViewState.Item("_Html2Text"), String)
                If IsNothing(text) Then
                    text = String.Empty
                End If
                Return text
            End Get
            Set(ByVal Value As String)
                ViewState.Item("_Html2Text") = Value
            End Set
        End Property


        Public Property Width() As Unit
            Get
                If (IsNothing(ViewState.Item("_Width"))) Then
                    Return New Unit("100%")
                Else
                    Return CType(ViewState.Item("_Width"), Unit)
                End If
            End Get
            Set(ByVal Value As Unit)
                ViewState.Item("_Width") = Value
            End Set
        End Property


        Public Property Height() As Unit
            Get
                If IsNothing(ViewState.Item("_Height")) Then
                    Return New Unit("100%")
                Else
                    Return CType(ViewState.Item("_Height"), Unit)
                End If

            End Get
            Set(ByVal Value As Unit)
                ViewState.Item("_Height") = Value
            End Set
        End Property

        Protected Overrides Sub CreateChildControls()

            Dim t As New Table()
            Dim tr As New TableRow()
            Dim tc As New TableCell()

            'Create a table
            t.Width = Me.Width
            t.Height = Me.Height
            t.CellPadding = 2
            t.CellSpacing = 2
            t.BorderColor = Color.Transparent
            t.Attributes.Add("Align", "left")
            t.Attributes.Add("Valign", "top")

            tr.Width = Unit.Percentage(100)
            tr.Height = Unit.Pixel(5)
            tr.HorizontalAlign = HorizontalAlign.Center

            'Add a table entry with Bold link
            tc.Attributes.Add("align", "center")
            tc.Width = Unit.Pixel(10)
            tc.Attributes.Add("align", "center")
            tc.HorizontalAlign = HorizontalAlign.Center
            tc.Controls.Add(PrepareLinkControl(HttpContext.Current.Server.MapPath("~/images/circle_b.gif"), "Bold", "Bold"))
            tr.Cells.Add(tc)

            'Add the Italic link 
            tc = New TableCell()
            tc.Width = Unit.Pixel(10)
            tc.Attributes.Add("align", "center")
            tc.HorizontalAlign = HorizontalAlign.Center
            tc.Controls.Add(PrepareLinkControl(HttpContext.Current.Server.MapPath("~/images/circle_i.gif"), "Italic", "Italic"))
            tr.Cells.Add(tc)

            'Add the Underline link 
            tc = New TableCell()
            tc.Width = Unit.Pixel(10)
            tc.Attributes.Add("align", "center")
            tc.HorizontalAlign = HorizontalAlign.Center
            tc.Controls.Add(PrepareLinkControl(HttpContext.Current.Server.MapPath("~/images/circle_ul.gif"), "underline", "Underline"))
            tr.Cells.Add(tc)


            'Add the createlink Link
            tc = New TableCell()
            tc.Width = Unit.Pixel(10)
            tc.Attributes.Add("align", "center")
            tc.HorizontalAlign = HorizontalAlign.Center
            tc.Controls.Add(PrepareLinkControl(HttpContext.Current.Server.MapPath("~/images/circle_u.gif"), "createlink", "URL"))
            tr.Cells.Add(tc)

            'Add the Numbered List Link
            tc = New TableCell()
            tc.Width = Unit.Pixel(10)
            tc.Attributes.Add("align", "center")
            tc.HorizontalAlign = HorizontalAlign.Center
            tc.Controls.Add(PrepareLinkControl(HttpContext.Current.Server.MapPath("~/images/circle_1.gif"), "insertorderedlist", "Number"))
            tr.Cells.Add(tc)

            'Add the Bullet List Link
            tc = New TableCell()
            tc.Width = Unit.Pixel(10)
            tc.Attributes.Add("align", "center")
            tc.HorizontalAlign = HorizontalAlign.Center
            tc.Controls.Add(PrepareLinkControl(HttpContext.Current.Server.MapPath("~/images/circle_bu.gif"), "insertunorderedlist", "Bullet"))
            tr.Cells.Add(tc)


            'Add the Size
            tc = New TableCell()
            tc.Attributes.Add("align", "center")
            tc.Controls.Add(PrepareDropDownList("Font Name", "FontName", "Arial, Tahoma, Verdana, Courier New,Times New Roman".Split(New Char() {","})))
            tr.Cells.Add(tc)


            'Add the Font
            tc = New TableCell()
            tc.Attributes.Add("align", "center")
            tc.Controls.Add(PrepareDropDownList("", "FontSize", "1, 2, 3, 4, 5, 6".Split(New Char() {","})))

            tr.Cells.Add(tc)

            'Add the Font Color
            tc = New TableCell()
            tc.Attributes.Add("align", "center")
            tc.Controls.Add(PrepareDropDownList("Font Color", "ForeColor", New String() {"Black", "Blue", "Green", "Orange", "Red"}))

            tr.Cells.Add(tc)


            'Add the row to the table
            tr.BackColor = System.Drawing.Color.LightGray
            t.Rows.Add(tr)

            'Add the HTML Generic Control to the table
            tr = New TableRow()
            tc = New TableCell()
            tr.Height = Unit.Percentage(98)
            tr.Width = Unit.Percentage(100)
            tc.Attributes.Add("Colspan", "9")

            Dim hg As New HtmlGenericControl()
            hg.TagName = "iframe"
            hg.ID = Me.ClientID + "_WROX_TB"
            hg.Attributes.Add("width", "100%")
            hg.Attributes.Add("Height", "100%")
            hg.Attributes.Add("OnBlur", String.Concat("PostIt", Me.ClientID, "();"))
            tc.Controls.Add(hg)
            tc.Width = Unit.Percentage(100)
            tr.Cells.Add(tc)
            t.Rows.Add(tr)

            'Add Input Hidden Field
            tr = New TableRow()
            tc = New TableCell()
            tc.Attributes.Add("Colspan", "9")

            hg = New HtmlGenericControl()
            hg.TagName = "input"
            hg.ID = Me.ClientID
            hg.Attributes.Add("name", MyBase.ClientID & "_hidden")
            hg.Attributes.Add("type", "hidden")
            hg.Attributes.Add("runat", "server")

            If Me.EnableViewState Then
                If (Me.RichHtml <> String.Empty) Then
                    hg.Attributes.Add("value", Me.RichHtml)
                Else
                    hg.Attributes.Add("value", Me.RichText)
                End If
            Else
                hg.Attributes.Add("value", Me.RichText)
            End If

            tc.Controls.Add(hg)
            tc.Width = Unit.Percentage(100)
            tr.Cells.Add(tc)
            t.Rows.Add(tr)

            ph.Controls.Add(t)


        End Sub



        Public Sub RaisePostDataChangedEvent() Implements IPostBackDataHandler.RaisePostDataChangedEvent

        End Sub

        Protected Overrides Sub Render(ByVal output As HtmlTextWriter)

            Dim t As New Table()
            Dim tr As New TableRow()
            Dim tc As New TableCell()

            t.Width = Me.Width
            t.Height = Me.Height

            tr.Width = Unit.Percentage(100)

            tc.Controls.Add(ph)
            tr.Controls.Add(tc)
            t.Controls.Add(tr)

            t.RenderControl(output)

        End Sub

        Private Function PrepareLinkControl(ByVal ImgName As String, ByVal Command As String, ByVal ToolTip As String) As System.Web.UI.Control
            Dim ib As New System.Web.UI.WebControls.Image()
            Dim sb As New StringBuilder()
            sb.Append("ExecThisCmd")
            sb.Append(Me.ClientID)
            sb.Append("('" + Command + "' ,null)")
            ib.ToolTip = ToolTip
            ib.Attributes.Add("unselectable", "on")
            ib.Attributes.Add("OnClick", sb.ToString())
            ib.BorderWidth = New Unit(0)
            ib.ImageUrl = ImgName
            Return ib
        End Function



        Private Function PrepareDropDownList(ByVal Name As String, ByVal Command As String, ByVal ItemArray As String()) As System.Web.UI.Control

            Dim dl As New DropDownList()

            dl.Attributes.Add("onchange", String.Concat(New String() {"ExecThisCmd", Me.ClientID, "('", Command, "',this[this.selectedIndex].value);"}))
            dl.Items.Add(New ListItem("- " + Name + " -", ""))
            Dim i As Integer = 0
            Do While (i < ItemArray.Length)
                Dim str3 As String
                Dim str2 As String = ItemArray(i)

                If (i < ItemArray.Length) Then
                    str3 = ItemArray(i)
                Else
                    str3 = str2
                End If
                Dim listItem2 As New ListItem(str2, str3)
                dl.Items.Add(listItem2)
                i = i + 1
            Loop

            Return dl

        End Function


        Public Function LoadPostData(ByVal postDataKey As String, ByVal values As NameValueCollection) As Boolean Implements IPostBackDataHandler.LoadPostData

            Dim htmlstring As String = values(MyBase.ClientID & "_hidden")

            If htmlstring <> String.Empty Then
                ViewState.Add("_text2html", htmlstring)
                Return True
            End If

            Return False

        End Function



        Protected Overrides Sub OnPreRender(ByVal e As EventArgs)

            Dim sb As New StringBuilder()

            If (Not Me.Visible) Then
                Exit Sub
            End If
            Me.Page.RegisterRequiresPostBack(Me)
            sb.Append(ControlChars.CrLf & "<script language='javaScript'>" & ControlChars.CrLf)
            sb.Append(PrepareBrowserMsgJs())
            sb.Append(ControlChars.CrLf & "</script>" & ControlChars.CrLf)
            Me.Page.RegisterStartupScript("WROXTextBoxOnLoad", sb.ToString())

        End Sub

        Private Function PreparePostItJs() As String

            Dim sb As New StringBuilder()

            sb.Append(ControlChars.CrLf & "function PostIt" + Me.ClientID + "()" & ControlChars.CrLf)
            sb.Append("{" & ControlChars.CrLf)
            sb.Append("document.getElementById('" + Me.ClientID + "_hidden').value = ")
            sb.Append(Me.ClientID + "_WROX_TB.document.body.innerHTML;" & ControlChars.CrLf)
            sb.Append("}")
            Return sb.ToString()

        End Function

        Private Function PrepareCmdExecJs() As String

            Dim stringBuilder As New stringBuilder()
            stringBuilder.Append("function ExecThisCmd" + Me.ClientID + "(command, arg)" & ControlChars.CrLf)
            stringBuilder.Append("{" & ControlChars.CrLf)
            stringBuilder.Append("if (arg == null)" & ControlChars.CrLf)
            stringBuilder.Append("{")
            stringBuilder.Append(Me.ClientID + "_WROX_TB.document.execCommand(command);" & ControlChars.CrLf)
            stringBuilder.Append("}")
            stringBuilder.Append("else")
            stringBuilder.Append("{")
            stringBuilder.Append(Me.ClientID + "_WROX_TB.document.execCommand(command, '', arg);" & ControlChars.CrLf)
            stringBuilder.Append("}")
            stringBuilder.Append(Me.ClientID + "_WROX_TB.focus();" & ControlChars.CrLf & "}" & ControlChars.CrLf)
            Return stringBuilder.ToString()

        End Function



        Private Function PrepareBrowserMsgJs() As String

            Dim hbc As New HttpBrowserCapabilities()

            Dim sb As New StringBuilder()

            hbc = HttpContext.Current.Request.Browser

            If ((hbc.MajorVersion < 5) Or (hbc.Browser <> "IE") Or ((hbc.Platform <> "Win95" And hbc.Platform <> "Win98" And hbc.Platform <> "WinNT"))) Then
                sb.Append(ControlChars.CrLf)
                sb.Append("alert('You cannot use this HTML Editor due to one of the following reasons: \r\n 1. Your browser is not Microsoft Internet Explorer \r\n 2. Your operating system is not windows based (such as Windows 98) \r\n 3. You do not have Windows 98 or later version on your system \r\n 4. You have Internet Explorer with version earlier than 5.X \r\n Sorry for the inconvenience!');")
                sb.Append(ControlChars.CrLf)
                ph.Visible = False
            Else
                sb.Append(Me.ClientID + "_WROX_TB.document.designMode ='On';" & ControlChars.CrLf)
                sb.Append("if (document.getElementById('" + Me.ClientID + "') && " & " document.getElementById('" + Me.ClientID + "').value.length > 0)" & ControlChars.CrLf)
                sb.Append("{" & ControlChars.CrLf & Me.ClientID & "_WROX_TB.document.open()" & ControlChars.CrLf)
                sb.Append(ControlChars.CrLf & Me.ClientID & "_WROX_TB.document.write(document.getElementById('" + Me.ClientID + "').value)" & ControlChars.CrLf)
                sb.Append(ControlChars.CrLf + Me.ClientID + "_WROX_TB.document.close()" & ControlChars.CrLf)
                sb.Append("}" & ControlChars.CrLf)
                sb.Append(Me.ClientID + "_WROX_TB.document.focus();" & ControlChars.CrLf)
                sb.Append(PrepareCmdExecJs())
                sb.Append(PreparePostItJs())
            End If

            Return sb.ToString()

        End Function

    End Class
End Namespace

