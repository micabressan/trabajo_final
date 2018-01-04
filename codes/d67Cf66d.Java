public boolean remove(Object item) {// Ejercicio 5
		root = remove(root, (E) item);
		return removeReturn;
	}

	private BinaryNode remove(BinaryNode r, E item) {
		if (r == null)
			removeReturn = false;
		else if (item.compareTo(r.data) < 0)
			r.left = remove(r.left, item);
		else if (item.compareTo(r.data) > 0)
			r.right = remove(r.right, item);
		else {
			size--;
			if (r.left != null && r.right != null) {
				E min = first(r.right);
				r.data = min;
				r.right = removeFirst(r.right);
			} else if (r.left != null)
				r = r.left;
			else
				r = r.right;
			removeReturn = true;
		}
		return r;
	}

	private BinaryNode removeFirst(BinaryNode r) {
		if (r != null) {
			if (r.left != null) {
				BinaryNode first = null;
				BinaryNode father = r;
				BinaryNode aux = r.left;
				while (aux.left != null) {
					father = aux;
					aux = aux.left;
				}
				father.left = aux.right;
			} else
				r = r.right;
		}
		return r;
	}