Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal


Namespace ASPNetPortal

   '*********************************************************************
   '
   ' WroxDocsDB Class
   '
   ' Class that encapsulates all data logic necessary to add/query/delete
   ' documents within the Portal database.
   '
   '*********************************************************************

   Public Class WroxDocsDB

#Region "Private Fields"
      Private _errorMessage As String
#End Region

#Region "Public Read Only Properties"
      Public ReadOnly Property ErrorMessage() As String
         Get
            Return _errorMessage
         End Get
      End Property
#End Region

#Region "Public Add/Update Methods"

      '*********************************************************************
      ' UploadDocument Sub
      '*********************************************************************

      Public Function UploadDocument(ByVal ModuleID As Integer, _
                                ByVal ItemID As Integer, _
                                ByVal UserName As String, _
                                ByVal FileName As String, _
                                ByVal Name As String, _
                                ByVal Category As String, _
                                ByVal Content() As Byte, _
                                ByVal Size As Integer, _
                                ByVal ContentType As String) As Integer

         Dim result As Integer
         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim params(8) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ModuleID", ModuleID)
            params(1) = db.MakeParameter("@ItemID", ItemID)
            params(2) = db.MakeParameter("@UserName", UserName)
            params(3) = db.MakeParameter("@FileName", FileName)
            params(4) = db.MakeParameter("@FileDesc", Name)
            params(5) = db.MakeParameter("@Category", Category)
            params(6) = db.MakeParameter("@Content", Content)
            params(6).SqlDbType = SqlDbType.Image
            params(7) = db.MakeParameter("@ContentType", ContentType)
            params(8) = db.MakeParameter("@ContentSize", Size)


            result = db.RunProcedure("upDMS_UploadWroxDoc", params)
            If result <= 0 Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to upload the document [" & e.Message & "]"
            result = -1
         Finally
            db = Nothing
         End Try

         Return result

      End Function


      '*********************************************************************
      ' UpdateDocument Sub
      '*********************************************************************

      Public Function UpdateDocument(ByVal ItemID As Integer, _
                                ByVal Name As String, _
                                ByVal Category As String) As Integer

         Dim result As Integer
         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim params(2) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            params(1) = db.MakeParameter("@FileDesc", Name)
            params(2) = db.MakeParameter("@Category", Category)


            result = db.RunProcedure("upDMS_UpdateWroxDoc", params)
            If result <= 0 Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to update the document [" & e.Message & "]"
            result = -1
         Finally
            db = Nothing
         End Try

         Return result

      End Function


      '*********************************************************************
      ' RenderDocument Sub
      '*********************************************************************

      Public Function RenderDocument(ByVal ItemID As Integer, ByVal strTable As String, ByRef response As HttpResponse) As Integer

         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim dr As SqlDataReader
         Dim params(1) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            params(1) = db.MakeParameter("@Table", strTable)
            db.RunProcedure("upDMS_RenderWroxDoc", params, dr)
            If dr Is Nothing Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to retrieve the document [" & e.Message & "]"
            dr = Nothing
         End Try

         dr.Read()

         response.AddHeader("Content-Disposition", "inline;filename=" & dr("filename"))
         'NOTE: could also use "attachment" instead of "inline"

         response.ContentType = CType(dr("ContentType"), String)
         response.OutputStream.Write(CType(dr("Content"), Byte()), 0, CInt(dr("ContentSize")))

         dr.Close()
         response.End()

      End Function


      '*********************************************************************
      ' ArchiveDocument Sub  - Changes the Status of a document from current.
      '*********************************************************************

      Public Function ArchiveDocument(ByVal ItemID As Integer) As Integer
         Dim result As Integer
         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim params(0) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)

            result = db.RunProcedure("upDMS_ArchiveWroxDoc", params)
            If result <= 0 Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to archive the document [" & e.Message & "]"
            result = -1
         Finally
            db = Nothing
         End Try

         Return result

      End Function

      '*********************************************************************
      ' CheckInDocument Sub - 
      '*********************************************************************

      Public Function CheckInDocument(ByVal ItemID As Integer, _
                        ByVal UserName As String, _
                        ByVal FileName As String, _
                        ByVal Content() As Byte, _
                        ByVal Size As Integer, _
                        ByVal ContentType As String) As Integer

         Dim result As Integer
         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim params(5) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            params(1) = db.MakeParameter("@UserName", UserName)
            params(2) = db.MakeParameter("@FileName", FileName)
            params(3) = db.MakeParameter("@Content", Content)
            params(3).SqlDbType = SqlDbType.Image
            params(4) = db.MakeParameter("@ContentType", ContentType)
            params(5) = db.MakeParameter("@ContentSize", Size)


            result = db.RunProcedure("upDMS_CheckInWroxDoc", params)
            If result <= 0 Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to check the document in[" & e.Message & "]"
            result = -1
         Finally
            db = Nothing
         End Try

         Return result


      End Function

      '*********************************************************************
      ' CheckOutDocument Sub  
      '*********************************************************************

      Public Function CheckOutDocument(ByVal ItemID As Integer, _
                        ByVal UserName As String) As Integer

         Dim result As Integer
         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim params(1) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            params(1) = db.MakeParameter("@UserName", UserName)


            result = db.RunProcedure("upDMS_CheckOutWroxDoc", params)
            If result <= 0 Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to check the document out [" & e.Message & "]"
            result = -1
         Finally
            db = Nothing
         End Try

         Return result

      End Function

#End Region

#Region "Public Retrieve Methods"
      '*********************************************************************
      ' GetDocuments Function  - Get all documents for a module
      '*********************************************************************

      Public Function GetDocuments(ByVal ModuleID As Integer) As DataSet

         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim ds As New DataSet()
         Dim params(0) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ModuleId", ModuleID)
            db.RunProcedure("upDMS_GetWroxDocs", params, ds)
            If ds Is Nothing Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to retrieve documents[" & e.Message & "]"
            ds = Nothing
         End Try

         Return ds

      End Function


      '*********************************************************************
      ' GetChildDocuments Function  - Get versions of a Document
      '*********************************************************************

      Public Function GetChildDocuments(ByVal ItemID As Integer) As DataSet

         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim ds As New DataSet()
         Dim params(0) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            db.RunProcedure("upDMS_GetChildWroxDocs", params, ds)
            If ds Is Nothing Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to retrieve document[" & e.Message & "]"
            ds = Nothing
         End Try

         Return ds


      End Function


      '*********************************************************************
      ' GetSingleDocument Function
      '*********************************************************************

      Public Function GetSingleDocument(ByVal ItemID As Integer) As SqlDataReader

         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim dr As SqlDataReader
         Dim params(0) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            db.RunProcedure("upDMS_GetSingleWroxDoc", params, dr)
            If dr Is Nothing Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to get the document [" & e.Message & "]"
            dr = Nothing
         End Try

         Return dr

      End Function

#End Region

   End Class

End Namespace
