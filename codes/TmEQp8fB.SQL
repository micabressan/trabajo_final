CREATE DATABASE [Request]

 CREATE TABLE [dbo].[Problem ID](
   [Problem ID] [int] NOT NULL,
   [SubStatus ID] [int] NOT NULL,
   [SubArea ID] [int] NOT NULL,
   [Type ID] [int] NOTNULL,
   [Customer ID] [int] NOT NULL,
   [Customer Segment] [char] NULL,
   [Creator] [char] NOT NULL,
   [Status History] [char] NULL,
   [Status Time] [int] NULL,
   [Status] [char] NULL,
   [Agent] [char](1) NULL,
CONSTRAINT [PK_Problem ID] PRIMARY KEY CLUSTERED
)

CREATE TABLE [dbo].[SubStatus](
   [SubStatus ID] [int] NOT NULL,
   [Status ID] [int] NOT NULL,
   [Approved] [smallint] NULL,
   [Assignet] [smallint] NULL,
   [Completed] [smallint] NULL,
   [Resolved] [smallint] NULL,
   [InProgress] [smallint] NULL,
   [Returned] [smallint] NULL,
CONSTRAINT [SubStatus ID] PRIMARY KEY CLUSTERED

CREATE TABLE [dbo].[Status](
   [Status ID] [int] NOT NULL,
   [Open] [int] NULL,
   [Closed] [int] NULL,
   [Canseled] [int] NULL,
CONSTRAINT [Status ID] PRIMARY KEY CLUSTERED

CREATE TABLE [dbo].[Sub Area] (
   [SubArea ID] [int] NOT NULL,
   [Area ID] [int] NULL,
   [2G] [int] NULL,
   [3G] [int] NULL,
   [4G] [int] NULL,
   [Settings] [int] NULL,
   [Voice] [int] NULL,
   [Transmission] [int] NULL,
   [SMS] [int] NULL,
   [MMS] [int] NULL,
   [Rouming] [int] NULL,
   [Service] [int] NULL,
   [Questions] [int] NULL,
   [Covarage] [int] NULL,
   [Calls] [int] NULL,
CONSTRAINT [SubArea ID] PRIMARY KEY CLUSTERED

CREATE TABLE [dbl].[Area]
   [Area ID] [int] NOT NULL,
   [Internet] [int] NULL,
   [RoumingInternet] [int] NULL,
   [Voice] [int] NULL,
   [SMS] [int] NULL,
   [MMS] [int] NULL,
   [Coverage] [int] NULL,
CONSTRAINT [Area ID] PRIMARY KEY CLUSTERED

CREATE TABLE [dbl].[Customer]
   [Customer ID] [int] NOT NULL,
   [EGN] [int] NULL,
   [Name] [char] NULL,
   [Adress] [char] NULL,
CONSTRAINT [Customer] PRIMARY KEY CLUSTERED
    
CREATE TABLE [dbl].[Adress]
   [Adress] [char] NOT NULL,
   [Country] [char] NULL,
   [City/Village] [char] NULL,
   [Street Name] [char] NULL,
   [Street Number] [int] NULL,
   [Block Number] [int] NULL,
   [Zip] [int] NULL,
CONSTRAINT [Adress] PRIMARY KEY CLUSTERED

CREATE TABLE [dbl].[Type]
   [Type ID] [int] NOT NULL,
   [Missing Internet] [int] NULL,
   [Missing Internet-Rouming] [int] NULL,
   [Device Setup] [int] NULL,
   [Data Check] [int] NULL,
   [Low Speed Internet] [int] NULL,
   [Missing Incoming Calls] [int] NULL,
   [Missing Outgoing Calls] [int] NULL,
   [Rouming Missing Calls] [int] NULL,
   [Dropped Calls] [int] NULL,
   [Bad Voice Quality] [int] NULL,
   [Missing Incoming SMS] [int] NULL,
   [Missing Incoming MMS] [int] NULL,
   [Missing Outgoing SMS] [int] NULL,
   [Missing Outgoing MMS] [int] NULL,
   [SMS In Rouming] [int] NULL,
   [Coverage Quality Ckech] [int] NULL,
   [Info For Improvement] [int] NULL,
CONSTRAINT [Type ID] PRIMARY KEY CLUSTERED

CREATE TABLE [dbl].[Customer Segment]
   [Customer Segment] [int] NOT NULL,
   [Consumer] [int] NULL,
   [Corporate] [int] NULL,
   [VIP] [int] NULL,
   [Pri-Paid] [int] NULL,
CONSTRAINT [Customer Segment] PRIMARY KEY CLUSTERED

CREATE TABLE [dbl].[Creator History]
   [Problem ID] [int] NOT NULL,
   [Creator] [char] NOT NULL,
   [Status Time] [int] NOT NULL,
CONSTRAINT [Problem ID] PRIMARY KEY CLUSTERED

CREATE TABLE [dbl].[Status History]
   [Problem ID] [int] NOT NULL,
   [Status] [int] NOT NULL,
   [Status Time] [int] NOT NULL,
CONSTRAINT [Problem ID] PRIMARY KEY CLUSTERED

CREATE TABLE [dbl].[Statis Time]
   [Problem ID] [int] NOT NULL,
   [Status] [int] NOT NULL,
   [Opened] [int] NOT NULL,
   [Closed] [int] NOT NULL,
   [Agent On The Status] [char] NOT NULL,
CONSTRAINT [Problem ID] PRIMARY KEY CLUSTERED