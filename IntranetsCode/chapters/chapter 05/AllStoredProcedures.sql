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

