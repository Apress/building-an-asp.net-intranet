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

