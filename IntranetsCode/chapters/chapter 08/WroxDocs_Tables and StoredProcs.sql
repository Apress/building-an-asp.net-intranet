if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Wrox_Docs_Acls_Wrox_Docs]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Wrox_Docs_Acls] DROP CONSTRAINT FK_Wrox_Docs_Acls_Wrox_Docs
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Wrox_Docs_Versions_Wrox_Docs]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Wrox_Docs_Versions] DROP CONSTRAINT FK_Wrox_Docs_Versions_Wrox_Docs
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[update_log]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[update_log]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_AddWroxDocAcls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_AddWroxDocAcls]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_CheckInWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_CheckInWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_CheckOutWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_CheckOutWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_DeleteWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_DeleteWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_DeleteWroxDocAcls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_DeleteWroxDocAcls]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_GetChildWroxDocs]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_GetChildWroxDocs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_GetSingleWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_GetSingleWroxDoc]
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_GetWroxDocPermissions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_GetWroxDocPermissions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_GetWroxDocs]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_GetWroxDocs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_RenderWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_RenderWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_UpdateWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_UpdateWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_UpdateWroxDocPermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_UpdateWroxDocPermission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_UploadWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_UploadWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_WroxDocsHasAcls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_WroxDocsHasAcls]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upDMS_ArchiveWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upDMS_ArchiveWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Wrox_Docs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Wrox_Docs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Wrox_Docs_Acls]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Wrox_Docs_Acls]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Wrox_Docs_Logs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Wrox_Docs_Logs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Wrox_Docs_Versions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Wrox_Docs_Versions]
GO

CREATE TABLE [dbo].[Wrox_Docs] (
	[ItemID] [int] IDENTITY (0, 1) NOT NULL ,
	[ModuleID] [int] NOT NULL ,
	[FileDescription] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[FileName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CreatedByUser] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CreatedDate] [datetime] NOT NULL ,
	[CheckedUser] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CheckedDate] [datetime] NULL ,
	[Status] [bit] NOT NULL ,
	[Archived] [bit] NOT NULL ,
	[Category] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Content] [image] NOT NULL ,
	[ContentType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ContentSize] [int] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Wrox_Docs_Acls] (
	[ItemID] [int] NOT NULL ,
	[RoleID] [int] NOT NULL ,
	[Acl] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Wrox_Docs_Logs] (
	[ItemID] [int] NOT NULL ,
	[UserName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserAction] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[LogDate] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Wrox_Docs_Versions] (
	[SubItemID] [int] IDENTITY (1, 1) NOT NULL ,
	[ItemID] [int] NOT NULL ,
	[VersionedDate] [datetime] NOT NULL ,
	[FileName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Content] [image] NOT NULL ,
	[ContentType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ContentSize] [int] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Wrox_Docs_Acls] WITH NOCHECK ADD 
	CONSTRAINT [PK_Wrox_Docs_Acls] PRIMARY KEY  CLUSTERED 
	(
		[ItemID],
		[RoleID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Wrox_Docs_Versions] WITH NOCHECK ADD 
	CONSTRAINT [PK_Wrox_Docs_Versions] PRIMARY KEY  CLUSTERED 
	(
		[SubItemID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Wrox_Docs] WITH NOCHECK ADD 
	CONSTRAINT [DF_Wrox_Docs_CreatedDate] DEFAULT (getdate()) FOR [CreatedDate],
	CONSTRAINT [DF_Wrox_Docs_Status] DEFAULT (1) FOR [Status],
	CONSTRAINT [DF_Wrox_Docs_Archived] DEFAULT (0) FOR [Archived],
	CONSTRAINT [PK_Wrox_Docs] PRIMARY KEY  NONCLUSTERED 
	(
		[ItemID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Wrox_Docs_Versions] WITH NOCHECK ADD 
	CONSTRAINT [DF_Wrox_Docs_Versions_VersionedDate] DEFAULT (getdate()) FOR [VersionedDate]
GO

ALTER TABLE [dbo].[Wrox_Docs] ADD 
	CONSTRAINT [FK_Wrox_Docs_Modules] FOREIGN KEY 
	(
		[ModuleID]
	) REFERENCES [dbo].[Modules] (
		[ModuleID]
	) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Wrox_Docs_Acls] ADD 
	CONSTRAINT [FK_Wrox_Docs_Acls_Wrox_Docs] FOREIGN KEY 
	(
		[ItemID]
	) REFERENCES [dbo].[Wrox_Docs] (
		[ItemID]
	) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Wrox_Docs_Versions] ADD 
	CONSTRAINT [FK_Wrox_Docs_Versions_Wrox_Docs] FOREIGN KEY 
	(
		[ItemID]
	) REFERENCES [dbo].[Wrox_Docs] (
		[ItemID]
	) ON DELETE CASCADE 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upDMS_AddWroxDocAcls 
(
	@ItemID int,
	@RoleID int,
	@Acl 	int  = 3
)

AS

IF  NOT EXISTS (
    SELECT 
        * 
    FROM 
        Wrox_Docs_Acls
    WHERE 
        ItemID = @ItemID AND  RoleID = @RoleID
)

BEGIN
INSERT INTO Wrox_Docs_Acls
	(ItemID,
	RoleID,
	Acl
	)
VALUES
	(
	@ItemID,
	@RoleID,
	@Acl
	)
END
ELSE
RETURN -1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE upDMS_CheckInWroxDoc
(
    @ItemID           	int ,
    @FileName 		varchar(255),
    @UserName        	varchar(100),
    @Content          	image,
    @ContentType      	varchar(50),
    @ContentSize      	int
)

AS

BEGIN TRANSACTION CheckIn

/* Perform an Insert */
INSERT INTO Wrox_Docs_Versions
(
    ItemID,
    FileName,
    VersionedDate,
    Content,
    ContentType,
    ContentSize
)

SELECT 
    ItemID,
    FileName,
    GETDATE(),
    Content,
    ContentType,
    ContentSize
FROM Wrox_Docs
WHERE ItemID = @ItemID

/* Perform an Update */
UPDATE
    Wrox_Docs
SET
    FileName  		= @FileName,
    CheckedDate		= GETDATE(),
    CheckedUser		= @UserName,
    Content           	= @Content,
    ContentType       	= @ContentType,
    ContentSize       	= @ContentSize,
    Status		= 1

WHERE
    ItemID = @ItemID

IF @@ERROR > 0
	BEGIN
	RAISERROR('Check In Failed',16,1)
	ROLLBACK TRANSACTION CheckIn
	RETURN 99
	END

COMMIT TRANSACTION CheckIn
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upDMS_CheckOutWroxDoc
(
    @ItemID           	int ,
    @UserName		varchar(100)
)

AS

UPDATE Wrox_Docs
SET	status		= 0,
	CheckedDate	= GETDATE(),
	CheckedUser	= @UserName
WHERE ItemID = @ItemID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO






CREATE PROCEDURE upDMS_DeleteWroxDoc
(
    @ItemID int
)
AS

DELETE FROM
    WroxDocs

WHERE
    ItemID = @ItemID






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upDMS_DeleteWroxDocAcls
(
@ItemID  int,
@RoleID int 
)

AS
BEGIN

	DELETE  FROM Wrox_Docs_Acls 
	WHERE ItemID = @ItemID AND   RoleID = @RoleID
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upDMS_GetChildWroxDocs
(
    @ItemID int
)
AS

DECLARE @Counter int


SELECT
   SubItemID,
   ItemID,
   FileName,
   VersionedDate,
   ContentType,
   ContentSize
    
FROM
    Wrox_Docs_Versions

WHERE
    ItemID = @ItemID

ORDER BY VersionedDate
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE upDMS_GetSingleWroxDoc
(
    @ItemID int
)
AS

SELECT
    FileName,
    CreatedByUser,
    CreatedDate,
    FileDescription,
    Category,
    ContentSize,
    ContentType

FROM
    Wrox_Docs

WHERE
    ItemID = @ItemID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE upDMS_GetWroxDocPermissions
(
	@ItemID	int
)
AS

BEGIN
SELECT Roles.RoleID, Roles.RoleName, Wrox_Docs_Acls.Acl
FROM Wrox_Docs_Acls INNER JOIN
     Roles ON Wrox_Docs_Acls.RoleID = Roles.RoleID
WHERE (Wrox_Docs_Acls.ItemID = @ItemID)  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE upDMS_GetWroxDocs
(
    @ModuleID int
)
AS

SELECT
    ItemID,
    FileName,
    FileDescription,
    CreatedByUser,
    CreatedDate,
    CheckedUser,
    Category,
    ContentType,
    Status,
    ContentSize,
    (SELECT COUNT(*) FROM Wrox_Docs_Versions WHERE ItemID = Wrox_Docs.ItemID) AS VersionCount
    
FROM
    Wrox_Docs

WHERE
    ModuleID = @ModuleID AND Archived <> 1
ORDER by CreatedDate DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upDMS_RenderWroxDoc
(
	@ItemID int,
	@Table  char(10)
)
AS

IF (@Table = 'parent')
BEGIN
SELECT 
   Content,
   ContentType,
   ContentSize,
   FileName
FROM Wrox_Docs 
WHERE ItemID = @ItemID
END

ELSE
/* Render a child document */
BEGIN
SELECT
   Content,
   ContentType,
   ContentSize,
   FileName
FROM Wrox_Docs_Versions
WHERE SubItemID = @ItemID

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE upDMS_UpdateWroxDoc
(
    @ItemID           	int ,
    @FileDesc		varchar(255),
    @Category         	varchar(50)
)
AS

/* An Update Action is being performed */

BEGIN

UPDATE
    Wrox_Docs

SET
    Category		= @Category,
    FileDescription	= @FileDesc
WHERE
    ItemID = @ItemID

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE upDMS_UpdateWroxDocPermission
(
	@ItemID  int,
	@RoleID	 int,
	@Acl	 int
)

AS

UPDATE Wrox_Docs_Acls SET 
Acl = @Acl
WHERE ItemID = @ItemID AND RoleID = @RoleID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE upDMS_UploadWroxDoc
(
    @ItemID           	int ,
    @ModuleID         	int,
    @FileName 		varchar(255),
    @FileDesc		varchar(255),
    @UserName        	varchar(100),
    @Category         	varchar(50),
    @Content          	image,
    @ContentType      	varchar(50),
    @ContentSize      	int,
    @Status		bit = 1
)

AS

INSERT INTO Wrox_Docs
(
    ModuleID,
    FileName,
    FileDescription,
    CreatedByUser,
    CreatedDate,
    Status,
    Category,
    Content,
    ContentType,
    ContentSize
)

VALUES
(
    @ModuleID,
    @FileName,
    @FileDesc,
    @UserName,
    GetDate(),
    @Status,
    @Category,
    @Content,
    @ContentType,
    @ContentSize
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upDMS_WroxDocsHasAcls
(
    @User nvarchar(100),
    @ItemID int,
    @TargetAcl int
)

AS

BEGIN
SELECT  

    Roles.RoleID,
    Wrox_Docs_Acls.Acl

FROM
    UserRoles

  INNER JOIN 
    Users ON UserRoles.UserID = Users.UserID
  INNER JOIN 
    Roles ON UserRoles.RoleID = Roles.RoleID
  INNER JOIN 
    Wrox_Docs_Acls ON Roles.RoleID = Wrox_Docs_Acls.RoleID

WHERE   
    Users.Email = @User AND Wrox_Docs_Acls.ItemID = @ItemID 
    AND Wrox_Docs_Acls.Acl >= @targetAcl 

RETURN @@ROWCOUNT


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upDMS_ArchiveWroxDoc
(
    @ItemID           	int ,
    @ArchivedBit	bit = 1
)
AS

BEGIN

UPDATE
    Wrox_Docs

SET
    Archived   	= @ArchivedBit

WHERE
    ItemID = @ItemID

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER update_log
ON dbo.Wrox_Docs
FOR UPDATE
AS
IF UPDATE(archived)
BEGIN

INSERT Wrox_Docs_Logs (ItemID, UserName,LogDate,UserAction)
SELECT ItemID, CreatedByUser, GETDATE(), 'Document Archived'
FROM inserted 
END

ELSE
IF UPDATE(status)
BEGIN

DECLARE @StatusText char(20)
DECLARE @Statuscode int
	
select @StatusCode = status from inserted
 IF (@StatusCode = 1)
	SET @StatusText = 'Document Checked In'
	ELSE
	SET @StatusText = 'Document Checked Out'

INSERT Wrox_Docs_Logs (ItemID, UserName,LogDate,UserAction)
SELECT ItemID, CheckedUser, GETDATE(),@StatusText
FROM inserted 
END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

