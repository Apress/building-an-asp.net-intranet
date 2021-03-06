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

