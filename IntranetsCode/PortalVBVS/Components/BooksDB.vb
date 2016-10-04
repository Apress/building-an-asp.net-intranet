Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient


Namespace ASPNetPortal

   '*********************************************************************
   '
   ' BooksDB Class
   '
   ' Class that encapsulates all data logic necessary to add/query/delete
   ' books within the Portal database.
   '
   '*********************************************************************

   Public Class BooksDB

      '*********************************************************************
      '
      ' GetBooks Method
      '
      ' The GetBooks method returns a DataSet containing all of the
      ' Books for a specific portal module from the Books
      ' database table.
      '
      ' NOTE: A DataSet is returned from this method to allow this method to support
      ' both desktop and mobile Web UI.
      '
      ' Other relevant sources:
      '     + <a href="GetBooks.htm" style="color:green">GetBooks Stored Procedure</a>
      '
      '*********************************************************************

      Public Function GetBooks(ByVal moduleId As Integer) As DataSet

         ' Create Instance of Connection and Command Object
         Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
         Dim myCommand As New SqlDataAdapter("GetBooks", myConnection)

         ' Mark the Command as a SPROC
         myCommand.SelectCommand.CommandType = CommandType.StoredProcedure

         ' Add Parameters to SPROC
         Dim parameterModuleId As New SqlParameter("@ModuleId", SqlDbType.Int, 4)
         parameterModuleId.Value = moduleId
         myCommand.SelectCommand.Parameters.Add(parameterModuleId)

         ' Create and Fill the DataSet
         Dim myDataSet As New DataSet()
         myCommand.Fill(myDataSet)

         ' Return the DataSet
         Return myDataSet

      End Function


      '*********************************************************************
      '
      ' GetSingleBook Method
      '
      ' The GetSingleBook method returns a SqlDataReader containing details
      ' about a specific Book from the Books database table.
      '
      ' Other relevant sources:
      '     + <a href="GetSingleBook.htm" style="color:green">GetSingleBook Stored Procedure</a>
      '
      '*********************************************************************

      Public Function GetSingleBook(ByVal itemId As Integer) As SqlDataReader

         ' Create Instance of Connection and Command Object
         Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
         Dim myCommand As New SqlCommand("GetSingleBook", myConnection)

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
      ' DeleteBook Method
      '
      ' The DeleteBook method deletes the specified Book from
      ' the Books database table.
      '
      ' Other relevant sources:
      '     + <a href="DeleteBook.htm" style="color:green">DeleteBook Stored Procedure</a>
      '
      '*********************************************************************

      Public Sub DeleteBook(ByVal itemID As Integer)

         ' Create Instance of Connection and Command Object
         Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
         Dim myCommand As New SqlCommand("DeleteBook", myConnection)

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
      ' AddBook Method
      '
      ' The AddBook method adds a new Book to the
      ' Books database table, and returns the ItemId value as a result.
      '
      ' Other relevant sources:
      '     + <a href="AddBook.htm" style="color:green">AddBook Stored Procedure</a>
      '
      '*********************************************************************

      Public Function AddBook(ByVal moduleId As Integer, ByVal itemId As Integer, ByVal userName As String, ByVal title As String, ByVal imageUrl As String, ByVal authors As String, ByVal price As String, ByVal isbn As String, ByVal buyLink As String) As Integer

         If userName.Length < 1 Then
            userName = "unknown"
         End If

         ' Create Instance of Connection and Command Object
         Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
         Dim myCommand As New SqlCommand("AddBook", myConnection)

         ' Mark the Command as a SPROC
         myCommand.CommandType = CommandType.StoredProcedure

         ' Add Parameters to SPROC
         Dim parameterItemID As New SqlParameter("@ItemID", SqlDbType.Int, 4)
         parameterItemID.Direction = ParameterDirection.Output
         myCommand.Parameters.Add(parameterItemID)

         Dim parameterModuleID As New SqlParameter("@ModuleID", SqlDbType.Int, 4)
         parameterModuleID.Value = moduleId
         myCommand.Parameters.Add(parameterModuleID)

         Dim parameterUserName As New SqlParameter("@UserName", SqlDbType.NVarChar, 100)
         parameterUserName.Value = userName
         myCommand.Parameters.Add(parameterUserName)

         Dim parameterTitle As New SqlParameter("@Title", SqlDbType.NVarChar, 150)
         parameterTitle.Value = title
         myCommand.Parameters.Add(parameterTitle)

         Dim parameterImageUrl As New SqlParameter("@ImageUrl", SqlDbType.NVarChar, 150)
         parameterImageUrl.Value = imageUrl
         myCommand.Parameters.Add(parameterImageUrl)

         Dim parameterAuthors As New SqlParameter("@Authors", SqlDbType.NVarChar, 150)
         parameterAuthors.Value = authors
         myCommand.Parameters.Add(parameterAuthors)

         Dim parameterPrice As New SqlParameter("@Price", SqlDbType.NVarChar, 10)
         parameterPrice.Value = price
         myCommand.Parameters.Add(parameterPrice)

         Dim parameterISBN As New SqlParameter("@ISBN", SqlDbType.NVarChar, 10)
         parameterISBN.Value = isbn
         myCommand.Parameters.Add(parameterISBN)

         Dim parameterBuyLink As New SqlParameter("@BuyLink", SqlDbType.NVarChar, 150)
         parameterBuyLink.Value = buyLink
         myCommand.Parameters.Add(parameterBuyLink)

         myConnection.Open()
         myCommand.ExecuteNonQuery()
         myConnection.Close()

         Return CInt(parameterItemID.Value)

      End Function


      '*********************************************************************
      '
      ' UpdateBook Method
      '
      ' The UpdateBook method updates the specified Book within
      ' the Books database table.
      '
      ' Other relevant sources:
      '     + <a href="UpdateBook.htm" style="color:green">UpdateBook Stored Procedure</a>
      '
      '*********************************************************************

      Public Sub UpdateBook(ByVal moduleId As Integer, ByVal itemId As Integer, ByVal userName As String, ByVal title As String, ByVal imageUrl As String, ByVal authors As String, ByVal price As String, ByVal isbn As String, ByVal buyLink As String)

         If userName.Length < 1 Then
            userName = "unknown"
         End If
         ' Create Instance of Connection and Command Object
         Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
         Dim myCommand As New SqlCommand("UpdateBook", myConnection)

         ' Mark the Command as a SPROC
         myCommand.CommandType = CommandType.StoredProcedure

         ' Add Parameters to SPROC
         Dim parameterItemID As New SqlParameter("@ItemID", SqlDbType.Int, 4)
         parameterItemID.Value = itemId
         myCommand.Parameters.Add(parameterItemID)

         Dim parameterUserName As New SqlParameter("@UserName", SqlDbType.NVarChar, 100)
         parameterUserName.Value = userName
         myCommand.Parameters.Add(parameterUserName)

         Dim parameterTitle As New SqlParameter("@Title", SqlDbType.NVarChar, 150)
         parameterTitle.Value = title
         myCommand.Parameters.Add(parameterTitle)

         Dim parameterImageUrl As New SqlParameter("@ImageUrl", SqlDbType.NVarChar, 150)
         parameterImageUrl.Value = imageUrl
         myCommand.Parameters.Add(parameterImageUrl)

         Dim parameterAuthors As New SqlParameter("@Authors", SqlDbType.NVarChar, 150)
         parameterAuthors.Value = authors
         myCommand.Parameters.Add(parameterAuthors)

         Dim parameterPrice As New SqlParameter("@Price", SqlDbType.NVarChar, 10)
         parameterPrice.Value = price
         myCommand.Parameters.Add(parameterPrice)

         Dim parameterISBN As New SqlParameter("@ISBN", SqlDbType.NVarChar, 10)
         parameterISBN.Value = isbn
         myCommand.Parameters.Add(parameterISBN)

         Dim parameterBuyLink As New SqlParameter("@BuyLink", SqlDbType.NVarChar, 150)
         parameterBuyLink.Value = buyLink
         myCommand.Parameters.Add(parameterBuyLink)

         myConnection.Open()
         myCommand.ExecuteNonQuery()
         myConnection.Close()

      End Sub

   End Class

End Namespace

