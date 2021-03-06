USE [master]
GO
/****** Object:  Database [BPDTSys]    Script Date: 7/2/2017 6:06:08 PM ******/
CREATE DATABASE [BPDTSys]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BPDTSys', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BPDTSys.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BPDTSys_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BPDTSys_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BPDTSys] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BPDTSys].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BPDTSys] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BPDTSys] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BPDTSys] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BPDTSys] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BPDTSys] SET ARITHABORT OFF 
GO
ALTER DATABASE [BPDTSys] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BPDTSys] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BPDTSys] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BPDTSys] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BPDTSys] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BPDTSys] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BPDTSys] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BPDTSys] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BPDTSys] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BPDTSys] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BPDTSys] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BPDTSys] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BPDTSys] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BPDTSys] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BPDTSys] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BPDTSys] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BPDTSys] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BPDTSys] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BPDTSys] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BPDTSys] SET  MULTI_USER 
GO
ALTER DATABASE [BPDTSys] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BPDTSys] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BPDTSys] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BPDTSys] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [BPDTSys]
GO
/****** Object:  StoredProcedure [dbo].[DELETE_ALL_DATA]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETE_ALL_DATA]

			@Parameter	NVARCHAR(100),
			@Status						INT
	
AS
BEGIN

	SET NOCOUNT ON;
		DECLARE @ErrorSave int

		SET
			@ErrorSave = 0

		BEGIN TRAN
			IF (@Status = 1) --
				BEGIN

				UPDATE [dbo].[Regular_Registration_Data] SET Status = 1
				UPDATE [dbo].[Pro_Rata_Registration_Data] SET Status = 1
				UPDATE [dbo].[Pro_Rata_Registration_Subject_List] SET Status = 1
				UPDATE [dbo].[Repeat_Registration_Data] SET Status = 1
				UPDATE [dbo].[Repeat_Registration_Subject_List] SET Status = 1

				END

			ELSE IF(@Status = 2)  -- 
				BEGIN

				SELECT [Index_No] ,[Student_Name] ,[Student_Type] ,[Course] ,[Email]
				FROM [dbo].[Users_List] AS UL
				WHERE UL.[Status] = 0
				
				END

	IF ( @@ERROR <> 0 )
		SET @ErrorSave = @@ERROR

	IF ( @ErrorSave <> 0 )
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[Get_All_Users]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_All_Users]


			@Index_No	NVARCHAR(100),	
			@Student_Name	NVARCHAR(100),	
			@Temp_Password	NVARCHAR(100),	
			@Student_Type	NVARCHAR(100),	
			@Course	NVARCHAR(100),	
			@Email				NVARCHAR(100),	
			@Status						INT
	
AS
BEGIN

	SET NOCOUNT ON;
		DECLARE @ErrorSave int,
		@INVALIDUSER NVARCHAR(100) = 'INVALID',
		@VALIDUSER NVARCHAR(100) = 'VALID',
		@ADMIN NVARCHAR(100) = 'ADMIN'

		SET
			@ErrorSave = 0

		BEGIN TRAN
			IF (@Status = 1) -- Get all users list
				BEGIN

				SELECT [Index_No] ,[Student_Name] ,[Student_Type] ,[Course] ,[Email]
				FROM [dbo].[Users_List] AS UL
				WHERE UL.[Status] = 0

				END

			ELSE IF(@Status = 2)  -- SAVE & ADD A USER FROM THE ADMIN
				BEGIN
				DECLARE @NEWPASSWORD NVARCHAR(100) = 'Welcome#1'
				INSERT INTO [dbo].[Users_List] ([Index_No],[Student_Name],[Temp_Password],[Student_Type],[Course],[Email])
				VALUES (@Index_No,@Student_Name,@NEWPASSWORD,@Student_Type,@Course,@Email)
				END

	IF ( @@ERROR <> 0 )
		SET @ErrorSave = @@ERROR

	IF ( @ErrorSave <> 0 )
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[Get_NLP_Response_Data]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_NLP_Response_Data]


			@ParameterOne	NVARCHAR(100),	
			@ParameterTwo	NVARCHAR(100),	
			@IndexNo	NVARCHAR(100),	
			@Student_Type	NVARCHAR(100),	
			@Course	NVARCHAR(100),	
			@Email				NVARCHAR(100),	
			@Status						INT
	
AS
BEGIN

	SET NOCOUNT ON;
		DECLARE @ErrorSave int

		SET
			@ErrorSave = 0

		BEGIN TRAN
			IF (@Status = 1) --
				BEGIN

				SELECT TOP 1 @ParameterOne ,@ParameterTwo
				FROM [dbo].[Regular_Registration_Data] AS RRD
				LEFT JOIN [dbo].[Pro_Rata_Registration_Data] AS PRRD ON PRRD.[Semester_Id] = RRD.[Semester_Id]
				WHERE RRD.[Status] = 0

				END

			ELSE IF(@Status = 2)  -- 
				BEGIN

				SELECT [Index_No] ,[Student_Name] ,[Student_Type] ,[Course] ,[Email]
				FROM [dbo].[Users_List] AS UL
				WHERE UL.[Status] = 0
				
				END

	IF ( @@ERROR <> 0 )
		SET @ErrorSave = @@ERROR

	IF ( @ErrorSave <> 0 )
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[Login_Data]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Login_Data]

			@Email				NVARCHAR(100),
			@Temp_Password				NVARCHAR(100),
			@Status						INT
	
AS
BEGIN

	SET NOCOUNT ON;
		DECLARE @ErrorSave int,
		@INVALIDUSER NVARCHAR(100) = 'INVALID',
		@VALIDUSER NVARCHAR(100) = 'VALID',
		@ADMIN NVARCHAR(100) = 'ADMIN'

		SET
			@ErrorSave = 0

		BEGIN TRAN
		IF (@Status = 1) -- LOGIN
		BEGIN

		SELECT @Email = (SELECT LOWER(@Email))
		IF (@Email = 'admin@gmail.com' AND @Temp_Password = 'Welcome#1')
		SELECT @ADMIN AS RESULT

		ELSE
			IF NOT EXISTS (SELECT [dbo].[Users_List].Email FROM [dbo].[Users_List] WHERE [dbo].[Users_List].Email = @Email)
				SELECT @INVALIDUSER AS RESULT

			ELSE
				IF NOT EXISTS (SELECT [dbo].[Users_List].Temp_Password FROM [dbo].[Users_List] WHERE [dbo].[Users_List].Temp_Password = @Temp_Password)
					SELECT @INVALIDUSER AS RESULT

				ELSE SELECT @VALIDUSER AS RESULT

		END


	IF ( @@ERROR <> 0 )
		SET @ErrorSave = @@ERROR

	IF ( @ErrorSave <> 0 )
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[Save_Pro_Rata_Registration_Data]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Save_Pro_Rata_Registration_Data]

			@Ref_No						NVARCHAR(100),
			@Semester_Id				NVARCHAR(100),
			@Pro_Rata_Registration_Start_Date				NVARCHAR(100),
			@Pro_Rata_Registration_End_Date			NVARCHAR(100),
			@Pro_Rata_Fee			NVARCHAR(100),
			@Last_Payment_Date_From		NVARCHAR(100),
			@Last_Payment_Date_To			NVARCHAR(100),
			@Late_Payment_Fee				NVARCHAR(100),
			@Status						INT
	
AS
BEGIN

	SET NOCOUNT ON;
		DECLARE @ErrorSave int,
		@NewIdSet  NVARCHAR(100),
		@Auto_Code_Prefix NVARCHAR(100)

		SET
			@ErrorSave = 0


		BEGIN TRAN
		IF (@Status = 1) --SAVE DATA
		BEGIN

			DECLARE
				@Created_Id		NVARCHAR(100),
				@Allow_Subject_Name		NVARCHAR(100)


		
		SELECT @NewIdSet = COALESCE(CAST(MAX((CAST (SUBSTRING(NewIdSet,CHARINDEX('-',NewIdSet)+1,LEN(NewIdSet)) AS INT)) + 1 ) AS varchar(100)),'1')
		FROM [dbo].[Pro_Rata_Registration_Data]
		SELECT @Auto_Code_Prefix = 'PRREG'
		SET @NewIdSet = @Auto_Code_Prefix + '-' + @NewIdSet 

		INSERT INTO [dbo].[Pro_Rata_Registration_Data]( [Semester_Id],[NewIdSet],[Pro_Rata_Registration_Start_Date],[Pro_Rata_Registration_End_Date],[Pro_Rata_Fee],[Last_Payment_Date_From],[Last_Payment_Date_To],[Late_Payment_Fee])
		VALUES ( @Semester_Id,@NewIdSet, @Pro_Rata_Registration_Start_Date, @Pro_Rata_Registration_End_Date, @Pro_Rata_Fee, @Last_Payment_Date_From, @Last_Payment_Date_To, @Late_Payment_Fee)

		SELECT @Created_Id = @NewIdSet
		
		--SAVE SUBJECT LIST DATA value according to the input
		--START
			DECLARE Insert_Pro_Rata_Registration_Subject_List CURSOR FOR SELECT [Allow_Subject_Name]
			FROM [dbo].[Temp_Pro_Rata_Registration_Subject_List] 
			WHERE [Ref_No] = @Ref_No 
				
			OPEN Insert_Pro_Rata_Registration_Subject_List
			FETCH NEXT FROM  Insert_Pro_Rata_Registration_Subject_List INTO @Allow_Subject_Name
			WHILE @@FETCH_STATUS=0
			BEGIN 
				INSERT INTO [dbo].[Pro_Rata_Registration_Subject_List]([Pro_Rata_Registration_Id], [Allow_Subject_Name])
				VALUES(@Created_Id, @Allow_Subject_Name)

			FETCH NEXT FROM  Insert_Pro_Rata_Registration_Subject_List INTO @Allow_Subject_Name
			END 
			CLOSE Insert_Pro_Rata_Registration_Subject_List
			DEALLOCATE Insert_Pro_Rata_Registration_Subject_List
			
			DELETE FROM [dbo].[Temp_Pro_Rata_Registration_Subject_List]  WHERE Ref_No = @Ref_No 
		--END

		select @Semester_Id
		END


	IF ( @@ERROR <> 0 )
		SET @ErrorSave = @@ERROR

	IF ( @ErrorSave <> 0 )
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[Save_Regular_Registration_Data]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Save_Regular_Registration_Data]

			@Semester_Id				NVARCHAR(100),
			@Semester_Name				NVARCHAR(100),
			@Payment_Start_Date			NVARCHAR(100),
			@Payment_End_Date			NVARCHAR(100),
			@Semester_Start_Date		NVARCHAR(100),
			@Semester_End_Date			NVARCHAR(100),
			@Semester_Fee				NVARCHAR(100),
			@Late_Payment_Date_From		NVARCHAR(100),
			@Late_Payment_Date_To		NVARCHAR(100),
			@Late_Payment_Fee			NVARCHAR(100),
			@Status						INT
	
AS
BEGIN

	SET NOCOUNT ON;
		DECLARE @ErrorSave int
		SET
			@ErrorSave = 0


		BEGIN TRAN
		IF (@Status = 1) --SAVE DATA
		BEGIN

		INSERT INTO [dbo].[Regular_Registration_Data]( [Semester_Id],[Semester_Name],[Payment_Start_Date],[Payment_End_Date],[Semester_Start_Date],[Semester_End_Date],[Semester_Fee],[Late_Payment_Date_From],[Late_Payment_Date_To],[Late_Payment_Fee])
		VALUES ( @Semester_Id,	@Semester_Name,	@Payment_Start_Date, @Payment_End_Date,	@Semester_Start_Date, @Semester_End_Date, @Semester_Fee, @Late_Payment_Date_From, @Late_Payment_Date_To, @Late_Payment_Fee)

		select @Semester_Id
		END


	IF ( @@ERROR <> 0 )
		SET @ErrorSave = @@ERROR

	IF ( @ErrorSave <> 0 )
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[Save_Repeat_Registration_Data]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Save_Repeat_Registration_Data]

			@Ref_No						NVARCHAR(100),
			@Semester_Id				NVARCHAR(100),
			@Repeat_Registration_Start_Date				NVARCHAR(100),
			@Repeat_Registration_End_Date			NVARCHAR(100),
			@Repeat_Fee			NVARCHAR(100),
			@Status						INT
	
AS
BEGIN

	SET NOCOUNT ON;
		DECLARE @ErrorSave int,
		@NewIdSet NVARCHAR(100),
		@Auto_Code_Prefix NVARCHAR(100)

		SET
			@ErrorSave = 0


		BEGIN TRAN
		IF (@Status = 1) --SAVE DATA
		BEGIN

			DECLARE
				@Created_Id		NVARCHAR(100),
				@Allow_Subject_Name		NVARCHAR(100)


		SELECT @NewIdSet = COALESCE(CAST(MAX((CAST (SUBSTRING(NewIdSet,CHARINDEX('-',NewIdSet)+1,LEN(NewIdSet)) AS INT)) + 1 ) AS varchar(100)),'1')
		FROM [dbo].[Pro_Rata_Registration_Data]
		SELECT @Auto_Code_Prefix = 'REREG'
		SET @NewIdSet = @Auto_Code_Prefix + '-' + @NewIdSet 

		INSERT INTO [dbo].[Repeat_Registration_Data]([Semester_Id],[NewIdSet],[Repeat_Registration_Start_Date],[Repeat_Registration_End_Date],[Repeat_Fee])
		VALUES ( @Semester_Id,@NewIdSet, @Repeat_Registration_Start_Date, @Repeat_Registration_End_Date, @Repeat_Fee)

		SELECT @Created_Id = @NewIdSet
		
		--SAVE SUBJECT LIST DATA value according to the input
		--START
			DECLARE Insert_Repeat_Registration_Subject_List CURSOR FOR SELECT [Allow_Subject_Name]
			FROM [dbo].[Temp_Repeat_Registration_Subject_List] 
			WHERE [Ref_No] = @Ref_No 
				
			OPEN Insert_Repeat_Registration_Subject_List
			FETCH NEXT FROM  Insert_Repeat_Registration_Subject_List INTO @Allow_Subject_Name
			WHILE @@FETCH_STATUS=0
			BEGIN 
				INSERT INTO [dbo].[Repeat_Registration_Subject_List]([Repeat_Registration_Id], [Allow_Subject_Name])
				VALUES(@Created_Id, @Allow_Subject_Name)

			FETCH NEXT FROM  Insert_Repeat_Registration_Subject_List INTO @Allow_Subject_Name
			END 
			CLOSE Insert_Repeat_Registration_Subject_List
			DEALLOCATE Insert_Repeat_Registration_Subject_List
			
			DELETE FROM [dbo].[Temp_Repeat_Registration_Subject_List]  WHERE Ref_No = @Ref_No 
		--END

		select @Semester_Id
		END


	IF ( @@ERROR <> 0 )
		SET @ErrorSave = @@ERROR

	IF ( @ErrorSave <> 0 )
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END

GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pro_Rata_Registration_Data]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pro_Rata_Registration_Data](
	[ID] [uniqueidentifier] NOT NULL,
	[NewIdSet] [nvarchar](100) NULL,
	[Semester_Id] [nvarchar](100) NULL,
	[Pro_Rata_Registration_Start_Date] [nvarchar](100) NULL,
	[Pro_Rata_Registration_End_Date] [nvarchar](100) NULL,
	[Pro_Rata_Fee] [nvarchar](100) NULL,
	[Last_Payment_Date_From] [nvarchar](100) NULL,
	[Last_Payment_Date_To] [nvarchar](100) NULL,
	[Late_Payment_Fee] [nvarchar](100) NULL,
	[Date_Time] [nvarchar](100) NULL,
	[Status] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pro_Rata_Registration_Subject_List]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pro_Rata_Registration_Subject_List](
	[ID] [uniqueidentifier] NOT NULL,
	[Pro_Rata_Registration_Id] [nvarchar](100) NULL,
	[Allow_Subject_Name] [nvarchar](100) NULL,
	[Date_Time] [nvarchar](100) NULL,
	[Status] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Regular_Registration_Data]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Regular_Registration_Data](
	[ID] [uniqueidentifier] NOT NULL,
	[Semester_Id] [nvarchar](100) NULL,
	[Semester_Name] [nvarchar](100) NULL,
	[Payment_Start_Date] [nvarchar](100) NULL,
	[Payment_End_Date] [nvarchar](100) NULL,
	[Semester_Start_Date] [nvarchar](100) NULL,
	[Semester_End_Date] [nvarchar](100) NULL,
	[Semester_Fee] [nvarchar](100) NULL,
	[Late_Payment_Date_From] [nvarchar](100) NULL,
	[Late_Payment_Date_To] [nvarchar](100) NULL,
	[Late_Payment_Fee] [nvarchar](100) NULL,
	[Date_Time] [nvarchar](100) NULL,
	[Status] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Repeat_Registration_Data]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Repeat_Registration_Data](
	[ID] [uniqueidentifier] NOT NULL,
	[Semester_Id] [nvarchar](100) NULL,
	[Repeat_Registration_Start_Date] [nvarchar](100) NULL,
	[Repeat_Registration_End_Date] [nvarchar](100) NULL,
	[Repeat_Fee] [nvarchar](100) NULL,
	[Date_Time] [nvarchar](100) NULL,
	[Status] [int] NULL,
	[NewIdSet] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Repeat_Registration_Subject_List]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Repeat_Registration_Subject_List](
	[ID] [uniqueidentifier] NOT NULL,
	[Repeat_Registration_Id] [nvarchar](100) NULL,
	[Allow_Subject_Name] [nvarchar](100) NULL,
	[Date_Time] [nvarchar](100) NULL,
	[Status] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Temp_Pro_Rata_Registration_Subject_List]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp_Pro_Rata_Registration_Subject_List](
	[Ref_No] [nvarchar](100) NULL,
	[Allow_Subject_Name] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Temp_Repeat_Registration_Subject_List]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp_Repeat_Registration_Subject_List](
	[Ref_No] [nvarchar](100) NULL,
	[Allow_Subject_Name] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users_List]    Script Date: 7/2/2017 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users_List](
	[ID] [uniqueidentifier] NOT NULL,
	[Index_No] [nvarchar](100) NULL,
	[Student_Name] [nvarchar](100) NULL,
	[Temp_Password] [nvarchar](100) NULL,
	[Student_Type] [nvarchar](100) NULL,
	[Course] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Date_Time] [nvarchar](100) NULL,
	[Status] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 7/2/2017 6:06:08 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 7/2/2017 6:06:08 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 7/2/2017 6:06:08 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 7/2/2017 6:06:08 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 7/2/2017 6:06:08 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 7/2/2017 6:06:08 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pro_Rata_Registration_Data] ADD  CONSTRAINT [DF_Pro_Rata_Registration_Data_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Pro_Rata_Registration_Data] ADD  CONSTRAINT [DF_Pro_Rata_Registration_Data_Date_Time]  DEFAULT (getdate()) FOR [Date_Time]
GO
ALTER TABLE [dbo].[Pro_Rata_Registration_Data] ADD  CONSTRAINT [DF_Pro_Rata_Registration_Data_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Pro_Rata_Registration_Subject_List] ADD  CONSTRAINT [DF_Pro_Rata_Registration_Subject_List_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Pro_Rata_Registration_Subject_List] ADD  CONSTRAINT [DF_Pro_Rata_Registration_Subject_List_Date_Time]  DEFAULT (getdate()) FOR [Date_Time]
GO
ALTER TABLE [dbo].[Pro_Rata_Registration_Subject_List] ADD  CONSTRAINT [DF_Pro_Rata_Registration_Subject_List_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Regular_Registration_Data] ADD  CONSTRAINT [DF_Regular_Registration_Data_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Regular_Registration_Data] ADD  CONSTRAINT [DF_Regular_Registration_Data_Date_Time]  DEFAULT (getdate()) FOR [Date_Time]
GO
ALTER TABLE [dbo].[Regular_Registration_Data] ADD  CONSTRAINT [DF_Regular_Registration_Data_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Repeat_Registration_Data] ADD  CONSTRAINT [DF_Repeat_Registration_Data_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Repeat_Registration_Data] ADD  CONSTRAINT [DF_Repeat_Registration_Data_Date_Time]  DEFAULT (getdate()) FOR [Date_Time]
GO
ALTER TABLE [dbo].[Repeat_Registration_Data] ADD  CONSTRAINT [DF_Repeat_Registration_Data_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Repeat_Registration_Subject_List] ADD  CONSTRAINT [DF_Repeat_Registration_Subject_List_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Repeat_Registration_Subject_List] ADD  CONSTRAINT [DF_Repeat_Registration_Subject_List_Date_Time]  DEFAULT (getdate()) FOR [Date_Time]
GO
ALTER TABLE [dbo].[Repeat_Registration_Subject_List] ADD  CONSTRAINT [DF_Repeat_Registration_Subject_List_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Users_List] ADD  CONSTRAINT [DF_Users_List_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Users_List] ADD  CONSTRAINT [DF_Users_List_Date_Time]  DEFAULT (getdate()) FOR [Date_Time]
GO
ALTER TABLE [dbo].[Users_List] ADD  CONSTRAINT [DF_Users_List_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
USE [master]
GO
ALTER DATABASE [BPDTSys] SET  READ_WRITE 
GO
