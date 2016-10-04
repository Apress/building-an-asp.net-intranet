Imports System
Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System.Globalization
Imports ASPNetPortal

Namespace ASPNetPortal.Hris

    Public MustInherit Class HrisEmployeesDisplaySearchResults
        Inherits ASPNetPortal.PortalModuleControl
        Protected WithEvents txtSearchPhrase As System.Web.UI.WebControls.TextBox
        Protected WithEvents Button1 As System.Web.UI.WebControls.Button
        Protected WithEvents lblCount As System.Web.UI.WebControls.Label
        Protected WithEvents lblResults As System.Web.UI.WebControls.Label
        Protected WithEvents rdoSearchHrisFiles As System.Web.UI.WebControls.RadioButton
        Protected WithEvents ResultsDataGrid As System.Web.UI.WebControls.DataGrid
        Protected WithEvents rdoSearchEmployeesTable As System.Web.UI.WebControls.RadioButton


#Region " Web Form Designer Generated Code "

        'This call is required by the Web Form Designer.
        <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

        End Sub

        Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
            'CODEGEN: This method call is required by the Web Form Designer
            'Do not modify it using the code editor.
            InitializeComponent()
        End Sub

#End Region

        'the ID of the Instance to Display
        Private InstanceID As Integer

        'property to provide access to the InstanceID
        Public Property Instance() As Integer
            Get
                Return InstanceID
            End Get
            Set(ByVal Value As Integer)
                InstanceID = Value
            End Set
        End Property

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        End Sub

        Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

            Dim conMyData As New SqlConnection()
            Dim strSearch As String
            Dim cmdSearch As SqlCommand
            Dim dtrSearch As SqlDataReader
            Dim strPhraseAlias As String
            Dim iCount As Int32

            iCount = 0

            conMyData = New SqlConnection(ConfigurationSettings.AppSettings("connectionString"))
            strPhraseAlias = txtSearchPhrase.Text.Replace("+", " AND ")
            strPhraseAlias = strPhraseAlias.Replace("-", " AND NOT ")
            strPhraseAlias = strPhraseAlias.Replace("'", """")

            If rdoSearchHrisFiles.Checked = True Then
                strSearch = "SELECT * FROM " & _
                  "OPENQUERY(HRIS, " & _
                  "'SELECT RANK, FileName, Directory, Characterization " & _
                  "FROM SCOPE() " & _
                  "WHERE CONTAINS( ''" & strPhraseAlias & _
                  "'') > 0 " & _
                  "ORDER BY RANK DESC' ) "

                cmdSearch = New SqlCommand(strSearch, conMyData)
                conMyData.Open()

                Try
                    dtrSearch = cmdSearch.ExecuteReader()
                    lblResults.Text = "<BR><ul>"
                    While dtrSearch.Read
                        lblResults.Text &= "<li> (" & dtrSearch("RANK") / 10 & "%) "
                        lblResults.Text &= "<a target=""_new"" href=""" & dtrSearch("Directory").ToString() + "\" + dtrSearch("FileName").ToString()
                        lblResults.Text &= """>"
                        lblResults.Text &= dtrSearch("FileName") & "</a><br>"
                        lblResults.Text &= dtrSearch("Characterization")
                        lblResults.Text &= "<p>"
                        iCount = iCount + 1
                    End While
                    dtrSearch.Close()
                    lblCount.Text = "<b>" & iCount.ToString() & " Documents found."
                    lblCount.Visible = True
                Catch exc As Exception
                    lblResults.Text = "Error: Invalid Query - Please re-phrase your search"
                End Try
                conMyData.Close()
                ResultsDataGrid.Visible = False
            Else
                ResultsDataGrid.DataSource = EmployeesBiz.SearchEmployees(strPhraseAlias)
                'Store the DataSource in ViewState
                ViewState("Results") = ResultsDataGrid.DataSource
                ResultsDataGrid.Visible = True
                ResultsDataGrid.DataBind()
            End If


        End Sub

        Public Sub Employees_PageIndexChanged(ByVal sender As System.Object, ByVal e As DataGridPageChangedEventArgs) Handles ResultsDataGrid.PageIndexChanged

            ResultsDataGrid.CurrentPageIndex = e.NewPageIndex
            'Since the Result set is likely to be quite small we can store
            'the results in viewstate to save re-querying the MSIDX Server
            'Retrieval from ViewState is only necessary after paging
            'Custom paging can be used to minimise the impact of requerying
            'by only returning the results appropriate to the current page
            ResultsDataGrid.DataSource = ViewState("Results")
            ResultsDataGrid.DataBind()
        End Sub

        '*******************************************************
        '
        ' GetBrowsePathDetails() is a helper method used to create the url   
        ' to view the details of an entity
        '
        ' This method is used in the databinding expression for
        ' the browse Hyperlink within the DataGrid, and is called 
        ' for each row when DataGrid.DataBind() is called.  It is 
        ' defined as a helper method here (as opposed to inline 
        ' within the template) to improve code organization and
        ' avoid embedding logic within the content template.
        '
        '*******************************************************'

        Function GetBrowsePathDetails(ByVal Entity As String, ByVal ID As Integer) As String
            ' if there is content in the database, create an 
            ' url to browse it
            Return EmployeesBiz.GetBrowsePathDetails(Entity, ID)
        End Function
    End Class

End Namespace