Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal


Namespace ASPNetPortal

    '*********************************************************************
    '
    ' DocumentDB Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' documents within the Portal database.
    '
    '*********************************************************************

    Public Class DocumentDB

        '*********************************************************************
        '
        ' GetDocuments Method
        '
        ' The GetDocuments method returns a SqlDataReader containing all of the
        ' documents for a specific portal module from the documents
        ' database.
        '
        ' Other relevant sources:
        '     + <a href="GetDocuments.htm" style="color:green">GetDocuments Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetDocuments(ByVal moduleId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetDocuments", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleId As New SqlParameter("@ModuleId", SqlDbType.Int, 4)
            parameterModuleId.Value = moduleId
            myCommand.Parameters.Add(parameterModuleId)

            ' Execute the command
            myConnection.Open()
            Dim result As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader 
            Return result

        End Function


        '*********************************************************************
        '
        ' GetSingleDocument Method
        '
        ' The GetSingleDocument method returns a SqlDataReader containing details
        ' about a specific document from the Documents database table.
        '
        ' Other relevant sources:
        '     + <a href="GetSingleDocument.htm" style="color:green">GetSingleDocument Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetSingleDocument(ByVal itemId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetSingleDocument", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterItemId As New SqlParameter("@ItemId", SqlDbType.Int, 4)
            parameterItemId.Value = itemId
            myCommand.Parameters.Add(parameterItemId)

            ' Execute the command
            myConnection.Open()
            Dim result As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader 
            Return result

        End Function


        '*********************************************************************
        '
        ' GetDocumentContent Method
        '
        ' The GetDocumentContent method returns the contents of the specified
        ' document from the Documents database table.
        '
        ' Other relevant sources:
        '     + <a href="GetDocumentContent.htm" style="color:green">GetDocumentContent</a>
        '
        '*********************************************************************

        Public Function GetDocumentContent(ByVal itemId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetDocumentContent", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterItemId As New SqlParameter("@ItemId", SqlDbType.Int, 4)
            parameterItemId.Value = itemId
            myCommand.Parameters.Add(parameterItemId)

            ' Execute the command
            myConnection.Open()
            Dim result As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader 
            Return result

        End Function


        '*********************************************************************
        '
        ' DeleteDocument Method
        '
        ' The DeleteDocument method deletes the specified document from
        ' the Documents database table.
        '
        ' Other relevant sources:
        '     + <a href="DeleteDocument.htm" style="color:green">DeleteDocument Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub DeleteDocument(ByVal itemID As Integer)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("DeleteDocument", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterItemID As New SqlParameter("@ItemID", SqlDbType.Int, 4)
            parameterItemID.Value = itemID
            myCommand.Parameters.Add(parameterItemID)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub


        '*********************************************************************
        '
        ' UpdateDocument Method
        '
        ' The UpdateDocument method updates the specified document within
        ' the Documents database table.
        '
        ' Other relevant sources:
        '     + <a href="UpdateDocument.htm" style="color:green">UpdateDocument Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdateDocument(ByVal moduleId As Integer, ByVal itemId As Integer, ByVal userName As String, ByVal name As String, ByVal url As String, ByVal category As String, ByVal content() As Byte, ByVal size As Integer, ByVal contentType As String)

            If userName.Length < 1 Then
                userName = "unknown"
            End If

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateDocument", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterItemID As New SqlParameter("@ItemID", SqlDbType.Int, 4)
            parameterItemID.Value = itemId
            myCommand.Parameters.Add(parameterItemID)

            Dim parameterModuleID As New SqlParameter("@ModuleID", SqlDbType.Int, 4)
            parameterModuleID.Value = moduleId
            myCommand.Parameters.Add(parameterModuleID)

            Dim parameterUserName As New SqlParameter("@UserName", SqlDbType.NVarChar, 100)
            parameterUserName.Value = userName
            myCommand.Parameters.Add(parameterUserName)

            Dim parameterName As New SqlParameter("@FileFriendlyName", SqlDbType.NVarChar, 150)
            parameterName.Value = name
            myCommand.Parameters.Add(parameterName)

            Dim parameterFileUrl As New SqlParameter("@FileNameUrl", SqlDbType.NVarChar, 250)
            parameterFileUrl.Value = url
            myCommand.Parameters.Add(parameterFileUrl)

            Dim parameterCategory As New SqlParameter("@Category", SqlDbType.NVarChar, 50)
            parameterCategory.Value = category
            myCommand.Parameters.Add(parameterCategory)

            Dim parameterContent As New SqlParameter("@Content", SqlDbType.Image)
            parameterContent.Value = content
            myCommand.Parameters.Add(parameterContent)

            Dim parameterContentType As New SqlParameter("@ContentType", SqlDbType.NVarChar, 50)
            parameterContentType.Value = contentType
            myCommand.Parameters.Add(parameterContentType)

            Dim parameterContentSize As New SqlParameter("@ContentSize", SqlDbType.Int, 4)
            parameterContentSize.Value = size
            myCommand.Parameters.Add(parameterContentSize)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub

    End Class

End Namespace
