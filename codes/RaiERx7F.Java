try {
			System.out.println(dateCreatedDoc() + " in process ...");
			for (HashMap <String, String> employee : data) {
				employee.put("date", dateCreatedDoc());
				XWPFDocument doc = new XWPFDocument(OPCPackage.open(filePath));
				for (Map.Entry<String,String> entry : employee.entrySet()) {
					for (XWPFParagraph paragraph : doc.getParagraphs()) {
						List <XWPFRun> runs = paragraph.getRuns();
						if (runs != null) {
							for (XWPFRun text : runs) {
								String str = text.getText(0);
								if (str != null && str.contains("{{{"+ entry.getKey() +"}}}")) {
									str = str.replace("{{{"+ entry.getKey() +"}}}", entry.getValue());
									countChanges++;
									text.setText(str, 0);
								}
							}
						}
					}
				}
				doc.write(new FileOutputStream("./success/"+ fileName +"_"+ employee.get("lastName") +
						employee.get("firstName") +	employee.get("patronymic")+".docx"));
				countDoc++;
			}
			System.out.println("Done!");
			System.out.println("Created documents: " + countDoc + ".");
			System.out.println("Total replacements: " + countChanges + ".");