public class BinaryTree
{

   public BinaryTree(Datum d)
   {
	  root = new BinaryNode(d);
   }
   public BinaryNode getRoot()
   {
	   return root;
   }
   public void print()
   {
	  print(this.root);
   }
   public void print(BinaryNode parent)
   {
	  if (parent.getLeft() != null)
	  {
		 print(parent.getLeft());
	  }
	  System.out.print("node: ");
	  System.out.print(parent.getId());
	  System.out.print(", datum: ");
	  parent.getDatum().print();
	  System.out.print("\n");
	  if (parent.getRight() != null)
	  {
		 print(parent.getRight());
	  }
   }
   public static void addElement(BinaryNode parent, Datum d)
   {
	  if (d.getVal() < parent.getDatum().getVal())
	  {
		 if (parent.getLeft() == null)
		 {
			parent.setLeft(new BinaryNode(d));
		 }
		 else
		 {
			addElement(parent.getLeft(), d);
		 }
	  }
	  else if (d.getVal() > parent.getDatum().getVal())
	  {
		 if (parent.getRight() == null)
		 {
			parent.setRight(new BinaryNode(d));
		 }
		 else
		 {
			addElement(parent.getRight(), d);
		 }
	  }
	  else if (d.getVal() == parent.getDatum().getVal())
	  {
		 return parent.getId();
	  }
   }

	private BinaryNode root;
}