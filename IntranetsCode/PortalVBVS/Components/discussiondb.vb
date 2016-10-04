Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Imports ASPNetPortal
Imports Wrox.Intranet


Namespace ASPNetPortal

  '*********************************************************************
  '
  ' DiscussionDB Class
  '
  ' Class that encapsulates all data logic necessary to add/query/delete
  ' discussions within the Portal database.
  '
  '*********************************************************************

  Friend Class DiscussionDB


    '*******************************************************
    '
    ' GetDataReader Function
    '
    ' Because several of our functions call a stored procedure
    ' and pass it simple input parameters to get back a DataReader,
    ' we'll abstract the functionality into a helper method.
    '
    '*******************************************************

    'Private Shared Function GetDataReader(ByVal ProcedureName As String, _
    '                      ByVal Parameters() As SqlClient.SqlParameter) _
    '                      As SqlDataReader

    '  ' Create an instance of our database class
    '  Dim db As New Wrox.Intranet.Database()

    '  ' Get the results (passing in the default procedure variable)
    '  db.RunProcedure(ProcedureName, Parameters, GetDataReader)

    '  ' When the function ends it will automatically return the data reader
    '  ' in the default procedure variable
    'End Function


    '*******************************************************
    '
    ' GetDataReader Function (Overload)
    '
    ' Now we'll overload it to take a single parameter as
    ' a name and value pair.
    '
    '*******************************************************

    'Private Shared Function GetDataReader(ByVal ProcedureName As String, _
    '                                  ByVal ParameterName As String, _
    '                                  ByVal ParameterValue As Object) _
    '                                  As SqlDataReader
    '  'Create the single element parameter array
    '  Return GetDataReader(ProcedureName, _
    '                        New SqlParameter() _
    '                        {New SqlParameter(ParameterName, ParameterValue)})

    'End Function


    '*******************************************************
    '
    ' GetTopLevelMessages Method
    '
    ' Returns details for all of the messages in the discussion specified by ModuleID.
    '
    ' Other relevant sources:
    '     + <a href="GetTopLevelMessages.htm" style="color:green">GetTopLevelMessages Stored Procedure</a>
    '
    '*******************************************************

    Public Shared Function GetTopLevelMessages( _
                              ByVal moduleId As Integer) _
                              As SqlDataReader

      ' Create an instance of our database class
            Dim db As New Wrox.Intranet.DataTools.Database()

      ' Get the results (passing in the default procedure variable)
      db.RunProcedure("GetTopLevelMessages", _
                        New SqlParameter() _
                        {db.MakeParameter("@ModuleId", moduleId)}, _
                        GetTopLevelMessages)

      ' When the function ends it will automatically return the data reader
      ' in the default procedure variable
    End Function


    '*******************************************************
    '
    ' GetThreadMessages Method
    '
    ' Returns details for all of the messages the thread, as identified by the Parent id string.
    '
    ' Other relevant sources:
    '     + <a href="GetThreadMessages.htm" style="color:green">GetThreadMessages Stored Procedure</a>
    '
    '*******************************************************

    Public Shared Function GetThreadMessages(ByVal threadId As Integer) _
                                                    As SqlDataReader

      ' Create an instance of our database class
            Dim db As New Wrox.Intranet.DataTools.Database()

      ' Get the results (passing in the default procedure variable)
      db.RunProcedure("GetThreadMessages", _
                        New SqlParameter() _
                        {db.MakeParameter("@ThreadID", threadId)}, _
                        GetThreadMessages)

      ' When the function ends it will automatically return the data reader
      ' in the default procedure variable
    End Function


    '*******************************************************
    '
    ' GetSingleMessage Method
    '
    ' The GetSingleMessage method returns the details for the message
    ' specified by the itemId parameter.
    '
    ' Other relevant sources:
    '     + <a href="GetSingleMessage.htm" style="color:green">GetSingleMessage Stored Procedure</a>
    '
    '*******************************************************

    Public Shared Function GetSingleMessage(ByVal moduleId As Integer, _
                                              ByVal itemId As Integer) _
                                              As SqlDataReader
      ' Create an instance of our database class
            Dim db As New Wrox.Intranet.DataTools.Database()

      ' Get the results (passing in the default procedure variable)
      db.RunProcedure("GetSingleMessage", _
                        New SqlParameter() _
                        {db.MakeParameter("@ModuleId", moduleId), _
                        db.MakeParameter("@ItemId", itemId)}, _
                        GetSingleMessage)

      ' When the function ends it will automatically return the data reader
      ' in the default procedure variable
    End Function


    '*********************************************************************
    '
    ' AddMessage Method
    '
    ' The AddMessage method adds a new message within the
    ' Discussions database table, and returns ItemID value as a result.
    '
    ' Other relevant sources:
    '     + <a href="AddMessage.htm" style="color:green">AddMessage Stored Procedure</a>
    '
    '*********************************************************************

    Public Shared Function AddMessage(ByVal moduleId As Integer, _
                                ByVal parentId As Integer, _
                                ByVal userName As String, _
                                ByVal title As String, _
                                ByVal body As String) As Integer

      If userName.Length < 1 Then
        userName = "unknown"
      End If

      ' Create an instance of our database class
            Dim db As New Wrox.Intranet.DataTools.Database()

      'Create the parameter array
      Dim parameters() As SqlParameter = { _
              db.MakeParameter("@ItemID", ParameterDirection.Output, 0), _
              db.MakeParameter("@Title", title), _
              db.MakeParameter("@Body", body), _
              db.MakeParameter("@ParentID", parentId), _
              db.MakeParameter("@UserName", userName), _
              db.MakeParameter("@ModuleID", moduleId) _
              }

      ' Run the stored procedure
      db.RunProcedure("AddMessage", parameters)

      'Now get back the itemId
      AddMessage = CInt(parameters(0).Value)

      'Close everything up
      db.Close()

      ' When the function ends it will automatically return the integer
      ' value in the default procedure variable
    End Function
  End Class

End Namespace
