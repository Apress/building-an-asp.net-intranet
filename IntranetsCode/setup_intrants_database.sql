CREATE TABLE [dbo].[Books] (
	[ItemID] [int] IDENTITY (1, 1) NOT NULL ,
	[ModuleID] [int] NOT NULL ,
	[CreatedByUser] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL ,
	[CreatedDate] [datetime] NULL ,
	[Title] [nvarchar] (150) COLLATE Latin1_General_CI_AS NULL ,
	[ImageUrl] [nvarchar] (150) COLLATE Latin1_General_CI_AS NULL ,
	[Authors] [nvarchar] (150) COLLATE Latin1_General_CI_AS NULL ,
	[Price] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL ,
	[ISBN] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL ,
	[Buylink] [nvarchar] (150) COLLATE Latin1_General_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE PROCEDURE AddBook
(
    @ModuleID       int,
    @UserName       nvarchar(100),
    @Title          nvarchar(150),
    @ImageUrl       nvarchar(150),
    @Authors	 nvarchar(150),
    @Price     nvarchar(10),
    @ISBN   nvarchar(10),
    @BuyLink	 nvarchar(150),
    @ItemID         int OUTPUT
)
AS

INSERT INTO Books
(
    ModuleID,
    CreatedByUser,
    CreatedDate,
    Title,
    ImageUrl,
    Authors,
    Price,
    ISBN,
    BuyLink
)

VALUES
(
    @ModuleID,
    @UserName,
    GetDate(),
    @Title,
    @ImageUrl,
    @Authors,
    @Price,
    @ISBN,
    @BuyLink
)

SELECT
    @ItemID = @@Identity
GO

CREATE PROCEDURE DeleteBook
(
    @ItemID int
)
AS

DELETE FROM
    Books

WHERE
    ItemID = @ItemID
GO

CREATE PROCEDURE GetBooks
(
    @ModuleID int
)
AS

SELECT
    ItemID,
    CreatedByUser,
    CreatedDate,
    Title,
    ImageUrl,
    Authors,
    Price,
    ISBN,
    BuyLink

FROM 
    Books

WHERE
    ModuleID = @ModuleID
GO

CREATE PROCEDURE GetSingleBook
(
    @ItemID int
)
AS

SELECT
    CreatedByUser,
    CreatedDate,
    Title,
    ImageUrl,
    Authors,
    Price,
    ISBN,
    BuyLink

FROM 
    Books

WHERE
    ItemID = @ItemID
GO

CREATE PROCEDURE UpdateBook
(
    @ItemID         int,
    @UserName       nvarchar(100),
    @Title          nvarchar(150),
    @ImageUrl       nvarchar(150),
    @Authors	 nvarchar(150),
    @Price     nvarchar(10),
    @ISBN   nvarchar(10),
    @BuyLink	 nvarchar(150)
)
AS

UPDATE
    Books

SET
    CreatedByUser   = @UserName,
    CreatedDate     = GetDate(),
    Title           = @Title,
    ImageUrl        = @ImageUrl,
    Authors  	    = @Authors,
    Price	    = @Price,
    ISBN            = @ISBN,
    BuyLink         = @BuyLink

WHERE
    ItemID = @ItemID
GO



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

-- Clear out any existing ThreadId values (just in case)
UPDATE
    Discussion
SET
    ThreadID = NULL


-- Set the ThreadId values for the top level messages
UPDATE 
    Discussion
SET
    ThreadID = ItemID
WHERE
    Len(DisplayOrder) <= 23


-- Set the ThreadID values for the replies
UPDATE
    Discussion
SET
    ThreadID = (SELECT
                    Threads.ThreadID 
                FROM
                    Discussion Threads
                WHERE
                    LEFT(Discussion.DisplayOrder, 23) = Threads.DisplayOrder
                    AND Threads.ThreadID IS NOT NULL)
WHERE
    LEN(Discussion.DisplayOrder) > 23

/****** Object:  Stored Procedure dbo.AddMessage    Script Date: 8/7/2002 2:44:22 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddMessage]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddMessage]
GO

/****** Object:  Stored Procedure dbo.GetNextMessageID    Script Date: 8/7/2002 2:44:22 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetNextMessageID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetNextMessageID]
GO

/****** Object:  Stored Procedure dbo.GetPrevMessageID    Script Date: 8/7/2002 2:44:22 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetPrevMessageID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetPrevMessageID]
GO

/****** Object:  Stored Procedure dbo.GetSingleMessage    Script Date: 8/7/2002 2:44:22 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSingleMessage]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSingleMessage]
GO

/****** Object:  Stored Procedure dbo.GetThreadMessages    Script Date: 8/7/2002 2:44:22 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetThreadMessages]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetThreadMessages]
GO

/****** Object:  Stored Procedure dbo.GetTopLevelMessages    Script Date: 8/7/2002 2:44:22 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetTopLevelMessages]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetTopLevelMessages]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AddMessage    Script Date: 8/7/2002 2:44:22 AM ******/

CREATE PROCEDURE AddMessage
(
    @ItemID int OUTPUT,
    @Title nvarchar(100),
    @Body nvarchar(3000),
    @ParentID int,
    @UserName nvarchar(100),
    @ModuleID int
)   

AS 

/* Find DisplayOrder of parent item */
DECLARE @ParentDisplayOrder as varchar(320)

SET @ParentDisplayOrder = ''

-- Also look up the ThreadID of the parent item
DECLARE @ThreadID as int


SELECT 
    @ThreadID = ThreadID,
    @ParentDisplayOrder = DisplayOrder
FROM 
    Discussion 
WHERE 
    ItemID = @ParentID
    AND ModuleID = @ModuleID

INSERT INTO Discussion
(
    ThreadID,
    Title,
    Body,
    CreatedDate, 
    CreatedByUser,
    ModuleID
)
VALUES
(
    @ThreadID,
    @Title,
    @Body,
    GetDate(),
    @UserName,
    @ModuleID
)

SET @ItemID = @@Identity

-- Determine the new display order
DECLARE @NewDisplayOrder varchar(320)
SET @NewDisplayOrder = @ParentDisplayOrder + 
                        REPLICATE('0', 10 - LEN(@ItemID)) + 
                        CONVERT(varchar(10), @ItemID)

-- Check to see if this is a new thread
IF @ThreadID IS NULL
    BEGIN
    -- It is, so update the ThreadID to match the new ItemID
    -- as well as updating the display order
    UPDATE
        Discussion
    SET
        DisplayOrder = @NewDisplayOrder,
        ThreadID = @ItemID
    WHERE 
        ItemID = @ItemID
    
    END
ELSE
    BEGIN
    -- Just update the display order
    UPDATE
        Discussion
    SET
        DisplayOrder = @NewDisplayOrder
    WHERE 
        ItemID = @ItemID
    
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

/****** Object:  Stored Procedure dbo.GetNextMessageID    Script Date: 8/7/2002 2:44:22 AM ******/


CREATE Procedure GetNextMessageID
(
    @ItemID int,
    @NextID int OUTPUT
)
AS

DECLARE @CurrentDisplayOrder as nvarchar(750)
DECLARE @CurrentModule as int

/* Find DisplayOrder of current item */
SELECT
    @CurrentDisplayOrder = DisplayOrder,
    @CurrentModule = ModuleID
FROM
    Discussion
WHERE
    ItemID = @ItemID

/* Get the next message in the same module */
SELECT Top 1
    @NextID = ItemID

FROM
    Discussion

WHERE
    DisplayOrder > @CurrentDisplayOrder
    AND
    ModuleID = @CurrentModule

ORDER BY
    DisplayOrder ASC

/* end of this thread? */
IF @@Rowcount < 1
    SET @NextID = null



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.GetPrevMessageID    Script Date: 8/7/2002 2:44:22 AM ******/


CREATE Procedure GetPrevMessageID
(
    @ItemID int,
    @PrevID int OUTPUT
)
AS

DECLARE @CurrentDisplayOrder as nvarchar(750)
DECLARE @CurrentModule as int

/* Find DisplayOrder of current item */
SELECT
    @CurrentDisplayOrder = DisplayOrder,
    @CurrentModule = ModuleID
FROM
    Discussion
WHERE
    ItemID = @ItemID

/* Get the previous message in the same module */
SELECT Top 1
    @PrevID = ItemID

FROM
    Discussion

WHERE
    DisplayOrder < @CurrentDisplayOrder
    AND
    ModuleID = @CurrentModule

ORDER BY
    DisplayOrder DESC

/* already at the beginning of this module? */
IF @@Rowcount < 1
    SET @PrevID = null



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.GetSingleMessage    Script Date: 8/7/2002 2:44:22 AM ******/



CREATE Procedure GetSingleMessage
(
    @ModuleID int,
    @ItemID int
)
AS

DECLARE @nextMessageID int
EXECUTE GetNextMessageID @ItemID, @nextMessageID OUTPUT
DECLARE @prevMessageID int
EXECUTE GetPrevMessageID @ItemID, @prevMessageID OUTPUT

SELECT
    ItemID,
    Title,
    CreatedByUser,
    CreatedDate,
    Body,
    NextMessageID = @nextMessageID,
    PrevMessageID = @prevMessageID
FROM
    Discussion
WHERE
    ItemID = @ItemID
    AND ModuleID = @ModuleID




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.GetThreadMessages    Script Date: 8/7/2002 2:44:22 AM ******/





CREATE PROCEDURE GetThreadMessages
(
    @ThreadID int
)
AS

SELECT
    ItemID,
    ((LEN( DisplayOrder ) / 10 ) - 1 ) AS Indent,
    Title,  
    CreatedByUser,
    CreatedDate,
    Body
FROM 
    Discussion
WHERE
    ThreadID = @ThreadID
    AND ItemID <> ThreadID
ORDER BY
    DisplayOrder





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.GetTopLevelMessages    Script Date: 8/7/2002 2:44:22 AM ******/



CREATE PROCEDURE GetTopLevelMessages
(
    @ModuleID int
)
AS

SELECT
    ItemID,
    ThreadID,
    (SELECT COUNT(*) -1  FROM Discussion Disc2 
        WHERE Disc2.ThreadID = Disc.ThreadID)
      AS ChildCount,
    Title,  
    CreatedByUser,
    CreatedDate
FROM 
    Discussion Disc
WHERE 
    ModuleID=@ModuleID 
    AND ItemID = ThreadID
ORDER BY
    DisplayOrder




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[Events]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Events]
GO


CREATE TABLE [Events] (
	[ItemID] [int] IDENTITY (0, 1) NOT NULL ,
	[ModuleID] [int] NOT NULL ,
	[CreatedByUser] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CreatedDate] [datetime] NOT NULL ,
	[EventDate] [datetime] NOT NULL ,
	[Title] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[WhereWhen] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[AuthorizedViewRoles] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_Events] PRIMARY KEY  NONCLUSTERED 
	(
		[ItemID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE PROCEDURE up_Events_AddEvent
(
    @ModuleID    int,
    @UserName    nvarchar(100),
    @Title       nvarchar(100),
    @EventDate DateTime,
    @Description nvarchar(2000),
    @WhereWhen   nvarchar(100),
    @ViewRoles nvarchar(256)
)
AS

INSERT INTO Events
(
    ModuleID,
    CreatedByUser,
    Title,
    CreatedDate,
    EventDate,
    Description,
    WhereWhen,
    AuthorizedViewRoles
)

VALUES
(
    @ModuleID,
    @UserName,
    @Title,
    GetDate(),
    @EventDate,
    @Description,
    @WhereWhen,
    @ViewRoles
)
GO


CREATE PROCEDURE up_Events_DeleteEvent
(
    @ItemID int
)
AS

DELETE FROM
    Events

WHERE
    ItemID = @ItemID



GO

CREATE PROCEDURE up_Events_GetAllEvents
(
    @ModuleID int,
    @CurrentDate DateTime
)
AS

SELECT     ItemID, Title, WhereWhen, EventDate, Title AS Expr1, Description, AuthorizedViewRoles
FROM         Events
WHERE     (ModuleID = @ModuleID) AND (EventDate >= @CurrentDate)
ORDER BY EventDate
GO

CREATE PROCEDURE up_Events_GetMonthlyEvents
(
    @ModuleID int,
    @ShowDate datetime,
    @CurrentDate datetime
)
AS

SELECT     ItemID, Title, CreatedByUser, WhereWhen, CreatedDate, EventDate, Title AS Expr1, Description, AuthorizedViewRoles
FROM         Events
WHERE     (ModuleID = @ModuleID) AND (YEAR(EventDate) = YEAR(@ShowDate)) AND (MONTH(EventDate) = MONTH(@ShowDate)) AND 
                      (EventDate >= @CurrentDate)
ORDER BY EventDate
GO

CREATE PROCEDURE up_Events_GetSingleEvent
(
    @ItemID int,
    @ModuleID int
)
AS

SELECT
    CreatedByUser,
    CreatedDate,
    EventDate,
    Title,
    Description,
    WhereWhen,
    AuthorizedViewRoles

FROM
    Events

WHERE
    ItemID = @ItemID
    AND
    ModuleID = @ModuleID
GO

CREATE PROCEDURE up_Events_UpdateEvent
(
    @ItemID      int,
    @UserName    nvarchar(100),
    @Title       nvarchar(100),
    @EventDate datetime,
    @Description nvarchar(2000),
    @WhereWhen   nvarchar(100),
    @ViewRoles nvarchar(256)
)

AS

UPDATE
    Events

SET
    CreatedByUser = @UserName,
    CreatedDate   = GetDate(),
    Title         = @Title,
    EventDate = @EventDate,
    Description   = @Description,
    WhereWhen     = @WhereWhen,
    AuthorizedViewRoles = @ViewRoles

WHERE
    ItemID = @ItemID
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_tblContentManagement_RelatedContent_tblContentManagement_Content]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[tblContentManagement_RelatedContent] DROP CONSTRAINT FK_tblContentManagement_RelatedContent_tblContentManagement_Content
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblContentManagement_Content]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblContentManagement_Content]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblContentManagement_RelatedContent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblContentManagement_RelatedContent]
GO

CREATE TABLE [dbo].[tblContentManagement_Content] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ModuleID] [int] NOT NULL ,
	[Title] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Summary] [varchar] (5000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Body] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[BeginDate] [datetime] NOT NULL ,
	[EndDate] [datetime] NOT NULL ,
	[CreatedBy] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblContentManagement_RelatedContent] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ContentID] [int] NOT NULL ,
	[RelatedContentID] [int] NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblContentManagement_Content] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblContentManagement_Content] PRIMARY KEY  CLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblContentManagement_RelatedContent] ADD 
	CONSTRAINT [FK_tblContentManagement_RelatedContent_tblContentManagement_Content] FOREIGN KEY 
	(
		[ContentID]
	) REFERENCES [dbo].[tblContentManagement_Content] (
		[ID]
	)
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upContentManagement_ClearRelatedContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upContentManagement_ClearRelatedContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upContentManagement_DeleteContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upContentManagement_DeleteContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upContentManagement_EditContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upContentManagement_EditContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upContentManagement_GetContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upContentManagement_GetContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upContentManagement_SaveContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upContentManagement_SaveContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upContentManagement_SaveRelatedContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upContentManagement_SaveRelatedContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upContentManagement_SearchContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upContentManagement_SearchContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upContentManagement_ViewContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upContentManagement_ViewContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upContentManagement_ViewMyContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upContentManagement_ViewMyContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[upContentManagement_ViewRelatedContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[upContentManagement_ViewRelatedContent]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upContentManagement_ClearRelatedContent
(
@ContentID As int
)

AS

DELETE tblContentManagement_RelatedContent Where ContentID = @ContentID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upContentManagement_DeleteContent
(
@ContentID As int,
@CreatedBy As varchar(200)
)

AS

DECLARE @Owner varchar(200)

SET @Owner = (SELECT CreatedBy FROM tblContentManagement_Content WHERE ID = @ContentID)

IF ( @Owner = @CreatedBy )

BEGIN

--First Delete Related Content
DELETE tblContentManagement_RelatedContent WHERE ContentID = @ContentID OR RelatedContentID = @ContentID
--Then Delete the actual Content itself
DELETE tblContentManagement_Content WHERE ID = @ContentID

END

ELSE
BEGIN
	RAISERROR ('Not Authorized to delete this content', 16,1)
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

CREATE PROCEDURE upContentManagement_EditContent
(
@ID As int,
@ModuleID As int,
@Title As varchar(200),
@Summary As varchar(5000),
@Body As text,
@BeginDate As datetime,
@EndDate As datetime,
@CreatedBy As varchar(200)
)

AS

DECLARE @Owner varchar(200)

--Get the Owner of this content item
SET @Owner = (SELECT CreatedBy FROM tblContentManagement_Content WHERE ID = @ID)

-- If the owner is the logged in user
IF ( @Owner = @CreatedBy )
BEGIN
-- The update the item
              UPDATE tblContentManagement_Content 
	SET ModuleID = @ModuleID, Title = @Title, Summary = @Summary, Body = @Body, BeginDate = @BeginDate, EndDate = @EndDate
	WHERE ID = @ID
	SELECT @ID
END

ELSE
--Else throw an error
BEGIN
	RAISERROR ('Not Authorized to edit this content', 16,1)
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

CREATE PROCEDURE upContentManagement_GetContent
(
@ContentID As Int
)
AS

    SELECT c.ID, c.Title, c.Summary, c.Body, c.BeginDate, c.EndDate, c.ModuleID
    FROM tblContentManagement_Content c 
    WHERE (c.ID = @ContentID AND GETDATE() <= c.EndDate AND GETDATE() >= c.BeginDate)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upContentManagement_SaveContent
(
@ModuleID As int,
@Title As varchar(200),
@Summary As varchar(5000),
@Body As text,
@BeginDate As datetime,
@EndDate As datetime,
@CreatedBy As varchar(200)
)

AS

INSERT INTO tblContentManagement_Content (ModuleID, Title, Summary, Body, BeginDate, EndDate, CreatedBy)
VALUES (@ModuleID, @Title, @Summary, @Body, @BeginDate, @EndDate, @CreatedBy)

SELECT @@IDENTITY
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upContentManagement_SaveRelatedContent

(
@ContentID As int,
@RelatedContentID As int
)

AS

INSERT INTO tblContentManagement_RelatedContent (ContentID, RelatedContentID) VALUES (@ContentID, @RelatedContentID)
SELECT @@Identity
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upContentManagement_SearchContent
(
@KeyWord as varchar(50),
@ModuleID As int
)

AS

    SELECT DISTINCT(c.ID), c.Title, c.Summary, c.BeginDate, c.ModuleID
    FROM tblContentManagement_Content c 
    WHERE (c.ModuleID = @ModuleID AND GETDATE() <= c.EndDate AND GETDATE() >= c.BeginDate)  AND
                ( c.Title LIKE '%' + @KeyWord + '%'  OR  c.Summary LIKE '%' + @KeyWord + '%')
    ORDER BY c.BeginDate DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upContentManagement_ViewContent
(
@ModuleID AS Int
)
AS

    SELECT c.ID, c.Title, c.Summary, c.BeginDate
    FROM tblContentManagement_Content c 
    WHERE (c.ModuleID = @ModuleID AND GETDATE() <= c.EndDate AND GETDATE() >= c.BeginDate) 
    ORDER BY c.BeginDate DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upContentManagement_ViewMyContent
(
@ModuleID As int,
@CreatedBy As varchar(200)
)
AS 
     SELECT DISTINCT(c.ID), c.Title, c.Summary, c.BeginDate, c.EndDate, c.ModuleID
     FROM tblContentManagement_Content c
    WHERE (c.ModuleID = @ModuleID  AND c.CreatedBy = @CreatedBy) 
    ORDER BY c.BeginDate DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE upContentManagement_ViewRelatedContent
(
@ContentID As int
)
AS 
     SELECT DISTINCT(c.ID), c.Title, c.Summary, c.BeginDate, c.ModuleID
     FROM tblContentManagement_Content c
     INNER JOIN tblContentManagement_RelatedContent RelCon On (RelatedContentID = c.ID)
    WHERE (RelCon.ContentID = @ContentID  AND GETDATE() <= c.EndDate AND GETDATE() >= c.BeginDate) 
    ORDER BY c.BeginDate DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Wrox_Docs_Acls_Wrox_Docs]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Wrox_Docs_Acls] DROP CONSTRAINT FK_Wrox_Docs_Acls_Wrox_Docs
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Wrox_Docs_Versions_Wrox_Docs]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Wrox_Docs_Versions] DROP CONSTRAINT FK_Wrox_Docs_Versions_Wrox_Docs
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[update_log]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[update_log]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_AddWroxDocAcls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_AddWroxDocAcls]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CheckInWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CheckInWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CheckOutWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CheckOutWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DeleteWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DeleteWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DeleteWroxDocAcls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DeleteWroxDocAcls]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetChildWroxDocs]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetChildWroxDocs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetSingleWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetSingleWroxDoc]
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetWroxDocPermissions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetWroxDocPermissions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetWroxDocs]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetWroxDocs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_RenderWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_RenderWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateWroxDocPermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateWroxDocPermission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UploadWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UploadWroxDoc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_WroxDocsHasAcls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_WroxDocsHasAcls]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ArchiveWroxDoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ArchiveWroxDoc]
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

CREATE PROCEDURE sp_AddWroxDocAcls 
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


CREATE PROCEDURE sp_CheckInWroxDoc
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

CREATE PROCEDURE sp_CheckOutWroxDoc
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






CREATE PROCEDURE sp_DeleteWroxDoc
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

CREATE PROCEDURE sp_DeleteWroxDocAcls
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

CREATE PROCEDURE sp_GetChildWroxDocs
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


CREATE PROCEDURE sp_GetSingleWroxDoc
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




CREATE PROCEDURE sp_GetWroxDocPermissions
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

CREATE PROCEDURE sp_GetWroxDocs
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

CREATE PROCEDURE sp_RenderWroxDoc
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


CREATE PROCEDURE sp_UpdateWroxDoc
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


CREATE PROCEDURE sp_UpdateWroxDocPermission
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

CREATE PROCEDURE sp_UploadWroxDoc
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

CREATE PROCEDURE sp_WroxDocsHasAcls
(
    @User nvarchar(100),
    @ItemID int,
    @TargetAcl int,
    @Result int OUTPUT
)

AS

BEGIN
SELECT  
    Roles.RoleName,
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
    Users.Email = @user AND Wrox_Docs_Acls.ItemID = @ItemID 
    AND Wrox_Docs_Acls.Acl >= @targetAcl 

SELECT @Result = @@ROWCOUNT

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

CREATE PROCEDURE sp_ArchiveWroxDoc
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_EmployeeSkillLevel_Employees]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[tblHris_EmployeeSkillLevel] DROP CONSTRAINT FK_EmployeeSkillLevel_Employees
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Employees_Race]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[tblHris_Employees] DROP CONSTRAINT FK_Employees_Race
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_tblHris_Employees_tblHris_JobStatuses]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[tblHris_Employees] DROP CONSTRAINT FK_tblHris_Employees_tblHris_JobStatuses
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_tblHris_Employees_tblHris_JobTitles]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[tblHris_Employees] DROP CONSTRAINT FK_tblHris_Employees_tblHris_JobTitles
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_tblHris_Employees_tblHris_Sites]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[tblHris_Employees] DROP CONSTRAINT FK_tblHris_Employees_tblHris_Sites
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_EmployeeSkillLevel_Skill]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[tblHris_EmployeeSkillLevel] DROP CONSTRAINT FK_EmployeeSkillLevel_Skill
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_ConvertSql2VB]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_ConvertSql2VB]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_sysnametolength]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_sysnametolength]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_DeleteCountry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_DeleteCountry]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_DeleteEmployee]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_DeleteEmployee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_DeleteEthnicOrigin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_DeleteEthnicOrigin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_DeleteJobStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_DeleteJobStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_DeleteJobTitle]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_DeleteJobTitle]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_DeleteSite]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_DeleteSite]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_DeleteSkill]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_DeleteSkill]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetCountries]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetCountries]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetEmployeeSkillLevels]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetEmployeeSkillLevels]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetEmployees]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetEmployees]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetEmployeesFull]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetEmployeesFull]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetEthnicOrigins]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetEthnicOrigins]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetJobStatuses]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetJobStatuses]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetJobTitles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetJobTitles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetNewEmployees]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetNewEmployees]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetSingleCountry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetSingleCountry]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetSingleEmployee]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetSingleEmployee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetSingleEmployeeSkillLevel]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetSingleEmployeeSkillLevel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetSingleEthnicOrigin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetSingleEthnicOrigin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetSingleJobStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetSingleJobStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetSingleJobTitle]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetSingleJobTitle]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetSingleSite]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetSingleSite]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetSingleSkill]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetSingleSkill]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetSites]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetSites]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_GetSkills]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_GetSkills]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_InsertCountry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_InsertCountry]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_InsertEmployee]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_InsertEmployee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_InsertEthnicOrigin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_InsertEthnicOrigin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_InsertJobStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_InsertJobStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_InsertSite]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_InsertSite]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_InsertSkill]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_InsertSkill]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_SearchEmployeesFT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_SearchEmployeesFT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_UpdateCountry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_UpdateCountry]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_UpdateEmployee]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_UpdateEmployee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_UpdateEthnicOrigin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_UpdateEthnicOrigin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_UpdateJobStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_UpdateJobStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_UpdateJobTitle]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_UpdateJobTitle]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_UpdateSite]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_UpdateSite]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_Hris_UpdateSkill]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[up_Hris_UpdateSkill]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblHris_EmployeeSkillLevel]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblHris_EmployeeSkillLevel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblHris_Employees]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblHris_Employees]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblHris_EthnicOrigins]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblHris_EthnicOrigins]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblHris_JobStatuses]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblHris_JobStatuses]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblHris_JobTitles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblHris_JobTitles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblHris_Sites]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblHris_Sites]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblHris_Skills]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblHris_Skills]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

--
--  UDF to return length of a type
--
CREATE function fn_ConvertSql2VB (
	@typename nvarchar(128)
)
RETURNS  nvarchar(128)
AS
BEGIN
DECLARE @VBType nvarchar(128)
SELECT @VBType = VBType FROM UtilGenCodeTypeConvert WHERE @typename = SqlType
RETURN ISNULL(@VBType, 'String')
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--
--  UDF to return length of a type
--
CREATE function fn_sysnametolength (
	@typename nvarchar(128)
)
RETURNS int
AS
BEGIN
DECLARE @length int
SELECT @length = length FROM master..systypes WHERE @typename = name
RETURN ISNULL(@length, 0)
end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE TABLE [dbo].[tblHris_EmployeeSkillLevel] (
	[EmployeeID] [int] NOT NULL ,
	[SkillID] [int] NOT NULL ,
	[SkillLevel] [tinyint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblHris_Employees] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[InstanceID] [int] NULL ,
	[FirstName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[MiddleNames] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Title] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[EthnicOriginID] [int] NOT NULL ,
	[SSN] [nvarchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[HomeAddress] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[TelephoneNum] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[BankRT] [nvarchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[BankAcct] [nvarchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[NextOfKin] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[GPAddress] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[EMail] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[SiteID] [int] NOT NULL ,
	[StatusID] [int] NOT NULL ,
	[JobID] [int] NOT NULL ,
	[Photograph] [image] NULL ,
	[PhotoContentType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PhotoContentSize] [int] NULL ,
	[Contract] [image] NULL ,
	[ContractContentType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ContractContentSize] [int] NULL ,
	[Salary] [money] NOT NULL ,
	[Notes] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[HealthNotes] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[DateOfBirth] [smalldatetime] NOT NULL ,
	[ReviewBaseDate] [smalldatetime] NOT NULL ,
	[LeavingDate] [smalldatetime] NULL ,
	[LastAlteredByUser] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlteredDate] [smalldatetime] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblHris_EthnicOrigins] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Description] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblHris_JobStatuses] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Description] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblHris_JobTitles] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Content] [image] NULL ,
	[ContentType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ContentSize] [int] NULL ,
	[LastAlteredByUser] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlteredDate] [smalldatetime] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblHris_Sites] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Code] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Description] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[LastAlteredByUser] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlteredDate] [smalldatetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblHris_Skills] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_DeleteCountry
/*
Procedure to Delete Country details from the tblHris_Sites table.
Input: The Identity column from the tblHris_Sites table (ID)

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

DELETE FROM
    tblHris_Sites

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_DeleteEmployee
/*
Procedure to Delete Employee details from the tblHris_Employees table.
Input: The Identity column from the tblHris_Employees table (ID)

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

DELETE FROM
    tblHris_Employees

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_DeleteEthnicOrigin
/*
Procedure to Delete EthnicOrigin details from the tblHris_EthnicOrigins table.
Input: The Identity column from the tblHris_EthnicOrigins table (ID)

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

DELETE FROM
    tblHris_EthnicOrigins

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_DeleteJobStatus
/*
Procedure to Delete JobStatus details from the tblHris_JobStatuses table.
Input: The Identity column from the tblHris_JobStatuses table (ID)

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

DELETE FROM
    tblHris_JobStatuses

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_DeleteJobTitle
/*
Procedure to Delete JobTitle details from the tblHris_JobTitles table.
Input: The Identity column from the tblHris_JobTitles table (ID)

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

DELETE FROM
    tblHris_JobTitles

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_DeleteSite
/*
Procedure to Delete Site details from the tblHris_Sites table.
Input: The Identity column from the tblHris_Sites table (ID)

Author  : Brian Boyce
Date	: Jul  4 2002  8:29PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  4 2002  8:29PM

*/
(
    @ID int
)
AS

DELETE FROM
    tblHris_Sites

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_DeleteSkill
/*
Procedure to Delete Skill details from the tblHris_Skills table.
Input: The Identity column from the tblHris_Skills table (ID)

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

DELETE FROM
    tblHris_Skills

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetCountries
/*
Procedure to return all of the Countries in the tblHris_Sites table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
AS

SELECT
ID,
Code, 
Description

FROM
    tblHris_Sites
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetEmployeeSkillLevels
/*
Procedure to return all of the EmployeeSkillLevels in the tblHris_EmployeeSkillLevel table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
AS

SELECT
EmployeeID, 
SkillID, 
SkillLevel

FROM
    tblHris_EmployeeSkillLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetEmployees
/*
Procedure to return all of the Employees in the tblHris_Employees table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
@InstanceID int
)
AS

SELECT
ID,
FirstName, 
MiddleNames, 
LastName, 
Title, 
EthnicOriginID, 
SSN, 
HomeAddress, 
TelephoneNum, 
BankRT, 
BankAcct, 
NextOfKin, 
GPAddress, 
EMail, 
SiteID, 
StatusID, 
JobID, 
Photograph, 
PhotoContentType, 
PhotoContentSize, 
Contract, 
ContractContentType, 
ContractContentSize, 
Salary, 
Notes, 
HealthNotes, 
DateOfBirth, 
ReviewBaseDate, 
LeavingDate

FROM
    tblHris_Employees
WHERE 
	InstanceID = @InstanceID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE up_Hris_GetEmployeesFull
/*
Procedure to return basic details on all of the Employees in the tblHris_Employees table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  4 2002 10:38PM

*/
(
@InstanceID int
)
AS

SELECT Emp.ID, Emp.Title as 'EmpTitle', FirstName, LastName,  
	Code as 'SiteCode', 	-- Site Code
	JobID,
	JobTitles.Title as 'JobTitle',
	str(Datediff(yyyy, ReviewBaseDate, getdate())) + ' Years' as 'Service',
	EMail, 
	CASE WHEN Photograph IS NULL THEN '' ELSE 'Show Photo' END as 'PhotoAvail'
FROM
	tblHris_Employees Emp INNER JOIN tblHris_Sites
		ON SiteID = tblHris_Sites.ID
	INNER JOIN tblHris_JobTitles JobTitles
		ON JobID = JobTitles.ID
WHERE InstanceID = @InstanceID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetEthnicOrigins
/*
Procedure to return all of the EthnicOrigins in the tblHris_EthnicOrigins table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
AS

SELECT
ID,
Description

FROM
    tblHris_EthnicOrigins
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetJobStatuses
/*
Procedure to return all of the JobStatuses in the tblHris_JobStatuses table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
AS

SELECT
ID,
Description

FROM
    tblHris_JobStatuses
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetJobTitles
/*
Procedure to return all of the JobTitles in the tblHris_JobTitles table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
AS

SELECT
ID,
Title, 
Content, 
ContentType, 
ContentSize

FROM
    tblHris_JobTitles
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE up_Hris_GetNewEmployees
/*
Procedure to return basic details on all newly started Employees in the tblHris_Employees table. The ReviewBaseDate is treated
as the start date.

Author  : Brian Boyce
Date	: Jul  8 2002 00:52AM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  8 2002 00:52AM

*/
(
@Months int = 3
)
AS

SELECT Emp.ID, Emp.Title as 'EmpTitle', FirstName, LastName,  
	Code as 'SiteCode', 	-- Site Code
	JobID,
	JobTitles.Title as 'JobTitle',
	str(Datediff(yyyy, ReviewBaseDate, getdate())) + ' Years' as 'Service',
	EMail, 
	CASE WHEN Photograph IS NULL THEN '' ELSE 'Show Photo' END as 'PhotoAvail'
FROM
	tblHris_Employees Emp INNER JOIN tblHris_Sites
		ON SiteID = tblHris_Sites.ID
	INNER JOIN tblHris_JobTitles JobTitles
		ON JobID = JobTitles.ID
WHERE datediff(mm,ReviewBaseDate, getdate()) < @Months
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetSingleCountry
/*
Procedure to return a single Country from the tblHris_Sites table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

SELECT
Code, 
Description

FROM
    tblHris_Sites

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetSingleEmployee
/*
Procedure to return a single Employee from the tblHris_Employees table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

SELECT
FirstName, 
MiddleNames, 
LastName, 
str(Datediff(yyyy, DateOfBirth, getdate())) as 'Age',
tblHris_Employees.Title as 'Title', 
EthnicOriginID, 
tblHris_EthnicOrigins.Description as 'EthnicOrigin',
SSN, 
HomeAddress, 
TelephoneNum, 
BankRT, 
BankAcct, 
NextOfKin, 
GPAddress, 
EMail, 
SiteID, 
tblHris_Sites.Description as 'SiteDescription',
StatusID, 
tblHris_JobStatuses.Description as 'StatusDescription',
JobID, 
JobTitles.Title as 'JobTitle',
Photograph, 
PhotoContentType, 
PhotoContentSize, 
Contract, 
ContractContentType, 
ContractContentSize, 
Salary, 
Notes, 
HealthNotes, 
DateOfBirth, 
ReviewBaseDate, 
case when dateadd(yyyy,datediff(yyyy, Convert(smalldatetime,ReviewBaseDate), getdate()), ReviewBaseDate) < getdate() then dateadd(yyyy, datediff(yyyy, Convert(smalldatetime,ReviewBaseDate), getdate()) + 1,ReviewBaseDate) else dateadd(yyyy,datediff(yyyy, Convert(smalldatetime,ReviewBaseDate), getdate()), ReviewBaseDate) end as 'NextReviewDate',
LeavingDate,
 tblHris_Employees.LastAlteredByUser,
 tblHris_Employees.AlteredDate

FROM
    tblHris_Employees INNER JOIN tblHris_Sites
		ON SiteID = tblHris_Sites.ID
	INNER JOIN tblHris_JobTitles JobTitles
		ON JobID = JobTitles.ID
	INNER JOIN tblHris_JobStatuses
		ON tblHris_JobStatuses.ID = StatusID
	INNER JOIN tblHris_EthnicOrigins
		ON tblHris_EthnicOrigins.ID = EthnicOriginID

WHERE
    tblHris_Employees.ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetSingleEmployeeSkillLevel
/*
Procedure to return a single EmployeeSkillLevel from the tblHris_EmployeeSkillLevel table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @EmployeeID int, 
@SkillID int
)
AS

SELECT
EmployeeID, 
SkillID, 
SkillLevel

FROM
    tblHris_EmployeeSkillLevel

WHERE
    EmployeeID = @EmployeeID AND 
SkillID = @SkillID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetSingleEthnicOrigin
/*
Procedure to return a single EthnicOrigin from the tblHris_EthnicOrigins table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

SELECT
Description

FROM
    tblHris_EthnicOrigins

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetSingleJobStatus
/*
Procedure to return a single JobStatus from the tblHris_JobStatuses table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

SELECT
Description

FROM
    tblHris_JobStatuses

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetSingleJobTitle
/*
Procedure to return a single JobTitle from the tblHris_JobTitles table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

SELECT
Title, 
Content, 
ContentType, 
ContentSize,
LastAlteredByUser,
AlteredDate

FROM
    tblHris_JobTitles

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetSingleSite
/*
Procedure to return a single Site from the tblHris_Sites table.

Author  : Brian Boyce
Date	: Jul  4 2002  8:29PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  4 2002  8:29PM

*/
(
    @ID int
)
AS

SELECT
Code, 
Description,
LastAlteredByUser,
AlteredDate

FROM
    tblHris_Sites

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetSingleSkill
/*
Procedure to return a single Skill from the tblHris_Skills table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
    @ID int
)
AS

SELECT
Description

FROM
    tblHris_Skills

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetSites
/*
Procedure to return all of the Sites in the tblHris_Sites table.

Author  : Brian Boyce
Date	: Jul  4 2002  8:29PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  4 2002  8:29PM

*/
AS

SELECT
ID,
Code, 
Description

FROM
    tblHris_Sites
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_GetSkills
/*
Procedure to return all of the Skills in the tblHris_Skills table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
AS

SELECT
ID,
Description

FROM
    tblHris_Skills
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_InsertCountry
/*
Procedure to Insert Country details in the tblHris_Sites table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
        @ID int OUTPUT,
	@Code varchar(5), 
@Description varchar(50)
)
    AS

    INSERT INTO tblHris_Sites
    (
Code, 
Description
    )
    VALUES
    (
@Code, 
@Description
    )
    SELECT
        @ID = @@Identity
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_InsertEmployee
/*
Procedure to Insert Employee details in the tblHris_Employees table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
        @ID int OUTPUT,
@InstanceID int,
	@FirstName nvarchar(50), 
@MiddleNames nvarchar(50), 
@LastName nvarchar(50), 
@Title nvarchar(5), 
@EthnicOriginID int, 
@SSN nvarchar(11), 
@HomeAddress nvarchar(300), 
@TelephoneNum nvarchar(25), 
@BankRT nvarchar(9), 
@BankAcct nvarchar(14), 
@NextOfKin nvarchar(300), 
@GPAddress nvarchar(300), 
@EMail varchar(255), 
@SiteID int, 
@StatusID int, 
@JobID int, 
@Photograph image, 
@PhotoContentType nvarchar(50), 
@PhotoContentSize int, 
@Contract image, 
@ContractContentType nvarchar(50), 
@ContractContentSize int, 
@Salary money, 
@Notes nvarchar(1000), 
@HealthNotes nvarchar(1000), 
@DateOfBirth smalldatetime, 
@ReviewBaseDate smalldatetime, 
@LeavingDate smalldatetime,
@UserName nvarchar(100)
)
    AS

    INSERT INTO tblHris_Employees
    (
InstanceID,
FirstName, 
MiddleNames, 
LastName, 
Title, 
EthnicOriginID, 
SSN, 
HomeAddress, 
TelephoneNum, 
BankRT, 
BankAcct, 
NextOfKin, 
GPAddress, 
EMail, 
SiteID, 
StatusID, 
JobID, 
Photograph, 
PhotoContentType, 
PhotoContentSize, 
Contract, 
ContractContentType, 
ContractContentSize, 
Salary, 
Notes, 
HealthNotes, 
DateOfBirth, 
ReviewBaseDate, 
LeavingDate,
LastAlteredByUser,
AlteredDate
    )
    VALUES
    (
@InstanceID,
@FirstName, 
@MiddleNames, 
@LastName, 
@Title, 
@EthnicOriginID, 
@SSN, 
@HomeAddress, 
@TelephoneNum, 
@BankRT, 
@BankAcct, 
@NextOfKin, 
@GPAddress, 
@EMail, 
@SiteID, 
@StatusID, 
@JobID, 
@Photograph, 
@PhotoContentType, 
@PhotoContentSize, 
@Contract, 
@ContractContentType, 
@ContractContentSize, 
@Salary, 
@Notes, 
@HealthNotes, 
@DateOfBirth, 
@ReviewBaseDate, 
@LeavingDate,
@UserName,
getdate()
    )
    SELECT
        @ID = @@Identity
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_InsertEthnicOrigin
/*
Procedure to Insert EthnicOrigin details in the tblHris_EthnicOrigins table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
        @ID int OUTPUT,
	@Description nvarchar(50)
)
    AS

    INSERT INTO tblHris_EthnicOrigins
    (
Description
    )
    VALUES
    (
@Description
    )
    SELECT
        @ID = @@Identity
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_InsertJobStatus
/*
Procedure to Insert JobStatus details in the tblHris_JobStatuses table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
        @ID int OUTPUT,
	@Description nvarchar(50)
)
    AS

    INSERT INTO tblHris_JobStatuses
    (
Description
    )
    VALUES
    (
@Description
    )
    SELECT
        @ID = @@Identity
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_InsertSite
/*
Procedure to Insert Site details in the tblHris_Sites table.

Author  : Brian Boyce
Date	: Jul  4 2002  8:29PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  4 2002  8:29PM

*/
(
        @ID int OUTPUT,
	@Code varchar(5), 
@Description varchar(50),
@UserName nvarchar(100)
)
    AS

    INSERT INTO tblHris_Sites
    (
Code, 
Description,
LastAlteredByUser,
AlteredDate
    )
    VALUES
    (
@Code, 
@Description,
@UserName,
getdate()
    )
    SELECT
        @ID = @@Identity
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_InsertSkill
/*
Procedure to Insert Skill details in the tblHris_Skills table.

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
        @ID int OUTPUT,
	@Description varchar(255)
)
    AS

    INSERT INTO tblHris_Skills
    (
Description
    )
    VALUES
    (
@Description
    )
    SELECT
        @ID = @@Identity
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE up_Hris_SearchEmployees
/*
Procedure to perform a full text search on the Employees table using CONTAINSTABLE
Author  : Brian Boyce
Date	: Jul  7 2002 2:00PM

Change History
WHO		DESCRIPTION		DATE
Brian Boyce	Initial development	Jul  7 2002 2:00PM
*/
(
@SearchText varchar(1000)
)
AS
DECLARE @sql varchar(3000)

SELECT @sql = 'Select key_tbl.RANK, ft_tbl.[ID], ft_tbl.[Title] as ''EmpTitle'', ft_tbl.[FirstName],  ft_tbl.[LastName], Code as ''SiteCode'', JobID, JobTitles.Title as ''JobTitle''  from tblHris_Employees as ft_tbl inner join CONTAINSTABLE(tblHRIS_Employees, *, ''' + @SearchText  + ''') as key_tbl on ft_tbl.[ID] = key_tbl.[KEY]  INNER JOIN tblHris_Sites ON SiteID = tblHris_Sites.ID	INNER JOIN tblHris_JobTitles JobTitles ON JobID = JobTitles.ID order by key_tbl.RANK desc'
EXEC (@sql)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_UpdateCountry
/*
Procedure to Update Country details on the tblHris_Sites table.
Input: The Identity column from the tblHris_Sites table (ID)
	All other fields in the table

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
@ID  int,
@Code varchar(5), 
@Description varchar(50)
)
AS

UPDATE
    tblHris_Sites

SET
    Code = @Code, 
Description = @Description

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_UpdateEmployee
/*
Procedure to Update Employee details on the tblHris_Employees table.
Input: The Identity column from the tblHris_Employees table (ID)
	All other fields in the table

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE			TAG
Brian Boyce	Initial development							Jul  3 2002 10:38PM
Brian Boyce	Changed to prevent the overwriting / wiping of uploaded documents	July 5 2002 00:55AM	000001
		While this change could have been handled with multiple updates for each of the possible file upload combinations
		I prefer to sacrafice slight performance for clarity and simplicity of logic.
Brian Boyce	After an INSERT store the @@IDENTITY field in order to update the 	July 9 2002 23:45AM	000002
		Blobs if necessary
*/
(
@ID  int,
@InstanceID int,
@FirstName nvarchar(50), 
@MiddleNames nvarchar(50), 
@LastName nvarchar(50), 
@Title nvarchar(5), 
@EthnicOriginID int, 
@SSN nvarchar(11), 
@HomeAddress nvarchar(300), 
@TelephoneNum nvarchar(25), 
@BankRT nvarchar(9), 
@BankAcct nvarchar(14), 
@NextOfKin nvarchar(300), 
@GPAddress nvarchar(300), 
@EMail varchar(255), 
@SiteID int, 
@StatusID int, 
@JobID int, 
@Photograph image, 
@PhotoContentType nvarchar(50), 
@PhotoContentSize int, 
@Contract image, 
@ContractContentType nvarchar(50), 
@ContractContentSize int, 
@Salary money, 
@Notes nvarchar(1000), 
@HealthNotes nvarchar(1000), 
@DateOfBirth smalldatetime, 
@ReviewBaseDate smalldatetime, 
@LeavingDate smalldatetime,
@UserName nvarchar(100)
)
AS
-- If the record exists for this employee thenUpdate the details
-- otherwise  INSERT the new employee record
IF EXISTS (SELECT * FROM tblHris_Employees WHERE ID = @ID) BEGIN
UPDATE
    tblHris_Employees

-- InstanceID is not updated since it should never change
SET
    FirstName = @FirstName, 
MiddleNames = @MiddleNames, 
LastName = @LastName, 
Title = @Title, 
EthnicOriginID = @EthnicOriginID, 
SSN = @SSN, 
HomeAddress = @HomeAddress, 
TelephoneNum = @TelephoneNum, 
BankRT = @BankRT, 
BankAcct = @BankAcct, 
NextOfKin = @NextOfKin, 
GPAddress = @GPAddress, 
EMail = @EMail, 
SiteID = @SiteID, 
StatusID = @StatusID, 
JobID = @JobID, 
/* 000001 The File Uploads are Handled as part of a subsequent update 
Photograph = @Photograph, 
PhotoContentType = @PhotoContentType, 
PhotoContentSize = @PhotoContentSize, 
Contract = @Contract, 
ContractContentType = @ContractContentType, 
ContractContentSize = @ContractContentSize, 
*/
Salary = @Salary, 
Notes = @Notes, 
HealthNotes = @HealthNotes, 
DateOfBirth = @DateOfBirth, 
ReviewBaseDate = @ReviewBaseDate, 
LeavingDate = @LeavingDate,
LastAlteredByUser = @UserName,
AlteredDate = getdate()

WHERE
    ID = @ID
	END
ELSE BEGIN
    INSERT INTO tblHris_Employees
    (
InstanceID,
FirstName, 
MiddleNames, 
LastName, 
Title, 
EthnicOriginID, 
SSN, 
HomeAddress, 
TelephoneNum, 
BankRT, 
BankAcct, 
NextOfKin, 
GPAddress, 
EMail, 
SiteID, 
StatusID, 
JobID, 
/* 000001 
Photograph, 
PhotoContentType, 
PhotoContentSize, 
Contract, 
ContractContentType, 
ContractContentSize, 
*/
Salary, 
Notes, 
HealthNotes, 
DateOfBirth, 
ReviewBaseDate, 
LeavingDate,
LastAlteredByUser,
AlteredDate
    )
    VALUES
    (
@InstanceID,
@FirstName, 
@MiddleNames, 
@LastName, 
@Title, 
@EthnicOriginID, 
@SSN, 
@HomeAddress, 
@TelephoneNum, 
@BankRT, 
@BankAcct, 
@NextOfKin, 
@GPAddress, 
@EMail, 
@SiteID, 
@StatusID, 
@JobID, 
/* 000001
@Photograph, 
@PhotoContentType, 
@PhotoContentSize, 
@Contract, 
@ContractContentType, 
@ContractContentSize, 
*/
@Salary, 
@Notes, 
@HealthNotes, 
@DateOfBirth, 
@ReviewBaseDate, 
@LeavingDate,
@UserName,
getdate()
    )

-- 000002
-- This is required because we later update the binary large object fields ONLY
-- if the ContentSize is > 0 
SELECT @ID = @@IDENTITY
END

-- The Employee record now exists in the DB, any existing documents still exist
-- but have not yet been updated.

-- Update the Photograph if a file has been uploaded
IF @PhotoContentSize > 0 BEGIN
	UPDATE    tblHris_Employees
	SET 	Photograph = @Photograph, 
		PhotoContentType = @PhotoContentType, 
		PhotoContentSize = @PhotoContentSize 
	WHERE
		    ID = @ID
END

-- Update the Contract if a file has been uploaded
IF @ContractContentSize > 0 BEGIN
	UPDATE    tblHris_Employees
	SET 	Contract = @Contract,
		ContractContentType = @ContractContentType, 
		ContractContentSize = @ContractContentSize 
	WHERE
		    ID = @ID
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

CREATE PROCEDURE up_Hris_UpdateEthnicOrigin
/*
Procedure to Update EthnicOrigin details on the tblHris_EthnicOrigins table.
Input: The Identity column from the tblHris_EthnicOrigins table (ID)
	All other fields in the table

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
@ID  int,
@Description nvarchar(50)
)
AS

UPDATE
    tblHris_EthnicOrigins

SET
    Description = @Description

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_UpdateJobStatus
/*
Procedure to Update JobStatus details on the tblHris_JobStatuses table.
Input: The Identity column from the tblHris_JobStatuses table (ID)
	All other fields in the table

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
@ID  int,
@Description nvarchar(50)
)
AS

UPDATE
    tblHris_JobStatuses

SET
    Description = @Description

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_UpdateJobTitle
/*
Procedure to Update JobTitle details on the tblHris_JobTitles table.
Input: The Identity column from the tblHris_JobTitles table (ID)
	All other fields in the table

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM
Brian Boyce	Allow for updating of Title field without overwriting previously uploaded 	Jul  9 2002 23:30PM
		information.

*/
(
@ID  int,
@Title varchar(50), 
@Content image, 
@ContentType nvarchar(50), 
@ContentSize int,
@UserName nvarchar(100)
)
AS
IF (@ID=0) OR NOT EXISTS (SELECT    *    FROM    tblHris_JobTitles  WHERE   ID = @ID) 
	INSERT INTO tblHris_JobTitles
	(   Title,
	--    CreatedByUser,
	--    CreatedDate,
	    Content,
	    ContentType,
	    ContentSize,
	    LastAlteredByUser,
    	    AlteredDate
	)
	VALUES
	(
	    @Title,
	--    @UserName,
	--    GetDate(),
	    @Content,
	    @ContentType,
	    @ContentSize,
	@UserName,
	getdate()
	) 
ELSE BEGIN

	IF (@ContentSize > 0) 	begin

		UPDATE
		tblHris_JobTitles
		SET
		Title = @Title,
		Content           = @Content,
		ContentType       = @ContentType,
		ContentSize       = @ContentSize,
		LastAlteredByUser = @UserName,
		AlteredDate = getdate()
		WHERE
		  ID = @ID
		END
	ELSE BEGIN
		UPDATE
		tblHris_JobTitles
		SET
		Title = @Title,
		LastAlteredByUser = @UserName,
		AlteredDate = getdate()
		WHERE
		  ID = @ID
	END
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

CREATE PROCEDURE up_Hris_UpdateSite
/*
Procedure to Update Site details on the tblHris_Sites table.
Input: The Identity column from the tblHris_Sites table (ID)
	All other fields in the table

Author  : Brian Boyce
Date	: Jul  4 2002  8:29PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  4 2002  8:29PM

*/
(
@ID  int,
@Code varchar(5), 
@Description varchar(50),
@UserName nvarchar(100)
)
AS

UPDATE
    tblHris_Sites

SET
    Code = @Code, 
Description = @Description,
LastAlteredByUser = @UserName,
AlteredDate = getdate()

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE up_Hris_UpdateSkill
/*
Procedure to Update Skill details on the tblHris_Skills table.
Input: The Identity column from the tblHris_Skills table (ID)
	All other fields in the table

Author  : Brian Boyce
Date	: Jul  3 2002 10:38PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  3 2002 10:38PM

*/
(
@ID  int,
@Description varchar(255)
)
AS

UPDATE
    tblHris_Skills

SET
    Description = @Description

WHERE
    ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

