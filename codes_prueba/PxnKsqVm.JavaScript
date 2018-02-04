var cache = {
	stack: {}, //Cache stack
	load: function(id){ //Load cache if found
		return (typeof(this.stack[id]) != 'undefined') ? this.stack[id] : false;
	},
	save: function(data,id){ //Cache data with unique id
		this.stack[id] = data;
	},
	remove: function(id){//Remove cache for identifier
		if(typeof(this.stack[id]) != 'undefined')
			delete this.stack[id];
	}
};

//so when you load the people data, you can store it like
cache.save(stuff[item][2],stuff[item][0])
//so the name is the key, and the id is the value.
// and when you make the list of selected ids
for (var i = 0, row; row = table.rows[i]; i++) {
	selids.push(parseInt(
	cache.load(row.cells[0].innerText))
	)
}