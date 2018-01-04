use master 
go

if exists (
	select	name 
	from	sys.databases 
	where	name = N'GusarovVadim' )
alter database [GusarovVadim] set single_user with rollback immediate
go

if exists (
	select	name 
	from	sys.databases 
	where	name = N'GusarovVadim' )
drop database [GusarovVadim]
go

create database [GusarovVadim]
go

use [GusarovVadim]
go

if object_id('GusarovVadim.Tariffs', 'U') is not null
	drop table  GusarovVadim.Tariffs
go

create table Tariffs (
	name			varchar(100),
	mounthCost		float,
	minutesCount	int,
	overflowCost	float,
	check (mounthCost >= 0 and minutesCount >= 0 and overflowCost >= 0 and name != N'')
)
go

insert into Tariffs(name, mounthCost, minutesCount, overflowCost) values
	(N'Без абонентской платы',0, 0, 3),
	(N'Абонентский 50-минутный', 30, 50, 1),
	(N'Безлимитный',50, 0, 0)
go

if object_id( 'GusarovVadim.GetCost', 'F' ) is not null   
    drop function GusarovVadim.GetCost
go

create function GetCost(@nameOfTariff varchar(100), @count float)
returns float as
begin
	declare @overflow float; declare @tariffCost float; declare @minuteCost float;
    select @overflow = minutesCount from Tariffs where @nameOfTariff=name
	select @tariffCost = mounthCost	from Tariffs where @nameOfTariff=name
	select @minuteCost = overflowCost from Tariffs where @nameOfTariff=name
	if (@count < @overflow) return @tariffCost
	return @tariffCost + (@count - @overflow) * @minuteCost
end
go

if object_id( 'GusarovVadim.Median', 'F' ) is not null   
    drop function GusarovVadim.Median
go

create function Median(@name varchar(100), @first float, @second float)
returns float as
begin return (dbo.GetCost(@name, @first) + dbo.GetCost(@name, @second)) / 2 end
go

if object_id( 'GusarovVadim.GetTariff', 'F' ) is not null   
    drop procedure GusarovVadim.GetTariff
go

create procedure GetTariff(@minutes float)
as
	declare @nameOfTariff varchar(100); declare @min float;
	select @min = min(dbo.Median(name, 0, @minutes)) from Tariffs
	select @nameOfTariff = name from Tariffs where @min = dbo.Median(name, 0, @minutes)
	print(@nameOfTariff)
go

exec GetTariff 9

declare @previous float = 0;
declare @current float = 0;
declare intervalСursor cursor for  
select distinct round(b.minutesCount + a.mounthCost / b.overflowCost, 0)
from Tariffs a, Tariffs b
where b.overflowCost != 0 and round(b.minutesCount + a.mounthCost / b.overflowCost, 0) > 0
order by round(b.minutesCount + a.mounthCost / b.overflowCost, 0);

open intervalСursor
fetch next from intervalСursor   
into @current

while @@fetch_status = 0  
begin
	declare @min float = 0; declare @minName varchar(100);
	select @min = min(dbo.Median(name, @previous, @current)) from Tariffs
	select @minName = name from Tariffs where @min = dbo.Median(name, @previous, @current)
	print(N'Интервал: ' 
			+ convert(varchar(100), @previous) 
			+ ' -> ' 
			+  convert(varchar(100), @current)
			+ ' - ' + @minName
	)
	select @previous = @current;
	fetch next from intervalСursor   
    into @current  
end

close intervalСursor;  
deallocate intervalСursor;
go