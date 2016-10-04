/*
   Tuesday, August 06, 2002 3:18:46 AM
   User: 
   Server: JOHN-NOTEBOOK
   Database: Portal
   Application: 
*/

BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.Discussion
	DROP CONSTRAINT FK_Discussion_Modules
GO
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_Discussion
	(
	ItemID int NOT NULL IDENTITY (0, 1),
	ModuleID int NOT NULL,
	ThreadID int NULL,
	Title nvarchar(100) NULL,
	CreatedDate datetime NULL,
	Body nvarchar(3000) NULL,
	DisplayOrder varchar(320) NULL,
	CreatedByUser nvarchar(100) NULL
	)  ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.Tmp_Discussion ON
GO
IF EXISTS(SELECT * FROM dbo.Discussion)
	 EXEC('INSERT INTO dbo.Tmp_Discussion (ItemID, ModuleID, Title, CreatedDate, Body, DisplayOrder, CreatedByUser)
		SELECT ItemID, ModuleID, Title, CreatedDate, Body, CONVERT(varchar(320), DisplayOrder), CreatedByUser FROM dbo.Discussion (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Discussion OFF
GO
DROP TABLE dbo.Discussion
GO
EXECUTE sp_rename N'dbo.Tmp_Discussion', N'Discussion', 'OBJECT'
GO
ALTER TABLE dbo.Discussion ADD CONSTRAINT
	PK_Discussion PRIMARY KEY NONCLUSTERED 
	(
	ItemID
	) ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX IX_Discussion_ModuleID ON dbo.Discussion
	(
	ModuleID
	) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_Discussion_ThreadID ON dbo.Discussion
	(
	ThreadID
	) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_Discussion_DisplayOrder ON dbo.Discussion
	(
	DisplayOrder
	) ON [PRIMARY]
GO
ALTER TABLE dbo.Discussion WITH NOCHECK ADD CONSTRAINT
	FK_Discussion_Modules FOREIGN KEY
	(
	ModuleID
	) REFERENCES dbo.Modules
	(
	ModuleID
	) ON DELETE CASCADE
	 NOT FOR REPLICATION

GO
COMMIT
