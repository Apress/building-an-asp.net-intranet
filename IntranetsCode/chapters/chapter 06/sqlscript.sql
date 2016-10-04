
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
