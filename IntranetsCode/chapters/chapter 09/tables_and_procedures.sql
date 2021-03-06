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

CREATE PROCEDURE up_Hris_SearchEmployeesFT
/*
Procedure to perform a full text search on the Employees table using CONTAINSTABLE

To Set-up Full-Text Search on the Employees table use the following SQL

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

Author  : Brian Boyce
Date	: Jul  7 2002 2:00PM

Change History
WHO		DESCRIPTION								DATE
Brian Boyce	Initial development							Jul  7 2002 2:00PM

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

