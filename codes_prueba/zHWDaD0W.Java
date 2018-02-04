WebElement table = driver.findElement(By.id("moviegrid"));
WebElement tBody = table.findElement(By.tagName("tbody"));
List<WebElement> trows = tBody.findElements(By.tagName("tr")); 	//get total no of rows from table(4 rows)
List<WebElement> tcols = tBody.findElements(By.tagName("td"));	//get total no of cols from table(16 cols). each row has 4 cols

for(i=0;i<trows.size();i++){

	for(j=0;j<tcols.size();j++){
		WebElement colsValue = tcols.get(j);
			if(colsValue.getText().equalsIgnoreCase(studName)){
				System.out.println("Printing statement");
				break;
			}
	}
}

when every row executes, all my 16 also get executed. But I want to execute only 4 rows per each row. when if condition is true, then print state should print the line. so in second loop, I gave cols.size(). that why in every row iteration, all cols get executed. So I should avoid it. I need to give col size for single row.