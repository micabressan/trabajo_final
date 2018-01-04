public void process(Data row) {

    Value value1 = row.getValue1();
    Value value2 = row.getValue2();  

	Boolian relevant1 = 
	    (  (value1 != null) 
		&& (relevantValues.contains(value1)) 
	);
		
	Boolian relevant2 = (relevantValues.contains(value2));
	
    if (relevant1) {
        addRow(value1, row, only1collection);
    }

    if (relevant1 && relevant2) {
        addRow(value2, row, values12collection); 
    }	
	
    if (relevant2) {
        addRow(value2, row, only2collection); 
    }
	
    if (relevant1 || relevant2) {
        store.update(row);
    }
}