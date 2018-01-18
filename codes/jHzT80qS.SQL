set nocount on
declare @name varchar(128), @substr nvarchar(4000), @column varchar(128)
set @substr = 'BAED936C-1E44-4E4A-AD32-F3E41CEB7FAC' --фрагмент строки, который будем искать

create table #rslt 
(table_name varchar(128), field_name varchar(128), value uniqueidentifier)

declare s cursor for select table_name as table_name from information_schema.tables where table_type = 'BASE TABLE' order by table_name
open s
fetch next from s into @name
while @@fetch_status = 0
begin
 declare c cursor for 
	select quotename(column_name) as column_name from information_schema.columns 
	  where data_type in ('uniqueidentifier') and table_name  = @name
 set @name = quotename(@name)
 open c
 fetch next from c into @column
 while @@fetch_status = 0
 begin
   print 'Processing table - ' + @name + ', column - ' + @column
   exec('insert into #rslt select ''' + @name + ''' as Table_name, ''' + @column + ''', ' + @column + 
	' from' + @name + ' where ' + @column + ' like ''' + @substr + '''')
   fetch next from c into @column
 end
 close c
 deallocate c
 fetch next from s into @name
end
select table_name as [Table Name], field_name as [Field Name], count(*) as [Found Mathes] from #rslt
group by table_name, field_name
order by table_name, field_name
--Если нужно, можем отобразить все найденные значения
--select * from #rslt order by table_name, field_name
drop table #rslt
close s
deallocate s