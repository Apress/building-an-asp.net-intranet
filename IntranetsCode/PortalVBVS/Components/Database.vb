Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration

Namespace Wrox.Intranet.DataTools

    Public Class Database
        Implements IDisposable

#Region "Private Fields"
        'connection to data source
        Private con As SqlConnection
        'Error Message field
        Private _errorMessage As String
#End Region

#Region "Public Properties"

        Public ReadOnly Property ErrorMessage() As String
            Get
                Return _errorMessage
            End Get
        End Property

        Public Shared ReadOnly Property ConnectionString() As String
            Get
                'Return System.Configuration.ConfigurationSettings.AppSettings("Database.DEFAULT_CONNECTION_STRING")
                Return System.Configuration.ConfigurationSettings.AppSettings _
                                                            ("ConnectionString")
            End Get
        End Property

#End Region

#Region "Public Method Implementations"

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'This function takes a stored proc name and returns an integer '
        'by invoking ExecuteScalar() on the SqlCommand type instance   '
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Public Function RunProcedure(ByVal procName As String) As Integer
            Dim result As Integer
            Dim cmd As SqlCommand

            Try
                cmd = CreateCommand(procName, Nothing)
                result = CType(cmd.ExecuteScalar(), Integer)

            Catch e As Exception
                result = -1
                _errorMessage = e.Message

            Finally
                Me.Close()

            End Try

            Return result

        End Function

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'This function takes a stored proc name, sql parameters returns an integer '
        'by invoking ExecuteScalar() on the SqlCommand type instance               '
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Public Function RunProcedure(ByVal procName As String, ByVal prams As SqlParameter()) As Integer
            Dim result As Integer
            Dim cmd As SqlCommand

            Try

                cmd = CreateCommand(procName, prams)
                result = cmd.ExecuteScalar()

            Catch e As Exception
                result = -1
                _errorMessage = e.Message

            Finally
                Me.Close()

            End Try

            Return result

        End Function

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'This method takes a stored proc name and a SqlDataReader (BY REF) and returns the results    '
        'in the same DataReader that you pass in as ref. This invokes ExecuteReader on SqlCommand type'
        'instance                                                                                     '
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Public Sub RunProcedure(ByVal procName As String, ByRef dataReader As SqlDataReader)
            Dim cmd As SqlCommand
            Try
                cmd = CreateCommand(procName, Nothing)
                dataReader = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

            Catch e As Exception
                dataReader = Nothing
                _errorMessage = e.Message
                Me.Close()

            End Try
        End Sub

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'This method takes a stored proc name, Sql Parameters and a SqlDataReader (BY REF) and         '
        'returns the results in the same DataReader that you pass in as ref. This invokes ExecuteReader'
        'on SqlCommand type instance                                                                   '
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Public Sub RunProcedure(ByVal procName As String, ByVal prams As SqlParameter(), ByRef dataReader As SqlDataReader)
            Dim cmd As SqlCommand
            Try
                cmd = CreateCommand(procName, prams)
                dataReader = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

            Catch e As Exception
                dataReader = Nothing
                _errorMessage = e.Message
                Me.Close()
            End Try

        End Sub

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'This method takes a stored proc name, Sql Parameters and a DataSet ByRef      '
        'In case of an exception returns a Nothing and ErrorMessage                    '
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Public Sub RunProcedure(ByVal procName As String, ByVal prams As SqlParameter(), ByRef ds As DataSet)
            Dim cmd As SqlCommand
            Dim adapter As SqlDataAdapter
            Try
                cmd = CreateCommand(procName, prams)
                adapter = New SqlDataAdapter(cmd)
                adapter.Fill(ds)
            Catch e As Exception
                _errorMessage = e.Message
                ds = Nothing
            Finally
                adapter = Nothing
                Me.Close()
            End Try

        End Sub


        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'This method takes a stored proc name and a Dataset by Ref     '
        'In case of an exception returns a Nothing and ErrorMessage    '
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Public Sub RunProcedure(ByVal procName As String, ByRef ds As DataSet)

            Dim cmd As SqlCommand
            Dim adapter As SqlDataAdapter

            Try
                cmd = CreateCommand(procName, Nothing)
                adapter = New SqlDataAdapter(cmd)
                adapter.Fill(ds)
            Catch e As Exception
                _errorMessage = e.Message
                ds = Nothing
            Finally
                adapter = Nothing
                Me.Close()
            End Try

        End Sub

        Public Function MakeParameter(ByVal ParamName As String, ByVal Value As Object) As SqlParameter
            Dim param As SqlParameter

            param = New SqlParameter(ParamName, Value)
            param.Direction = ParameterDirection.Input

            Return param

        End Function

        Public Function MakeParameter(ByVal ParamName As String, ByVal Direction As ParameterDirection, ByVal Value As Object) As SqlParameter
            Dim param As SqlParameter

            param = New SqlParameter(ParamName, Value)
            param.Direction = Direction

            Return param

        End Function


        Public Sub Close()
            If (con Is Nothing) Then
            Else
                con.Close()
            End If
        End Sub

        Public Sub Dispose() Implements IDisposable.Dispose

            If (con Is Nothing) Then
            Else
                con.Dispose()
                con = Nothing
            End If

        End Sub

#End Region

#Region "Private Method Implementations"

        Private Function CreateCommand(ByVal procName As String, ByVal prams As SqlParameter()) As SqlCommand

            Dim cmd As SqlCommand
            Dim parameter As SqlParameter

            Call Open()

            cmd = New SqlCommand(procName, con)

            cmd.CommandType = CommandType.StoredProcedure

            If (prams Is Nothing) Then
            Else
                For Each parameter In prams
                    cmd.Parameters.Add(parameter)
                Next

            End If

            Return cmd

        End Function


        Private Sub Open()
            If (con Is Nothing) Then
                con = New SqlConnection(Me.ConnectionString())
                con.Open()
            Else
                If ((con.State = ConnectionState.Closed) Or (con.State = ConnectionState.Broken)) Then
                    con.Open()
                End If
            End If
        End Sub
#End Region


    End Class

End Namespace
