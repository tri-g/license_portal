USE [master]
GO
/****** Object:  Database [License_Portal]    Script Date: 03-09-2021 11:42:58 ******/
CREATE DATABASE [License_Portal]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'License_Portal', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\License_Portal.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'License_Portal_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\License_Portal_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [License_Portal] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [License_Portal].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [License_Portal] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [License_Portal] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [License_Portal] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [License_Portal] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [License_Portal] SET ARITHABORT OFF 
GO
ALTER DATABASE [License_Portal] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [License_Portal] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [License_Portal] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [License_Portal] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [License_Portal] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [License_Portal] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [License_Portal] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [License_Portal] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [License_Portal] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [License_Portal] SET  DISABLE_BROKER 
GO
ALTER DATABASE [License_Portal] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [License_Portal] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [License_Portal] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [License_Portal] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [License_Portal] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [License_Portal] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [License_Portal] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [License_Portal] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [License_Portal] SET  MULTI_USER 
GO
ALTER DATABASE [License_Portal] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [License_Portal] SET DB_CHAINING OFF 
GO
ALTER DATABASE [License_Portal] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [License_Portal] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [License_Portal] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [License_Portal] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'License_Portal', N'ON'
GO
ALTER DATABASE [License_Portal] SET QUERY_STORE = OFF
GO
USE [License_Portal]
GO
/****** Object:  Table [dbo].[Algorithm]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Algorithm](
	[Algorithm ID] [int] NOT NULL,
	[Name] [varchar](45) NOT NULL,
	[Key] [varchar](45) NOT NULL,
	[Description] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Algorithm ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[License]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[License](
	[LicenseID] [int] NOT NULL,
	[LicenseKey] [varchar](45) NOT NULL,
	[Expiration Date] [date] NOT NULL,
	[Activation Date] [date] NOT NULL,
	[LicenseType ID] [int] NOT NULL,
	[Product ID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[Algorithm ID] [int] NOT NULL,
	[OrgID] [int] NOT NULL,
	[No of Licenses] [int] NOT NULL,
	[Per License Cost] [decimal](10, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LicenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[License_User]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[License_User](
	[LicenseUserID] [int] IDENTITY(1,1) NOT NULL,
	[LicenseID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LicenseUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LicenseType]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LicenseType](
	[LicenseType ID] [int] NOT NULL,
	[LicenseType] [varchar](45) NOT NULL,
	[Description] [varchar](200) NOT NULL,
	[IsActive] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LicenseType ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Org_User]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Org_User](
	[OrgUserID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[OrgID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrgUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organization]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[OrgID] [int] IDENTITY(1,1) NOT NULL,
	[OrgName] [varchar](50) NOT NULL,
	[OrgEmailAdd] [varchar](50) NOT NULL,
	[OrgConNumber] [varchar](50) NOT NULL,
	[OrgAddress] [varchar](200) NOT NULL,
	[PostCode] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrgID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrgType]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrgType](
	[OrgType_ID] [int] IDENTITY(1,1) NOT NULL,
	[OrgType_name] [varchar](45) NOT NULL,
	[Description] [varchar](200) NOT NULL,
	[OrgID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrgType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Product ID] [int] NOT NULL,
	[PrdName] [varchar](45) NOT NULL,
	[PrdDesc] [varchar](200) NOT NULL,
	[ProductCode] [varchar](20) NOT NULL,
	[PrdVersion] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Product ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[RoleType] [varchar](45) NOT NULL,
	[RoleDescription] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusID] [int] NOT NULL,
	[Description] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[EmailAddress] [varchar](50) NOT NULL,
	[ContactNumber] [int] NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[lastlogin] [datetime2](0) NULL,
	[password] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users_Roles]    Script Date: 03-09-2021 11:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users_Roles](
	[Users_Role_ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Users_Role_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Algorithm] ([Algorithm ID], [Name], [Key], [Description]) VALUES (12345, N'XYZ', N'DSL-SLK-100', N'xvvbxbncnvnvmn')
INSERT [dbo].[Algorithm] ([Algorithm ID], [Name], [Key], [Description]) VALUES (12346, N'ABC', N'DSL-SLK-101', N'kfhalkfhlkdvkxdbbvkjdbjk')
GO
INSERT [dbo].[LicenseType] ([LicenseType ID], [LicenseType], [Description], [IsActive]) VALUES (10, N'Monthly', N'Monthly subscription', 1)
GO
SET IDENTITY_INSERT [dbo].[Org_User] ON 

INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (1, 100, 1)
INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (2, 101, 2)
INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (4, 104, 2)
INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (5, 105, 1)
INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (6, 106, 1)
INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (7, 107, 2)
INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (8, 108, 1)
INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (9, 109, 1)
INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (10, 110, 2)
INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (11, 111, 2)
INSERT [dbo].[Org_User] ([OrgUserID], [UserID], [OrgID]) VALUES (12, 112, 1)
SET IDENTITY_INSERT [dbo].[Org_User] OFF
GO
SET IDENTITY_INSERT [dbo].[Organization] ON 

INSERT [dbo].[Organization] ([OrgID], [OrgName], [OrgEmailAdd], [OrgConNumber], [OrgAddress], [PostCode]) VALUES (1, N'SLK', N'slk@slkgroup.com', N'123456', N'pune', 560000)
INSERT [dbo].[Organization] ([OrgID], [OrgName], [OrgEmailAdd], [OrgConNumber], [OrgAddress], [PostCode]) VALUES (2, N'VFISLK', N'vfislk@slk.com', N'123456', N'bangalore', 560000)
SET IDENTITY_INSERT [dbo].[Organization] OFF
GO
SET IDENTITY_INSERT [dbo].[OrgType] ON 

INSERT [dbo].[OrgType] ([OrgType_ID], [OrgType_name], [Description], [OrgID]) VALUES (2, N'Private', N'Private Organization', 1)
INSERT [dbo].[OrgType] ([OrgType_ID], [OrgType_name], [Description], [OrgID]) VALUES (3, N'Private', N'Private Organization', 2)
SET IDENTITY_INSERT [dbo].[OrgType] OFF
GO
INSERT [dbo].[Products] ([Product ID], [PrdName], [PrdDesc], [ProductCode], [PrdVersion]) VALUES (1, N'Oracle', N'Database product', N'ABC', N'10.0')
INSERT [dbo].[Products] ([Product ID], [PrdName], [PrdDesc], [ProductCode], [PrdVersion]) VALUES (2, N'Java', N'Java Software', N'XYZ', N'1.8')
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleType], [RoleDescription]) VALUES (1000, N'admin', N'admin', N'admin role')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleType], [RoleDescription]) VALUES (1001, N'user', N'user', N'user role')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
INSERT [dbo].[Status] ([StatusID], [Description]) VALUES (123, N'safgsdgsgsdg')
INSERT [dbo].[Status] ([StatusID], [Description]) VALUES (124, N'dfdhfhdfhdf')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (100, N'testtt', N'dslk@slkgroup.com', 9999999, N'Bangalore', CAST(N'2021-01-19T19:39:28.0000000' AS DateTime2), N'test1')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (101, N'dsl123', N'DSL123@slk.com', 647375355, N'Hyderabad', CAST(N'2020-08-20T18:30:00.0000000' AS DateTime2), N'DSL123')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (102, N'test123', N'test123@gmail.com', 678646783, N'Bangalore', CAST(N'2021-01-19T19:39:28.0000000' AS DateTime2), N'asds')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (104, N'dsl', N'dsl@gmail.com', 678646781, N'Mangalore', CAST(N'2021-01-19T19:39:28.0000000' AS DateTime2), N'admin')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (105, N'admin', N'admin@admin.com', 678646780, N'Mysore', CAST(N'2021-01-22T16:21:56.0000000' AS DateTime2), N'admin')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (106, N'dsl456', N'dsl456@slkdoft.com', 678646790, N'Delhi', CAST(N'2020-12-04T18:30:00.0000000' AS DateTime2), N'dsl456')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (107, N'slk26', N'slk26@slk.com', 365873656, N'mumbai', CAST(N'2020-08-25T18:30:00.0000000' AS DateTime2), N'test')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (108, N'himabindu', N'bindu.gjs@gmail.com', 664666666, N'Punjab', CAST(N'2018-12-26T18:30:00.0000000' AS DateTime2), N'bindu123')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (109, N'TestIDM', N'testidm@slk.com', 465646678, N'Kolkata', CAST(N'2018-12-26T18:30:00.0000000' AS DateTime2), N'test')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (110, N'dsltest123', N'test1234@slk.com', 453553554, N'Vijaywada', CAST(N'2020-08-25T18:30:00.0000000' AS DateTime2), N'slk')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (111, N'Yathish', N'rahul@gmail.com', 453566566, N'Pune', CAST(N'2020-08-25T18:30:00.0000000' AS DateTime2), N'star123')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (112, N'dsltest', N'test123@slk.com', 364666666, N'Noida', CAST(N'2018-12-26T18:30:00.0000000' AS DateTime2), N'slk')
INSERT [dbo].[Users] ([UserID], [UserName], [EmailAddress], [ContactNumber], [Address], [lastlogin], [password]) VALUES (113, N'www', N'www', 123, N'www', CAST(N'2020-08-25T18:30:00.0000000' AS DateTime2), N'slk')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[LicenseType] ADD  DEFAULT ('1') FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (NULL) FOR [lastlogin]
GO
ALTER TABLE [dbo].[License]  WITH CHECK ADD  CONSTRAINT [FK_Algorithm_License] FOREIGN KEY([Algorithm ID])
REFERENCES [dbo].[Algorithm] ([Algorithm ID])
GO
ALTER TABLE [dbo].[License] CHECK CONSTRAINT [FK_Algorithm_License]
GO
ALTER TABLE [dbo].[License]  WITH CHECK ADD  CONSTRAINT [FK_License_Type] FOREIGN KEY([LicenseType ID])
REFERENCES [dbo].[LicenseType] ([LicenseType ID])
GO
ALTER TABLE [dbo].[License] CHECK CONSTRAINT [FK_License_Type]
GO
ALTER TABLE [dbo].[License]  WITH CHECK ADD  CONSTRAINT [FK_Org_License] FOREIGN KEY([OrgID])
REFERENCES [dbo].[Organization] ([OrgID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[License] CHECK CONSTRAINT [FK_Org_License]
GO
ALTER TABLE [dbo].[License]  WITH CHECK ADD  CONSTRAINT [FK_Product_License] FOREIGN KEY([Product ID])
REFERENCES [dbo].[Products] ([Product ID])
GO
ALTER TABLE [dbo].[License] CHECK CONSTRAINT [FK_Product_License]
GO
ALTER TABLE [dbo].[License]  WITH CHECK ADD  CONSTRAINT [FK_Status_License] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[License] CHECK CONSTRAINT [FK_Status_License]
GO
ALTER TABLE [dbo].[License_User]  WITH CHECK ADD  CONSTRAINT [FK_License_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[License_User] CHECK CONSTRAINT [FK_License_User]
GO
ALTER TABLE [dbo].[License_User]  WITH CHECK ADD  CONSTRAINT [FK_License_User1] FOREIGN KEY([LicenseID])
REFERENCES [dbo].[License] ([LicenseID])
GO
ALTER TABLE [dbo].[License_User] CHECK CONSTRAINT [FK_License_User1]
GO
ALTER TABLE [dbo].[Org_User]  WITH CHECK ADD  CONSTRAINT [FK_Org_User] FOREIGN KEY([OrgID])
REFERENCES [dbo].[Organization] ([OrgID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Org_User] CHECK CONSTRAINT [FK_Org_User]
GO
ALTER TABLE [dbo].[Org_User]  WITH CHECK ADD  CONSTRAINT [FK_Org_User1] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Org_User] CHECK CONSTRAINT [FK_Org_User1]
GO
ALTER TABLE [dbo].[OrgType]  WITH CHECK ADD  CONSTRAINT [FK_Org_OrgType] FOREIGN KEY([OrgID])
REFERENCES [dbo].[Organization] ([OrgID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrgType] CHECK CONSTRAINT [FK_Org_OrgType]
GO
ALTER TABLE [dbo].[Users_Roles]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Users_Roles] CHECK CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[Users_Roles]  WITH CHECK ADD  CONSTRAINT [FK_User_Role1] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Users_Roles] CHECK CONSTRAINT [FK_User_Role1]
GO
USE [master]
GO
ALTER DATABASE [License_Portal] SET  READ_WRITE 
GO
