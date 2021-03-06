USE [master]
GO
/****** Object:  Database [PrnAssign]    Script Date: 4/3/2021 11:39:20 PM ******/
CREATE DATABASE [PrnAssign]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PrnAssign', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PrnAssign.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PrnAssign_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PrnAssign_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PrnAssign] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PrnAssign].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PrnAssign] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PrnAssign] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PrnAssign] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PrnAssign] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PrnAssign] SET ARITHABORT OFF 
GO
ALTER DATABASE [PrnAssign] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PrnAssign] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PrnAssign] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PrnAssign] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PrnAssign] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PrnAssign] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PrnAssign] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PrnAssign] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PrnAssign] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PrnAssign] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PrnAssign] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PrnAssign] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PrnAssign] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PrnAssign] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PrnAssign] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PrnAssign] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PrnAssign] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PrnAssign] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PrnAssign] SET  MULTI_USER 
GO
ALTER DATABASE [PrnAssign] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PrnAssign] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PrnAssign] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PrnAssign] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PrnAssign] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PrnAssign] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PrnAssign', N'ON'
GO
ALTER DATABASE [PrnAssign] SET QUERY_STORE = OFF
GO
USE [PrnAssign]
GO
/****** Object:  User [tuanlinh]    Script Date: 4/3/2021 11:39:20 PM ******/
CREATE USER [tuanlinh] FOR LOGIN [tuanlinh] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [tuanlinh]
GO
/****** Object:  Table [dbo].[Playlist]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Playlist](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Owner_id] [int] NOT NULL,
	[Created_at] [datetime] NULL,
	[Last_modified] [datetime] NULL,
	[Quantity] [int] NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchQuery]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchQuery](
	[user_id] [int] NOT NULL,
	[search_query] [nvarchar](max) NOT NULL,
	[searched_at] [datetime] NOT NULL,
	[query_status] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_SearchQueries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subscriber]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscriber](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Channel_id] [int] NOT NULL,
	[User_id] [int] NOT NULL,
	[Time] [datetime] NULL,
	[Action] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tag]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Created_at] [datetime] NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Account_status] [int] NULL,
	[Username] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Avatar] [nvarchar](max) NULL,
	[Created_date] [datetime2](7) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Birth_date] [datetime2](7) NOT NULL,
	[First_name] [nvarchar](max) NOT NULL,
	[Last_name] [nvarchar](max) NOT NULL,
	[Channel_name] [nvarchar](max) NOT NULL,
	[Background_image] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Subscriber] [int] NULL,
	[Active_code] [nvarchar](max) NOT NULL,
	[Sad_code] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserFavoriteChannel]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFavoriteChannel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[User_id] [int] NOT NULL,
	[Channel_id] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Created_at] [datetime] NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserFavoriteTag]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFavoriteTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[User_id] [int] NOT NULL,
	[Tag_id] [int] NOT NULL,
	[Rating] [int] NULL,
	[Created_at] [datetime] NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Video]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Video](
	[Name] [nvarchar](max) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Created_date] [datetime] NOT NULL,
	[Owner_id] [int] NOT NULL,
	[View] [int] NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Video_format] [nvarchar](max) NOT NULL,
	[Duration] [int] NOT NULL,
	[ID] [nvarchar](max) NOT NULL,
	[rID] [int] IDENTITY(1,1) NOT NULL,
	[Comment] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VideoComment]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VideoComment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Video_id] [nvarchar](max) NOT NULL,
	[Owner_id] [int] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[Created_at] [datetime] NULL,
	[Updated_at] [datetime] NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VideoPlaylist]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VideoPlaylist](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Video_id] [nvarchar](max) NOT NULL,
	[Playlist_id] [int] NOT NULL,
	[Added_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VideoTag]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VideoTag](
	[video_id] [nvarchar](max) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tag_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WatchHistory]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WatchHistory](
	[Video_id] [nvarchar](max) NOT NULL,
	[User_id] [int] NOT NULL,
	[Time] [datetime] NOT NULL,
	[Status] [int] NULL,
	[Watch_time] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[SearchQuery] ON 

INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (1, N'test', CAST(N'2021-09-03T00:00:00.000' AS DateTime), 0, 1)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'ada', CAST(N'2021-09-03T00:00:00.000' AS DateTime), 0, 2)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'fsd', CAST(N'2021-03-09T16:50:29.180' AS DateTime), 0, 3)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'fsd', CAST(N'2021-03-09T16:53:05.010' AS DateTime), 0, 4)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sdad', CAST(N'2021-03-09T16:53:22.917' AS DateTime), 0, 5)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sdad', CAST(N'2021-03-09T16:55:32.200' AS DateTime), 0, 6)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'adf', CAST(N'2021-03-09T16:55:56.657' AS DateTime), 0, 7)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'adf', CAST(N'2021-03-09T16:55:59.747' AS DateTime), 0, 8)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'adf', CAST(N'2021-03-09T16:56:00.760' AS DateTime), 0, 9)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'a', CAST(N'2021-03-09T17:07:18.573' AS DateTime), 0, 10)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'a', CAST(N'2021-03-09T17:09:18.850' AS DateTime), 0, 11)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'a', CAST(N'2021-03-09T17:09:35.977' AS DateTime), 0, 12)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:09:44.950' AS DateTime), 0, 13)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:15:19.837' AS DateTime), 0, 14)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:17:59.523' AS DateTime), 0, 15)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:18:47.533' AS DateTime), 0, 16)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:19:18.020' AS DateTime), 0, 17)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:21:08.910' AS DateTime), 0, 18)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:21:36.177' AS DateTime), 0, 19)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:22:50.217' AS DateTime), 0, 20)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:23:13.547' AS DateTime), 0, 21)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:23:32.310' AS DateTime), 0, 22)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:24:15.690' AS DateTime), 0, 23)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:24:40.570' AS DateTime), 0, 24)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:26:09.863' AS DateTime), 0, 25)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:26:18.417' AS DateTime), 0, 26)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:26:26.257' AS DateTime), 0, 27)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:27:04.870' AS DateTime), 0, 28)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:27:20.877' AS DateTime), 0, 29)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:27:42.367' AS DateTime), 0, 30)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:27:49.747' AS DateTime), 0, 31)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:28:04.307' AS DateTime), 0, 32)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:28:13.587' AS DateTime), 0, 33)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:28:59.913' AS DateTime), 0, 34)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:29:16.727' AS DateTime), 0, 35)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:29:39.823' AS DateTime), 0, 36)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:29:54.837' AS DateTime), 0, 37)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:30:05.433' AS DateTime), 0, 38)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:30:19.460' AS DateTime), 0, 39)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:30:24.837' AS DateTime), 0, 40)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:32:08.267' AS DateTime), 0, 41)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:32:14.027' AS DateTime), 0, 42)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:32:30.043' AS DateTime), 0, 43)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:32:45.127' AS DateTime), 0, 44)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:32:54.597' AS DateTime), 0, 45)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:34:58.210' AS DateTime), 0, 46)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:35:07.057' AS DateTime), 0, 47)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:35:28.057' AS DateTime), 0, 48)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:36:30.710' AS DateTime), 0, 49)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:36:46.550' AS DateTime), 0, 50)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:36:51.777' AS DateTime), 0, 51)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:37:01.320' AS DateTime), 0, 52)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:37:31.780' AS DateTime), 0, 53)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:38:21.337' AS DateTime), 0, 54)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:38:31.373' AS DateTime), 0, 55)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:39:10.220' AS DateTime), 0, 56)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:39:48.963' AS DateTime), 0, 57)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sad', CAST(N'2021-03-09T17:40:24.057' AS DateTime), 0, 58)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (4, N'a', CAST(N'2021-03-13T15:47:22.627' AS DateTime), 0, 59)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'a', CAST(N'2021-03-13T16:33:19.073' AS DateTime), 0, 60)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-21T13:28:41.067' AS DateTime), 0, 61)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-21T13:29:05.887' AS DateTime), 0, 62)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-21T13:38:48.030' AS DateTime), 0, 63)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T13:39:12.887' AS DateTime), 0, 64)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'm', CAST(N'2021-03-21T13:41:27.677' AS DateTime), 0, 65)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'm', CAST(N'2021-03-21T13:41:32.840' AS DateTime), 0, 66)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T13:41:35.367' AS DateTime), 0, 67)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T13:41:40.797' AS DateTime), 0, 68)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T13:41:59.547' AS DateTime), 0, 69)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T13:42:09.660' AS DateTime), 0, 70)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'sdf', CAST(N'2021-03-21T13:48:19.427' AS DateTime), 0, 71)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T13:48:24.490' AS DateTime), 0, 72)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T13:48:39.163' AS DateTime), 0, 73)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T13:48:48.877' AS DateTime), 0, 74)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T13:51:43.817' AS DateTime), 0, 75)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-21T15:30:46.370' AS DateTime), 0, 76)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T15:31:15.357' AS DateTime), 0, 77)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-21T20:53:09.897' AS DateTime), 0, 78)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-21T20:53:17.957' AS DateTime), 0, 79)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T20:53:36.097' AS DateTime), 0, 80)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'v', CAST(N'2021-03-21T20:53:49.537' AS DateTime), 0, 81)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'v', CAST(N'2021-03-21T20:53:56.667' AS DateTime), 0, 82)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T20:54:05.933' AS DateTime), 0, 83)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T20:54:08.780' AS DateTime), 0, 84)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-21T20:54:34.303' AS DateTime), 0, 85)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-21T21:22:22.573' AS DateTime), 0, 86)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-21T21:22:34.067' AS DateTime), 0, 87)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-21T21:37:31.880' AS DateTime), 0, 88)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'music', CAST(N'2021-03-22T11:53:39.297' AS DateTime), 0, 89)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'music', CAST(N'2021-03-22T11:53:49.857' AS DateTime), 0, 90)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'ad', CAST(N'2021-03-22T11:53:55.153' AS DateTime), 0, 91)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'te', CAST(N'2021-03-22T11:54:09.407' AS DateTime), 0, 92)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-23T08:46:38.290' AS DateTime), 0, 93)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sa', CAST(N'2021-03-25T00:12:46.727' AS DateTime), 0, 94)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-03-29T10:01:10.380' AS DateTime), 0, 95)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-03-31T08:18:12.303' AS DateTime), 0, 96)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-02T01:50:28.173' AS DateTime), 0, 97)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-02T07:59:48.393' AS DateTime), 0, 98)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (4, N's', CAST(N'2021-04-02T20:12:54.703' AS DateTime), 0, 99)
GO
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (14, N's', CAST(N'2021-04-02T22:32:58.047' AS DateTime), 0, 100)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-02T23:45:04.127' AS DateTime), 0, 101)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:49:55.227' AS DateTime), 0, 102)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:50:34.670' AS DateTime), 0, 103)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:51:07.087' AS DateTime), 0, 104)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:51:27.180' AS DateTime), 0, 105)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:56:18.627' AS DateTime), 0, 106)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:57:42.787' AS DateTime), 0, 107)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:57:47.310' AS DateTime), 0, 108)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:58:02.767' AS DateTime), 0, 109)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:58:05.350' AS DateTime), 0, 110)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:58:11.293' AS DateTime), 0, 111)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:58:35.297' AS DateTime), 0, 112)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:59:25.353' AS DateTime), 0, 113)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:59:37.157' AS DateTime), 0, 114)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T00:59:49.463' AS DateTime), 0, 115)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:00:16.530' AS DateTime), 0, 116)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:00:19.983' AS DateTime), 0, 117)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:00:23.650' AS DateTime), 0, 118)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:02:34.790' AS DateTime), 0, 119)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:02:39.140' AS DateTime), 0, 120)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:02:52.207' AS DateTime), 0, 121)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:07:01.100' AS DateTime), 0, 1098)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:07:57.933' AS DateTime), 0, 1099)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:08:04.847' AS DateTime), 0, 1100)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:08:49.243' AS DateTime), 0, 1101)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:10:17.980' AS DateTime), 0, 1102)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:10:25.850' AS DateTime), 0, 1103)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:10:50.777' AS DateTime), 0, 1104)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:10:57.567' AS DateTime), 0, 1105)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:11:06.903' AS DateTime), 0, 1106)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:11:19.497' AS DateTime), 0, 1107)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'asd', CAST(N'2021-04-03T01:11:27.373' AS DateTime), 0, 1108)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sa', CAST(N'2021-04-03T01:11:29.073' AS DateTime), 0, 1109)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:11:30.887' AS DateTime), 0, 1110)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'sd', CAST(N'2021-04-03T01:11:32.633' AS DateTime), 0, 1111)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N'messi', CAST(N'2021-04-03T01:11:35.413' AS DateTime), 0, 1112)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:13:12.173' AS DateTime), 0, 1113)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:16:12.487' AS DateTime), 0, 1114)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:18:18.637' AS DateTime), 0, 1115)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:20:42.650' AS DateTime), 0, 1116)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:21:21.827' AS DateTime), 0, 1117)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:22:58.273' AS DateTime), 0, 1118)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:23:45.437' AS DateTime), 0, 1119)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:24:03.437' AS DateTime), 0, 1120)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:24:29.680' AS DateTime), 0, 1121)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:24:38.677' AS DateTime), 0, 1122)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:26:27.053' AS DateTime), 0, 1123)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:26:59.123' AS DateTime), 0, 1124)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:27:13.397' AS DateTime), 0, 1125)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:29:41.377' AS DateTime), 0, 1126)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:30:02.753' AS DateTime), 0, 1127)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:30:43.647' AS DateTime), 0, 1128)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:32:38.493' AS DateTime), 0, 1129)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:33:36.457' AS DateTime), 0, 1130)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:34:07.520' AS DateTime), 0, 1131)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:34:41.987' AS DateTime), 0, 1132)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:35:19.697' AS DateTime), 0, 1133)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:35:30.477' AS DateTime), 0, 1134)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:35:35.720' AS DateTime), 0, 1135)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:35:48.013' AS DateTime), 0, 1136)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:36:06.647' AS DateTime), 0, 1137)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:37:03.863' AS DateTime), 0, 1138)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:37:10.883' AS DateTime), 0, 1139)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:37:49.180' AS DateTime), 0, 1140)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:38:33.193' AS DateTime), 0, 1141)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:38:59.080' AS DateTime), 0, 1142)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:39:13.957' AS DateTime), 0, 1143)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:39:31.790' AS DateTime), 0, 1144)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:40:35.330' AS DateTime), 0, 1145)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:41:07.997' AS DateTime), 0, 1146)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:43:09.540' AS DateTime), 0, 1147)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:43:21.380' AS DateTime), 0, 1148)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:43:36.707' AS DateTime), 0, 1149)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:44:10.493' AS DateTime), 0, 1150)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:44:14.183' AS DateTime), 0, 1151)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:44:20.690' AS DateTime), 0, 1152)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:44:58.060' AS DateTime), 0, 1153)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:45:10.493' AS DateTime), 0, 1154)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:45:50.167' AS DateTime), 0, 1155)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:47:22.763' AS DateTime), 0, 1156)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T01:47:32.277' AS DateTime), 0, 1157)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T02:04:53.217' AS DateTime), 0, 1158)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T02:05:22.287' AS DateTime), 0, 1159)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T02:06:10.487' AS DateTime), 0, 1160)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:06:26.510' AS DateTime), 0, 1161)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:06:34.417' AS DateTime), 0, 1162)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:06:42.343' AS DateTime), 0, 1163)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:06:43.517' AS DateTime), 0, 1164)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:07:39.547' AS DateTime), 0, 1165)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T02:08:38.483' AS DateTime), 0, 1166)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:08:56.057' AS DateTime), 0, 1167)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:09:33.510' AS DateTime), 0, 1168)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:09:56.037' AS DateTime), 0, 1169)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:10:08.483' AS DateTime), 0, 1170)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:10:21.730' AS DateTime), 0, 1171)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:11:04.757' AS DateTime), 0, 1172)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:11:25.723' AS DateTime), 0, 1173)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:11:33.840' AS DateTime), 0, 1174)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:12:03.387' AS DateTime), 0, 1175)
GO
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:14:03.977' AS DateTime), 0, 1176)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:14:27.130' AS DateTime), 0, 1177)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:15:27.420' AS DateTime), 0, 1178)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:15:30.987' AS DateTime), 0, 1179)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:16:55.520' AS DateTime), 0, 1180)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:17:00.640' AS DateTime), 0, 1181)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:17:01.523' AS DateTime), 0, 1182)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:17:02.323' AS DateTime), 0, 1183)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T02:19:22.433' AS DateTime), 0, 1184)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T02:21:42.773' AS DateTime), 0, 1185)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T02:29:39.210' AS DateTime), 0, 1186)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T02:31:50.417' AS DateTime), 0, 1187)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:32:05.677' AS DateTime), 0, 1188)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:32:41.703' AS DateTime), 0, 1189)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:33:03.200' AS DateTime), 0, 1190)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:33:09.563' AS DateTime), 0, 1191)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:33:11.083' AS DateTime), 0, 1192)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:33:14.000' AS DateTime), 0, 1193)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:36:44.797' AS DateTime), 0, 1194)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:37:18.060' AS DateTime), 0, 1195)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:37:27.403' AS DateTime), 0, 1196)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:38:14.343' AS DateTime), 0, 1197)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:40:41.980' AS DateTime), 0, 1198)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:40:49.070' AS DateTime), 0, 1199)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:41:43.110' AS DateTime), 0, 1200)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:42:01.403' AS DateTime), 0, 1201)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:42:10.383' AS DateTime), 0, 1202)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:43:04.653' AS DateTime), 0, 1203)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'sasuke', CAST(N'2021-04-03T02:43:42.853' AS DateTime), 0, 1204)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:44:03.907' AS DateTime), 0, 1205)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:44:07.513' AS DateTime), 0, 1206)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:44:24.110' AS DateTime), 0, 1207)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N'sa', CAST(N'2021-04-03T02:47:52.137' AS DateTime), 0, 1208)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T02:47:57.610' AS DateTime), 0, 1209)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (-1, N's', CAST(N'2021-04-03T12:55:20.353' AS DateTime), 0, 1210)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T12:55:47.953' AS DateTime), 0, 1211)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T14:10:15.850' AS DateTime), 0, 1212)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T16:38:21.940' AS DateTime), 0, 1213)
INSERT [dbo].[SearchQuery] ([user_id], [search_query], [searched_at], [query_status], [id]) VALUES (0, N's', CAST(N'2021-04-03T23:32:40.433' AS DateTime), 0, 1214)
SET IDENTITY_INSERT [dbo].[SearchQuery] OFF
GO
SET IDENTITY_INSERT [dbo].[Subscriber] ON 

INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (194, 0, 4, CAST(N'2021-03-20T21:25:03.500' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (195, 4, 0, CAST(N'2021-03-22T11:41:13.030' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (196, 4, 0, CAST(N'2021-03-22T11:42:08.490' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (197, 4, 0, CAST(N'2021-03-22T11:42:09.810' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (198, 4, 0, CAST(N'2021-03-22T11:42:10.250' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (199, 4, 0, CAST(N'2021-03-22T11:42:11.213' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (200, 5, 0, CAST(N'2021-04-02T23:06:23.703' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1200, 4, 0, CAST(N'2021-04-03T02:09:57.523' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1201, 6, 0, CAST(N'2021-04-03T02:10:14.273' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1202, 6, 0, CAST(N'2021-04-03T02:12:15.147' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1203, 18, 0, CAST(N'2021-04-03T02:16:47.833' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1204, 18, 0, CAST(N'2021-04-03T02:16:57.947' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1205, 4, 0, CAST(N'2021-04-03T02:32:07.227' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1206, 4, 0, CAST(N'2021-04-03T02:32:43.553' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1207, 4, 0, CAST(N'2021-04-03T02:33:04.543' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1208, 6, 0, CAST(N'2021-04-03T02:33:06.723' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1209, 18, 0, CAST(N'2021-04-03T02:33:12.613' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1210, 4, 0, CAST(N'2021-04-03T02:36:46.760' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1211, 4, 0, CAST(N'2021-04-03T02:37:29.037' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1212, 4, 0, CAST(N'2021-04-03T02:38:15.647' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1213, 4, 0, CAST(N'2021-04-03T02:40:44.783' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1214, 4, 0, CAST(N'2021-04-03T02:40:50.390' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1215, 4, 0, CAST(N'2021-04-03T02:41:44.610' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1216, 4, 0, CAST(N'2021-04-03T02:42:03.690' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1217, 4, 0, CAST(N'2021-04-03T02:42:04.663' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1218, 4, 0, CAST(N'2021-04-03T02:42:12.010' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1219, 4, 0, CAST(N'2021-04-03T02:42:15.290' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1220, 4, 0, CAST(N'2021-04-03T02:43:06.627' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1221, 4, 0, CAST(N'2021-04-03T02:43:07.160' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1222, 4, 0, CAST(N'2021-04-03T02:43:10.460' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1223, 4, 0, CAST(N'2021-04-03T02:43:11.323' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1224, 4, 0, CAST(N'2021-04-03T02:43:14.577' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1225, 6, 0, CAST(N'2021-04-03T02:43:15.930' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1226, 18, 0, CAST(N'2021-04-03T02:43:17.153' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1227, 6, 0, CAST(N'2021-04-03T02:43:22.857' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1228, 4, 0, CAST(N'2021-04-03T02:48:06.230' AS DateTime), 0)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1229, 4, 0, CAST(N'2021-04-03T16:38:33.073' AS DateTime), 1)
INSERT [dbo].[Subscriber] ([Id], [Channel_id], [User_id], [Time], [Action]) VALUES (1230, 4, 0, CAST(N'2021-04-03T16:38:34.200' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Subscriber] OFF
GO
SET IDENTITY_INSERT [dbo].[Tag] ON 

INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (3, N'Company Culture', CAST(N'2021-03-29T15:55:36.150' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (4, N'Interview', CAST(N'2021-03-29T15:55:42.290' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (5, N'Q&A', CAST(N'2021-03-29T15:55:47.277' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (6, N'Webinar', CAST(N'2021-03-29T15:55:51.393' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (7, N'Event', CAST(N'2021-03-29T15:55:54.953' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (8, N'Presentation', CAST(N'2021-03-29T15:55:58.757' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (9, N'Turtorial', CAST(N'2021-03-29T15:56:04.277' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (10, N'React Js', CAST(N'2021-03-29T15:56:13.053' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (11, N'React Native', CAST(N'2021-03-29T15:56:15.927' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (12, N'Product Review', CAST(N'2021-03-29T15:56:22.307' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (13, N'Testimonial', CAST(N'2021-03-29T15:56:28.403' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (14, N'Animation', CAST(N'2021-03-29T15:56:41.573' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (15, N'Anime', CAST(N'2021-03-29T15:56:43.747' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (16, N'Jujutsu Kaisen', CAST(N'2021-03-29T15:56:51.207' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (17, N'Live Streaming', CAST(N'2021-03-29T15:56:58.957' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (18, N'Film', CAST(N'2021-03-29T15:57:11.210' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (19, N'Cinema', CAST(N'2021-03-29T15:57:14.080' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (20, N'Video Emails', CAST(N'2021-03-29T15:57:20.443' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (21, N'Contest', CAST(N'2021-03-29T15:57:30.327' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (22, N'Kingkong vs Godzilla', CAST(N'2021-03-29T15:57:39.750' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (23, N'Daily life', CAST(N'2021-03-29T15:57:50.623' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (24, N'Video game', CAST(N'2021-03-29T15:58:07.897' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (25, N'Esport', CAST(N'2021-03-29T15:58:12.377' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (26, N'Valorant', CAST(N'2021-03-29T15:58:20.077' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (27, N'Leage of Legends', CAST(N'2021-03-29T15:58:26.590' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (28, N'CSGO', CAST(N'2021-03-29T15:58:34.653' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (29, N'Music', CAST(N'2021-03-29T15:58:49.883' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (30, N'Oscar Award', CAST(N'2021-03-29T15:58:57.760' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (31, N'Computer', CAST(N'2021-03-29T15:59:03.950' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (32, N'Ai', CAST(N'2021-03-29T15:59:06.823' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (33, N'Computer Science', CAST(N'2021-03-29T15:59:12.947' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (34, N'Software engineer', CAST(N'2021-03-29T15:59:25.750' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (35, N'Internet', CAST(N'2021-03-29T15:59:34.610' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (36, N'Cover', CAST(N'2021-03-29T21:54:36.133' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (37, N'Health', CAST(N'2021-03-29T21:56:48.170' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (38, N'Trailer', CAST(N'2021-03-29T21:57:23.273' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (39, N'Action Movie', CAST(N'2021-03-29T21:57:32.260' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (40, N'Horror Movie', CAST(N'2021-03-29T21:58:04.587' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (41, N'Reaction', CAST(N'2021-03-29T21:59:27.910' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (42, N'Comedy', CAST(N'2021-03-29T21:59:31.903' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (43, N'Attack On Titan', CAST(N'2021-03-29T22:01:46.240' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (44, N'George Hotz', CAST(N'2021-03-29T22:09:32.550' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (45, N'Interview', CAST(N'2021-03-29T22:09:39.013' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (46, N'Programming', CAST(N'2021-03-29T22:09:52.830' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (47, N'Reading', CAST(N'2021-03-29T22:12:34.440' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (48, N'Life Style', CAST(N'2021-03-29T22:12:42.207' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (50, N'NCS', CAST(N'2021-03-29T22:18:43.863' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (51, N'Vlog', CAST(N'2021-03-29T22:51:54.620' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (52, N'History', CAST(N'2021-03-30T22:44:20.710' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (53, N'Discovery', CAST(N'2021-03-30T22:44:43.407' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (54, N'Education', CAST(N'2021-03-30T22:47:20.220' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (55, N'Elon Musk', CAST(N'2021-03-30T22:47:28.640' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (56, N'Cooking', CAST(N'2021-03-30T22:48:43.393' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (57, N'Food', CAST(N'2021-03-30T22:48:47.520' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (58, N'Gordon Ramsay', CAST(N'2021-03-30T22:49:01.500' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (59, N'Science', CAST(N'2021-03-30T22:51:56.470' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (60, N'Documentary', CAST(N'2021-03-30T22:54:20.263' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (61, N'Suez Canal', CAST(N'2021-03-30T22:54:32.623' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (62, N'Lionel Messi', CAST(N'2021-03-30T22:55:17.370' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (63, N'Football', CAST(N'2021-03-30T22:55:23.293' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (64, N'Super Star', CAST(N'2021-03-30T22:55:31.293' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (65, N'Sport', CAST(N'2021-03-30T22:56:06.710' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (66, N'Hightlight', CAST(N'2021-03-30T22:56:49.323' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (67, N'Maroon 5', CAST(N'2021-03-30T22:58:32.290' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (68, N'TED Talk', CAST(N'2021-03-30T22:59:33.020' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (69, N'Language', CAST(N'2021-03-30T23:59:09.937' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (70, N'Mathematic', CAST(N'2021-03-31T00:19:33.287' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (71, N'Jeff Bezos', CAST(N'2021-03-31T00:20:31.847' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (72, N'Sleep', CAST(N'2021-03-31T00:21:11.190' AS DateTime), 0)
INSERT [dbo].[Tag] ([Id], [Name], [Created_at], [Status]) VALUES (73, N'Barcelona', CAST(N'2021-03-31T00:22:28.750' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Tag] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Account_status], [Username], [Password], [Avatar], [Created_date], [Email], [Birth_date], [First_name], [Last_name], [Channel_name], [Background_image], [Description], [Subscriber], [Active_code], [Sad_code]) VALUES (0, 1, N'sa                       ', N'03a63f091be62ea693b573a8df6d41601efecb24d7d5dc6addfd93665454ea3a', N'default.png', CAST(N'2021-03-08T00:00:00.0000000' AS DateTime2), N't@gmail.com', CAST(N'2000-07-29T00:00:00.0000000' AS DateTime2), N'nguyen vu                ', N'tuan linh                ', N'tuan linh', N'sky.png', N'...', 1, N'abcdzuy0', N'ssfdfsdf')
INSERT [dbo].[User] ([Id], [Account_status], [Username], [Password], [Avatar], [Created_date], [Email], [Birth_date], [First_name], [Last_name], [Channel_name], [Background_image], [Description], [Subscriber], [Active_code], [Sad_code]) VALUES (4, 1, N'SatoruDojo', N'3a6701d2afcc496ff5e81dc23fb15d1ebedcb5fa489552e4f6da826f360cdfe8', N'default.png', CAST(N'2021-03-12T00:19:58.1710779' AS DateTime2), N'tuanlinh29720@gmail.com', CAST(N'2000-12-12T00:00:00.0000000' AS DateTime2), N'nguyen vu', N'tuan linh', N'SatoruDojo', N'sky.png', N'...', 1, N'abcdzuz4', N'ssfdfsde')
INSERT [dbo].[User] ([Id], [Account_status], [Username], [Password], [Avatar], [Created_date], [Email], [Birth_date], [First_name], [Last_name], [Channel_name], [Background_image], [Description], [Subscriber], [Active_code], [Sad_code]) VALUES (5, 1, N'Uzimaki Naruto', N'fbabad751e92124db746d32445c8dccb7cd1585a256e4a2337755282c341c504', N'default.png', CAST(N'2021-03-14T11:38:45.4805923' AS DateTime2), N't@gmail.com', CAST(N'2000-07-29T00:00:00.0000000' AS DateTime2), N'nguyen', N'tuan', N'Uzimaki Naruto', N'sky.png', N'...', 1, N'abcdzuy5', N'ssfdfsdg')
INSERT [dbo].[User] ([Id], [Account_status], [Username], [Password], [Avatar], [Created_date], [Email], [Birth_date], [First_name], [Last_name], [Channel_name], [Background_image], [Description], [Subscriber], [Active_code], [Sad_code]) VALUES (6, 1, N'Sasuke', N'c047b07704c3064dc2dc662b4e8f3a37a51ab622d879057eae8347f771a81c29', N'default.png', CAST(N'2021-03-14T11:42:05.9000000' AS DateTime2), N't@gmail.com', CAST(N'2000-07-29T00:00:00.0000000' AS DateTime2), N'tuan', N'linh', N'Sasuke', N'sky.png', N'...', 1, N'abcdzuy6', N'ssfdfsdh')
INSERT [dbo].[User] ([Id], [Account_status], [Username], [Password], [Avatar], [Created_date], [Email], [Birth_date], [First_name], [Last_name], [Channel_name], [Background_image], [Description], [Subscriber], [Active_code], [Sad_code]) VALUES (7, 1, N'Tenz', N'353c756ae9a3083dfbb76491bbf84d11a156414a6952ee683f96780e26110479', N'default.png', CAST(N'2021-03-14T11:52:50.1930000' AS DateTime2), N't@gmail.com', CAST(N'2000-07-29T00:00:00.0000000' AS DateTime2), N'tyson', N'ngo', N'Tenz', N'sky.png', N'...', 0, N'abcdzuy7', N'ssfdfsdd')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[UserFavoriteTag] ON 

INSERT [dbo].[UserFavoriteTag] ([Id], [User_id], [Tag_id], [Rating], [Created_at], [Status]) VALUES (1056, 0, 62, 15, CAST(N'2021-04-03T23:28:17.673' AS DateTime), 0)
INSERT [dbo].[UserFavoriteTag] ([Id], [User_id], [Tag_id], [Rating], [Created_at], [Status]) VALUES (1057, 0, 66, 15, CAST(N'2021-04-03T23:28:17.680' AS DateTime), 0)
INSERT [dbo].[UserFavoriteTag] ([Id], [User_id], [Tag_id], [Rating], [Created_at], [Status]) VALUES (1058, 0, 63, 15, CAST(N'2021-04-03T23:28:17.680' AS DateTime), 0)
INSERT [dbo].[UserFavoriteTag] ([Id], [User_id], [Tag_id], [Rating], [Created_at], [Status]) VALUES (1059, 0, 64, 15, CAST(N'2021-04-03T23:28:17.680' AS DateTime), 0)
INSERT [dbo].[UserFavoriteTag] ([Id], [User_id], [Tag_id], [Rating], [Created_at], [Status]) VALUES (1060, 0, 71, 15, CAST(N'2021-04-03T23:28:21.210' AS DateTime), 0)
INSERT [dbo].[UserFavoriteTag] ([Id], [User_id], [Tag_id], [Rating], [Created_at], [Status]) VALUES (1061, 0, 54, 15, CAST(N'2021-04-03T23:28:21.213' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[UserFavoriteTag] OFF
GO
SET IDENTITY_INSERT [dbo].[Video] ON 

INSERT [dbo].[Video] ([Name], [Title], [Created_date], [Owner_id], [View], [Description], [Video_format], [Duration], [ID], [rID], [Comment]) VALUES (N'Lionel Messi - King Of Football.mp4', N'Lionel Messi - King Of Football', CAST(N'2021-04-03T16:11:10.217' AS DateTime), 0, 2, N'', N'mp4', 818, N'1617466259437vid', 50, 0)
INSERT [dbo].[Video] ([Name], [Title], [Created_date], [Owner_id], [View], [Description], [Video_format], [Duration], [ID], [rID], [Comment]) VALUES (N'What Jeff Bezos Says About Sleep.mp4', N'What Jeff Bezos Says About Sleep', CAST(N'2021-04-03T16:14:15.837' AS DateTime), 0, 1, N'', N'mp4', 167, N'1617466453711vid', 51, 0)
INSERT [dbo].[Video] ([Name], [Title], [Created_date], [Owner_id], [View], [Description], [Video_format], [Duration], [ID], [rID], [Comment]) VALUES (N'Elon Musk Attacks The Education System.mp4', N'Elon Musk Attacks The Education System', CAST(N'2021-04-03T16:29:52.033' AS DateTime), 0, 0, N'', N'mp4', 181, N'1617467389031vid', 52, 0)
INSERT [dbo].[Video] ([Name], [Title], [Created_date], [Owner_id], [View], [Description], [Video_format], [Duration], [ID], [rID], [Comment]) VALUES (N'Maroon 5 - Memories (Official Video).mp4', N'Maroon 5 - Memories(Offical Video)', CAST(N'2021-04-03T16:30:30.173' AS DateTime), 0, 0, N'', N'mp4', 195, N'1617467427667vid', 53, 0)
SET IDENTITY_INSERT [dbo].[Video] OFF
GO
SET IDENTITY_INSERT [dbo].[VideoTag] ON 

INSERT [dbo].[VideoTag] ([video_id], [id], [tag_id]) VALUES (N'1617466259437vid', 86, 62)
INSERT [dbo].[VideoTag] ([video_id], [id], [tag_id]) VALUES (N'1617466259437vid', 87, 66)
INSERT [dbo].[VideoTag] ([video_id], [id], [tag_id]) VALUES (N'1617466259437vid', 88, 63)
INSERT [dbo].[VideoTag] ([video_id], [id], [tag_id]) VALUES (N'1617466259437vid', 89, 64)
INSERT [dbo].[VideoTag] ([video_id], [id], [tag_id]) VALUES (N'1617466453711vid', 90, 71)
INSERT [dbo].[VideoTag] ([video_id], [id], [tag_id]) VALUES (N'1617466453711vid', 91, 54)
INSERT [dbo].[VideoTag] ([video_id], [id], [tag_id]) VALUES (N'1617467389031vid', 92, 55)
INSERT [dbo].[VideoTag] ([video_id], [id], [tag_id]) VALUES (N'1617467389031vid', 93, 54)
INSERT [dbo].[VideoTag] ([video_id], [id], [tag_id]) VALUES (N'1617467427667vid', 94, 29)
SET IDENTITY_INSERT [dbo].[VideoTag] OFF
GO
SET IDENTITY_INSERT [dbo].[WatchHistory] ON 

INSERT [dbo].[WatchHistory] ([Video_id], [User_id], [Time], [Status], [Watch_time], [Id]) VALUES (N'1617466259437vid', 0, CAST(N'2021-04-03T23:28:27.457' AS DateTime), 0, 320, 1053)
INSERT [dbo].[WatchHistory] ([Video_id], [User_id], [Time], [Status], [Watch_time], [Id]) VALUES (N'1617466453711vid', 0, CAST(N'2021-04-03T23:28:21.217' AS DateTime), 0, 0, 1054)
SET IDENTITY_INSERT [dbo].[WatchHistory] OFF
GO
ALTER TABLE [dbo].[Playlist] ADD  DEFAULT (getdate()) FOR [Created_at]
GO
ALTER TABLE [dbo].[Playlist] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Playlist] ADD  DEFAULT ('...') FOR [Description]
GO
ALTER TABLE [dbo].[Subscriber] ADD  DEFAULT (getdate()) FOR [Time]
GO
ALTER TABLE [dbo].[Tag] ADD  DEFAULT (getdate()) FOR [Created_at]
GO
ALTER TABLE [dbo].[Tag] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [df_useravatar]  DEFAULT ('default.png') FOR [Avatar]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [default_description]  DEFAULT (getdate()) FOR [Created_date]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__Users__Backgroun__03F0984C]  DEFAULT ('sky.png') FOR [Background_image]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__Users__Channel_d__04E4BC85]  DEFAULT ('...') FOR [Description]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [Subscriber]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ('abcdzuy') FOR [Active_code]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ('ssfdfsdf') FOR [Sad_code]
GO
ALTER TABLE [dbo].[UserFavoriteChannel] ADD  DEFAULT (getdate()) FOR [Created_at]
GO
ALTER TABLE [dbo].[UserFavoriteChannel] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[UserFavoriteTag] ADD  CONSTRAINT [DF__UserFavor__Ratin__1B9317B3]  DEFAULT ((15)) FOR [Rating]
GO
ALTER TABLE [dbo].[UserFavoriteTag] ADD  DEFAULT (getdate()) FOR [Created_at]
GO
ALTER TABLE [dbo].[UserFavoriteTag] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Video] ADD  DEFAULT ('1615343325897vid') FOR [ID]
GO
ALTER TABLE [dbo].[Video] ADD  DEFAULT ((0)) FOR [Comment]
GO
ALTER TABLE [dbo].[VideoComment] ADD  DEFAULT (getdate()) FOR [Created_at]
GO
ALTER TABLE [dbo].[VideoComment] ADD  DEFAULT (getdate()) FOR [Updated_at]
GO
ALTER TABLE [dbo].[VideoComment] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[VideoPlaylist] ADD  DEFAULT (getdate()) FOR [Added_at]
GO
ALTER TABLE [dbo].[VideoTag] ADD  DEFAULT ((0)) FOR [tag_id]
GO
ALTER TABLE [dbo].[WatchHistory] ADD  CONSTRAINT [DF_WatchHistory_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD  CONSTRAINT [FK_Video_User] FOREIGN KEY([Owner_id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Video] CHECK CONSTRAINT [FK_Video_User]
GO
/****** Object:  Trigger [dbo].[updateRating]    Script Date: 4/3/2021 11:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[updateRating]
   ON [dbo].[UserFavoriteTag]
   AFTER UPDATE
AS 
BEGIN
    UPDATE uft 
	SET uft.Rating -= 1
    FROM UserFavoriteTag uft,inserted
    where (not (uft.Tag_id = inserted.Tag_id and uft.User_id = inserted.User_id)) and uft.Rating > 10
END

GO
ALTER TABLE [dbo].[UserFavoriteTag] ENABLE TRIGGER [updateRating]
GO
USE [master]
GO
ALTER DATABASE [PrnAssign] SET  READ_WRITE 
GO
