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