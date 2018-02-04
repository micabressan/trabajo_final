//IMPLEMENT -- removes a book and returns it, or 
	//	returns null if book is not present
	public Book remove(Book b){
		
		Book removed = null;
		int counter = 0;
		for (BookNode node = head; node != null; node = node.getNext()) {			
			Book book = node.getBook();
			//System.out.println("Book: " + book.toString() + " to " + b.toString());
			
			if (book.equals(b)) {
				removed = book;
				//Now move the BookNode head into the correct index, and remove the book.
				remove(counter);
				return removed;
			}
			counter++;
		}
		return removed;
	}