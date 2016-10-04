Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Namespace ASPNetPortal

   Public Enum DocumentPermissions
      CheckInOutRights = 3      'check in/out ability
      DownloadandViewOnly = 2   'no check in/out ability
      ViewListingOnly = 1       'same as anonymous users
   End Enum

   '*********************************************************************
   '
   ' WroxDocSecurity 
   '
   ' Class that encapsulates all data logic necessary to add/query/delete
   ' security related functionality.
   '
   '*********************************************************************

   Public Class WroxDocSecurity
      Inherits ASPNetPortal.PortalSecurity


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

#Region "Public Retrieve Methods"


      '*********************************************************************
      ' HasDocPermissions Function  - Checks for permissions to a document
      '*********************************************************************

      Public Function HasDocPermissions(ByVal Acls As DocumentPermissions, _
                                        ByVal ItemID As Integer) As Boolean

         Dim result As Integer
         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim context As HttpContext = HttpContext.Current

         Dim params(2) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            params(1) = db.MakeParameter("@User", context.User.Identity.Name)
            params(2) = db.MakeParameter("@TargetAcl", CType(Acls, Integer))


            result = db.RunProcedure("upDMS_WroxDocsHasAcls", params)
            If result <= 0 Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to verify the permission [" & e.Message & "]"
            result = -1
         Finally
            db = Nothing
         End Try

         Return result

      End Function


      '*********************************************************************
      ' GetDocAcls Function  - gets Acls for a document
      '*********************************************************************

      Public Function GetDocAcls(ByVal ItemID As Integer) As DataSet

         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim ds As New DataSet()
         Dim params(0) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            db.RunProcedure("upDMS_GetWroxDocPermissions", params, ds)
            If ds Is Nothing Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to get the document permissions[" & e.Message & "]"
            ds = Nothing
         End Try

         Return ds

      End Function

#End Region

#Region "Public Add/Update Methods"

      '*********************************************************************
      ' AddDocAcls Function  - adds Acls for a document
      '*********************************************************************

      Public Function AddDocAcls(ByVal ItemID As Integer, ByVal RoleID As Integer) As Integer

         Dim result As Integer
         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim params(1) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            params(1) = db.MakeParameter("@RoleID", RoleID)


            result = db.RunProcedure("upDMS_AddWroxDocAcls", params)
            If result <= 0 Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to Add the permissions [" & e.Message & "]"
            result = -1
         Finally
            db = Nothing
         End Try

         Return result

      End Function

      '*********************************************************************
      ' DeleteDocAcls Function  - deletes Acls for a document
      '*********************************************************************

      Public Function DeleteDocAcls(ByVal ItemID As Integer, _
                                    ByVal RoleID As Integer) As Integer
         Dim result As Integer
         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim params(1) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            params(1) = db.MakeParameter("@RoleID", RoleID)


            result = db.RunProcedure("upDMS_DeleteWroxDocAcls", params)
            If result <= 0 Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to Delete the permission [" & e.Message & "]"
            result = -1
         Finally
            db = Nothing
         End Try

         Return result

      End Function

      '*********************************************************************
      ' UpdateDocAcls Function  - Updates Acls for a document
      '*********************************************************************

      Public Function UpdateDocAcls(ByVal ItemID As Integer, _
                                    ByVal RoleID As Integer, _
                                    ByVal Acl As Integer) As Integer

         Dim result As Integer
         Dim db As New Wrox.Intranet.DataTools.Database()
         Dim params(2) As SqlParameter

         Try
            params(0) = db.MakeParameter("@ItemID", ItemID)
            params(1) = db.MakeParameter("@RoleID", RoleID)
            params(2) = db.MakeParameter("@Acl", Acl)


            result = db.RunProcedure("upDMS_UpdateWroxDocPermission", params)
            If result <= 0 Then
               _errorMessage = db.ErrorMessage
            End If
         Catch e As Exception
            _errorMessage = "Unable to update the permission [" & e.Message & "]"
            result = -1
         Finally
            db = Nothing
         End Try

         Return result

      End Function


#End Region

   End Class
End Namespace