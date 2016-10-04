Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports ASPNetPortal


Namespace ASPNetPortal

    '*********************************************************************
    '
    ' HtmlTextDB Class
    '
    ' Class that encapsulates all data logic necessary to add/query/delete
    ' HTML/text within the Portal database.
    '
   '*********************************************************************

    Public Class HtmlTextDB

        '*********************************************************************
        '
        ' GetHtmlText Method
        '
        ' The GetHtmlText method returns a SqlDataReader containing details
        ' about a specific item from the HtmlText database table.
        '
        ' Other relevant sources:
        '     + <a href="GetHtmlText.htm" style="color:green">GetHtmlText Stored Procedure</a>
        '
        '*********************************************************************

        Public Function GetHtmlText(ByVal moduleId As Integer) As SqlDataReader

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("GetHtmlText", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleID As New SqlParameter("@ModuleID", SqlDbType.Int, 4)
            parameterModuleID.Value = moduleId
            myCommand.Parameters.Add(parameterModuleID)

            ' Execute the command
            myConnection.Open()
            Dim result As SqlDataReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection)

            ' Return the datareader 
            Return result

        End Function


        '*********************************************************************
        '
        ' UpdateHtmlText Method
        '
        ' The UpdateHtmlText method updates a specified item within
        ' the HtmlText database table.
        '
        ' Other relevant sources:
        '     + <a href="UpdateHtmlText.htm" style="color:green">UpdateHtmlText Stored Procedure</a>
        '
        '*********************************************************************

        Public Sub UpdateHtmlText(ByVal moduleId As Integer, ByVal desktopHtml As String, ByVal mobileSummary As String, ByVal mobileDetails As String)

            ' Create Instance of Connection and Command Object
            Dim myConnection As New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            Dim myCommand As New SqlCommand("UpdateHtmlText", myConnection)

            ' Mark the Command as a SPROC
            myCommand.CommandType = CommandType.StoredProcedure

            ' Add Parameters to SPROC
            Dim parameterModuleID As New SqlParameter("@ModuleID", SqlDbType.Int, 4)
            parameterModuleID.Value = moduleId
            myCommand.Parameters.Add(parameterModuleID)

            Dim parameterDesktopHtml As New SqlParameter("@DesktopHtml", SqlDbType.NText)
            parameterDesktopHtml.Value = desktopHtml
            myCommand.Parameters.Add(parameterDesktopHtml)

            Dim parameterMobileSummary As New SqlParameter("@MobileSummary", SqlDbType.NText)
            parameterMobileSummary.Value = mobileSummary
            myCommand.Parameters.Add(parameterMobileSummary)

            Dim parameterMobileDetails As New SqlParameter("@MobileDetails", SqlDbType.NText)
            parameterMobileDetails.Value = mobileDetails
            myCommand.Parameters.Add(parameterMobileDetails)

            myConnection.Open()
            myCommand.ExecuteNonQuery()
            myConnection.Close()

        End Sub

    End Class

End Namespace
