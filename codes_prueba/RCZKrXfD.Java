public Landing() {
	
		Categories list = new Categories();
		Products products = new Products();
		
		setSize(1024,768);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		setLayout(new BorderLayout());
		setContentPane(new JLabel(new ImageIcon("/Users/Gio/Downloads/back.png")));
		setLayout(new BorderLayout());
		

	
		add(list, BorderLayout.LINE_START);
		
		setVisible(true);
	}