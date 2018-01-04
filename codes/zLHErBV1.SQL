select * from 
	mytable rep1
	join mytable rep2
		on	rep1.id = rep2.id
		and rep2.time = (select min(t.time) from mytable t
						where t.id = rep2.id and 
							  t.repository = rep2.repository and
							  t.time - 1/24 < rep1.time and
							  t.time > rep1.time)		
	join mytable rep3
		and rep1.id = rep3.id
		and rep3.time = (select min(t.time) from mytable t
						where t.id = rep3.id and 
							  t.repository = rep3.repository and
							  t.time - 1/24 < rep1.time and
							  t.time > rep2.time)  
	where	rep1.repository = 'A' and
			rep2.repository = 'B' and
			rep3.repository = 'C';