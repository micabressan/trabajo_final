-- QUESTION 1
-- Select the group name and annual revenue for all theatre groups
-- whose revenue is less than £15000 per year, displayed in descending
-- order of the revenue
select GroupName, AnnualRevenue
from TheatreGroup
where AnnualRevenue < 15000
order by AnnualRevenue desc

-- QUESTION 2
-- Show the total revenue figure for the whole theatre company for one month,
-- displayed with no decimal places. Give the calculated column a suitable
-- column name
-- Note - The theatre company contains all groups in the database
select CONVERT(int,SUM(AnnualRevenue/12)) as TotalCompanyMonthlyRevenue
from TheatreGroup
 
-- QUESTION 3
-- List the group ID and name of all theatre groups started on or after
-- 24th July 2009 sorted in ascending order of group name. 
select GroupID, GroupName
from TheatreGroup
where DateStarted >= '24-July-2009'
order by GroupName

-- QUESTION 4
-- Add 'Ballet Dance' as a new skill to the database
insert into Skill values (8,'Ballet Dance')

-- QUESTION 5
-- Calculate the average monthly revenue. Round the result to 2 decimal places
-- and name the column "AverageMonthlyRevenue".
select ROUND(AVG(tg.AnnualRevenue)/12,2) as AverageMonthlyRevenue
from TheatreGroup tg
 
-- QUESTION 6
-- Calculate the average annual revenue, displaying the result with no decimal
-- places.  Name the column "AverageAnnualRevenue".
select CONVERT(int,AVG(tg.AnnualRevenue)) as AverageAnnualRevenue
from TheatreGroup tg

-- QUESTION 7
-- For all theatre groups that have an associated local theatre, display both
-- the name of the theatre group and the name of the theatre
select GroupName, TheatreName
from TheatreGroup
where TheatreName is not null

-- QUESTION 8
-- Display the name of all theatre groups 
select tg.GroupName
from TheatreGroup tg

-- QUESTION 9
-- Select a distinct list of the names of any theatre groups that have
-- performed either Wicked or Chicago
select distinct tg.GroupName
from TheatreGroup tg
join Performance p on tg.GroupID = p.GroupID
where p.ShowName in ('Chicago','Wicked')
 
-- QUESTION 10
-- The latest revenue figures have just come in and all of them have increased.
-- Annual revenue for groups 300 and 500 have increased by 5%, while the annual
-- revenue for group 700 has increased by 10%. 
-- Produce a list of theatre group names, the percentage by which their revenue
-- has increased, and both the old and new revenue figures.
select
  tg.GroupName,
  case
  when GroupID IN(300,500) then 5
  when GroupID IN(700) then 10
  else 0
  end as '% Increase',
  AnnualRevenue as 'Old Revenue',
  case
  when GroupID IN(300,500) then AnnualRevenue * 1.05
  when GroupID IN(700) then AnnualRevenue * 1.1
  else AnnualRevenue
  end as 'New Revenue'  
from TheatreGroup tg  

-- QUESTION 11
-- Create an index called Dir_IDX on the Director in the TheatreGroup table.
create index Dir_IDX on TheatreGroup(Director) 

-- QUESTION 12
-- Display the group name and monthly revenue of theatre
-- groups 300 and 700.  Name the monthly revenue fee column
-- as 'MonthlyRevenue' and round values in this column to 2 decimal places.
select GroupName, ROUND(AnnualRevenue/12,2) as MonthlyRevenue
from TheatreGroup
where GroupID in (300,700)
 
-- QUESTION 13
-- Select the region name, group name and director surname for all theatre
-- groups started in 2007, 2008 or 2009. Order the results by group name 
-- within region name
select r.RegionName, tg.GroupName, p.Surname, tg.DateStarted
from TheatreGroup tg
join Performer p on tg.Director=p.MembershipID
join Region r on r.RegionID=tg.RegionID
where tg.DateStarted>='1-Jan-2007'
and tg.DateStarted<'1-Jan-2010'
order by r.RegionName, tg.GroupName

--question 13 second solution
select r.RegionName, tg.GroupName, p.Surname
from TheatreGroup tg
join Performer p on tg.Director=p.MembershipID
join Region r on r.RegionID=tg.RegionID
where datepart(year, tg.DateStarted)>= '2007'
and datepart(year, tg.DateStarted) < '2010' 
order by r.RegionName, tg.GroupName

-- QUESTION 14
-- List the group ID and name, and the total number of members for each group
-- that has more than 5 members
select tg.GroupID, tg.GroupName, COUNT(p.MembershipID)
from TheatreGroup tg
join Performer p on tg.GroupID = p.GroupID
group by tg.GroupID, tg.GroupName
having COUNT(p.MembershipID) > 5

-- QUESTION 15
-- List the group ID and name, and the number of members for the group
-- that has the highest number of performers.
select tg.GroupID, tg.GroupName, COUNT(MembershipID)
from TheatreGroup tg
join Performer p on tg.GroupID = p.GroupID
group by tg.GroupID, tg.GroupName
having COUNT(MembershipID)=
  (
    select MAX(MemCount)
    from
    (
      select COUNT(MembershipID) as MemCount
      from TheatreGroup tg
      join Performer p on p.GroupID=tg.GroupID
      group by tg.GroupID, tg.GroupName
    ) as MemCount
  )


-- question 15 second solution
select top 1 tg.GroupID, tg.GroupName, COUNT(MembershipID)
from TheatreGroup tg
join Performer p on tg.GroupID = p.GroupID
group by tg.GroupID, tg.GroupName
-----------------------------------------------------------------
-- testing no 15
select * from Performer
select count(*) from performer where GroupID = 200
-----------------------------------------------------------------

-- QUESTION 16
-- List the theatre group ID and name for all groups that have no members
-- with the stage combat skill
select tg.GroupID, tg.GroupName
from TheatreGroup tg
where not exists
  (
    select 1
    from Performer p
    join PerformerSkill ps on p.MembershipID=ps.MembershipID
    join Skill s on ps.SkillID=s.SkillID
    where s.SkillName='Stage Combat'
    and tg.GroupID=p.GroupID
  )

-- QUESTION 17
-- Display each skill name along with the count of the performers that have
-- that skill.  Ensure that skills that noone can perform are included in the
-- list with a count of zero.  
select s.SkillName, COUNT(ps.MembershipID) as PerformerCount
from Skill s
left outer join PerformerSkill ps on ps.SkillID = s.SkillID
group by s.SkillName

-- QUESTION 18
-- Increase the revenue figure for all theatre groups by 2000
update TheatreGroup set AnnualRevenue=AnnualRevenue+2000

-- QUESTION 19
-- List the data for all groups sorted in descending order of group ID
select tg.*
from TheatreGroup tg
order by tg.GroupID desc

-- QUESION 20
-- The data for skill with ID of 8 is no longer needed.  Delete this record
-- from the database
delete from Skill where SkillID=8

-- QUESION 21
-- List all the data for skills in ascending order of skill ID
select * from Skill order by SkillID

-- QUESTION 22
-- Show the total number of performers
select COUNT(MembershipID)
from Performer

-- QUESTION 23
-- Create a new view that contains the membership id and name of all performers
-- who are directors of a theatre group
create view Director
as
select MembershipID, Surname, FirstName
from Performer p
join TheatreGroup tg on p.MembershipID=tg.Director

-- QUESTION 24
-- Show all data from the director view sorted by decreasing order of
-- membership id
select * from Director order by MembershipID desc

-- QUESTION 25
-- Grant access to all users to select, insert and update data through
-- the Director view.
grant select, insert, update on Director to public

-- QUESTION 26
-- Display each theatre group name along with the month and year it was 
-- started.  Format the date so it is displayed in "dd mmm yyyy" format.
-- Order the results in descending order of start date.  Give the date
-- column an appropriate name.
select tg.GroupName, CONVERT(varchar,tg.DateStarted,106) as 'Date Started'
from TheatreGroup tg
order by tg.DateStarted desc

-- QUESTION 27
-- Display each theatre group name along with the name of its associated local
-- theatre.  Where there is no local theatre association, display the text "No
-- local theatre".
select tg.GroupName, coalesce(tg.TheatreName,'No local theatre') as Theatre
from TheatreGroup tg

-- QUESTION 28
-- Choose a theatre group to join and add yourself to the database as a
-- performer.  Select 3 skills that you can perform and insert data to the
-- database to reflect this.  Now write the SQL to retrieve the name of all
-- skills that the perfomer with your name can perform.
insert into Performer values (99,'Rhona','MacDonald',164,300)

insert into PerformerSkill values (99,2)
insert into PerformerSkill values (99,4)
insert into PerformerSkill values (99,7)

select s.SkillName
from Skill s
join PerformerSkill ps on ps.SkillID = s.SkillID
join Performer p on p.MembershipID = ps.MembershipID
where p.FirstName = 'Rhona'
and p.Surname = 'MacDonald'

-- QUESTION 29 
-- Update the database to show that Anna Craig has moved from the Music & Dance
-- group to the Showtime Performers group.
update Performer
set GroupID = 600 
where FirstName = 'Anna'
and Surname = 'Craig'

-- QUESTION 30
-- List the names of of all theatre groups in the London region.
select tg.GroupName
from TheatreGroup tg
join Region r on tg.RegionID = r.RegionID
where r.RegionName = 'London'