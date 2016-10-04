/*
To Set-up Full-Text Search on the Employees table use the following SQL
*/

if (select DATABASEPROPERTY(DB_NAME(), N'IsFullTextEnabled')) <> 1 
exec sp_fulltext_database N'enable' 
GO

if not exists (select * from dbo.sysfulltextcatalogs where name = N'HRISEmployees')
exec sp_fulltext_catalog N'HRISEmployees', N'create' 
GO

exec sp_fulltext_table N'[dbo].[tblHris_Employees]', N'create', N'HRISEmployees', N'PK_Employees'
GO

exec sp_fulltext_column N'[dbo].[tblHris_Employees]', N'FirstName', N'add', 1033  
GO

exec sp_fulltext_column N'[dbo].[tblHris_Employees]', N'LastName', N'add', 1033  
GO

exec sp_fulltext_column N'[dbo].[tblHris_Employees]', N'Title', N'add', 1033  
GO

exec sp_fulltext_column N'[dbo].[tblHris_Employees]', N'SSN', N'add', 1033  
GO

exec sp_fulltext_column N'[dbo].[tblHris_Employees]', N'HomeAddress', N'add', 1033  
GO

exec sp_fulltext_column N'[dbo].[tblHris_Employees]', N'GPAddress', N'add', 1033  
GO

exec sp_fulltext_column N'[dbo].[tblHris_Employees]', N'EMail', N'add', 1033  
GO

exec sp_fulltext_column N'[dbo].[tblHris_Employees]', N'Notes', N'add', 1033  
GO

exec sp_fulltext_column N'[dbo].[tblHris_Employees]', N'HealthNotes', N'add', 1033  
GO

exec sp_fulltext_table N'[dbo].[tblHris_Employees]', N'activate'  
GO