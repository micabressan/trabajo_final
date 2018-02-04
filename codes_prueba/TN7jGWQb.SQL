USE [master]
GO
/****** Object:  Database []    Script Date: 24.10.2017 13:04:45 ******/
CREATE DATABASE [WWWConference]
 CONTAINMENT = NONE
 ON  PRIMARY
( NAME = N'WWWConference', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\WWWConference_Data', SIZE = 25600KB , MAXSIZE = 102400KB , FILEGROWTH = 10%)
 LOG ON
( NAME = N'WWWConference_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\WWWConference_Log' , SIZE = 25600KB , MAXSIZE = 51200KB , FILEGROWTH = 20%)
GO
ALTER DATABASE [WWWConference] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WWWConference].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WWWConference] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [WWWConference] SET ANSI_NULLS OFF
GO
ALTER DATABASE [WWWConference] SET ANSI_PADDING OFF
GO
ALTER DATABASE [WWWConference] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [WWWConference] SET ARITHABORT OFF
GO
ALTER DATABASE [WWWConference] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [WWWConference] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [WWWConference] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [WWWConference] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [WWWConference] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [WWWConference] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [WWWConference] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [WWWConference] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [WWWConference] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [WWWConference] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WWWConference] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [WWWConference] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [WWWConference] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [WWWConference] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [WWWConference] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WWWConference] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [WWWConference] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [WWWConference] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WWWConference] SET  MULTI_USER 
GO
ALTER DATABASE [WWWConference] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WWWConference] SET DB_CHAINING OFF
GO
ALTER DATABASE [WWWConference] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF )
GO
ALTER DATABASE [WWWConference] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [WWWConference] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'WWWConference', N'ON'
GO

USE [WWWConference]
GO 
 
 --Create users
CREATE LOGIN moder WITH PASSWORD = 'moder'
CREATE USER moder FOR LOGIN moder
GO
CREATE LOGIN test WITH PASSWORD = 'test'
CREATE USER test FOR LOGIN test
GO
 --Create roles
CREATE ROLE administrator
GRANT INSERT
	ON messages, users, users_pending_review 
	TO administrator
EXEC sp_addrolemember 'administrator', 'moder'
GO

CREATE ROLE test_role 
GRANT INSERT
	ON messages
	TO test_role
EXEC sp_addrolemember 'test_role', 'test'
GO
-- Create schemas
 
-- Create tables
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE messages
(
    id INTEGER NOT NULL,
    topic VARCHAR(255) NOT NULL,
    text VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    parent INTEGER,
    author INTEGER NOT NULL,
    level INTEGER DEFAULT 1 NOT NULL,
    PRIMARY KEY(id)
);
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE users
(
    primary_key INTEGER NOT NULL,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullname VARCHAR(255) NOT NULL,
    is_admin BIT DEFAULT 0 NOT NULL,
    PRIMARY KEY(primary_key)
);
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
CREATE TABLE users_pending_review
(
    primary_key INTEGER NOT NULL,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullname VARCHAR(255) NOT NULL,
    PRIMARY KEY(primary_key)
);
GO
 
-- Create FKs
ALTER TABLE messages
    ADD    FOREIGN KEY (author)
    REFERENCES users(primary_key)
   --MATCH SIMPLE
;
GO    
ALTER TABLE messages
    ADD    FOREIGN KEY (parent)
    REFERENCES messages(id)
   -- MATCH SIMPLE
;
GO   
 
-- Create Indexes
CREATE INDEX full_text ON messages (text, topic, author);
GO

 
-- Insert Test Values
INSERT INTO users 
VALUES (1, 'admin', 'admin', 'admin', 1), 
(2, 'user', 'password', 'Common User', 0), 
(3, 'stupiduser', 'qwerty', 'Mike', 0), 
(4, 'fedotkiller228', 'expelled', 'CMCadmin', 1), 
(5, 'guest', 'guest', 'guest', 0);
GO
 
INSERT INTO messages 
 -- (id,topic,text,date,parent,author(int), level(int))
VALUES (1, 'Main', 'Hello world!', '20171212 10:10:10 AM', NULL, 2, 1), 
(2, 'Main', 'Hello!', '20171212 10:10:54 AM', 1, 3, 1), 
(3, 'Main', 'What r u doing now?', '20171212 10:11:30 AM', 2, 3, 1), 
(4, 'Main', 'Hacking Pentagon, like always', '20171212 10:12:00 AM', 3, 2, 1), 
(5, 'Main', 'Are u from CMC?', '20171212 10:12:21 AM', 4, 4, 1), 
(6, 'Main', 'Yeah!', '20171212 10:12:29 AM', 5, 2, 1), 
(7, 'Main', 'Admin from this conference from vyshka...bye-bye!', '20171212 10:12:59 AM', 6, 5, 1), 
(8, 'Manuals', '1001 ways to expel the CMC student', '20172012 23:59:59 PM', NULL, 4, 1);
GO 
USE [master]
GO
ALTER DATABASE [WWWConference] SET  READ_WRITE 
GO