
The code theat accompanies this book uses the Visual Studio .NET version of the IBuySPy portal. It is possible to get it working without Visual Studio .NET but some additional work is required. We therefore recommend that you use VS.NET.

The PortalVBVS folder has the full code for the entire book, incorporated into the IBuySpy code.

The database.bak file has a backup of the database for the entire project.

You can also create the database by following these steps:
1) Run the PortalDB.sql SQL code against your SQl Server in query analyser
2) Run the setup_intranets_database.sql file against the Portal database
3) Create an index called PK_Employees on the ID column of rhe tbl_hris_employees table (make sure to select "Unique Values")
4) Run the setup_fulltext_searching.sql file against the Portal database

You may need to change the database connection string in the web.config.

If you want to add the code for the chapters individually to an existing INBuySpy installation, you will need to follow these instructions and use the source code in the chapters folder.

For all of the chapters, you will need the  common data access class that is defined in Database.vb. Copy it to the components folder of your IBuySpy portal installation and add it to your project.

Chapter 3

1) Copy all the files to your IBuySpy portal folder
2) Add the .ascx files to your visual studi project and recompile

Chapter 5

1) run the DiscussionTableUpdate.sql file against the portal database
2) run the AllStoredprocedures.sql file against the portal database
3) run the PopulateThreadID.sql file against the portal database
4) Ensure that the ASP.NET user has execute permissions on all of the stored procedures
5) Copy all the files to the your IBuySpy Portal folder
6) Recompile your project

Chapter 6

1) run the sqlscripts.sql file against your portal database
2) copy the code files to the portal folder and recompile


Chapter7

1) copy the files in the components folder to the components folder of your portal and add them to your VS.NET solution
2) copy the content management folder to your portal folder and add the files to your solution
3) run the upContentManagement.sql and tblContentManagement.sql files against your portal database
4) Recompile

Chapter 8

1) run the wroxdocs_tables_and_stored_procedures.sql file against your portal database
2) ensure that the asp.net user has execute access to all of the stored procedues
3) Copy the components and desktop modules folders to your portal folder
4) add the new files to your portal VS.NET solution
5) rebuild the solution to compile the files

Chapter 9

1) run the tables_and_procedures.sql file against your portal database
2) copy the components and desktopmodules folders to your portal folder and add the files to your VS.NET project
3) Add the required configuration sections to the web.config as described in the chapter (page 425)
4) Recompile

You will then be able to add the new modules to your portal as described in the chapters.
