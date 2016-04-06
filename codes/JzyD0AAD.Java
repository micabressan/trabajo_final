public Landing() {
	
		Categories list = new Categories();
		Products products = new Products();
		
		setSize(1024,768);
		setLayout(new BorderLayout());
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		JPanel panel = new JPanel();
		
		JLabel holder=new JLabel(new ImageIcon("/Users/Gio/Downloads/back.png"));
		add(holder);
		holder.setLayout(new BorderLayout());
	
		holder.add(list, BorderLayout.LINE_START);
		
		setVisible(true);

	}