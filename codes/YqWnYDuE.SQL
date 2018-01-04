use AgentsDB

create table [User] (
  id integer not null identity (1, 1) primary key,
  login varchar(128) not null unique,
  password varchar(128) not null,
)
go

create table [Agent] (
  id integer not null identity (1, 1) primary key,
  name varchar(128) not null,
  description varchar(max),
  script varchar(max) not null,
  userId integer not null foreign key references [User] ([id]),
)
go

create table [RunConfiguration] (
  id integer not null identity (1, 1) primary key,
  name varchar(max) not null,
  agentId integer not null foreign key references [Agent] ([id]),
  inputData varchar(max)
)
go

create table [Status] (
  id integer not null identity (1, 1) primary key,
  status varchar(128) not null,
)
go

create table [Execution] (
  id varchar(256) not null primary key,
  script varchar(max) not null,
  runConfId integer not null foreign key references [RunConfiguration] ([id]),
  startTime datetime not null,
  endTime datetime,
  status integer not null foreign key references [Status] ([id]),
)
go

create table [Report] (
  id varchar(256) not null primary key,
  executionId varchar(256) not null foreign key references [Execution] ([id]),
  elapsedTime integer not null,
  result varchar(max),
)
go