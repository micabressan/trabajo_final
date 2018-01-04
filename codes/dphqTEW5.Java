public void process(Data row) {

    Value value1 = row.getValue1();
    Value value2 = row.getValue2();
    boolean saved = false;

    if (   (value1 != null) 
        && (relevantValues.contains(value1))
	) {
        addRow(value1, row, only1collection);
    }

    if (   (value1 != null) 
	    && (relevantValues.contains(value1)) 
		&& (relevantValues.contains(value2))
	) {
        addRow(value2, row, values12collection); 
    }	
	
    if (relevantValues.contains(value2)) {
        addRow(value2, row, only2collection); 
    }
	
    if (   (value1 != null) 
	    && (relevantValues.contains(value1))
	) {
		repository.save(row);
		stats.increment();
		saved = true;
    }	
	
    if (relevantValues.contains(value2)) {
        if (!saved) {
            repository.save(row);
            stats.increment();
        }
    }
}