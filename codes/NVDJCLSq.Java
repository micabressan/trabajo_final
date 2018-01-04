package lab2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Stack;


public class SintaksniAnalizator {
	
	class Node {

		private String data;
		private ArrayList<Node> children;
		private int childrenCount;

		private boolean isLeaf = false;

		public Node(String data, int childrenCount, boolean isChild) {
			this.data = data;
			this.children = new ArrayList<>();
			this.isLeaf = isChild;
		}

		public ArrayList<Node> getChildren() {
			return children;
		}

		public void addChild(Node child) {
			children.add(child);
		}
		
		@Override
		public String toString() {
			return data;
		}
		
		public String getTokenType() {
			if (isLeaf) {
				return data.split(" ")[0];
			}
			return data;
		}
		
		public boolean hasAllChildren() {
			return (children.size() == childrenCount);
		}
	}
	
	class ParserException extends Exception {
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		String err_str = null;
		
		public ParserException(String err_str) {
			super("err");
			this.err_str = err_str;
		}
	}

	private BufferedReader reader;

	private ArrayList<Node> tokens = new ArrayList<>();
	private HashMap<String, String[]> parseTable = new HashMap<>();
	private HashMap<Integer, String[]> grammar = new HashMap<>();
	private HashMap<String, Integer> tokenID = new HashMap<>();
	private String initNonFinal = "<program>";
	
	private Node root;
	private Node currToken;
	private int currTokenIndex = 0;
	private Stack<String> dataStack = new Stack<>();
	private Stack<Node> nodeStack = new Stack<>();
	private StringBuilder outputTree = new StringBuilder();
	
	public static void main(String[] args) throws IOException {
		SintaksniAnalizator parser = new SintaksniAnalizator();
		try {
			parser.parse();
			parser.generateTree(parser.root, 0);
			System.out.println(parser.outputTree.toString());
		} catch (ParserException pe) {
			System.out.println(pe.err_str);
		}
	}

	public SintaksniAnalizator() throws IOException {
		init();
	}

	public void init() throws IOException {
		reader = new BufferedReader(new InputStreamReader(System.in));
		
		String inputLine;
		while ((inputLine = reader.readLine()) != null) {
			tokens.add(new Node(inputLine, 0, true));
		}
		tokens.add(new Node("-FINISH-", 0, true));
		
		for (String line : parseTable_str.split("\n")) {
			String[] grammar_rule = line.split("=");
			String[] grammar_rule_lhs = grammar_rule[1].split("\\|");
			for (String part : grammar_rule_lhs) {
				part = part.trim();
			}
			parseTable.put(grammar_rule[0].trim(), grammar_rule_lhs);
		}
		
		int i = 0;
		for (String token : tokenTypes) {
			tokenID.put(token, i++);
		}
		
		i = 0;
		String[] production;
		for (String line : grammar_str.split("\n")) {
			production = line.split("::=");
			grammar.put(i++, production[1].trim().split(" "));
		}
		
		currToken = tokens.get(currTokenIndex++);
		dataStack.push(initNonFinal);
	}
	
	public void parse() throws ParserException {
		while (!dataStack.isEmpty()) {
			String action = parseTable.get(dataStack.peek())[tokenID.get(currToken.getTokenType())];

			if (action.equals("-")) {
				if (currToken.toString().equals("-FINISH-")) {
					throw new ParserException("err kraj");
				} else {
					throw new ParserException("err " + currToken.toString());
				}
			} else if (action.equals("ACCEPT")) {
				dataStack.clear();
			} else {
				String[] actionParts = action.split("/");

				if (actionParts[1].equals("P")) {
					if (actionParts[0].contains("Z")) {
						String[] rightSide = grammar.get(Integer.parseInt(actionParts[0].split("-")[1]));
						Node tmpNode = new Node(dataStack.pop(), rightSide.length, false);
						nodeStack.peek().addChild(tmpNode);

						nodeStack.push(tmpNode);

						for (int i = rightSide.length - 1; i > 0; i--) {
							dataStack.push(rightSide[i]);
						}

						tmpNode.addChild(currToken);
						currToken = tokens.get(currTokenIndex++);
					} else if (actionParts[0].contains("I"))  {
						String tmpData;
						Node tmpNode;
						if ((tmpData = dataStack.pop()).charAt(0) == '<') {
							tmpNode = new Node(tmpData, 1, false);
							tmpNode.addChild(currToken);
						} else {
							tmpNode = currToken;
						}

						nodeStack.peek().addChild(tmpNode);
						currToken = tokens.get(currTokenIndex++);

						while (!nodeStack.isEmpty() && nodeStack.peek().hasAllChildren()) {
							nodeStack.pop();
						}
					}
				} else if (actionParts[1].equals("H")) {
					if (actionParts[0].contains("Z")) {
						String[] rightSide = grammar.get(Integer.parseInt(actionParts[0].split("-")[1]));
						Node tmpNode = new Node(dataStack.pop(), rightSide.length, false);
						
						if (!nodeStack.isEmpty()) {
							nodeStack.peek().addChild(tmpNode);
						} else {
							root = tmpNode;
						}
						
						nodeStack.push(tmpNode);

						for (int i = rightSide.length; i > 0; i--) {
							dataStack.push(rightSide[i - 1]);
						}					
					} else if (actionParts[0].contains("I"))  {
						Node tmpNode = null;

						tmpNode = new Node(dataStack.pop(), 1, false);
						tmpNode.addChild(new Node("$", 0, true));
						nodeStack.peek().addChild(tmpNode);

						while (!nodeStack.isEmpty() && nodeStack.peek().hasAllChildren()) {
							nodeStack.pop();
						}
					}
				}
			}
		}
		
		if (currTokenIndex < tokens.size()) {
			throw new ParserException("err " + currToken.toString());
		}
	}
	
	public void generateTree(Node node, int level) {
		if (node == null)
			return;
		if (level > 0) {
			outputTree.append("\n");
			for (int i = 0; i < level; i++) {
				outputTree.append(" ");
			}
		}
		level++;
		outputTree.append(node);
		for (Node child : node.getChildren()) {
			generateTree(child, level);
		}
		return;
	}
	
	static String[] tokenTypes = {"IDN",  "BROJ",  "OP_PRIDRUZI",  "OP_PLUS",  "OP_MINUS",  "OP_PUTA",  "OP_DIJELI",  "L_ZAGRADA",  "D_ZAGRADA",  "KR_ZA",  "KR_OD",  "KR_DO",  "KR_AZ",  "-FINISH-" };
	
	static String parseTable_str = 
	"<program>					= Z-0/H |	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|  Z-0/H  |	   -	|	 -	  |	   -	|	Z-0/H	\n" +
	"<lista_naredbi>			= Z-1/H	|	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|  Z-1/H  |	   -	|	 -	  |	  I/H	|	I/H		\n" +
	"<naredba>					= Z-3/H	|	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|  Z-4/H  |	   -	|    -	  |	   -	|	 -		\n" +
	"<naredba_pridruzivanja>	= Z-5/P	|	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|	 -	  |	   -	|	 -	  |	   -	|	 -		\n" +
	"<za_petlja>				=	-	|	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|  Z-6/P  |	   -	|	 -	  |	   -	|	 -		\n" +
	"<E>						= Z-7/H	| Z-7/H  |		 -		 |	 Z-7/H	 |	 Z-7/H	  |		-	  |		 -		|	 Z-7/H	  |		 -		|	 -	  |	   -	|	 -	  |	   -	|	 -		\n" +
	"<E_lista>					=  I/H	|	 -	 |		 -		 |	 Z-8/P	 |	 Z-9/P	  |		-	  |		 -		|	   -	  |		I/H		|	I/H	  |	   -	|	I/H	  |	  I/H	|	I/H		\n" +
	"<T>						= Z-11/H| Z-11/H |		 -		 |	 Z-11/H	 |	 Z-11/H	  |		-	  |		 -		|	 Z-11/H	  |		 -		|	 -	  |	   -	|	 -	  |	   -	|	 -		\n" +
	"<T_lista>					=  I/H 	|	 -	 |		 -		 |	  I/H	 |	   I/H	  |	 Z-12/P   |	  Z-13/P	|	   -	  |		I/H		|	I/H	  |	   -	|	I/H	  |	  I/H	|	I/H		\n" +
	"<P>						=  I/P	|	I/P	 |		 -		 |	 Z-15/P	 |	 Z-16/P	  |		-	  |		 -		|	 Z-17/P	  |		 -		|	 -	  |	   -	|	 -	  |	   -	|	 -		\n" +
	"IDN						=  I/P	|	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|	 -	  |	   -	|	 -	  |	   -	|	 -		\n" +
	"OP_PRIDRUZI				=	-	|	 -	 |		I/P		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|	 -	  |	   -	|	 - 	  |	   -	|	 -		\n" +
	"D_ZAGRADA					=	-	|	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		I/P		|	 -	  |	   -	|	 - 	  |	   -	|	 -		\n" +
	"KR_OD 						=	-	|	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|	 -	  |	  I/P	|	 -	  |	   -	|	 -		\n" +
	"KR_DO 						=	-	|	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|	 -	  |	   -	|	I/P	  |	   -	|	 -		\n" +
	"KR_AZ 						=	-	|	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|	 -	  |	   -	|	 -	  |	  I/P	|	 -		\n" +
	"-BOTTOM-					=	-	|	 -	 |		 -		 |	   -	 |		-	  |		-	  |		 -		|	   -	  |		 -		|	 -	  |	   -	|	 -	  |	   -	|	ACCEPT	";
	
	static String grammar_str = 
	"<program> ::= <lista_naredbi>\n" +
	"<lista_naredbi> ::= <naredba> <lista_naredbi>\n" +
	"<lista_naredbi> ::= $\n" +
	"<naredba> ::= <naredba_pridruzivanja>\n" +
	"<naredba> ::= <za_petlja>\n" +
	"<naredba_pridruzivanja> ::= IDN OP_PRIDRUZI <E>\n" +
	"<za_petlja> ::= KR_ZA IDN KR_OD <E> KR_DO <E> <lista_naredbi> KR_AZ\n" +
	"<E> ::= <T> <E_lista>\n" +
	"<E_lista> ::= OP_PLUS <E>\n" +
	"<E_lista> ::= OP_MINUS <E>\n" +
	"<E_lista> ::= $\n" +
	"<T> ::= <P> <T_lista>\n" +
	"<T_lista> ::= OP_PUTA <T>\n" +
	"<T_lista> ::= OP_DIJELI <T>\n" +
	"<T_lista> ::= $\n" +
	"<P> ::= OP_PLUS <P>\n" +
	"<P> ::= OP_MINUS <P>\n" +
	"<P> ::= L_ZAGRADA <E> D_ZAGRADA\n" +
	"<P> ::= IDN\n" +
	"<P> ::= BROJ";
}