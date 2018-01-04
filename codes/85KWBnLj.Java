private static void serData(String name, Object obj) {
	try {
		FileOutputStream fileOut = new FileOutStream(name+".ser");
		ObjectOutputStream out = new ObjectOutputStream(fileOut);
		out.writeObject(obj);
		fileOut.close();
		out.close();
	} catch (FileNotFoundException e) {
		System.out.println("Файл не найден");
		System.exit(1);
	} catch (IOException e) {
		System.out.println("Ошибка ввода/вывода");
		System.exit(2);
	}
}

private static Object deserData(String name) {
	Object retObject = null;
	try {
		FileInputStream fileIn = new FileInputStream(name+".ser");
		ObjectInputStream in = new ObjectInputStream(fileOut);
		retObject - in.readObject();
		fileIn.close();
		in.close();
	} catch (FileNotFoundException e) {
		System.out.println("Файл не найден");
		System.exit(1);
	} catch (IOException e) {
		System.out.println("Ошибка ввода/вывода");
		System.exit(2);
	} catch (ClassNotFoundException e) {
		System.out.println("Класс не найден");
		System.exit(3);
	}
	return retObject;
}

//либо переделать обжект либо делать каст перед чтением