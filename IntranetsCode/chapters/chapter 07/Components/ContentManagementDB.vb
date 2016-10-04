Imports System
Imports System.Web
Imports System.Web.SessionState
Imports System.Data.SqlClient

Namespace Wrox.Intranet.ContentManagement.Components
    Public Class ContentManagement

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

#Region "Content View/Add/Edit/Delete/Search Functions"

        Public Function ViewContent(ByVal ModuleID As Integer) As SqlDataReader

            Dim db As New Wrox.Intranet.DataTools.Database()
            Dim dr As SqlDataReader
            Dim params(0) As SqlParameter

            Try
                params(0) = db.MakeParameter("@ModuleID", ModuleID)
                db.RunProcedure("upContentManagement_ViewContent", params, dr)
                If dr Is Nothing Then
                    _errorMessage = db.ErrorMessage
                End If
            Catch e As Exception
                _errorMessage = "Unable to view content [" & e.Message & "]"
                dr = Nothing
            End Try

            Return dr

        End Function

        Public Function ViewMyContent(ByVal ModuleID As Integer, ByVal CreatedBy As String) As SqlDataReader

            Dim db As New Wrox.Intranet.DataTools.Database()
            Dim dr As SqlDataReader
            Dim params(1) As SqlParameter

            Try
                params(0) = db.MakeParameter("@ModuleID", ModuleID)
                params(1) = db.MakeParameter("@CreatedBy", CreatedBy)
                db.RunProcedure("upContentManagement_ViewMyContent", params, dr)
                If dr Is Nothing Then
                    _errorMessage = db.ErrorMessage
                End If
            Catch e As Exception
                _errorMessage = "Unable to view your content [" & e.Message & "]"
                dr = Nothing
            End Try

            Return dr

        End Function


        Public Function GetContent(ByVal ContentID As Integer) As SqlDataReader

            Dim db As New Wrox.Intranet.DataTools.Database()
            Dim dr As SqlDataReader
            Dim params(0) As SqlParameter

            Try
                params(0) = db.MakeParameter("@ContentID", ContentID)
                db.RunProcedure("upContentManagement_GetContent", params, dr)
                If dr Is Nothing Then
                    _errorMessage = db.ErrorMessage
                End If
            Catch e As Exception
                _errorMessage = "Unable to retrieve the content [" & e.Message & "]"
                dr = Nothing
            End Try

            Return dr

        End Function

        Public Function AddContent(ByVal ModuleID As Integer, ByVal Title As String, ByVal Summary As String, ByVal Body As String, ByVal BeginDate As Date, ByVal EndDate As Date, ByVal CreatedBy As String) As Integer

            Dim result As Integer
            Dim db As New Wrox.Intranet.DataTools.Database()
            Dim params(6) As SqlParameter

            Try
                params(0) = db.MakeParameter("@ModuleID", ModuleID)
                params(1) = db.MakeParameter("@Title", Title)
                params(2) = db.MakeParameter("@Summary", Summary)
                params(3) = db.MakeParameter("@Body", Body)
                params(4) = db.MakeParameter("@BeginDate", BeginDate)
                params(5) = db.MakeParameter("@EndDate", EndDate)
                params(6) = db.MakeParameter("@CreatedBy", CreatedBy)

                result = db.RunProcedure("upContentManagement_SaveContent", params)
                If result <= 0 Then
                    _errorMessage = db.ErrorMessage
                End If
            Catch e As Exception
                _errorMessage = "Unable to retrieve the content [" & e.Message & "]"
                result = -1
            Finally
                db = Nothing
            End Try

            Return result

        End Function

        Public Function EditContent(ByVal ID As Integer, ByVal ModuleID As Integer, ByVal Title As String, ByVal Summary As String, ByVal Body As String, ByVal BeginDate As Date, ByVal EndDate As Date, ByVal CreatedBy As String) As Integer

            Dim result As Integer
            Dim db As New Wrox.Intranet.DataTools.Database()
            Dim params(7) As SqlParameter

            Try
                params(0) = db.MakeParameter("@ID", ID)
                params(1) = db.MakeParameter("@ModuleID", ModuleID)
                params(2) = db.MakeParameter("@Title", Title)
                params(3) = db.MakeParameter("@Summary", Summary)
                params(4) = db.MakeParameter("@Body", Body)
                params(5) = db.MakeParameter("@BeginDate", BeginDate)
                params(6) = db.MakeParameter("@EndDate", EndDate)
                params(7) = db.MakeParameter("@CreatedBy", CreatedBy)
                result = db.RunProcedure("upContentManagement_EditContent", params)
                If result <= 0 Then
                    _errorMessage = db.ErrorMessage
                End If
            Catch e As Exception
                _errorMessage = "Unable to edit the content [" & e.Message & "]"
                result = -1
            Finally
                db = Nothing
            End Try

            Return result

        End Function

        Public Function DeleteContent(ByVal ID As Integer, ByVal CreatedBy As String) As Integer

            Dim result As Integer
            Dim db As New Wrox.Intranet.DataTools.Database()
            Dim params(1) As SqlParameter

            Try
                params(0) = db.MakeParameter("@ContentID", ID)
                params(1) = db.MakeParameter("@CreatedBy", CreatedBy)
                result = db.RunProcedure("upContentManagement_DeleteContent", params)
                If result <= 0 Then
                    _errorMessage = db.ErrorMessage
                End If
            Catch e As Exception
                _errorMessage = "Unable to delete the content [" & e.Message & "]"
                result = -1
            Finally
                db = Nothing
            End Try

            Return result

        End Function

        Public Function SearchContent(ByVal KeyWord As String, ByVal ModuleID As Integer) As SqlDataReader
            Dim db As New Wrox.Intranet.DataTools.Database()
            Dim dr As SqlDataReader
            Dim params(1) As SqlParameter

            Try
                params(0) = db.MakeParameter("@KeyWord", KeyWord)
                params(1) = db.MakeParameter("@ModuleID", ModuleID)
                db.RunProcedure("upContentManagement_SearchContent", params, dr)
                If dr Is Nothing Then
                    _errorMessage = db.ErrorMessage
                End If
            Catch e As Exception
                _errorMessage = "Unable to edit the content [" & e.Message & "]"
                dr = Nothing
            End Try

            Return dr
        End Function

#End Region

#Region "Add/View Related Content"
        Public Function AddRelatedContent(ByVal ContentID As Integer, ByVal RelatedContent() As Object) As Integer

            Dim result As Integer
            Dim db As New Wrox.Intranet.DataTools.Database()
            Dim params_Clear(0) As SqlParameter
            Dim params(1) As SqlParameter
            Dim Counter As Integer = 0

            Try
                params_Clear(0) = db.MakeParameter("@ContentID", ContentID)
                'Clear the existing items
                db.RunProcedure("upContentManagement_ClearRelatedContent", params_Clear)
                Do While (Counter < RelatedContent.Length)
                    params(0) = db.MakeParameter("@ContentID", ContentID)
                    params(1) = db.MakeParameter("@RelatedContentID", CType(RelatedContent(Counter), Integer))
                    result = db.RunProcedure("upContentManagement_SaveRelatedContent", params)
                    Counter += 1
                Loop
            Catch e As Exception
                _errorMessage = "Unable to edit the content [" & e.Message & "]"
                result = -1
            Finally
                db = Nothing
            End Try

            Return result

        End Function

        Public Function ViewRelatedContent(ByVal ContentID As Integer) As SqlDataReader

            Dim db As New Wrox.Intranet.DataTools.Database()
            Dim params(0) As SqlParameter
            Dim dr As SqlDataReader

            Try
                params(0) = db.MakeParameter("@ContentID", ContentID)
                db.RunProcedure("upContentManagement_ViewRelatedContent", params, dr)
                If dr Is Nothing Then
                    _errorMessage = db.ErrorMessage
                End If
            Catch e As Exception
                _errorMessage = "Unable to edit the content [" & e.Message & "]"
                dr = Nothing
            End Try

            Return dr

        End Function
#End Region

    End Class
End Namespace

