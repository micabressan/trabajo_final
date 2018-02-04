const splitByCommas = s => s.replace(/^,|,$/g, '').split(',');
const fields = line => line.split('"')
	.map((s, i) => (i % 2 === 0 ? splitByCommas(s) : s))
	.filter(x => x[0] !== '');
const parse = line => [].concat(...fields(line));

parse('"a",b,"c,c,c","d",e,"f",g');