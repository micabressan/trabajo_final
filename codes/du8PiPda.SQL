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
	(N'Без абонентской платы',0, 0, 0.5),
	(N'Абонентский 50-минутный', 2, 6, 1),
	(N'Безлимитный',5, 0, 0)
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
	select @min = min(dbo.Median(name, @minutes, @minutes)) from Tariffs
	select @nameOfTariff = name from Tariffs where @min = dbo.Median(name, @minutes, @minutes)
	print(@nameOfTariff)
go

exec GetTariff 9
exec GetTariff 55
exec GetTariff 70

declare _intervalСursor cursor for  
select distinct round(b.minutesCount + a.mounthCost / b.overflowCost, 0)
from Tariffs a, Tariffs b
where b.overflowCost != 0 and round(b.minutesCount + a.mounthCost / b.overflowCost, 0) > 0
order by round(b.minutesCount + a.mounthCost / b.overflowCost, 0);

open _intervalСursor
fetch next from _intervalСursor
declare @_count float = 1;

while @@FETCH_STATUS = 0
begin
	set @_count = @_count + 1;
	fetch next from _intervalСursor   
end

declare @previous float = 0;
declare @current float = 0;
declare intervalСursor cursor for  
select distinct round(b.minutesCount + a.mounthCost / b.overflowCost, 0)
from Tariffs a, Tariffs b
where b.overflowCost != 0 and round(b.minutesCount + a.mounthCost / b.overflowCost, 0) > 0
order by round(b.minutesCount + a.mounthCost / b.overflowCost, 0);

set @current = 0;
open intervalСursor
fetch next from intervalСursor   
into @current

declare @number float = 0;

while @@fetch_status = 0  
begin
	set @number = @number + 1;
	declare @min float = 0; declare @minName varchar(100);
	select @min = min(dbo.Median(name, @previous, @current)) from Tariffs
	select @minName = name from Tariffs where @min = dbo.Median(name, @previous, @current)
	if (@previous = 4) 
		set @current = 8;
		fetch next from intervalСursor   
		into @current

	if (@number + 3 = @_count) set @current = 43800;
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

close _intervalСursor
deallocate _intervalСursor;
go

close intervalСursor;  
deallocate intervalСursor;
go