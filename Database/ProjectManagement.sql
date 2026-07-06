USE [master]
GO
/****** Object:  Database [ProjectManagement]    Script Date: 30-06-2026 12:00:51 ******/
CREATE DATABASE [ProjectManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProjectManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\ProjectManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProjectManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\ProjectManagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ProjectManagement] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProjectManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProjectManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProjectManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProjectManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProjectManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProjectManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProjectManagement] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ProjectManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProjectManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProjectManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProjectManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProjectManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProjectManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProjectManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProjectManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProjectManagement] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ProjectManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProjectManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProjectManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProjectManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProjectManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProjectManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProjectManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProjectManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ProjectManagement] SET  MULTI_USER 
GO
ALTER DATABASE [ProjectManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProjectManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProjectManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProjectManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProjectManagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ProjectManagement] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [ProjectManagement] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ProjectManagement] SET QUERY_STORE = ON
GO
ALTER DATABASE [ProjectManagement] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ProjectManagement]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectCode] [nvarchar](50) NULL,
	[ProjectName] [nvarchar](200) NULL,
	[Description] [varchar](max) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Status] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](20) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NULL,
	[AssignedUserId] [int] NULL,
	[TaskName] [nvarchar](200) NULL,
	[Description] [varchar](max) NULL,
	[Priority] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[DueDate] [date] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](20) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[FullName] [nvarchar](150) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[Token] [nvarchar](255) NULL,
	[Role] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](20) NULL,
	[Password] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Projects] ON 
GO
INSERT [dbo].[Projects] ([ProjectId], [ProjectCode], [ProjectName], [Description], [StartDate], [EndDate], [Status], [CreatedDate], [CreatedBy], [IsActive]) VALUES (1, N'PRJ001', N'Project Management System', N'Sample Project', CAST(N'2026-06-10' AS Date), CAST(N'2026-12-31' AS Date), N'Active', CAST(N'2026-06-10T23:10:51.600' AS DateTime), N'Admin', 1)
GO
INSERT [dbo].[Projects] ([ProjectId], [ProjectCode], [ProjectName], [Description], [StartDate], [EndDate], [Status], [CreatedDate], [CreatedBy], [IsActive]) VALUES (2, N'PRJ001', N'Project Management System', N'Internship Project', CAST(N'2026-06-28' AS Date), CAST(N'2026-07-15' AS Date), N'Completed', CAST(N'2026-06-28T00:41:02.350' AS DateTime), N'Admin', 1)
GO
INSERT [dbo].[Projects] ([ProjectId], [ProjectCode], [ProjectName], [Description], [StartDate], [EndDate], [Status], [CreatedDate], [CreatedBy], [IsActive]) VALUES (3, N'PRJ003', N'Employee Management System', N'Employee Management System for HR Department', CAST(N'2026-06-28' AS Date), CAST(N'2026-07-31' AS Date), N'In Progress', CAST(N'2026-06-28T13:41:49.987' AS DateTime), N'Admin', 1)
GO
INSERT [dbo].[Projects] ([ProjectId], [ProjectCode], [ProjectName], [Description], [StartDate], [EndDate], [Status], [CreatedDate], [CreatedBy], [IsActive]) VALUES (5, N'PRJ005', N'Employement Description', N'Employement Description of employee', CAST(N'2026-06-29' AS Date), CAST(N'2026-07-22' AS Date), N'In Progress', CAST(N'2026-06-28T19:45:46.403' AS DateTime), N'Admin', 1)
GO
INSERT [dbo].[Projects] ([ProjectId], [ProjectCode], [ProjectName], [Description], [StartDate], [EndDate], [Status], [CreatedDate], [CreatedBy], [IsActive]) VALUES (6, N'PRJ002', N'Online Food Ordering System', N'Resturant Ordering and Delivery Platform', CAST(N'2026-07-06' AS Date), CAST(N'2026-09-09' AS Date), N'Not Started', CAST(N'2026-06-29T23:14:09.420' AS DateTime), N'Admin', 1)
GO
SET IDENTITY_INSERT [dbo].[Projects] OFF
GO
SET IDENTITY_INSERT [dbo].[Tasks] ON 
GO
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedUserId], [TaskName], [Description], [Priority], [Status], [DueDate], [CreatedDate], [CreatedBy], [IsActive]) VALUES (1, 1, 1, N'Database Setup', N'Create database and tables', N'High', N'In Progress', CAST(N'2026-06-15' AS Date), CAST(N'2026-06-10T23:11:28.553' AS DateTime), N'Admin', 1)
GO
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedUserId], [TaskName], [Description], [Priority], [Status], [DueDate], [CreatedDate], [CreatedBy], [IsActive]) VALUES (2, 1, 1, N'Create Login Page', N'Develop the login page using Angular', N'High', N'In Progress', CAST(N'2026-07-05' AS Date), CAST(N'2026-06-28T15:24:49.150' AS DateTime), N'Admin', 1)
GO
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedUserId], [TaskName], [Description], [Priority], [Status], [DueDate], [CreatedDate], [CreatedBy], [IsActive]) VALUES (4, 1, 23, N'API Integration Process', N'Connect Angular with ASP.NET API', N'Medium', N'Completed', CAST(N'2026-06-29' AS Date), CAST(N'2026-06-28T15:40:38.370' AS DateTime), N'Admin', 1)
GO
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedUserId], [TaskName], [Description], [Priority], [Status], [DueDate], [CreatedDate], [CreatedBy], [IsActive]) VALUES (5, 6, 17, N'UI Design', N'Design Customer interface', N'High', N'In Progress', CAST(N'2026-07-31' AS Date), CAST(N'2026-06-29T23:33:47.400' AS DateTime), N'Admin', 1)
GO
SET IDENTITY_INSERT [dbo].[Tasks] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserId], [UserName], [FullName], [Email], [Token], [Role], [IsActive], [CreatedDate], [CreatedBy], [Password]) VALUES (1, N'admin', N'System Admin', N'admin@gmail.com', NULL, N'Admin', 1, CAST(N'2026-06-10T22:38:53.300' AS DateTime), N'System', N'admin123')
GO
INSERT [dbo].[Users] ([UserId], [UserName], [FullName], [Email], [Token], [Role], [IsActive], [CreatedDate], [CreatedBy], [Password]) VALUES (3, N'anagha', N'Anagha Sunil', N'anagha@gmail.com', NULL, N'Admin', 1, CAST(N'2026-06-24T10:57:06.877' AS DateTime), N'admin', N'123456')
GO
INSERT [dbo].[Users] ([UserId], [UserName], [FullName], [Email], [Token], [Role], [IsActive], [CreatedDate], [CreatedBy], [Password]) VALUES (4, N'rahul', N'Rahul Kuamr Ravi', N'rahul@gmail.com', NULL, N'Admin', 1, CAST(N'2026-06-25T14:25:28.910' AS DateTime), N'Admin', N'rahul123')
GO
INSERT [dbo].[Users] ([UserId], [UserName], [FullName], [Email], [Token], [Role], [IsActive], [CreatedDate], [CreatedBy], [Password]) VALUES (14, N'arjun123', N'Arjun  Kumar', N'arjun123gmail.com', NULL, N'Admin', 1, CAST(N'2026-06-27T13:39:32.480' AS DateTime), N'Admin', N'arjun123')
GO
INSERT [dbo].[Users] ([UserId], [UserName], [FullName], [Email], [Token], [Role], [IsActive], [CreatedDate], [CreatedBy], [Password]) VALUES (17, N'aswin123', N'Aswin Kumar', N'aswin123@gmail.com', NULL, N'Admin', 1, CAST(N'2026-06-27T23:38:24.140' AS DateTime), N'Admin', N'aswin123')
GO
INSERT [dbo].[Users] ([UserId], [UserName], [FullName], [Email], [Token], [Role], [IsActive], [CreatedDate], [CreatedBy], [Password]) VALUES (18, N'testuser01', N'Test User', N'testuser01@gmail.com', NULL, N'Admin', 1, CAST(N'2026-06-27T23:42:47.553' AS DateTime), N'Admin', N'123456')
GO
INSERT [dbo].[Users] ([UserId], [UserName], [FullName], [Email], [Token], [Role], [IsActive], [CreatedDate], [CreatedBy], [Password]) VALUES (21, N'anagha001', N'Anagha Adhi', N'anagha001@gmail.com', NULL, N'Admin', 1, CAST(N'2026-06-27T23:51:57.667' AS DateTime), N'Admin', N'anagha001')
GO
INSERT [dbo].[Users] ([UserId], [UserName], [FullName], [Email], [Token], [Role], [IsActive], [CreatedDate], [CreatedBy], [Password]) VALUES (22, N'devi110', N'devi sunil', N'devo110@gmail.com', NULL, N'Admin', 1, CAST(N'2026-06-27T23:53:21.083' AS DateTime), N'Admin', N'devi110')
GO
INSERT [dbo].[Users] ([UserId], [UserName], [FullName], [Email], [Token], [Role], [IsActive], [CreatedDate], [CreatedBy], [Password]) VALUES (23, N'Anu001', N'Anu Sunil', N'anu001@gmail.com', NULL, N'Admin', 1, CAST(N'2026-06-28T18:01:15.287' AS DateTime), N'Admin', N'anu123')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__C9F284563BB3CACB]    Script Date: 30-06-2026 12:00:52 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Projects] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Projects] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Tasks] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Tasks] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_Projects]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_Users] FOREIGN KEY([AssignedUserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_Users]
GO
/****** Object:  StoredProcedure [dbo].[Login_GetUserDetails]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Login_GetUserDetails]
(
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        UserId,
        UserName,
        FullName,
        Email,
        Role,
        IsActive,
        CreatedDate,
        CreatedBy,
        Password,
        Token
    FROM dbo.Users
    WHERE UserId = @UserId;
END
GO
/****** Object:  StoredProcedure [dbo].[Login_ValidateUser]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Login_ValidateUser]
(
    @UserName NVARCHAR(100),
    @Password NVARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        UserId,
        UserName,
        FullName,
        Email,
        Role,
        IsActive,
        CreatedDate,
        CreatedBy,
        Password,
        Token
    FROM Users
    WHERE UserName = @UserName
      AND Password = @Password
      AND IsActive = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[Project_Delete]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Project_Delete]
(
    @ProjectId INT
)
AS
BEGIN

    DELETE FROM Projects
    WHERE ProjectId = @ProjectId;

END
GO
/****** Object:  StoredProcedure [dbo].[Project_GetAll]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Project_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ProjectId,
        ProjectCode,
        ProjectName,
        Description,
        StartDate,
        EndDate,
        Status,
        CreatedDate,
        CreatedBy,
        IsActive
    FROM dbo.Projects
    ORDER BY ProjectId DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[Project_GetById]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Project_GetById]
(
    @ProjectId INT
)
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        ProjectId,
        ProjectCode,
        ProjectName,
        Description,
        StartDate,
        EndDate,
        Status,
        CreatedDate,
        CreatedBy,
        IsActive
    FROM dbo.Projects
    WHERE ProjectId = @ProjectId;

END
GO
/****** Object:  StoredProcedure [dbo].[Project_Save]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Project_Save]
(
    @ProjectId INT,
    @ProjectCode NVARCHAR(50),
    @ProjectName NVARCHAR(200),
    @Description VARCHAR(MAX),
    @StartDate DATE,
    @EndDate DATE,
    @Status VARCHAR(50),
    @CreatedBy NVARCHAR(20)
)
AS
BEGIN

    SET NOCOUNT ON;

    IF(@ProjectId = 0)
    BEGIN

        INSERT INTO Projects
        (
            ProjectCode,
            ProjectName,
            Description,
            StartDate,
            EndDate,
            Status,
            CreatedBy
        )

        VALUES
        (
            @ProjectCode,
            @ProjectName,
            @Description,
            @StartDate,
            @EndDate,
            @Status,
            @CreatedBy
        );

    END
    ELSE
    BEGIN

        UPDATE Projects
        SET
            ProjectCode = @ProjectCode,
            ProjectName = @ProjectName,
            Description = @Description,
            StartDate = @StartDate,
            EndDate = @EndDate,
            Status = @Status
        WHERE ProjectId = @ProjectId;

    END

END
GO
/****** Object:  StoredProcedure [dbo].[Task_Delete]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Task_Delete]
(
    @TaskId INT
)
AS
BEGIN
    DELETE FROM Tasks
    WHERE TaskId = @TaskId;
END
GO
/****** Object:  StoredProcedure [dbo].[Task_GetAll]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Task_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        TaskId,
        ProjectId,
        AssignedUserId,
        TaskName,
        Description,
        Priority,
        Status,
        DueDate,
        CreatedDate,
        CreatedBy,
        IsActive
    FROM Tasks
    ORDER BY TaskId DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[Task_GetById]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Task_GetById]
(
    @TaskId INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        TaskId,
        ProjectId,
        AssignedUserId,
        TaskName,
        Description,
        Priority,
        Status,
        DueDate,
        CreatedDate,
        CreatedBy,
        IsActive
    FROM Tasks
    WHERE TaskId = @TaskId;
END
GO
/****** Object:  StoredProcedure [dbo].[Task_Save]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Task_Save]
(
    @TaskId INT,
    @ProjectId INT,
    @AssignedUserId INT,
    @TaskName NVARCHAR(200),
    @Description VARCHAR(MAX),
    @Priority VARCHAR(50),
    @Status VARCHAR(50),
    @DueDate DATE,
    @CreatedBy NVARCHAR(20)
)
AS
BEGIN
    SET NOCOUNT ON;

    IF(@TaskId = 0)
    BEGIN
        INSERT INTO Tasks
        (
            ProjectId,
            AssignedUserId,
            TaskName,
            Description,
            Priority,
            Status,
            DueDate,
            CreatedBy
        )
        VALUES
        (
            @ProjectId,
            @AssignedUserId,
            @TaskName,
            @Description,
            @Priority,
            @Status,
            @DueDate,
            @CreatedBy
        );
    END
    ELSE
    BEGIN
        UPDATE Tasks
        SET
            ProjectId = @ProjectId,
            AssignedUserId = @AssignedUserId,
            TaskName = @TaskName,
            Description = @Description,
            Priority = @Priority,
            Status = @Status,
            DueDate = @DueDate
        WHERE TaskId = @TaskId;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[User_Delete]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_Delete]
(
    @UserId INT
)
AS
BEGIN

    DELETE FROM Users
    WHERE UserId = @UserId;

END
GO
/****** Object:  StoredProcedure [dbo].[User_GetAll]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[User_GetAll]
AS
BEGIN
    SELECT
        UserId,
        UserName,
        FullName,
        Email,
        Role,
        IsActive,
        CreatedDate
    FROM Users
END
GO
/****** Object:  StoredProcedure [dbo].[User_GetById]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[User_GetById]
(
    @UserId INT
)
AS
BEGIN
    SELECT
        UserId,
        UserName,
        FullName,
        Email,
        Password,
        Role,
        IsActive
    FROM Users
    WHERE UserId = @UserId
END
GO
/****** Object:  StoredProcedure [dbo].[User_Save]    Script Date: 30-06-2026 12:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[User_Save]
(
    @UserId INT = 0,
    @UserName NVARCHAR(200),
    @FullName NVARCHAR(300),
    @Email NVARCHAR(300),
    @Password NVARCHAR(200),
    @Role NVARCHAR(100),
    @CreatedBy NVARCHAR(40)
)
AS
BEGIN

    IF @UserId = 0
    BEGIN
        INSERT INTO Users
        (
            UserName,
            FullName,
            Email,
            Password,
            Role,
            CreatedBy
        )
        VALUES
        (
            @UserName,
            @FullName,
            @Email,
            @Password,
            @Role,
            @CreatedBy
        )
    END
    ELSE
    BEGIN
        UPDATE Users
        SET
            UserName = @UserName,
            FullName = @FullName,
            Email = @Email,
            Password = @Password,
            Role = @Role
        WHERE UserId = @UserId
    END
END
GO
USE [master]
GO
ALTER DATABASE [ProjectManagement] SET  READ_WRITE 
GO
