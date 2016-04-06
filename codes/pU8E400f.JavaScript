
db.students.find({}, {'_id':1, 'scores': 1}, {'scores.score': 1}).forEach(function(stud) {
	
	var len = stud.scores.length;
	var removeIdx = -1;
	for (var i = 0; i < len; i++) {
		if (stud.scores[i].type === 'homework') {
			removeIdx = i;
		}
	}
	
	stud.scores.splice(removeIdx, 1)
	
	db.students.update({'_id': stud['_id']}, {$set: {'scores':stud.scores}})
})