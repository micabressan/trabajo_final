with x as(select distinct x.hasc A, x.area AREAA, x.name ANAAM, y.hasc B,y.name BNAAM, y.area AREAB from grenzen
  join regios x on x.hasc = hasc1 or x.hasc = hasc2
  join regios y on y.hasc = hasc1 or y.hasc = hasc2
  join regios p on p.hasc = x.parent
  join regios g on g.hasc = p.parent
  where x.hasc <> y.hasc and g.parent = 'BE.VL'),

aantal_grenzen as (  
select x.ANAAM, x.AREAB, x.BNAAM, row_number() over(partition by x.ANAAM order by x.ANAAM)nr , count(x.BNAAM) over(partition by x.ANAAM) aantal,
    sum(AREAB) over(partition by ANAAM) area from x)

,z as(select a.ANAAM A, b.ANAAM B, c.ANAAM C, d.ANAAM D, a.AREAA + b.AREAA + c.AREAA + d.AREAA area, row_number() over(partition by a.AREAA + b.AREAA + c.AREAA + d.AREAA order by a.AREAA + b.AREAA + c.AREAA + d.AREAA) it from x a
  join x b on b.A = a.B and b.B <> a.A
  join x c on c.A = b.B and c.B <> b.A and c.B <> a.A
  join x d on d.A = c.B and d.B <> c.A and d.B <> b.A and d.B = a.A
  left join x v on v.A = a.A and v.B = c.A
  left join x w on w.A = b.A and w.B = d.A
  where v.A is null and w.A is null)
  
,vierburen as(
  select distinct ANAAM, 
    max(case when nr = 1 then BNAAM end), 
    max(case when nr = 2 then BNAAM end), 
    max(case when nr = 3 then BNAAM end) , 
    max(case when nr = 4 then BNAAM end),
    max(area)     area
    from aantal_grenzen
  where aantal = 4
  group by ANAAM
  order by 1)
  
select A,B,C,D  from vierburen
  right join z on vierburen.area = z.area
  where vierburen.area is null and it = 1