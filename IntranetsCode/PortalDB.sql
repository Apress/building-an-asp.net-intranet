-- ===============================================
-- CONFIG IBUYSPY Portal DATABASE
-- 
-- Version:	1.2 - 01/02 (swarren)
--
-- ===============================================

CREATE DATABASE [Portal]
GO

USE [Portal]
GO

-- set various options
exec sp_dboption N'portal', N'autoclose', N'false'
GO

exec sp_dboption N'portal', N'bulkcopy', N'false'
GO

exec sp_dboption N'portal', N'trunc. log', N'false'
GO

exec sp_dboption N'portal', N'torn page detection', N'true'
GO

exec sp_dboption N'portal', N'read only', N'false'
GO

exec sp_dboption N'portal', N'dbo use', N'false'
GO

exec sp_dboption N'portal', N'single', N'false'
GO

exec sp_dboption N'portal', N'autoshrink', N'false'
GO

exec sp_dboption N'portal', N'ANSI null default', N'false'
GO

exec sp_dboption N'portal', N'recursive triggers', N'false'
GO

exec sp_dboption N'portal', N'ANSI nulls', N'false'
GO

exec sp_dboption N'portal', N'concat null yields null', N'false'
GO

exec sp_dboption N'portal', N'cursor close on commit', N'false'
GO

exec sp_dboption N'portal', N'default to local cursor', N'false'
GO

exec sp_dboption N'portal', N'quoted identifier', N'false'
GO

exec sp_dboption N'portal', N'ANSI warnings', N'false'
GO

exec sp_dboption N'portal', N'auto create statistics', N'true'
GO

exec sp_dboption N'portal', N'auto update statistics', N'true'
GO

-- 
-- end config
--


-- =======================================================
-- MAKE TABLES AND SPROCS FOR IBUYSPY Portal DB
-- =======================================================

-- point to proper DB 
use [Portal]
GO

-- drop any existing stuff
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Modules_ModuleDefinitions]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Modules] DROP CONSTRAINT FK_Modules_ModuleDefinitions
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Announcements_Modules]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Announcements] DROP CONSTRAINT FK_Announcements_Modules
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Contacts_Modules]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Contacts] DROP CONSTRAINT FK_Contacts_Modules
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Discussion_Modules]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Discussion] DROP CONSTRAINT FK_Discussion_Modules
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Documents_Modules]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Documents] DROP CONSTRAINT FK_Documents_Modules
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Events_Modules]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Events] DROP CONSTRAINT FK_Events_Modules
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_HtmlText_Modules]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[HtmlText] DROP CONSTRAINT FK_HtmlText_Modules
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Links_Modules]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Links] DROP CONSTRAINT FK_Links_Modules
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ModuleSettings_Modules]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ModuleSettings] DROP CONSTRAINT FK_ModuleSettings_Modules
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Roles_Portals]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Roles] DROP CONSTRAINT FK_Roles_Portals
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tabs_Portals]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Tabs] DROP CONSTRAINT FK_Tabs_Portals
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_UserRoles_Roles]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT FK_UserRoles_Roles
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Modules_Tabs]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Modules] DROP CONSTRAINT FK_Modules_Tabs
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_UserRoles_Users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT FK_UserRoles_Users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddAnnouncement]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddAnnouncement]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddContact]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddContact]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddEvent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddLink]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddLink]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddMessage]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddMessage]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddModule]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddModule]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddModuleDefinition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddModuleDefinition]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddTab]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddTab]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddUserRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddUserRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteAnnouncement]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteAnnouncement]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteContact]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteContact]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteDocument]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteDocument]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteEvent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteLink]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteLink]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteModule]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteModule]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteModuleDefinition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteModuleDefinition]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteTab]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteTab]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteUserRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteUserRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetAnnouncements]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetAnnouncements]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetAuthRoles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetAuthRoles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetContacts]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetContacts]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetDocumentContent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetDocumentContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetDocuments]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetDocuments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetEvents]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetEvents]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetHtmlText]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetHtmlText]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetLinks]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetLinks]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetModuleDefinitions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetModuleDefinitions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetModuleSettings]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetModuleSettings]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetNextMessageID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetNextMessageID]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetPortalRoles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetPortalRoles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetPortalSettings]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetPortalSettings]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetPrevMessageID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetPrevMessageID]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetRoleMembership]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetRoleMembership]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetRolesByUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetRolesByUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSingleAnnouncement]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSingleAnnouncement]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSingleContact]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSingleContact]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSingleDocument]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSingleDocument]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSingleEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSingleEvent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSingleLink]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSingleLink]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSingleMessage]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSingleMessage]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSingleModuleDefinition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSingleModuleDefinition]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSingleRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSingleRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSingleUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSingleUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetThreadMessages]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetThreadMessages]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetTopLevelMessages]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetTopLevelMessages]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetUsers]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetUsers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateAnnouncement]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateAnnouncement]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateContact]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateContact]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateDocument]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateDocument]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateEvent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateHtmlText]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateHtmlText]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateLink]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateLink]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateModule]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateModule]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateModuleDefinition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateModuleDefinition]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateModuleOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateModuleOrder]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateModuleSetting]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateModuleSetting]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdatePortalInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdatePortalInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateTab]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateTab]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateTabOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateTabOrder]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UserLogin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UserLogin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Announcements]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Announcements]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Contacts]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Contacts]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Discussion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Discussion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Documents]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Documents]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Events]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Events]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[HtmlText]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[HtmlText]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Links]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Links]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ModuleDefinitions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ModuleDefinitions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ModuleSettings]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ModuleSettings]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Modules]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Modules]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Portals]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Portals]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Roles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Roles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tabs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tabs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UserRoles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[UserRoles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Users]
GO

-- =============================================================
-- create the tables
-- =============================================================
CREATE TABLE [dbo].[Announcements] (
    [ItemID] [int] IDENTITY (0, 1) NOT NULL ,
    [ModuleID] [int] NOT NULL ,
    [CreatedByUser] [nvarchar] (100) NULL ,
    [CreatedDate] [datetime] NULL ,
    [Title] [nvarchar] (150) NULL ,
    [MoreLink] [nvarchar] (150) NULL ,
    [MobileMoreLink] [nvarchar] (150) NULL ,
    [ExpireDate] [datetime] NULL ,
    [Description] [nvarchar] (2000) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Contacts] (
    [ItemID] [int] IDENTITY (0, 1) NOT NULL ,
    [ModuleID] [int] NOT NULL ,
    [CreatedByUser] [nvarchar] (100) NULL ,
    [CreatedDate] [datetime] NULL ,
    [Name] [nvarchar] (50) NULL ,
    [Role] [nvarchar] (100) NULL ,
    [Email] [nvarchar] (100) NULL ,
    [Contact1] [nvarchar] (250) NULL ,
    [Contact2] [nvarchar] (250) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Discussion] (
    [ItemID] [int] IDENTITY (0, 1) NOT NULL ,
    [ModuleID] [int] NOT NULL ,
    [Title] [nvarchar] (100) NULL ,
    [CreatedDate] [datetime] NULL ,
    [Body] [nvarchar] (3000) NULL ,
    [DisplayOrder] [nvarchar] (750) NULL ,
    [CreatedByUser] [nvarchar] (100) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Documents] (
    [ItemID] [int] IDENTITY (0, 1) NOT NULL ,
    [ModuleID] [int] NOT NULL ,
    [CreatedByUser] [nvarchar] (100) NULL ,
    [CreatedDate] [datetime] NULL ,
    [FileNameUrl] [nvarchar] (250) NULL ,
    [FileFriendlyName] [nvarchar] (150) NULL ,
    [Category] [nvarchar] (50) NULL ,
    [Content] [image] NULL ,
    [ContentType] [nvarchar] (50) NULL ,
    [ContentSize] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Events] (
    [ItemID] [int] IDENTITY (0, 1) NOT NULL ,
    [ModuleID] [int] NOT NULL ,
    [CreatedByUser] [nvarchar] (100) NULL ,
    [CreatedDate] [datetime] NULL ,
    [Title] [nvarchar] (150) NULL ,
    [WhereWhen] [nvarchar] (150) NULL ,
    [Description] [nvarchar] (2000) NULL ,
    [ExpireDate] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[HtmlText] (
    [ModuleID] [int] NOT NULL ,
    [DesktopHtml] [ntext] NOT NULL ,
    [MobileSummary] [ntext] NOT NULL ,
    [MobileDetails] [ntext] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Links] (
    [ItemID] [int] IDENTITY (0, 1) NOT NULL ,
    [ModuleID] [int] NOT NULL ,
    [CreatedByUser] [nvarchar] (100) NULL ,
    [CreatedDate] [datetime] NULL ,
    [Title] [nvarchar] (100) NULL ,
    [Url] [nvarchar] (250) NULL ,
    [MobileUrl] [nvarchar] (250) NULL ,
    [ViewOrder] [int] NULL ,
    [Description] [nvarchar] (2000) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ModuleDefinitions] (
    [ModuleDefID] [int] IDENTITY (1, 1) NOT NULL ,
    [PortalID] [int] NOT NULL ,
    [FriendlyName] [nvarchar] (128) NOT NULL ,
    [DesktopSrc] [nvarchar] (256) NOT NULL ,
    [MobileSrc] [nvarchar] (256) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ModuleSettings] (
    [ModuleID] [int] NOT NULL ,
    [SettingName] [nvarchar] (50) NOT NULL ,
    [SettingValue] [nvarchar] (256) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Modules] (
    [ModuleID] [int] IDENTITY (0, 1) NOT NULL ,
    [TabID] [int] NOT NULL ,
    [ModuleDefID] [int] NOT NULL ,
    [ModuleOrder] [int] NOT NULL ,
    [PaneName] [nvarchar] (50) NOT NULL ,
    [ModuleTitle] [nvarchar] (256) NULL ,
    [AuthorizedEditRoles] [nvarchar] (256) NULL ,
    [CacheTime] [int] NOT NULL ,
    [ShowMobile] [bit] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Portals] (
    [PortalID] [int] IDENTITY (-1, 1) NOT NULL ,
    [PortalAlias] [nvarchar] (50) NULL ,
    [PortalName] [nvarchar] (128) NOT NULL ,
    [AlwaysShowEditButton] [bit] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Roles] (
    [RoleID] [int] IDENTITY (0, 1) NOT NULL ,
    [PortalID] [int] NOT NULL ,
    [RoleName] [nvarchar] (50) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Tabs] (
    [TabID] [int] IDENTITY (0, 1) NOT NULL ,
    [TabOrder] [int] NOT NULL ,
    [PortalID] [int] NOT NULL ,
    [TabName] [nvarchar] (50) NOT NULL ,
    [MobileTabName] [nvarchar] (50) NOT NULL ,
    [AuthorizedRoles] [nvarchar] (256) NULL ,
    [ShowMobile] [bit] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[UserRoles] (
    [UserID] [int] NOT NULL ,
    [RoleID] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Users] (
    [UserID] [int] IDENTITY (1, 1) NOT NULL ,
    [Name] [nvarchar] (50) NOT NULL ,
    [Password] [nvarchar] (20) NULL ,
    [Email] [nvarchar] (100) NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Announcements] WITH NOCHECK ADD 
    CONSTRAINT [PK_Announcements] PRIMARY KEY  NONCLUSTERED 
    (
        [ItemID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Contacts] WITH NOCHECK ADD 
    CONSTRAINT [PK_Contacts] PRIMARY KEY  NONCLUSTERED 
    (
        [ItemID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Discussion] WITH NOCHECK ADD 
    CONSTRAINT [PK_Discussion] PRIMARY KEY  NONCLUSTERED 
    (
        [ItemID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Documents] WITH NOCHECK ADD 
    CONSTRAINT [PK_Documents] PRIMARY KEY  NONCLUSTERED 
    (
        [ItemID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Events] WITH NOCHECK ADD 
    CONSTRAINT [PK_Events] PRIMARY KEY  NONCLUSTERED 
    (
        [ItemID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[HtmlText] WITH NOCHECK ADD 
    CONSTRAINT [PK_HtmlText] PRIMARY KEY  NONCLUSTERED 
    (
        [ModuleID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Links] WITH NOCHECK ADD 
    CONSTRAINT [PK_Links] PRIMARY KEY  NONCLUSTERED 
    (
        [ItemID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ModuleDefinitions] WITH NOCHECK ADD 
    CONSTRAINT [PK_ModuleDefinitions] PRIMARY KEY  NONCLUSTERED 
    (
        [ModuleDefID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Modules] WITH NOCHECK ADD 
    CONSTRAINT [PK_Modules] PRIMARY KEY  NONCLUSTERED 
    (
        [ModuleID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Portals] WITH NOCHECK ADD 
    CONSTRAINT [PK_Portals] PRIMARY KEY  NONCLUSTERED 
    (
        [PortalID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Roles] WITH NOCHECK ADD 
    CONSTRAINT [PK_Roles] PRIMARY KEY  NONCLUSTERED 
    (
        [RoleID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Tabs] WITH NOCHECK ADD 
    CONSTRAINT [PK_Tabs] PRIMARY KEY  NONCLUSTERED 
    (
        [TabID]
    )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Users] WITH NOCHECK ADD 
    CONSTRAINT [PK_Users] PRIMARY KEY  NONCLUSTERED 
    (
        [UserID]
    )  ON [PRIMARY] ,
    CONSTRAINT [IX_Users] UNIQUE  NONCLUSTERED 
    (
        [Email]
    )  ON [PRIMARY] 
GO

 CREATE  INDEX [IX_ModuleSettings] ON [dbo].[ModuleSettings]([ModuleID], [SettingName]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Announcements] ADD 
    CONSTRAINT [FK_Announcements_Modules] FOREIGN KEY 
    (
        [ModuleID]
    ) REFERENCES [dbo].[Modules] (
        [ModuleID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Contacts] ADD 
    CONSTRAINT [FK_Contacts_Modules] FOREIGN KEY 
    (
        [ModuleID]
    ) REFERENCES [dbo].[Modules] (
        [ModuleID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Discussion] ADD 
    CONSTRAINT [FK_Discussion_Modules] FOREIGN KEY 
    (
        [ModuleID]
    ) REFERENCES [dbo].[Modules] (
        [ModuleID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Documents] ADD 
    CONSTRAINT [FK_Documents_Modules] FOREIGN KEY 
    (
        [ModuleID]
    ) REFERENCES [dbo].[Modules] (
        [ModuleID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Events] ADD 
    CONSTRAINT [FK_Events_Modules] FOREIGN KEY 
    (
        [ModuleID]
    ) REFERENCES [dbo].[Modules] (
        [ModuleID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[HtmlText] ADD 
    CONSTRAINT [FK_HtmlText_Modules] FOREIGN KEY 
    (
        [ModuleID]
    ) REFERENCES [dbo].[Modules] (
        [ModuleID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Links] ADD 
    CONSTRAINT [FK_Links_Modules] FOREIGN KEY 
    (
        [ModuleID]
    ) REFERENCES [dbo].[Modules] (
        [ModuleID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[ModuleSettings] ADD 
    CONSTRAINT [FK_ModuleSettings_Modules] FOREIGN KEY 
    (
        [ModuleID]
    ) REFERENCES [dbo].[Modules] (
        [ModuleID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Modules] ADD 
    CONSTRAINT [FK_Modules_ModuleDefinitions] FOREIGN KEY 
    (
        [ModuleDefID]
    ) REFERENCES [dbo].[ModuleDefinitions] (
        [ModuleDefID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION ,
    CONSTRAINT [FK_Modules_Tabs] FOREIGN KEY 
    (
        [TabID]
    ) REFERENCES [dbo].[Tabs] (
        [TabID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Roles] ADD 
    CONSTRAINT [FK_Roles_Portals] FOREIGN KEY 
    (
        [PortalID]
    ) REFERENCES [dbo].[Portals] (
        [PortalID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Tabs] ADD 
    CONSTRAINT [FK_Tabs_Portals] FOREIGN KEY 
    (
        [PortalID]
    ) REFERENCES [dbo].[Portals] (
        [PortalID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[UserRoles] ADD 
    CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY 
    (
        [RoleID]
    ) REFERENCES [dbo].[Roles] (
        [RoleID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION ,
    CONSTRAINT [FK_UserRoles_Users] FOREIGN KEY 
    (
        [UserID]
    ) REFERENCES [dbo].[Users] (
        [UserID]
    ) ON DELETE CASCADE  NOT FOR REPLICATION 
GO


-- =============================================================
-- create the stored procs
-- =============================================================
CREATE PROCEDURE AddAnnouncement
(
    @ModuleID       int,
    @UserName       nvarchar(100),
    @Title          nvarchar(150),
    @MoreLink       nvarchar(150),
    @MobileMoreLink nvarchar(150),
    @ExpireDate     DateTime,
    @Description    nvarchar(2000),
    @ItemID         int OUTPUT
)
AS

INSERT INTO Announcements
(
    ModuleID,
    CreatedByUser,
    CreatedDate,
    Title,
    MoreLink,
    MobileMoreLink,
    ExpireDate,
    Description
)

VALUES
(
    @ModuleID,
    @UserName,
    GetDate(),
    @Title,
    @MoreLink,
    @MobileMoreLink,
    @ExpireDate,
    @Description
)

SELECT
    @ItemID = @@Identity


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE AddContact
(
    @ModuleID int,
    @UserName nvarchar(100),
    @Name     nvarchar(50),
    @Role     nvarchar(100),
    @Email    nvarchar(100),
    @Contact1 nvarchar(250),
    @Contact2 nvarchar(250),
    @ItemID   int OUTPUT
)
AS

INSERT INTO Contacts
(
    CreatedByUser,
    CreatedDate,
    ModuleID,
    Name,
    Role,
    Email,
    Contact1,
    Contact2
)

VALUES
(
    @UserName,
    GetDate(),
    @ModuleID,
    @Name,
    @Role,
    @Email,
    @Contact1,
    @Contact2
)

SELECT
    @ItemID = @@Identity


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE AddEvent
(
    @ModuleID    int,
    @UserName    nvarchar(100),
    @Title       nvarchar(100),
    @ExpireDate  DateTime,
    @Description nvarchar(2000),
    @WhereWhen   nvarchar(100),
    @ItemID      int OUTPUT
)
AS

INSERT INTO Events
(
    ModuleID,
    CreatedByUser,
    Title,
    CreatedDate,
    ExpireDate,
    Description,
    WhereWhen
)

VALUES
(
    @ModuleID,
    @UserName,
    @Title,
    GetDate(),
    @ExpireDate,
    @Description,
    @WhereWhen
)

SELECT
    @ItemID = @@Identity


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE AddLink
(
    @ModuleID    int,
    @UserName    nvarchar(100),
    @Title       nvarchar(100),
    @Url         nvarchar(250),
    @MobileUrl   nvarchar(250),
    @ViewOrder   int,
    @Description nvarchar(2000),
    @ItemID      int OUTPUT
)
AS

INSERT INTO Links
(
    ModuleID,
    CreatedByUser,
    CreatedDate,
    Title,
    Url,
    MobileUrl,
    ViewOrder,
    Description
)
VALUES
(
    @ModuleID,
    @UserName,
    GetDate(),
    @Title,
    @Url,
    @MobileUrl,
    @ViewOrder,
    @Description
)

SELECT
    @ItemID = @@Identity


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO



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
DECLARE @ParentDisplayOrder as nvarchar(750)

SET @ParentDisplayOrder = ""

SELECT 
    @ParentDisplayOrder = DisplayOrder
FROM 
    Discussion 
WHERE 
    ItemID = @ParentID

INSERT INTO Discussion
(
    Title,
    Body,
    DisplayOrder,
    CreatedDate, 
    CreatedByUser,
    ModuleID
)

VALUES
(
    @Title,
    @Body,
    @ParentDisplayOrder + CONVERT( nvarchar(24), GetDate(), 21 ),
    GetDate(),
    @UserName,
    @ModuleID
)

SELECT 
    @ItemID = @@Identity


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE AddModule
(
    @TabID          int,
    @ModuleOrder    int,
    @ModuleTitle    nvarchar(256),
    @PaneName       nvarchar(50),
    @ModuleDefID    int,
    @CacheTime      int,
    @EditRoles      nvarchar(256),
    @ShowMobile     bit,
    @ModuleID       int OUTPUT
)
AS

INSERT INTO Modules (
    TabID,
    ModuleOrder,
    ModuleTitle,
    PaneName,
    ModuleDefID,
    CacheTime,
    AuthorizedEditRoles,
    ShowMobile
) 
VALUES (
    @TabID,
    @ModuleOrder,
    @ModuleTitle,
    @PaneName,
    @ModuleDefID,
    @CacheTime,
    @EditRoles,
    @ShowMobile
)

SELECT 
    @ModuleID = @@Identity


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE AddModuleDefinition
(
    @PortalID     int,
    @FriendlyName nvarchar(128),
    @DesktopSrc   nvarchar(256),
    @MobileSrc    nvarchar(256),
    @ModuleDefID  int OUTPUT
)
AS

INSERT INTO ModuleDefinitions
(
    PortalID,
    FriendlyName,
    DesktopSrc,
    MobileSrc
)

VALUES
(
    @PortalID,
    @FriendlyName,
    @DesktopSrc,
    @MobileSrc
)

SELECT
    @ModuleDefID = @@Identity


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE AddRole
(
    @PortalID    int,
    @RoleName    nvarchar(50),
    @RoleID      int OUTPUT
)
AS

INSERT INTO Roles
(
    PortalID,
    RoleName
)

VALUES
(
    @PortalID,
    @RoleName
)

SELECT
    @RoleID = @@Identity


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE AddTab
(
    @PortalID   int,
    @TabName    nvarchar(50),
    @TabOrder   int,
    @AuthorizedRoles nvarchar (256),
    @MobileTabName nvarchar(50),
    @TabID      int OUTPUT
)
AS

INSERT INTO Tabs
(
    PortalID,
    TabName,
    TabOrder,
    ShowMobile,
    MobileTabName,
    AuthorizedRoles
)

VALUES
(
    @PortalID,
    @TabName,
    @TabOrder,
    0, /* false */
    @MobileTabName,
    @AuthorizedRoles
)

SELECT
    @TabID = @@Identity


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE Procedure AddUser
(
    @Name     nvarchar(50),
    @Email    nvarchar(100),
    @Password nvarchar(20),
    @UserID   int OUTPUT
)
AS

INSERT INTO Users
(
    Name,
    Email,
    Password
)

VALUES
(
    @Name,
    @Email,
    @Password
)

SELECT
    @UserID = @@Identity



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE Procedure AddUserRole
(
    @UserID int,
    @RoleID int
)
AS

SELECT 
    *
FROM
    UserRoles

WHERE
    UserID=@UserID
    AND
    RoleID=@RoleID

/* only insert if the record doesn't yet exist */
IF @@Rowcount < 1

    INSERT INTO UserRoles
    (
        UserID,
        RoleID
    )

    VALUES
    (
        @UserID,
        @RoleID
    )


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE DeleteAnnouncement
(
    @ItemID int
)
AS

DELETE FROM
    Announcements

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


CREATE PROCEDURE DeleteContact
(
    @ItemID int
)
AS

DELETE FROM
    Contacts

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


CREATE PROCEDURE DeleteDocument
(
    @ItemID int
)
AS

DELETE FROM
    Documents

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


CREATE PROCEDURE DeleteEvent
(
    @ItemID int
)
AS

DELETE FROM
    Events

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


CREATE PROCEDURE DeleteLink
(
    @ItemID int
)
AS

DELETE FROM
    Links

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


CREATE PROCEDURE DeleteModule
(
    @ModuleID       int
)
AS

DELETE FROM 
    Modules 
WHERE 
    ModuleID = @ModuleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE DeleteModuleDefinition
(
    @ModuleDefID int
)
AS

DELETE FROM
    ModuleDefinitions

WHERE
    ModuleDefID = @ModuleDefID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE DeleteRole
(
    @RoleID int
)
AS

DELETE FROM
    Roles

WHERE
    RoleID = @RoleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE DeleteTab
(
    @TabID int
)
AS

DELETE FROM
    Tabs

WHERE
    TabID = @TabID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE DeleteUser
(
    @UserID int
)
AS

DELETE FROM
    Users

WHERE
    UserID=@UserID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE DeleteUserRole
(
    @UserID int,
    @RoleID int
)
AS

DELETE FROM
    UserRoles

WHERE
    UserID=@UserID
    AND
    RoleID=@RoleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE GetAnnouncements
(
    @ModuleID int
)
AS

SELECT
    ItemID,
    CreatedByUser,
    CreatedDate,
    Title,
    MoreLink,
    MobileMoreLink,
    ExpireDate,
    Description

FROM 
    Announcements

WHERE
    ModuleID = @ModuleID
  AND
    ExpireDate > GetDate()


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE GetAuthRoles
(
    @PortalID    int,
    @ModuleID    int,
    @AccessRoles nvarchar (256) OUTPUT,
    @EditRoles   nvarchar (256) OUTPUT
)
AS

SELECT  
    @AccessRoles = Tabs.AuthorizedRoles,
    @EditRoles   = Modules.AuthorizedEditRoles
    
FROM    
    Modules
  INNER JOIN
    Tabs ON Modules.TabID = Tabs.TabID
    
WHERE   
    Modules.ModuleID = @ModuleID
  AND
    Tabs.PortalID = @PortalID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE GetContacts
(
    @ModuleID int
)
AS

SELECT
    ItemID,
    CreatedDate,
    CreatedByUser,
    Name,
    Role,
    Email,
    Contact1,
    Contact2

FROM
    Contacts

WHERE
    ModuleID = @ModuleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE GetDocumentContent
(
    @ItemID int
)
AS

SELECT
    Content,
    ContentType,
    ContentSize,
    FileFriendlyName

FROM
    Documents

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


CREATE PROCEDURE GetDocuments
(
    @ModuleID int
)
AS

SELECT
    ItemID,
    FileFriendlyName,
    FileNameUrl,
    CreatedByUser,
    CreatedDate,
    Category,
    ContentSize
    
FROM
    Documents

WHERE
    ModuleID = @ModuleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE GetEvents
(
    @ModuleID int
)
AS

SELECT
    ItemID,
    Title,
    CreatedByUser,
    WhereWhen,
    CreatedDate,
    Title,
    ExpireDate,
    Description

FROM
    Events

WHERE
    ModuleID = @ModuleID
  AND
    ExpireDate > GetDate()


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE GetHtmlText
(
    @ModuleID int
)
AS

SELECT
    *

FROM
    HtmlText

WHERE
    ModuleID = @ModuleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE GetLinks
(
    @ModuleID int
)
AS

SELECT
    ItemID,
    CreatedByUser,
    CreatedDate,
    Title,
    Url,
    ViewOrder,
    Description

FROM
    Links

WHERE
    ModuleID = @ModuleID

ORDER BY
    ViewOrder


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* returns all module definitions for the specified portal */
CREATE PROCEDURE GetModuleDefinitions
(
    @PortalID  int
)
AS

SELECT  
    FriendlyName,
    DesktopSrc,
    MobileSrc,
    ModuleDefID

FROM
    ModuleDefinitions
    
WHERE   
    PortalID = @PortalID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE GetModuleSettings
(
    @ModuleID int
)
AS

SELECT
    SettingName,
    SettingValue

FROM
    ModuleSettings

WHERE
    ModuleID = @ModuleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


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



/* returns all roles for the specified portal */
CREATE PROCEDURE GetPortalRoles
(
    @PortalID  int
)
AS

SELECT  
    RoleName,
    RoleID

FROM
    Roles

WHERE   
    PortalID = @PortalID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE GetPortalSettings
(
    @PortalAlias   nvarchar(50),
    @TabID         int,
    @PortalID      int OUTPUT,
    @PortalName    nvarchar(128) OUTPUT,
    @AlwaysShowEditButton bit OUTPUT,
    @TabName       nvarchar (50)  OUTPUT,
    @TabOrder      int OUTPUT,
    @MobileTabName nvarchar (50)  OUTPUT,
    @AuthRoles     nvarchar (256) OUTPUT,
    @ShowMobile    bit OUTPUT
)
AS

/* First, get Out Params */
IF @TabID = 0 
    SELECT TOP 1
        @PortalID      = Portals.PortalID,
        @PortalName    = Portals.PortalName,
        @AlwaysShowEditButton = Portals.AlwaysShowEditButton,
        @TabID         = Tabs.TabID,
        @TabOrder      = Tabs.TabOrder,
        @TabName       = Tabs.TabName,
        @MobileTabName = Tabs.MobileTabName,
        @AuthRoles     = Tabs.AuthorizedRoles,
        @ShowMobile    = Tabs.ShowMobile

    FROM
        Tabs
    INNER JOIN
        Portals ON Tabs.PortalID = Portals.PortalID
        
    WHERE
        PortalAlias=@PortalAlias
        
    ORDER BY
        TabOrder

ELSE 
    SELECT
        @PortalID      = Portals.PortalID,
        @PortalName    = Portals.PortalName,
        @AlwaysShowEditButton = Portals.AlwaysShowEditButton,
        @TabName       = Tabs.TabName,
        @TabOrder      = Tabs.TabOrder,
        @MobileTabName = Tabs.MobileTabName,
        @AuthRoles     = Tabs.AuthorizedRoles,
        @ShowMobile    = Tabs.ShowMobile

    FROM
        Tabs
    INNER JOIN
        Portals ON Tabs.PortalID = Portals.PortalID
        
    WHERE
        TabID=@TabID

/* Get Tabs list */
SELECT  
    TabName,
    AuthorizedRoles,
    TabID,
    TabOrder
    
FROM    
    Tabs
    
WHERE   
    PortalID = @PortalID
    
ORDER BY
    TabOrder

/* Get Mobile Tabs list */
SELECT  
    MobileTabName,
    AuthorizedRoles,
    TabID,
    ShowMobile
    
FROM    
    Tabs
    
WHERE   
    PortalID = @PortalID
  AND
    ShowMobile = 1
    
ORDER BY
    TabOrder

/* Then, get the DataTable of module info */
SELECT  
    *
    
FROM
    Modules
  INNER JOIN
    ModuleDefinitions ON Modules.ModuleDefID = ModuleDefinitions.ModuleDefID
    
WHERE   
    TabID = @TabID
    
ORDER BY
    ModuleOrder


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


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



/* returns all members for the specified role */
CREATE PROCEDURE GetRoleMembership
(
    @RoleID  int
)
AS

SELECT  
    UserRoles.UserID,
    Name,
    Email

FROM
    UserRoles
    
INNER JOIN 
    Users On Users.UserID = UserRoles.UserID

WHERE   
    UserRoles.RoleID = @RoleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* returns all roles for the specified user */
CREATE PROCEDURE GetRolesByUser
(
    @Email         nvarchar(100)
)
AS

SELECT  
    Roles.RoleName,
    Roles.RoleID

FROM
    UserRoles
  INNER JOIN 
    Users ON UserRoles.UserID = Users.UserID
  INNER JOIN 
    Roles ON UserRoles.RoleID = Roles.RoleID

WHERE   
    Users.Email = @Email


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE GetSingleAnnouncement
(
    @ItemID int
)
AS

SELECT
    CreatedByUser,
    CreatedDate,
    Title,
    MoreLink,
    MobileMoreLink,
    ExpireDate,
    Description

FROM
    Announcements

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



CREATE PROCEDURE GetSingleContact
(
    @ItemID int
)
AS

SELECT
    CreatedByUser,
    CreatedDate,
    Name,
    Role,
    Email,
    Contact1,
    Contact2

FROM
    Contacts

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


CREATE PROCEDURE GetSingleDocument
(
    @ItemID int
)
AS

SELECT
    FileFriendlyName,
    FileNameUrl,
    CreatedByUser,
    CreatedDate,
    Category,
    ContentSize

FROM
    Documents

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


CREATE PROCEDURE GetSingleEvent
(
    @ItemID int
)
AS

SELECT
    CreatedByUser,
    CreatedDate,
    Title,
    ExpireDate,
    Description,
    WhereWhen

FROM
    Events

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


CREATE PROCEDURE GetSingleLink
(
    @ItemID int
)
AS

SELECT
    CreatedByUser,
    CreatedDate,
    Title,
    Url,
    MobileUrl,
    ViewOrder,
    Description

FROM
    Links

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


CREATE Procedure GetSingleMessage
(
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
    DisplayOrder,
    NextMessageID = @nextMessageID,
    PrevMessageID = @prevMessageID

FROM
    Discussion

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


CREATE PROCEDURE GetSingleModuleDefinition
(
    @ModuleDefID int
)
AS

SELECT
    FriendlyName,
    DesktopSrc,
    MobileSrc

FROM
    ModuleDefinitions

WHERE
    ModuleDefID = @ModuleDefID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE GetSingleRole
(
    @RoleID int
)
AS

SELECT
    RoleName

FROM
    Roles

WHERE
    RoleID = @RoleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE GetSingleUser
(
    @Email nvarchar(100)
)
AS

SELECT
    Email,
    Password,
    Name

FROM
    Users

WHERE
    Email = @Email


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE GetThreadMessages
(
    @Parent nvarchar(750)
)
AS

SELECT
    ItemID,
    DisplayOrder,
    REPLICATE( '&nbsp;', ( ( LEN( DisplayOrder ) / 23 ) - 1 ) * 5 ) AS Indent,
    Title,  
    CreatedByUser,
    CreatedDate,
    Body

FROM 
    Discussion

WHERE
    LEFT(DisplayOrder, 23) = @Parent
  AND
    (LEN( DisplayOrder ) / 23 ) > 1

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


CREATE PROCEDURE GetTopLevelMessages
(
    @ModuleID int
)
AS

SELECT
    ItemID,
    DisplayOrder,
    LEFT(DisplayOrder, 23) AS Parent,    
    (SELECT COUNT(*) -1  FROM Discussion Disc2 WHERE LEFT(Disc2.DisplayOrder,LEN(RTRIM(Disc.DisplayOrder))) = Disc.DisplayOrder) AS ChildCount,
    Title,  
    CreatedByUser,
    CreatedDate

FROM 
    Discussion Disc

WHERE 
    ModuleID=@ModuleID
  AND
    (LEN( DisplayOrder ) / 23 ) = 1

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



CREATE PROCEDURE GetUsers
AS

SELECT  
    UserID,
    Email

FROM
    Users
    
ORDER BY Email



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE UpdateAnnouncement
(
    @ItemID         int,
    @UserName       nvarchar(100),
    @Title          nvarchar(150),
    @MoreLink       nvarchar(150),
    @MobileMoreLink nvarchar(150),
    @ExpireDate     datetime,
    @Description    nvarchar(2000)
)
AS

UPDATE
    Announcements

SET
    CreatedByUser   = @UserName,
    CreatedDate     = GetDate(),
    Title           = @Title,
    MoreLink        = @MoreLink,
    MobileMoreLink  = @MobileMoreLink,
    ExpireDate      = @ExpireDate,
    Description     = @Description

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


CREATE PROCEDURE UpdateContact
(
    @ItemID   int,
    @UserName nvarchar(100),
    @Name     nvarchar(50),
    @Role     nvarchar(100),
    @Email    nvarchar(100),
    @Contact1 nvarchar(250),
    @Contact2 nvarchar(250)
)
AS

UPDATE
    Contacts

SET
    CreatedByUser = @UserName,
    CreatedDate   = GetDate(),
    Name          = @Name,
    Role          = @Role,
    Email         = @Email,
    Contact1      = @Contact1,
    Contact2      = @Contact2

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


CREATE PROCEDURE UpdateDocument
(
    @ItemID           int,
    @ModuleID         int,
    @FileFriendlyName nvarchar(150),
    @FileNameUrl      nvarchar(250),
    @UserName         nvarchar(100),
    @Category         nvarchar(50),
    @Content          image,
    @ContentType      nvarchar(50),
    @ContentSize      int
)
AS
IF (@ItemID=0) OR NOT EXISTS (
    SELECT 
        * 
    FROM 
        Documents 
    WHERE 
        ItemID = @ItemID
)
INSERT INTO Documents
(
    ModuleID,
    FileFriendlyName,
    FileNameUrl,
    CreatedByUser,
    CreatedDate,
    Category,
    Content,
    ContentType,
    ContentSize
)

VALUES
(
    @ModuleID,
    @FileFriendlyName,
    @FileNameUrl,
    @UserName,
    GetDate(),
    @Category,
    @Content,
    @ContentType,
    @ContentSize
)
ELSE

BEGIN

IF (@ContentSize=0)

UPDATE 
    Documents

SET 
    CreatedByUser    = @UserName,
    CreatedDate      = GetDate(),
    Category         = @Category,
    FileFriendlyName = @FileFriendlyName,
    FileNameUrl      = @FileNameUrl

WHERE
    ItemID = @ItemID
ELSE

UPDATE
    Documents

SET
    CreatedByUser     = @UserName,
    CreatedDate       = GetDate(),
    Category          = @Category,
    FileFriendlyName  = @FileFriendlyName,
    FileNameUrl       = @FileNameUrl,
    Content           = @Content,
    ContentType       = @ContentType,
    ContentSize       = @ContentSize

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



CREATE PROCEDURE UpdateEvent
(
    @ItemID      int,
    @UserName    nvarchar(100),
    @Title       nvarchar(100),
    @ExpireDate  datetime,
    @Description nvarchar(2000),
    @WhereWhen   nvarchar(100)
)

AS

UPDATE
    Events

SET
    CreatedByUser = @UserName,
    CreatedDate   = GetDate(),
    Title         = @Title,
    ExpireDate    = @ExpireDate,
    Description   = @Description,
    WhereWhen     = @WhereWhen

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



CREATE PROCEDURE UpdateHtmlText
(
    @ModuleID      int,
    @DesktopHtml   ntext,
    @MobileSummary ntext,
    @MobileDetails ntext
)
AS

IF NOT EXISTS (
    SELECT 
        * 
    FROM 
        HtmlText 
    WHERE 
        ModuleID = @ModuleID
)
INSERT INTO HtmlText (
    ModuleID,
    DesktopHtml,
    MobileSummary,
    MobileDetails
) 
VALUES (
    @ModuleID,
    @DesktopHtml,
    @MobileSummary,
    @MobileDetails
)
ELSE
UPDATE
    HtmlText

SET
    DesktopHtml   = @DesktopHtml,
    MobileSummary = @MobileSummary,
    MobileDetails = @MobileDetails

WHERE
    ModuleID = @ModuleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE UpdateLink
(
    @ItemID      int,
    @UserName    nvarchar(100),
    @Title       nvarchar(100),
    @Url         nvarchar(250),
    @MobileUrl   nvarchar(250),
    @ViewOrder   int,
    @Description nvarchar(2000)
)
AS

UPDATE
    Links

SET
    CreatedByUser = @UserName,
    CreatedDate   = GetDate(),
    Title         = @Title,
    Url           = @Url,
    MobileUrl     = @MobileUrl,
    ViewOrder     = @ViewOrder,
    Description   = @Description

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


CREATE PROCEDURE UpdateModule
(
    @ModuleID       int,
    @ModuleOrder    int,
    @ModuleTitle    nvarchar(256),
    @PaneName       nvarchar(50),
    @CacheTime      int,
    @EditRoles      nvarchar(256),
    @ShowMobile     bit
)
AS

UPDATE
    Modules

SET
    ModuleOrder = @ModuleOrder,
    ModuleTitle = @ModuleTitle,
    PaneName    = @PaneName,
    CacheTime   = @CacheTime,
    ShowMobile  = @ShowMobile,
    AuthorizedEditRoles = @EditRoles

WHERE
    ModuleID = @ModuleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE UpdateModuleDefinition
(
    @ModuleDefID   int,
    @FriendlyName  nvarchar(128),
    @DesktopSrc    nvarchar(256),
    @MobileSrc     nvarchar(256)
)
AS

UPDATE
    ModuleDefinitions

SET
    FriendlyName = @FriendlyName,
    DesktopSrc   = @DesktopSrc,
    MobileSrc    = @MobileSrc

WHERE
    ModuleDefID = @ModuleDefID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE UpdateModuleOrder
(
    @ModuleID           int,
    @ModuleOrder        int,
    @PaneName           nvarchar(50)
)
AS

UPDATE
    Modules

SET
    ModuleOrder = @ModuleOrder,
    PaneName    = @PaneName

WHERE
    ModuleID = @ModuleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE UpdateModuleSetting
(
    @ModuleID      int,
    @SettingName   nvarchar(50),
    @SettingValue  nvarchar(256)
)
AS

IF NOT EXISTS (
    SELECT 
        * 
    FROM 
        ModuleSettings 
    WHERE 
        ModuleID = @ModuleID
      AND
        SettingName = @SettingName
)
INSERT INTO ModuleSettings (
    ModuleID,
    SettingName,
    SettingValue
) 
VALUES (
    @ModuleID,
    @SettingName,
    @SettingValue
)
ELSE
UPDATE
    ModuleSettings

SET
    SettingValue = @SettingValue

WHERE
    ModuleID = @ModuleID
  AND
    SettingName = @SettingName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE UpdatePortalInfo
(
    @PortalID           int,
    @PortalName         nvarchar(50),
    @AlwaysShowEditButton bit 
)
AS

UPDATE
    Portals

SET
    PortalName = @PortalName,
    AlwaysShowEditButton = @AlwaysShowEditButton

WHERE
    PortalID = @PortalID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE UpdateRole
(
    @RoleID      int,
    @RoleName    nvarchar(50)
)
AS

UPDATE
    Roles

SET
    RoleName = @RoleName

WHERE
    RoleID = @RoleID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE UpdateTab
(
    @PortalID        int,
    @TabID           int,
    @TabOrder        int,
    @TabName         nvarchar(50),
    @AuthorizedRoles nvarchar(256),
    @MobileTabName   nvarchar(50),
    @ShowMobile      bit
)
AS
IF NOT EXISTS (
    SELECT 
        * 
    FROM 
        Tabs 
    WHERE 
        TabID = @TabID
)
INSERT INTO Tabs (
    PortalID,
    TabOrder,
    TabName,
    AuthorizedRoles,
    MobileTabName,
    ShowMobile
) 
VALUES (
    @PortalID,
    @TabOrder,
    @TabName,
    @AuthorizedRoles,
    @MobileTabName,
    @ShowMobile
   
)
ELSE
UPDATE
    Tabs

SET
    TabOrder = @TabOrder,
    TabName = @TabName,
    AuthorizedRoles = @AuthorizedRoles,
    MobileTabName = @MobileTabName,
    ShowMobile = @ShowMobile
WHERE
    TabID = @TabID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE UpdateTabOrder
(
    @TabID           int,
    @TabOrder        int
)
AS

UPDATE
    Tabs

SET
    TabOrder = @TabOrder

WHERE
    TabID = @TabID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE UpdateUser
(
    @UserID        int,
    @Email           nvarchar(100),
    @Password    nvarchar(20)
)
AS

UPDATE
    Users

SET
    Email    = @Email,
    Password = @Password

WHERE
    UserId    = @UserID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE Procedure UserLogin
(
    @Email    nvarchar(100),
    @Password nvarchar(20),
    @UserName nvarchar(100) OUTPUT
)
AS

SELECT
    @UserName = Name

FROM
    Users

WHERE
    Email = @Email
  AND
    Password = @Password


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


--
-- End make objects
-- 

-- =======================================================
-- INSERT INITIAL DATA INTO IBUYSPY Portal DB
-- =======================================================

-- point to proper DB 
use [Portal]
GO

-- insert some initial template values
INSERT INTO PORTALS (PortalAlias,PortalName,AlwaysShowEditButton) VALUES ("unused","Unused Portal",0)
INSERT INTO TABS (TabOrder,PortalID,TabName,MobileTabName,AuthorizedRoles,ShowMobile) VALUES (0,-1,"Unused Tab","Unused Tab","All Users;",0)
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Announcements","DesktopModules/Announcements.ascx","MobileModules/Announcements.ascx")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Contacts","DesktopModules/Contacts.ascx","MobileModules/Contacts.ascx")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Discussion","DesktopModules/Discussion.ascx","")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Events","DesktopModules/Events.ascx","MobileModules/Events.ascx")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Html Document","DesktopModules/HtmlModule.ascx","MobileModules/Text.ascx")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Image","DesktopModules/ImageModule.ascx","")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Links","DesktopModules/Links.ascx","MobileModules/Links.ascx")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"QuickLinks","DesktopModules/QuickLinks.ascx","MobileModules/Links.ascx")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"XML/XSL","DesktopModules/XmlModule.ascx","")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Documents","DesktopModules/Document.ascx","")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Module Types (Admin)","Admin/ModuleDefs.ascx","")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Roles (Admin)","Admin/Roles.ascx","")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Tabs (Admin)","Admin/Tabs.ascx","")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Site Settings (Admin)","Admin/SiteSettings.ascx","")
INSERT INTO ModuleDefinitions(PortalID,FriendlyName,DesktopSrc,MobileSrc) VALUES (0,"Manage Users (Admin)","Admin/Users.ascx","")
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (0,1,1,"","Unused Module","All Users;",0,0)

-- insert templated records for each module type
INSERT INTO LINKS (ModuleID) VALUES (0)
INSERT INTO EVENTS (ModuleID) VALUES (0)
INSERT INTO ANNOUNCEMENTS (ModuleID) VALUES (0)
INSERT INTO CONTACTS (ModuleID) VALUES (0)
INSERT INTO DOCUMENTS (ModuleID) VALUES (0)
INSERT INTO DISCUSSION (ModuleID, Title, Body, DisplayOrder, CreatedByUser) VALUES (0,"","","","")

-- insert default IBuySpy Store data
INSERT INTO PORTALS (PortalAlias,PortalName,AlwaysShowEditButton) VALUES ("p_default","IBuySpy Portal",0)
INSERT INTO ROLES (PortalID,RoleName) VALUES (0,"Admins")
INSERT INTO USERS (Name, Password, Email) VALUES ('Guest','guest','guest')
INSERT INTO UserRoles (UserID,RoleID) VALUES (1,0)
INSERT INTO TABS (TabOrder,PortalID,TabName,MobileTabName,AuthorizedRoles,ShowMobile) VALUES (0,0,"Home","Home","All Users;",1)
INSERT INTO TABS (TabOrder,PortalID,TabName,MobileTabName,AuthorizedRoles,ShowMobile) VALUES (1,0,"Employee Info","HR","All Users;",1)
INSERT INTO TABS (TabOrder,PortalID,TabName,MobileTabName,AuthorizedRoles,ShowMobile) VALUES (2,0,"Product Info","Products","All Users;",1)
INSERT INTO TABS (TabOrder,PortalID,TabName,MobileTabName,AuthorizedRoles,ShowMobile) VALUES (3,0,"Discussions","Discussions","All Users;",0)
INSERT INTO TABS (TabOrder,PortalID,TabName,MobileTabName,AuthorizedRoles,ShowMobile) VALUES (4,0,"About the Portal","About","All Users;",1)
INSERT INTO TABS (TabOrder,PortalID,TabName,MobileTabName,AuthorizedRoles,ShowMobile) VALUES (5,0,"Admin","Admin","Admins;",0)

INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (1,8,1,"LeftPane","Quick Links","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (1,5,1,"ContentPane","Welcome to the IBuySpy Portal","Admins",0,1)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (1,1,2,"ContentPane","News and Features","Admins",0,1)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (1,4,3,"ContentPane","Upcoming Events","Admins",0,1)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (1,5,1,"RightPane","This Week's Special","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (1,9,2,"RightPane","Top Movers","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (2,5,1,"LeftPane","Spy Diary","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (2,1,1,"ContentPane","HR/Benefits","Admins",0,1)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (2,2,2,"ContentPane","Employee Contact Information","Admins",0,1)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (2,10,3,"ContentPane","New Employee Documentation","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (3,5,1,"LeftPane","Spy Diary","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (3,1,1,"ContentPane","Competition: TradeCraft","Admins",0,1)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (3,1,2,"ContentPane","Competition: Surveillance","Admins",0,1)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (3,1,3,"ContentPane","Competition: Protection","Admins",0,1)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (3,6,1,"RightPane","Night Vision Goggles","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (3,8,2,"RightPane","Competitors to Watch","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (4,5,1,"LeftPane","Spy Diary","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (4,3,1,"ContentPane","TradeCraft Techniques and Gear","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (4,3,2,"ContentPane","Recipes From the Field","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (4,10,3,"ContentPane","GoodReads","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (5,8,1,"LeftPane","Quick Links","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (5,5,1,"ContentPane","About the IBuySpy Portal Sample","Admins",0,1)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (5,5,2,"ContentPane","Portal Tabs","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (5,5,3,"ContentPane","Portal Modules","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (5,5,4,"ContentPane","Managing the Portal","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (5,5,5,"ContentPane","Managing Portal Layout","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (5,5,6,"ContentPane","Managing User Security","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (6,11,1,"RightPane","Module Definitions","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (6,14,1,"ContentPane","Site Settings","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (6,13,2,"ContentPane","Tabs","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (6,12,3,"ContentPane","Security Roles","Admins",0,0)
INSERT INTO MODULES (TabID,ModuleDefID,ModuleOrder,PaneName,ModuleTitle,AuthorizedEditRoles,CacheTime,ShowMobile) VALUES (6,15,4,"ContentPane","Manage Users","Admins",0,0)

INSERT INTO ModuleSettings(ModuleID,SettingName,SettingValue) VALUES (6,"xmlsrc","~/data/sales.xml")
INSERT INTO ModuleSettings(ModuleID,SettingName,SettingValue) VALUES (6,"xslsrc","~/data/sales.xsl")
INSERT INTO ModuleSettings(ModuleID,SettingName,SettingValue) VALUES (15,"src","~/data/nightvis.gif")

INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (1,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","ASP.NET Site","http://www.asp.net","",1,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (1,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","GotDotNet.com","http://www.gotdotnet.com","",3,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (1,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","ASP.NET on MSDN","http://msdn.microsoft.com/net/aspnet","",5,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (1,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","QuickStart Samples","http://www.gotdotnet.com/quickstart/aspplus","",7,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (16,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","SpyWorld","http://www.SpyWorld.com","",1,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (16,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","SpyGear4U","http://www.SpyGear4U.com","",3,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (16,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","GlobalSpy","http://www.GlobalSpy.com","",5,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (16,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","SpyProducts","http://www.SpyProducts.com","",7,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (21,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","ASP.NET Site","http://www.asp.net","",1,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (21,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","GotDotNet.com","http://www.gotdotnet.com","",3,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (21,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","ASP.NET on MSDN","http://msdn.microsoft.com/net/aspnet","",5,"")
INSERT INTO LINKS (ModuleID,CreatedByUser,CreatedDate,Title,Url,MobileUrl,ViewOrder,Description) VALUES (21,"JennaJ@ibuyspy.com","2001-12-20 14:41:40.840","QuickStart Samples","http://www.gotdotnet.com/quickstart/aspplus","",7,"")

INSERT INTO EVENTS (ModuleID,CreatedByUser,CreatedDate,Title,ExpireDate,Description,WhereWhen) VALUES (4,"JennaJ@ibuyspy.com","2001-12-19 15:46:25.053","Spy-o-Rama","2005-12-31 00:00:00","It's back!  The premier regional swap meet for spy paraphernalia of every description.  Shop early for some amazing bargins.", "This Saturday, usual secret time and place...")
INSERT INTO EVENTS (ModuleID,CreatedByUser,CreatedDate,Title,ExpireDate,Description,WhereWhen) VALUES (4,"JennaJ@ibuyspy.com","2001-12-19 15:48:22.813","Dark Ops Sock Hop","2005-12-31 00:00:00","Back by popular demand!  Practice your surveillance of the opposite sex, and dance some too.  Great opportunity for a brush pass!", "Saturday, 8pm to ?, Dark Ops Cafe")

INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (8,"JennaJ@ibuyspy.com","2001-12-19 15:46:25.053","Open Enrollment and Payroll Checklist","~/admin/notimplemented.aspx?title=Open%20Enrollment%20and%20Payroll%20Checklist","","2005-12-31 00:00:00","Please take a few moments to review this year-end checklist that will guide you through the Benefits Open Enrollment process and instruct you on how to ensure your payroll information is accurate for 2001.")
INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (8,"JennaJ@ibuyspy.com","2001-12-19 15:49:05.603","Selecting Your Primary Care Provider","~/admin/notimplemented.aspx?title=Selecting%20Your%20Primary%20Care%20Provider","","2005-12-31 00:00:00","Learn how to find the Primary Care Provider (PCP) that best suits your needs with this list of things to think about and questions to ask yourself and your potential PCP.")
INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (3,"JennaJ@ibuyspy.com","2002-01-10 11:17:52.903","Q4 Sales Rise 200% Over Last Year","~/admin/notimplemented.aspx?title=Q4%20Sales%20Rise%20200%%20Over%20Last%20Year","","2005-12-31 00:00:00","IBuySpy online sales for the crucial fourth quarter of last year rose nearly 200% over the previous year, despite a lackluster holiday sales overall. ")
INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (13,"JennaJ@ibuyspy.com","2002-01-10 06:09:11.117","Envelope X-Ray Spray","http://www.spyworld.net/Surveil3.htm","","2005-12-31 00:00:00","Envelope X-RAY Spray turns opaque paper temporarily translucent, allowing the user to view the contents of an envelope without ever opening it. SpyWorld, $42.95.")
INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (13,"JennaJ@ibuyspy.com","2002-01-10 06:19:35.883","Wrist Watch Video Camera","http://www.spyworld.net/Surveil1.htm","","2005-12-31 00:00:00","This is not a device from a James bond movie, but a real, sophisticated video camera disguised as a watch.  SpyWorld, $489.95.")
INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (13,"JennaJ@ibuyspy.com","2002-01-10 10:43:59.150","Bionic Ear","http://www.spyworld.net/Surveil3.htm","","2005-12-31 00:00:00","Zoom in on a whisper at up to 100 yards away, door shutting at 4 blocks, dog barking up to 2 miles away.  SpyWorld, $198.95.")
INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (13,"JennaJ@ibuyspy.com","2002-01-10 10:44:18.217","CAMCopter","http://www.spyworld.com/camcopter.htm","","2005-12-31 00:00:00","The CAMCopter is a remotely controlled, autonomous Aerial Vehicle System developed under military specifications design to carry various sensors that transmit data and live video.  SpyWorld, $490,000.00.")
INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (12,"JennaJ@ibuyspy.com","2002-01-10 07:01:58.280","Ultraviolet Pen","http://www.spyproducts.com/Theftpowders1.html","","2005-12-31 00:00:00","This felt-tipped pen is an inexpensive and convenient ultraviolet writing instrument.  SpyProducts, $6.95.")
INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (12,"JennaJ@ibuyspy.com","2002-01-10 07:06:09.160","Micro Bug Detector ","http://www.spygear4u.com/hi_tech.htm","","2005-12-31 00:00:00","Covert bug detection probe for room sweeping include a vibration mode.  SpyGear4U, $399.00.")
INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (12,"JennaJ@ibuyspy.com","2002-01-10 07:09:51.920","Telephone Voice Changer","http://www.firstlineindustries.com/telvoicchani.html","","2005-12-31 00:00:00","Answer the telephone without anyone recognizing your voice.  FirstLine, $42.95.")
INSERT INTO ANNOUNCEMENTS (ModuleID,CreatedByUser,CreatedDate,Title,MoreLink,MobileMoreLink,ExpireDate,Description) VALUES (14,"JennaJ@ibuyspy.com","2002-01-10 06:57:28.190","Air Taser","http://www.spyworld.com/3005.htm","","2005-12-31 00:00:00","Uses compressed air to shoot two small probes up to 15 feet.  These probes are connected by wire to the launcher, which sends a powerful electric signal into the nervous system of an assailant.  SpyWorld, $285.95.")

INSERT INTO CONTACTS (ModuleID,CreatedByUser,CreatedDate,Name,Role,Email,Contact1,Contact2) VALUES (9,"JennaJ@ibuyspy.com","2001-12-20 12:58:58.250","JennaJ","Program Lead","JennaJ@ibuyspy.com","home: 206-555-4434","mobile: 206-555-8381")
INSERT INTO CONTACTS (ModuleID,CreatedByUser,CreatedDate,Name,Role,Email,Contact1,Contact2) VALUES (9,"JennaJ@ibuyspy.com","2001-12-20 13:00:19.057","ManishG","Technical Lead","ManishG@ibuyspy.com","home: 425-555-9008","mobile: 425-555-7665")
INSERT INTO CONTACTS (ModuleID,CreatedByUser,CreatedDate,Name,Role,Email,Contact1,Contact2) VALUES (9,"JennaJ@ibuyspy.com","2001-12-20 13:03:55.657","BrettH","Development Lead","BrettH@ibuyspy.com","home: 206-555-5580","mobile: 206-555-1323")
INSERT INTO CONTACTS (ModuleID,CreatedByUser,CreatedDate,Name,Role,Email,Contact1,Contact2) VALUES (9,"JennaJ@ibuyspy.com","2001-12-20 14:07:31.290","MaryK","Test Lead","MaryK@ibuyspy.com","home: 206-555-7729","mobile: 206-555-8585")
INSERT INTO CONTACTS (ModuleID,CreatedByUser,CreatedDate,Name,Role,Email,Contact1,Contact2) VALUES (9,"JennaJ@ibuyspy.com","2001-12-20 14:07:44.470","RajivP","Fullfillment Lead","RajivP@ibuyspy.com","home: 425-555-7787","mobile: 425-555-4443")
INSERT INTO CONTACTS (ModuleID,CreatedByUser,CreatedDate,Name,Role,Email,Contact1,Contact2) VALUES (9,"JennaJ@ibuyspy.com","2001-12-20 13:02:54.730","TomVZ","Secret Agent","TomVZ@ibuyspy.com","shoe phone: 206-555-4433","fountain pen: 206-555-9985")

INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (19,"Edible Tape Puttanesca","2001-12-20 14:10:36","Had this last night in the Dark Ops Cafe and -- WOW -- is it good!  Red sauce with olives, capers and anchovies.","2001-12-20 14:10:36.317","MaryK@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (19,"Re: Edible Tape Puttanesca","2001-12-20 14:11:59","Their Edible Tape Carbonara is terrific too.  I think they add number two pencil shavings.","2001-12-20 14:10:36.3172001-12-20 14:11:59.090","JennaJ@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (19,"Help - need a Survival Bar recipe","2001-12-20 14:25:41","My wife's boss is coming for dinner this week and we wanted to serve survival bar.  Anybody have a favorite recipe?","2001-12-20 14:25:41.333","RajivP@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (19,"Re: Help - need a Survival Bar recipe","2001-12-20 14:26:53","I saute it with some garlic and onions in butter and white wine.  When it softens up (about an hour), I finish the dish with a little lemon and pine nuts, and serve over edible tape.  Yum!","2001-12-20 14:25:41.3332001-12-20 14:26:53.180","ManishG@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (19,"Re: Help - need a Survival Bar recipe","2001-12-20 14:28:18","Survival bar can be pretty chewy, so I throw it in the pressure cooker for about a half hour with onions, carrots, celery and a bay leaf.","2001-12-20 14:25:41.3332001-12-20 14:28:18.367","TomVZ@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (19,"Re: Help - need a Survival Bar recipe","2001-12-20 14:29:25","There's just one thing that can improve a survival bar: Ketchup ;)","2001-12-20 14:25:41.3332001-12-20 14:28:18.3672001-12-20 14:29:25.987","BrettH@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (19,"Eat my shoelaces","2001-12-20 14:30:44","I just tried the new Glow in the Dark Shoelaces and they are *yummy*!  Even better with ketchup...","2001-12-20 14:30:44.013","BrettH@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (18,"What's the best dead drop mark?","2001-01-08 08:06:52","I know this is a total newbie question, but how do I mark a dead drop?  What's the best mark?","2001-01-08 08:06:51.607","MaryK@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (18,"Re: What's the best dead drop mark?","2001-01-08 08:07:59","I just use chalk.  It's fast, writes on just about anything, and doesn't stick around long enough to get noticed.","2001-01-08 08:06:51.6072001-01-08 08:07:59.177","JennaJ@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (18,"Re: What's the best dead drop mark?","2001-01-09 08:15:33","I use chalk too -- it's really easy to erase.","2001-01-08 08:06:51.6072001-01-08 08:07:59.1772001-01-09 08:15:32.970","BrettH@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (18,"Re: What's the best dead drop mark?","2001-01-09 08:14:57","There are several things to consider in making your mark: it has to made (and later erased) quickly and discretely, durable enough to stick around until it's read, easily ignored by passers by, and not missed when it's gone.  Lots of folks like chalk, but I find it washes away too easily in rainy weather.  Chewing gum (already chewed) works great, but you'll want to place it well below eye level lest some zealous maintenance worker cleans it off before it has done the job.","2001-01-08 08:06:51.6072001-01-09 08:14:57.357","TomVZ@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (18,"Best night vision gear for nocturnal paint ball?","2001-01-10 08:27:17","We're going to start playing paint ball at night, and I'm looking for recommendations.  What night vision gear is best for this?","2001-01-10 08:27:17.640","BrettH@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (18,"Re: Best night vision gear for nocturnal paint ball?","2001-01-10 08:34:34","Well, you definitely want to use the goggle type since you'll want your hands free (btw, I think you are crazy to play paintball at night).  The Viper 2 (<a href=""http://www.spyworld.com/Viper2.htm"">http://www.spyworld.com/Viper2.htm</a>) is pretty comfortable and not too pricey ($550, vs the thousands you pay for the military versions).  It has a built-in IR illuminator, which is a 'must have' in your application.  Best of all, it will make you look just like a Borg... :)","2001-01-10 08:27:17.6402001-01-10 08:34:34.810","TomVZ@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (18,"Foreign language terms for 'mole'?","2001-01-11 08:49:58","Anyone know where I can find this?","2001-01-10 08:49:57.503","JennaJ@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (18,"Re: Foreign language terms for 'mole'?","2001-01-11 08:53:56","There's a great dictionary for intelligence terms both in English and the languages of the other major intelligence agencies: <i>The CIA Insider's Dictionary of US and Foreign Intelligence, Counterintelligence & Tradecraft</i>.  Last time I looked Amazon offered it, but was out of stock.  Let me know if you want to borrow my copy.","2001-01-10 08:49:57.5032001-01-10 08:53:55.600","TomVZ@ibuyspy.com")
INSERT INTO DISCUSSION (ModuleID,Title,CreatedDate,Body,DisplayOrder,CreatedByUser) VALUES (18,"AMT Mini Night Vision Monocular","2001-01-12 09:16:00","Has anyone tried this yet?  It looks really good: tiny (9.5 oz), built-in IR illumination.  The only downside I see is that it seems to be limited to 1.5x magnification.","2001-01-12 09:15:59.640","ManishG@ibuyspy.com")

INSERT INTO DOCUMENTS (ModuleID,CreatedByUser,CreatedDate,FileNameUrl,FileFriendlyName,Category) VALUES (10,"JennaJ@ibuyspy.com","2001-12-20 12:35:01.883","~/uploads/sample.doc","Employee Handbook","New Employee Info")
INSERT INTO DOCUMENTS (ModuleID,CreatedByUser,CreatedDate,FileNameUrl,FileFriendlyName,Category) VALUES (10,"JennaJ@ibuyspy.com","2001-12-20 12:37:54.503","~/uploads/sample.doc","Annual Reviews","New Employee Info")
INSERT INTO DOCUMENTS (ModuleID,CreatedByUser,CreatedDate,FileNameUrl,FileFriendlyName,Category) VALUES (10,"JennaJ@ibuyspy.com","2001-12-20 12:39:09.890","~/uploads/sample.doc","Vacation Policy","New Employee Info")
INSERT INTO DOCUMENTS (ModuleID,CreatedByUser,CreatedDate,FileNameUrl,FileFriendlyName,Category) VALUES (20,"TomVZ@ibuyspy.com","2001-12-20 12:35:01.883","~/uploads/sample.doc","Secret Diary of a Field Operative","Dossiers")
INSERT INTO DOCUMENTS (ModuleID,CreatedByUser,CreatedDate,FileNameUrl,FileFriendlyName,Category) VALUES (20,"TomVZ@ibuyspy.com","2001-12-20 12:37:54.503","~/uploads/sample.doc","Toaster Boat Users Guide","Documentation")
INSERT INTO DOCUMENTS (ModuleID,CreatedByUser,CreatedDate,FileNameUrl,FileFriendlyName,Category) VALUES (20,"TomVZ@ibuyspy.com","2001-12-20 12:39:09.890","~/uploads/sample.doc","Mistranslated: Translator Moustache Meets Interpreter Earrings","Spy Humor")
INSERT INTO DOCUMENTS (ModuleID,CreatedByUser,CreatedDate,FileNameUrl,FileFriendlyName,Category) VALUES (20,"TomVZ@ibuyspy.com","2001-12-20 12:35:01.883","~/uploads/sample.doc","The Edible Tape Recipe Book","Documentation")

INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (2,"&lt;table cellSpacing=&quot;0&quot; cellPadding=&quot;5&quot; border=&quot;0&quot;&gt;
    &lt;tr valign=&quot;top&quot;&gt;
        &lt;td&gt;
            &lt;a target=&quot;_blank&quot; href=&quot;http://www.ibuyspy.com&quot;&gt;
                &lt;img src=&quot;data/logoneg.gif&quot; border=&quot;0&quot; align=&quot;left&quot; hspace=&quot;10&quot;&gt;
            &lt;/a&gt;
        &lt;/td&gt;
        &lt;td class=&quot;Normal&quot; width=&quot;100%&quot;&gt;
            Welcome to the &lt;b&gt;IBuySpy Portal&lt;/b&gt;, the Intranet Home for IBuySpy's corporate employees.  This site serves as the hub application for IBuySpy's internal operations.  It provides online news, event and sales information, along with interactive discussion forums and employee contact information.  In a nutshell, everything needed to maintain and run the fast-growing IBuySpy commercial empire.
            &lt;br&gt;
            &lt;br&gt;
            Feel free to browse the site and explore.  Sign in to obtain edit access to different modules within the framework, as well as view the restricted sections of the site.
        &lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;","Welcome to the &lt;b&gt;IBuySpy Portal&lt;/b&gt;, the Intranet Home for IBuySpy's corporate employees.","This site serves as the hub application for IBuySpy's internal operations.  It provides online news, event and sales information, along with interactive discussion forums and employee contact information.  In a nutshell, everything needed to maintain and run the fast-growing IBuySpy commercial empire.  Feel free to browse the site and explore.  

&lt;br&gt;&lt;br&gt;Sign in with a desktop browser to obtain edit access to different modules within the framework, as well as view the restricted sections of the site.
")
INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (5,"&lt;span class=&quot;Normal&quot;&gt;
The QLT2112 &lt;a href=&quot;http://www.ibuyspy.com/store/ProductDetails.aspx?productID=399&quot;&gt;&lt;b&gt;Document Transportation System&lt;/b&gt;&lt;/a&gt; is on special this week to clear an overstock.  Purchasers of the P38 &lt;a href=&quot;http://www.ibuyspy.com/store/ProductDetails.aspx?productID=357&quot;&gt;Escape Vehicle (Air)&lt;/a&gt; receive one free.
&lt;p&gt;
&lt;img align=&quot;left&quot; src=&quot;data/qlt2112.gif&quot;&gt;
&lt;/p&gt;
&lt;/span&gt;
","The QLT2112 &lt;a href=&quot;http://www.ibuyspy.com/store&quot;&gt;&lt;b&gt;Document Transportation System&lt;/b&gt;&lt;/a&gt; is on special this week to clear an overstock.","The QLT2112 &lt;a href=&quot;http://www.ibuyspy.com/store/ProductDetails.aspx?productID=399&quot;&gt;&lt;b&gt;Document Transportation System&lt;/b&gt;&lt;/a&gt; is on special this week to clear an overstock.  Purchasers of the P38 &lt;a href=&quot;http://www.ibuyspy.com/store/ProductDetails.aspx?productID=357&quot;&gt;Escape Vehicle (Air)&lt;/a&gt; receive one free.")
INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (7,"&lt;span class=&quot;Normal&quot;&gt;
&lt;img align=&quot;right&quot; hspace=&quot;0&quot; src=&quot;data/hart.gif&quot;&gt;
&lt;p&gt;&lt;b&gt;Nancy Hart&lt;/b&gt; served as a scout, guide and spy for the Confederate army, carrying messages between the Southern Armies. She hung around isolated Federal outposts, acting as a peddlar, to report their strength, population and vulnerability to General Jackson. Nancy was twenty years old when she was captured by the Yankees and jailed in a dilapidated house with guards constantly patrolling the building. Nancy gained the trust of one of her guards, got his weapon from him, shot him and escaped.&lt;/p&gt;
&lt;/span&gt;
","","")
INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (11,"&lt;table cellspacing=&quot;0&quot; cellpadding=&quot;0&quot; border=&quot;0&quot;&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
            &lt;img src=&quot;data/enigma.gif&quot;&gt;
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
            &lt;br&gt;The WWII &lt;b&gt;Enigma&lt;/b&gt; cypher was based on a system of three rotors that substituted cipher text letters for plain text letters. The innovation that made Enigma machine so powerful was the spinning of its rotors. As the plain text letter passed through the first rotor, the first rotor would rotate one position. The other two rotors would remain stationary until the first rotor had rotated 26 times. Then the second rotor would rotate one position. After the second rotor had rotated 26 times, the third rotor would rotate one position.  As a result, an 's' could be encoded as a 'b' in the first part of the message, and then as an 'm' later in the same message.  
        &lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;
","","")
INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (17,"&lt;span class=&quot;Normal&quot;&gt;
    &lt;img align=&quot;right&quot; hspace=&quot;0&quot; src=&quot;data/vanlew.gif&quot;&gt;
    &lt;p&gt;
        &lt;b&gt;Elizabeth Van Lew&lt;/b&gt; asked to be allowed to visit Union prisoners held by the Confederates in Richmond and began taking them food and medicines. She realized that many of the prisoners had been marched through Confederate lines on their way to Richmond and were full of useful information about Confederate movements. She became a spy for the North for the next four years, setting up a network of couriers, and devising a code. For her efforts during the Civil War, Elizabeth Van Lew was made Postmaster of Richmond by General Grant. 
    &lt;/p&gt;
&lt;/span&gt;
","","")
INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (22,"&lt;table cellspacing=0 cellpadding=0 border=0&gt;
    &lt;tr&gt;
        &lt;td class=Normal width=&quot;100%&quot;&gt;
            The &lt;b&gt;IBuySpy Portal&lt;/b&gt; Solution Starter Kit demonstrates how you can use ASP.NET and the .NET Framework to build a either an intranet or Internet portal application. &lt;b&gt;IBuySpy Portal&lt;/b&gt; offers all the functionality of typical portal applications, including:&lt;br&gt;&lt;br&gt;

            &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td width=&quot;140&quot;&gt;
                        &lt;image src=&quot;data/sample.gif&quot;&gt;
                    &lt;/td&gt;
                    &lt;td&gt;&amp;nbsp;&lt;/td&gt;
                    &lt;td class=&quot;Normal&quot; width=&quot;*&quot;&gt;

                        &lt;ul&gt;
                            &lt;li&gt;
                            &lt;a href=&quot;#basicmod&quot;&gt;10 basic portal modules&lt;/a&gt; for common types of content
                            &lt;li&gt;
                            A &quot;pluggable&quot; framework that is simple to extend with &lt;a href=&quot;#custommod&quot;&gt;custom portal modules&lt;/a&gt;
                            &lt;li&gt;
                            &lt;a href=&quot;#admintool&quot;&gt;Online administration&lt;/a&gt; of portal layout, content and security
                            &lt;li&gt;
                            &lt;a href=&quot;#security&quot;&gt;Roles-based security&lt;/a&gt; for viewing content, editing content, and administering 
                            the portal
                            &lt;/li&gt;
                        &lt;/ul&gt;


                        All code contained in the IBuySpy Portal download package is free for use
                in your own applications.  But if you prefer, you may customize the portal for your own use without writing a line of code.  The portal includes built-in Administration pages for setting up your portal, adding content, and setting security options.&lt;br&gt;
                    &lt;/td&gt;
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td colspan=3 class=&quot;Normal&quot;&gt;
                        &lt;br&gt;
                        &lt;u&gt;Getting Started with the IBuySpy Portal&lt;/u&gt;&lt;br&gt;
                        This page explains how users interact with the portal, and how to use the Administration tool to customize it.  To browse the source code and read about it works, click the &lt;a href=&quot;Docs/Docs.htm&quot; target=&quot;_new&quot;&gt;Portal Documentation&lt;/a&gt; link at the top of the page. 
                    &lt;/td&gt;
                &lt;/tr&gt;
        &lt;/table&gt;    
            
        &lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;","The &lt;b&gt;IBuySpy Portal&lt;/b&gt; Solution Starter Kit demonstrates how you can use ASP.NET and the .NET Framework to build a either an intranet or Internet portal application.","")
INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (23,"&lt;a name=&quot;tabs&quot;&gt;
&lt;table cellspacing=0 cellpadding=0 border=0&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot; width=&quot;100%&quot;&gt;

            Content in the portal is grouped by &lt;b&gt;Tabs&lt;/b&gt;.  For example, the IBuySpy portal has five content tabs:&lt;br&gt;&lt;br&gt;
            
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td&gt;
            &lt;img src=&quot;data/tabbar.gif&quot;&gt;    
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;

            You can create tabs that are visible only to certain users.  For example, you might create a private tab that only users in the &quot;Managers&quot; role can view.  See &lt;a href=&quot;#layout&quot;&gt;Managing Portal Layout&lt;/a&gt; to learn how to create a tab, and &lt;a href=&quot;#security&quot;&gt;Managing User Security&lt;/a&gt; to learn how to control access to a tab.
        
        &lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;
","","")
INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (24,"&lt;a name=&quot;modules&quot;&gt;
&lt;table cellspacing=0 cellpadding=5 border=0&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot; width=&quot;100%&quot;&gt;

            Portal Modules are modular pieces of code and UI that each present some functionality to the user, like a threaded discussion list, or render data, graphics and text, like a &quot;sales by region&quot; report.  Typically, several portal modules are grouped on a portal tab.  For example, the Home tab of the IBuySpy Portal has seven modules:&lt;br&gt;
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
            &lt;img align=&quot;left&quot; src=&quot;data/whataremodules.gif&quot;&gt;
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
            When a user browses a tab in the portal, the portal framework reads a description of the tab from it's configuration file, and automatically assembles a page from the portal modules associated with the tab.  The Home tab is composed from these modules:
            
            &lt;ol&gt;
            &lt;li&gt;&lt;u&gt;Sign-in module&lt;/u&gt;:  the portal framework inserts this module on the first tab automatically if the user is not yet authenticated.
            &lt;li&gt;&lt;u&gt;QuickLinks module&lt;/u&gt;:  a list of ASP.NET links rendered compactly.
            &lt;li&gt;&lt;u&gt;Html/Text module&lt;/u&gt;:  an Html snippet, including an image, that introduces the IBuySpy Portal.  An alternate, text-only version is supplied to Mobile users.
            &lt;li&gt;&lt;u&gt;Announcements module&lt;/u&gt;:  a list of IBuySpy news items, briefly summarized, with links for more information.
            &lt;li&gt;&lt;u&gt;Events module&lt;/u&gt;:  a list of upcoming IBuySpy events, including time, location and a brief description.
            &lt;li&gt;&lt;u&gt;Another Html/Text module&lt;/u&gt;:  an Html snippet, including an image, that describes this week's special on IBuySpy.com.
            &lt;li&gt;&lt;u&gt;XML module&lt;/u&gt;:  the results of an XSL/T transform on an XML file that shows recent revenue trends for IBuySpy.com.
            &lt;/ol&gt;
            
            &lt;a name=&quot;basicmod&quot;&gt;
            &lt;u&gt;Built-In Portal Modules&lt;/u&gt;
            &lt;br&gt;
            You can use multiple instances of a module type in the portal, for example an HR &lt;i&gt;Links&lt;/i&gt; module and a Products &lt;i&gt;Links&lt;/i&gt; module.  The IBuySpy Portal provides 10 basic Desktop module types, listed below.  Four of these--Announcements, Contacts, Events and HTML/Text--support an alternate rendering for Mobile devices.&lt;br&gt;&lt;br&gt;

            &lt;table cellpadding=&quot;5&quot; cellspacing=&quot;0&quot; border=&quot;0&quot;&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                        &lt;img align=&quot;right&quot; hspace=&quot;10&quot; vspace=&quot;10&quot; src=&quot;data/m_ann.gif&quot;&gt;

                        &lt;b&gt;Announcements&lt;/b&gt;&lt;br&gt;
                        This module renders a list of announcements. Each announcement includes title, text and a &quot;read more&quot; link, and can be set to automatically expire after a particular date.  Announcements includes an edit page, which allows authorized users to edit the data stored in the SQL database.
                    &lt;/td&gt;    
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                        &lt;img align=&quot;right&quot; hspace=&quot;10&quot; vspace=&quot;10&quot; src=&quot;data/m_con.gif&quot;&gt;

                        &lt;b&gt;Contacts&lt;/b&gt;&lt;br&gt;
                        This module renders contact information for a group of people, for example a project team.  The Mobile version of this module also provides a Call link to phone a contact when the module is browsed from a wireless telephone.  Contacts includes an edit page, which allows authorized users to edit the Contacts data stored in the SQL database.
                    &lt;/td&gt;    
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                        &lt;img align=&quot;right&quot; hspace=&quot;10&quot; vspace=&quot;10&quot; src=&quot;data/m_dsc.gif&quot;&gt;

                        &lt;b&gt;Discussion&lt;/b&gt;&lt;br&gt;
                        This module renders a group of message threads on a specific topic.  Discussion includes a Read/Reply Message page, which allows authorized users to reply to exising messages or add a new message thread.  The data for Discussion is stored in the SQL database.
                    &lt;/td&gt;    
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                        &lt;img align=&quot;right&quot; hspace=&quot;10&quot; vspace=&quot;10&quot; src=&quot;data/m_doc.gif&quot;&gt;

                        &lt;b&gt;Documents&lt;/b&gt;&lt;br&gt;
                        This module renders a list of documents, including links to browse or download the document.  Documents includes an edit page, which allows authorized users to edit the information about the Documents (for example, a friendly title) stored in the SQL database.  The document itself may be linked to via URL or uploaded and stored in the SQL database.
                    &lt;/td&gt;    
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                        &lt;img align=&quot;right&quot; hspace=&quot;10&quot; vspace=&quot;10&quot; src=&quot;data/m_evt.gif&quot;&gt;

                        &lt;b&gt;Events&lt;/b&gt;&lt;br&gt;
                        This module renders a list of upcoming events, including time and location.  Individual events can be set to automatically expire from the list after a particular date.  Events includes an edit page, which allows authorized users to edit the Events data stored in the SQL database.
                    &lt;/td&gt;    
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                        &lt;img align=&quot;right&quot; hspace=&quot;10&quot; vspace=&quot;10&quot; src=&quot;data/m_htm.gif&quot;&gt;

                        &lt;b&gt;Html/Text&lt;/b&gt;&lt;br&gt;
                        This module renders a snippet of HTML or text.  The Html/Text module includes an edit page, which allows authorized users to the HTML or text snippets directly.  The snippets are stored in the SQL database.
                    &lt;/td&gt;    
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                        &lt;img align=&quot;right&quot; hspace=&quot;10&quot; vspace=&quot;10&quot; src=&quot;data/m_img.gif&quot;&gt;

                        &lt;b&gt;Image&lt;/b&gt;&lt;br&gt;
                        This module renders an image using an HTML IMG tag.  The module simply sets the IMG tag's src attribute to a relative or absolute URL, so the image file does not need to reside within the portal.  The module also exposes height and width attributes, which permits you to scale the image.  Image includes an edit page, which persists these settings to the portal's configuration file.                        
                    &lt;/td&gt;    
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                        &lt;img align=&quot;right&quot; hspace=&quot;10&quot; vspace=&quot;10&quot; src=&quot;data/m_lnk.gif&quot;&gt;

                        &lt;b&gt;Links&lt;/b&gt;&lt;br&gt;
                        This module renders a list of hyperlinks.  Links includes an edit page, which allows authorized users to edit the Links data stored in the SQL database.
                    &lt;/td&gt;    
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                        &lt;img align=&quot;right&quot; hspace=&quot;10&quot; vspace=&quot;10&quot; src=&quot;data/m_ql.gif&quot;&gt;

                        &lt;b&gt;QuickLinks&lt;/b&gt;&lt;br&gt;
                        Like Links, this module renders a list of hyperlinks.  Rather than rendering it's title, however, QuickLinks shows the title &quot;Quick Launch.&quot;  It's compact rendering and generic title make it ideal for a set of 'global' links that appears on several tabs in the portal.  QuickLinks shares the Links edit page, which allows authorized users to edit the QuickLinks data stored in the SQL database.
                    &lt;/td&gt;    
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                        &lt;img align=&quot;right&quot; hspace=&quot;10&quot; vspace=&quot;10&quot; src=&quot;data/m_xml.gif&quot;&gt;

                        &lt;b&gt;Xml/Xsl&lt;/b&gt;&lt;br&gt;
                        This module renders the result of an XML/XSL transform.  The XML and XSL files are identified by their UNC paths in the xmlsrc and xslsrc properties of the module.  The Xml/Xsl module includes an edit page, which persists these settings to the SQL database.
                    &lt;/td&gt;    
                &lt;/tr&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        &lt;hr&gt;&lt;br&gt;
                    &lt;/td&gt;    
                &lt;/tr&gt;
            &lt;/table&gt;
            
            &lt;a name=&quot;custommod&quot;&gt;
            &lt;u&gt;Custom Portal Modules&lt;/u&gt;
            &lt;br&gt;
            You can create your own custom modules and add them to the portal framework.  See the &lt;a href=&quot;docs/docs.htm&quot;&gt;Portal Documentation&lt;/a&gt; for more information about how to create a custom module.&lt;br&gt;&lt;br&gt;
            See &lt;a href=&quot;#layout&quot;&gt;Managing Portal Layout&lt;/a&gt; below to learn about how to add your custom modules to the portal administration system.
            
        &lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;","","")
INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (25,"&lt;table cellspacing=0 cellpadding=5 border=0&gt;
    &lt;tr&gt;
        &lt;td&gt;
            &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td width=&quot;*&quot; class=&quot;Normal&quot;&gt;
                    
                        &lt;a name=&quot;admintool&quot;&gt;
                        &lt;u&gt;Using the Admin Tool&lt;/u&gt;&lt;br&gt;
                        The IBuySpy Portal provides an online Admin tool that authenticated users in the &quot;Admins&quot; role can use to set up the layout, content and security of the portal.&lt;br&gt;&lt;br&gt;

                        You must sign in on the Home tab to use the Admin tool.  If you've never signed in before, you'll need to add yourself to the portal database using the &quot;register&quot; button.  After signing in, you'll see a new tab called &quot;Admin&quot; at the top of the page.  Click it to go to the Admin tool.&lt;br&gt;&lt;br&gt;
        
                        
                        &lt;a name=&quot;sitesettings&quot;&gt;
                        &lt;u&gt;Site Settings&lt;/u&gt;&lt;br&gt;&lt;br&gt;
                        &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                            &lt;tr&gt;
                                &lt;td width=&quot;235&quot;&gt;
                                    &lt;img src=&quot;data/sitesettings.gif&quot;&gt;
                                &lt;/td&gt;
                            &lt;/tr&gt;
                            &lt;tr&gt;
                                &lt;td class=&quot;Normal&quot;&gt;
                                    &lt;br&gt;
                                    The &lt;b&gt;Site Settings&lt;/b&gt; section of the Admin tool lets you to set the portal's title, and whether to show edit links to all users.  When changing one of these settings, by sure to click the Apply Changes button at the bottom of the section.
                                &lt;/td&gt;
                            &lt;/tr&gt;
                       &lt;/table&gt;    

                    &lt;/td&gt;
                    &lt;td&gt;&amp;nbsp;&amp;nbsp;&lt;/td&gt;
                    &lt;td width=&quot;420&quot;&gt;
                        &lt;img src=&quot;data/admin.gif&quot;&gt;
                    &lt;/td&gt;
                &lt;/tr&gt;
            &lt;/table&gt;    
        &lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;
","","")
INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (26,"&lt;table cellspacing=0 cellpadding=5 border=0&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
            &lt;a name=&quot;layout&quot;&gt;
            &lt;b&gt;Note:&lt;/b&gt; Portal layout is managed using the &lt;a href=&quot;#admintool&quot;&gt;Admin tool&lt;/a&gt; described above.&lt;br&gt;&lt;br&gt;
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td&gt;
            &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td width=&quot;235&quot; rowspan=&quot;2&quot;&gt;
                        &lt;img align=&quot;left&quot; src=&quot;data/tabs.gif&quot;&gt;
                    &lt;/td&gt;
                    &lt;td&gt;&amp;nbsp;&amp;nbsp;&lt;/td&gt;
                    &lt;td class=&quot;Normal&quot;&gt;
                        
                        &lt;u&gt;Working with Tabs&lt;/u&gt;&lt;br&gt;
                        The &lt;b&gt;Tabs&lt;/b&gt; section lets you add and remove tabs, and change the order of the tabs.  
                        &lt;ul&gt;
                        &lt;li&gt;To &lt;b&gt;add&lt;/b&gt; a new tab to the portal, click the &quot;Add new tab&quot; link (1).  
                        &lt;li&gt;To &lt;b&gt;modify&lt;/b&gt; an existing tab, first select the tab to modify (2) then click the pencil button (3).
                        &lt;li&gt;To &lt;b&gt;reorder&lt;/b&gt; the tabs, click the tab name (2), then click the up or down button (3).
                        &lt;li&gt;To &lt;b&gt;delete&lt;/b&gt; a tab, click the tab name (2), then click the X button (3).
                        &lt;/ul&gt;
                    &lt;/td&gt;
                &lt;/tr&gt;
           &lt;/table&gt;    
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
            &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td width=&quot;420&quot; rowspan=&quot;2&quot;&gt;
                        &lt;img align=&quot;left&quot; src=&quot;data/layout.gif&quot;&gt;
                    &lt;/td&gt;
                    &lt;td&gt;&amp;nbsp;&amp;nbsp;&lt;/td&gt;
                    &lt;td width=&quot;*&quot; class=&quot;Normal&quot;&gt;
                    
                        &lt;a name=&quot;workmodules&quot;&gt;&lt;/a&gt;
                        &lt;u&gt;Working With Modules on a Tab&lt;/u&gt;&lt;br&gt;
                        The &lt;b&gt;Tab Name and Layout&lt;/b&gt; page lets you manipulate the modules for the selected tab.  Use this page to set the tab name and which roles may view the tab.  Optionally, you can use this page to make the tab visible to Mobile users, and set a different (often abbreviated) tab name for mobile viewing (1).&lt;br&gt;&lt;br&gt;
                        
                        To open the Tab Name and Layout page, select the tab you wish to modify in the Tabs section of the Admin page, then click the pencil button.  See &lt;a href=&quot;#layout&quot;&gt;Portal Layout&lt;/a&gt; above.
                        &lt;ul&gt;
                        &lt;li&gt;To &lt;b&gt;add a new module&lt;/b&gt; to the Tab, pick a Module Type from the list, and give your module a name (2).  Then click the &quot;Add to Organize Modules below&quot; link (3).  The module is added to the bottom of the center Content Pane (4).
                        &lt;li&gt;To &lt;b&gt;add an existing module&lt;/b&gt; to this Tab, click the Exising Module radio button (2).  Pick the module you wish by name from the Module Type list (2).  Then click the &quot;Add to Organize Modules below&quot; link (3).
                        &lt;li&gt;To &lt;b&gt;move a module&lt;/b&gt; within the tab, first select the module to move (4) then click the up, down, right or left button (4).
                        &lt;li&gt;To &lt;b&gt;delete a module&lt;/b&gt; from this tab, click the module name (4), then click the X button (4).
                        &lt;li&gt;To &lt;b&gt;change a module's name&lt;/b&gt;, set it's caching timeout or control which roles may modify the first select the tab to modify it's data click the module name (4), then click the pencil button (4).
                        &lt;/ul&gt;
                    &lt;/td&gt;
                &lt;/tr&gt;
            &lt;/table&gt;    
            
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
            &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td width=&quot;235&quot; rowspan=&quot;2&quot;&gt;
                        &lt;img align=&quot;left&quot; src=&quot;data/modulesettings.gif&quot;&gt;
                    &lt;/td&gt;
                    &lt;td&gt;&amp;nbsp;&amp;nbsp;&lt;/td&gt;
                    &lt;td width=&quot;*&quot; class=&quot;Normal&quot;&gt;
                    
                        &lt;a name=&quot;modulesettings&quot;&gt;&lt;/a&gt;
                        &lt;u&gt;Modules Settings&lt;/u&gt;&lt;br&gt;
                        The &lt;b&gt;Modules Settings&lt;/b&gt; page lets you change a module's name, set it's cache timeout, set edit permissions for the module's data, and indicate whether the module should be visible to mobile users.  Click the Apply Modules Changes button to save the changes.&lt;br&gt;&lt;br&gt;
                        
                        To open the Module Settings page, select the module you wish to modify in the Tab Name and Layout page, then click the pencil button.  See &lt;a href=&quot;#workmodules&quot;&gt;Working with Modules on a Tab&lt;/a&gt; above.&lt;br&gt;&lt;br&gt;
                        
                        For information about setting edit permissions, see &lt;a href=&quot;#authorization&quot;&gt;Roles-Based Authorization&lt;/a&gt; below.
                    &lt;/td&gt;
                &lt;/tr&gt;
            &lt;/table&gt;    
        &lt;/td&gt;
    &lt;/tr&gt;
        &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
            &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                &lt;tr valign=&quot;middle&quot;&gt;
                    &lt;td&gt;
                        &lt;img align=&quot;bottom&quot; src=&quot;data/moduledefs.gif&quot;&gt;
                    &lt;/td&gt;
                    &lt;td&gt;&amp;nbsp;&amp;nbsp;&lt;/td&gt;
                    &lt;td width=&quot;*&quot; class=&quot;Normal&quot;&gt;
                                    
                        &lt;a name=&quot;moduledefs&quot;&gt;&lt;/a&gt;
                        &lt;u&gt;Defining New Module Types&lt;/u&gt;&lt;br&gt;
                            The &lt;b&gt;Module Definitions&lt;/b&gt; section lets you add or change a module type definition.  To modify an existing definition, click the pencil button next to the definition name.  To add a new definition click the Add New Module Type button.&lt;br&gt;&lt;br&gt;
                            
                            On the &lt;b&gt;Module Type Definition&lt;/b&gt; page, set a Friendly name and path to the Desktop module source file.  If applicable, set a path to the Mobile version of the module as well.  Due to the ASP.NET security restrictions, the module files must be located within the portal's application directory or subdirectories.&lt;br&gt;&lt;br&gt;&lt;br&gt;&lt;br&gt;
                        &lt;img src=&quot;data/moduletypedef.gif&quot;&gt;
                    &lt;/td&gt;
                &lt;/tr&gt;
            &lt;/table&gt;    
        &lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;","","")
INSERT INTO HTMLTEXT (ModuleID,DesktopHtml,MobileSummary,MobileDetails) VALUES (27,"&lt;table cellspacing=0 cellpadding=5 border=0&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
        
            &lt;a name=&quot;security&quot;&gt;
            Portal security is managed using the &lt;a href=&quot;#admintool&quot;&gt;Admin tool&lt;/a&gt; described above.&lt;br&gt;&lt;br&gt;
        
            &lt;a name=&quot;authentication&quot;&gt;
            &lt;u&gt;Authentication&lt;/u&gt;&lt;br&gt;

            &lt;i&gt;Authentication&lt;/i&gt; validates a user's crenditials.  The IBuySpy Portal sample supports two forms of authentication.  
            
            &lt;ul&gt;
            &lt;li&gt;&lt;b&gt;Forms-Based/Cookie authentication&lt;/b&gt; collects a user name and password in a simple input form, then validates them against the Users table in the database.  This type of authentication is typically used for Internet and extranet portals.

            &lt;li&gt;With &lt;b&gt;Windows/NTLM authentication&lt;/b&gt;, either the Windows SAM or Active Directory is used to store and validate all username/password credentials.  This type of authentication is typically used  for intranet-based portals.
           
            &lt;/ul&gt;
            When you install the IBuySpy Portal, Forms Authentication is enabled by default.  To change the authentication mode, edit the web.config file in the root portal directory:&lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td&gt;
            &lt;img align=&quot;left&quot; src=&quot;data/config_auth_win.gif&quot;&gt;
            &lt;img align=&quot;left&quot; src=&quot;data/config_auth_forms.gif&quot;&gt;
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
        
            &lt;a name=&quot;authorization&quot;&gt;
            &lt;u&gt;Roles-Based Authorization&lt;/u&gt;&lt;br&gt;

            &lt;i&gt;Authorization&lt;/i&gt; is used to control access to the modules and tabs in the portal, including the Admin tab.  The IBuySpy Portal sample uses roles-based authorization.  The portal administrator uses these steps to set up roles-based authorization:
            
            &lt;ol&gt;
            &lt;li&gt;&lt;a href=&quot;#createrole&quot;&gt;&lt;b&gt;Create a role&lt;/b&gt;&lt;/a&gt;, for example &quot;Managers&quot; or &quot;HR&quot;.
            &lt;li&gt;&lt;a href=&quot;#addtorole&quot;&gt;&lt;b&gt;Add users to the role&lt;/b&gt;&lt;/a&gt;, for example &quot;CORP01\andreabr&quot;, &quot;CORP01\tomka&quot;, and &quot;CORP01\marklo&quot;.
            &lt;li&gt;&lt;a href=&quot;#tabperms&quot;&gt;&lt;b&gt;Set view permission for tabs&lt;/b&gt;&lt;/a&gt;, for example, limit viewing of the &quot;FY01 Budget&quot; tab to users in the &quot;Managers&quot; role.
            &lt;li&gt;&lt;a href=&quot;#editperms&quot;&gt;&lt;b&gt;Set edit permission for modules&lt;/b&gt;&lt;/a&gt;, for example, limit permission to edit information in the &quot;HR/Benefits News&quot; module to users in the &quot;HR&quot; role.
            &lt;/ol&gt;
            
            The roles-based authorization system in the IBuySpy portal works independently of the authentication mode.  Role membership data is stored in the portal's configuration system, and does not rely on the ASP.NET configuration system or Windows groups.  

            &lt;ul&gt;&lt;li&gt;
            &lt;b&gt;IMPORTANT NOTE&lt;/b&gt;: &lt;i&gt;The &quot;All Users&quot; member is a special value that, if present, adds all authenticated users to the role.  When you first install the IBuySpy Portal sample, the &quot;Admins&quot; and &quot;Power Users&quot; roles contain the All Users member.  Remove this member to make the these role secure.&lt;/i&gt;
            &lt;/li&gt;&lt;/ul&gt;

        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
            &lt;a name=&quot;createrole&quot;&gt;
            &lt;u&gt;Creating and Managing Roles&lt;/u&gt;&lt;br&gt;
        
            &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td class=&quot;Normal&quot; width=&quot;*&quot;&gt;
                        The &lt;b&gt;Security Roles&lt;/b&gt; section of the Admin tab lets you define roles for the portal.  
                        &lt;ul&gt;
                        &lt;li&gt;To &lt;b&gt;create&lt;/b&gt; a new role to the portal, click the &quot;Add new role&quot; link.  
                        &lt;li&gt;To &lt;b&gt;edit&lt;/b&gt; an existing role, click the pencil button next to the role name.  See &lt;a href=&quot;#addtorole&quot;&gt;Adding Users to a Role&lt;/a&gt; below.
                        &lt;li&gt;To &lt;b&gt;delete&lt;/b&gt; a role, click the X button next to the role name.
                        &lt;/ul&gt;
                    &lt;/td&gt;
                    &lt;td&gt;&amp;nbsp;&amp;nbsp;&lt;/td&gt;
                    &lt;td width=&quot;320&quot;&gt;
                        &lt;img src=&quot;data/roles1.gif&quot;&gt;
                        &lt;br&gt;
                        &lt;img align=&quot;left&quot; src=&quot;data/roles.gif&quot;&gt;
                    &lt;/td&gt;
                &lt;/tr&gt;
           &lt;/table&gt;    
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
            &lt;a name=&quot;addtorole&quot;&gt;
            &lt;u&gt;Adding Users to a Role&lt;/u&gt;&lt;br&gt;

            &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td width=&quot;*&quot; class=&quot;Normal&quot;&gt;
                        The &lt;b&gt;Role Membership&lt;/b&gt; page lets you manage the add or delete users for the selected role.&lt;br&gt;&lt;br&gt;
                        
                        To open the Role Name and Membership page, select the role you wish to modify in the Security Roles section of the Admin page, then click the Change Role Members button.  See &lt;a href=&quot;#createrole&quot;&gt;Creating and Managing Roles&lt;/a&gt; above.
                        &lt;ul&gt;
                        &lt;li&gt;To &lt;b&gt;add&lt;/b&gt; a member to the role, select the user name from the dropdown and click the &quot;Add to Role&quot; link.
                        &lt;li&gt;To &lt;b&gt;delete&lt;/b&gt; a member from the role,  click the X button to the left of the member name.
                        &lt;/ul&gt;
                    &lt;/td&gt;
                    &lt;td&gt;&amp;nbsp;&amp;nbsp;&lt;/td&gt;
                    &lt;td width=&quot;320&quot;&gt;
                        &lt;img align=&quot;left&quot; src=&quot;data/rolemembership.gif&quot;&gt;
                    &lt;/td&gt;
                &lt;/tr&gt;
            &lt;/table&gt;  

        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
        
            &lt;a name=&quot;tabperms&quot;&gt;&lt;/a&gt;
            &lt;u&gt;Setting View Permission for a Tab&lt;/u&gt;&lt;br&gt;

            You can show show or hide an entire tab depending on whether a user is in an authorized role.  For example, you can limit viewing of the &quot;FY01 Budget&quot; tab to users in the &quot;Managers&quot; role. 
              
            &lt;br&gt;&lt;br&gt;
            
            &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td width=&quot;220&quot;&gt;
                        &lt;img src=&quot;data/layout.gif&quot;&gt;
                    &lt;/td&gt;
                    &lt;td&gt;&amp;nbsp;&amp;nbsp;&lt;/td&gt;
                    &lt;td width=&quot;*&quot; class=&quot;Normal&quot;&gt;
                        &lt;ul&gt;
                        &lt;li&gt;To set which security roles may view a tab, go to the &lt;a href=&quot;#workmodules&quot;&gt;Tab Name and Layout&lt;/a&gt; page for the tab.  Check the desired roles in the &quot;Authorized Roles&quot; section, then click the &quot;Save Tab Changes&quot; button.
                        &lt;/ul&gt;
                    &lt;/td&gt;
                &lt;/tr&gt;
            &lt;/table&gt;  

        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td class=&quot;Normal&quot;&gt;
        
            &lt;a name=&quot;editperms&quot;&gt;&lt;/a&gt;
            &lt;u&gt;Setting Edit Access for a Module&lt;/u&gt;&lt;br&gt;

            Permission to edit module data is granted by security role on a per-module basis.  
            
            &lt;ul&gt;
            &lt;li&gt;To set the roles that may edit data for a specific module, go to the &lt;a href=&quot;#modulesettings&quot;&gt;Module Settings&lt;/a&gt; page for the module.  Check the desired roles in the &quot;Roles that can edit content&quot; section, then click the &quot;Apply Module Changes&quot; button.
            &lt;/ul&gt;
            
            &lt;table cellspacing=0 cellpadding=0 border=0&gt;
                &lt;tr valign=&quot;top&quot;&gt;
                    &lt;td width=&quot;220&quot;&gt;
                        &lt;img src=&quot;data/modulesettings.gif&quot;&gt;
                    &lt;/td&gt;
                    &lt;td&gt;&amp;nbsp;&amp;nbsp;&lt;/td&gt;
                    &lt;td width=&quot;*&quot; class=&quot;Normal&quot;&gt;
                    
                        Normally, a module's Edit button is shown only to users who have permission to edit the module's data.  If you wish, however, you can show the Edit button to all users.  When an unauthorized user clicks the Edit button she recieves an &quot;Edit Access Denied&quot; message, which prompts her to contact the portal administrator to set up edit access.   
                        
                        &lt;ul&gt;
                        &lt;li&gt;This is a portal-wide setting.  To show the Edit button to all users -- even those who do not have edit access -- go to the &lt;b&gt;Site Settings&lt;/b&gt; section on the main Admin page and check the &quot;Always show Edit button&quot; checkbox, then click the &quot;Apply  Changes&quot; button.
                        &lt;/ul&gt;
                    &lt;/td&gt;
                &lt;/tr&gt;
            &lt;/table&gt;  

        &lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;","","")

--
-- End load data
-- 

