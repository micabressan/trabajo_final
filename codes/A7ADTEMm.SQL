; first query will find the ids of the meetings (t.mote) we're interested in
select m.id from moter m, perioder p where m.dato >= p.start and m.dato <= p.slutt and p.id = 1

; second query will get the sums we're looking for
select p.parti, sum(t.stop - t.start) as sum from tags t, representanter r, periode_representant pr, partier p where r.id = t.representant and t.representant = pr.representant and pr.parti = p.id and pr.periode = 1 and t.mote in (above query) group by p.parti order by sum desc;