Namespace ASPNetPortal

   '*********************************************************************
   '
   ' WroxDocUtilBiz Class
   '
   ' Class for various utility functions.
   '
   '*********************************************************************    

   Public Class WroxDocUtilBiz

      '*********************************************************************
      ' GetImageFromMime Function  - Maps an image file to a mime type
      '*********************************************************************

      Public Function GetImageFromMime(ByVal strMimeType As String) As String

         Select Case strMimeType
            Case "application/pdf"
               Return "pdfsmall.gif"
            Case "application/msword"
               Return "wordsmall.gif"
            Case "application/vnd.ms-excel"
               Return "excelsmall.gif"
            Case "application/x-zip-compressed"
               Return "zipsmall.gif"

            Case Else
               Return "default.gif"
         End Select

      End Function


      '*********************************************************************
      ' HandleItemBound Function  - Used with our DataGrids to set our images
      ' and command buttons depending on the state of a document.
      '*********************************************************************

      Sub HandleItemBound(ByRef e As System.Web.UI.WebControls.DataGridItemEventArgs, ByVal IsAnonymous As Boolean)
         If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.EditItem Then
            Dim ControlName As String = ""

            'since we are using the edititemtemplate to display
            'our child grid, we need to distinguish the control names
            'to avoid duplicate names
            If e.Item.ItemType = ListItemType.EditItem Then
               ControlName = "_Edit"
            End If

            'Set the image icon to match the format
            Dim img As WebControls.Image
            img = CType(e.Item.Cells(0).FindControl("imgFormat" & ControlName), WebControls.Image)
            If Not (img Is Nothing) Then img.ImageUrl = "images/" & Me.GetImageFromMime(e.Item.DataItem("ContentType"))

            'Now set the imagebutton to indicate check in/out
            Dim imgCheck As ImageButton
            imgCheck = CType(e.Item.Cells(0).FindControl("imgCheck" & ControlName), ImageButton)

            'Check out / in command
            Dim lnkCheck As LinkButton
            lnkCheck = CType(e.Item.Cells(0).FindControl("CheckButton" & ControlName), LinkButton)

            'Check out / in command
            Dim lblMsgs As Label
            lblMsgs = CType(e.Item.Cells(0).FindControl("lblStatus" & ControlName), Label)

            'Set buttons and imgages according to Status    
            If e.Item.DataItem("Status") <> "1" Then
               ' the document is checked out
               lblMsgs.ForeColor = Color.Red
               lblMsgs.Text = "<font color='red'>This Document is Checked Out by " & _
               DataBinder.Eval(e.Item.DataItem, "CheckedUser") & "</font>"

               If Not (imgCheck Is Nothing) Then
                  imgCheck.ImageUrl = "images/checkin.gif"
                  imgCheck.CommandArgument = "checkin"
               End If

               If Not (lnkCheck Is Nothing) Then
                  lnkCheck.CommandArgument = "checkin"
                  lnkCheck.Text = "Check In"
               End If

               'disable link if anonymous
               If IsAnonymous Then
                  If Not (imgCheck Is Nothing) Then
                     imgCheck.Attributes.Add("onclick", _
                     "alert('You are not authorized to Check this document in. \nTry again after Logging in." & "');return false")
                  End If

                  If Not (lnkCheck Is Nothing) Then
                     lnkCheck.Attributes.Add("onclick", _
                     "alert('You are not authorized to Check this document in. \nTry again after Logging in." & "');return false")
                  End If

               End If

            Else ' else document is checked in
               lblMsgs.Text = "This Document is Available."
               lblMsgs.ForeColor = Color.Black

               If Not (imgCheck Is Nothing) Then
                  imgCheck.ImageUrl = "images/checkout.gif"
                  imgCheck.CommandArgument = "checkout"
               End If

               If Not (lnkCheck Is Nothing) Then
                  lnkCheck.CommandArgument = "checkout"
                  lnkCheck.Text = "Check Out"
               End If

               If IsAnonymous Then
                  If Not (imgCheck Is Nothing) Then
                     imgCheck.Attributes.Add("onclick", _
                     "alert('You are not authorized to Check this document out. \nTry again after Logging in." & "');return false")
                  End If

                  If Not (lnkCheck Is Nothing) Then
                     lnkCheck.Attributes.Add("onclick", _
                     "alert('You are not authorized to Check this document out. \nTry again after Logging in." & "');return false")
                  End If
               End If

            End If

         End If


      End Sub

   End Class
End Namespace