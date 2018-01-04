Update pa
Set pa.name = 'hej'
From Players pa
JOIN Team ta on pa.ext_team = ta.id
WHERE ta.name = 'Dignitas'