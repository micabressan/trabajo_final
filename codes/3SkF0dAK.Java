import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class Parser
{
    static List<String> tokens = new ArrayList<>();
    static List<String> stack = new ArrayList<>();
    static int index = 0;
    static int level = 0;


    public static void main(String[] args) throws IOException
    {
        readTokens();
        start();
        print();
    }
    public static void readTokens() throws IOException
    {
        FileReader inputStream;
        inputStream = new FileReader("C:/Users/Arnas/Desktop/Parser/src/output.txt");
        StringBuilder buffer = new StringBuilder("");
        try
        {
            int c;
            char chr;

            while ((c = inputStream.read()) != -1) {
                chr = (char) c;
                if(chr == '$')
                {
                    while(!Character.isWhitespace(chr))
                    {
                        buffer.append(chr);
                        c = inputStream.read();
                        chr = (char) c;
                    }
                    if(buffer.toString().equals("$INT") || buffer.toString().equals("$ID") ||  buffer.toString().equals("$FLOAT"))
                    {
                        do
                        {
                            buffer.append(chr);
                            c = inputStream.read();
                            chr = (char) c;
                        } while(!Character.isWhitespace(chr));
                        if(buffer.toString().equals("$FLOAT float"))
                        {
                            buffer.delete(0, buffer.length());
                            buffer.append("$FLOAT");
                        }
                        else if(buffer.toString().equals("$INT int"))
                        {
                            buffer.delete(0, buffer.length());
                            buffer.append("$INT");
                        }
                    }
                    else if(buffer.toString().equals("$DBLQUOTE"))
                    {
                        do
                        {
                            buffer.append(chr);
                            c = inputStream.read();
                            chr = (char) c;
                        } while(chr != '\n' && chr != '\t' && chr != '\r');
                    }
                    tokens.add(buffer.toString());
                    buffer.delete(0, buffer.length());
                }
            }
        }
        finally
        {
            if(inputStream != null)
            {
                inputStream.close();
            }
        }
    }

    /* Program structure */
    public static void start()
    {
        stack.add(level + " <program>");
        level++;
        if(tokens.get(index).equals("$START"))
        {
            index++;
            stack.add(level + " start");
            level++;
            if(mainBlock()) {
                if (tokens.get(index).equals("$END"))
                {
                    stack.add(level + " end");
                }
                else parserError("end");
            }
        }
        else
        {
            parserError("keyword start");
        }
    }
    public static boolean voidMain()
    {
        if(tokens.get(index).equals("$VOID"))
        {
            index++;
            stack.add(level + " void");
            if(tokens.get(index).equals("$MAIN"))
            {
                index++;
                stack.add(level + " main");
                if(tokens.get(index).equals("$LBRACKET1"))
                {
                    index++;
                    stack.add(level + " (");
                    if(tokens.get(index).equals("$RBRACKET1"))
                    {
                        index++;
                        stack.add(level + " )");
                        level++;
                        if(block())
                            functions();
                        return true;
                    }
                    else
                        parserError(")");
                }
                else
                    parserError("(");
            }
            else
                parserError("main");
        }
        return false;
    }
    public static boolean mainBlock()
    {
        stack.add(level + " <mainBlock>");
        if(voidMain()){}
        else
        {
            level++;
            globals();
            level--;
            voidMain();
            return true;
        }
        level--;
        return false;
    }
    public static boolean block()
    {
        if(tokens.get(index).equals("$LBRACKET2"))
        {
            index++;
            stack.add(level + " '{'");
            level++;
            if (statements())
            {}
            else if (tokens.get(index).equals("$RBRACKET2"))
            {
                index++;
                stack.add(level + " '}'");
                return true;
            }

            parserError("}");
            return false;
        }

        parserError("{");
        return false;
    }


    /* Functions */
    public static boolean functions()
    {
        if (function())
        {
            if(functions())
                return true;
        }
        return false;
    }
    public static boolean function()
    {
        if (returnType())
        {
            if (functionName())
            {
                if (tokens.get(index).equals("$LBRACKET1"))
                {
                    index++;
                    stack.add(level + " '('");
                    if (tokens.get(index).equals("$RBRACKET1"))
                    {
                        index++;
                        stack.add(level + " ')'");
                        if (block())
                            return true;
                        else
                            parserError("block");
                    }
                    else if (parameters()) {
                        if (tokens.get(index).equals("$RBRACKET1"))
                        {
                            index++;
                            stack.add(level + " )");
                            if (block())
                                return true;
                            else
                                parserError("block");
                        }
                        level--;
                    }
                    level--;
                }
                level--;
            }
            level--;
        }
        level--;
        return false;
    }
    public static boolean parameters()
    {
        if (parameter())
        {
            if (tokens.get(index).equals("$COMMA"))
            {
                index++;
                stack.add(level + " ','");
                parameters();
            }
            return true;
        }
        return false;
    }

    public static boolean parameter()
    {
        if(type())
        {
            if(variable()){
                level--;
                return true;
            }

        }
        else
            level--;
        return false;
    }
    public static boolean functionName()
    {
        if(tokens.get(index).substring(0, 3).equals("$ID"))
        {
            stack.add(level + " <functionName>");
            letters();
            stack.add(level + " " + tokens.get(index).substring(4));
            index++;
            return true;
        }
        else{
            level--;
            return false;
        }
    }

    /* Control statements */
    public static boolean controlStmt()
    {
        if( loop_for())
            return true;
        if( loop_while())
            return true;
        if( statement_if())
            return true;
        return false;
    }
    public static boolean loop_while()
    {
        if (tokens.get(index).equals("$WHILE")) {
            index++;
            stack.add(level + " while");
            if (tokens.get(index).equals("$LBRACKET1")) {
                index++;
                stack.add(level + " '('");
                if (expression()) {
                    if (tokens.get(index).equals("$RBRACKET1")) {
                        index++;
                        stack.add(level + " ')'");
                        if (block()) return true;
                    }
                }
            }
        }
        return false;
    }
    public static boolean loop_for()
    {
        stack.add(level + " <loop_for>");
        level++;
        if(tokens.get(index).equals("$FOR"))
        {
            index++;
            if(tokens.get(index).equals("$LBRACKET1"))
            {
                index++;
                if(expression())
                {
                    if(tokens.get(index).equals("$SEMICOLON"))
                    {
                        index++;
                        if(expression())
                        {
                            if(tokens.get(index).equals("$SEMICOLON"))
                            {
                                index++;
                                if(expression())
                                {
                                    if(tokens.get(index).equals("$RBRACKET1"))
                                    {
                                        if(block())
                                            return true;
                                    }
                                    parserError(")");
                                }
                                parserError("expression");
                            }
                            parserError(";");
                        }
                        parserError("expression");
                    }
                    parserError(";");
                }
                parserError("expression");
            }
            parserError("for");
        }
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean statement_if()
    {
        stack.add(level + " <statement_if>");
        if(tokens.get(index).equals("$IF"))
        {
            stack.add(level + " if");
            index++;
            if(tokens.get(index).equals("$LBRACKET1"))
            {
                stack.add(level + " (");
                index++;
                if(expression())
                {
                    if(tokens.get(index).equals("$RBRACKET1"))
                    {
                        stack.add(level + " )");
                        index++;
                        if(block())
                        {
                            if(tokens.get(index).equals("$ELSE"))
                            {
                                stack.add(level + " else");
                                index++;
                                if(block())
                                    return true;
                                else if(statement_if())
                                    return true;
                                else parserError("block or statement if");
                            }
                            else return true;
                        }
                        parserError("block");
                    }
                    parserError(")");
                }
                parserError("expression");
            }
            parserError("(");
        }
        stack.remove(stack.size() - 1);
        return false;
    }

    /* Data types and operators */
    public static boolean type()
    {
        stack.add(level + " <type>");
        if(tokens.get(index).equals("$INT"))
        {
            index++;
            stack.add(level + " int");
            return true;
        }
        if(tokens.get(index).equals("$FLOAT"))
        {
            index++;
            stack.add(level + " float");
            return true;
        }
        if(tokens.get(index).equals("$STRING"))
        {
            index++;
            stack.add(level + " string");
            return true;
        }
        if(tokens.get(index).equals("$BOOLEAN"))
        {
            index++;
            stack.add(level + " bool");
            return true;
        }
        level--;
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean variable()
    {
        if(tokens.get(index).substring(0, 3).equals("$ID"))
        {
            stack.add(level + " <variable>");
            letters();
            level++;
            stack.add(level + " " + tokens.get(index).substring(4));
            index++;
            level = level - 2;
            return true;
        }
        else{
            level--;
            return false;
        }

    }
    public static void letters()
    {
        level++;
        stack.add(level + " <letters>");
    }
    public static void digits()
    {
        stack.add(level + " <digits>");
        level++;
    }

    /* Expressions */
    public static boolean expression()
    {
        stack.add(level + " <expression>");
        level++;
        if(and_expression())
        {
            if(or())
            {
                if(expression())
                {
                    stack.add(level + " <expression>");
                    return true;
                }
                else
                    level--;
            }
            else{
                level--;
                return true;
            }

        }
        level--;
        //   parserError("expression");
        return false;
    }
    public static boolean and_expression()
    {
        if(comp_expression())
        {
            if(and())
            {
                if(and_expression())
                {
                    stack.add(level + " <and_expression>");
                    return true;
                }
            }
            else
                return true;
        }
        //   parserError("and expression");
        return false;
    }
    public static boolean comp_expression()
    {
        if(add_expression())
        {
            if(comparision())
            {
                if(comp_expression())
                {
                    stack.add(level + " <comp_expression>");
                    return true;
                }
            }
            else
                return true;
        }
        //  parserError("comp expression");
        return false;
    }
    public static boolean add_expression()
    {
        if(term())
        {
            if(addition())
            {
                if(add_expression())
                {
                    stack.add(level + " <add_expression>");
                    return true;
                }
            }
            else
                return true;
        }
        // parserError("add expression");
        return false;
    }
    public static boolean term()
    {
        if(factor())
        {
            if(multiplication())
            {
                if(term())
                {
                    stack.add(level + " <term>");
                    return true;
                }
            }
            else
                return true;
        }
        // parserError("term");
        return false;
    }
    public static boolean factor()
    {
        stack.add(level + " <factor>");
        level++;
        if(tokens.get(index).equals("$LBRACKET1"))
        {
            index++;
            if(expression())
            {
                if(tokens.get(index).equals("$RBRACKET1"));
                index++;
            }
            else
                parserError("expression");
        }
        int tmp = level;
        if(functionCall())
            return true;
        else
        {
            level = tmp;
            if(variable())
                return true;
            else
            {
                level = tmp;
                if(constant())
                    return true;
                else
                {
                    level = tmp;
                    if(booleanE())
                        return true;
                }
            }
        }
        // parserError("factor");
        stack.remove(stack.size() - 1);
        return false;
    }

    /* Data types and operators */
    public static boolean returnType()
    {
        stack.add(level + " <returnType>");
        level++;
        if( type() )
            return true;
        if( tokens.get(index).equals("$VOID") )
        {
            index++;
            stack.add(level + " void");
        }
        return false;
    }
    public static boolean constant()
    {
        stack.add(level + " <constant>");
        level++;
        if(string())
            return true;
        else if(number())
            return true;
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean number()
    {
        stack.add(level + " <number>");
        if(integer())
        {
            return true;
        }
        else if(floate())
        {
            return true;
        }
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean minus()
    {
     /*   if(tokens.get(index).length() < 7)
            return false;
        if(tokens.get(index).charAt(7) == '-')
        {
            stack.add(level + " <negativeSign>");
            return true;
        }
        else */return false;
    }
    public static boolean negativeSign()
    {
        if(tokens.get(index).equals("$NEGATIVESIGN"))
        {
            index++;
            stack.add(level + " -");
            return true;
        }
        return false;
    }
    public static boolean plus()
    {
        if(tokens.get(index).equals("$PLUS"))
        {
            index++;
            stack.add(level + " +");
            return true;
        }
        return false;
    }
    public static boolean floate()
    {
        if(tokens.get(index).length() < 6)
            return false;
        if(tokens.get(index).substring(0, 6).equals("$FLOAT"))
        {
            level++;
            stack.add(level + " <float>");
            level++;

            String token = tokens.get(index);
            String[] parts = token.split("\\.");
            String part1 = parts[0];
            String part2 = parts[1];
            if(minus())
            {
                stack.add(level + " <int>");
                stack.add(level + " " + part1.substring(8));
            }
            else
            {
                stack.add(level + " <int>");
                stack.add(level + " " + part1.substring(7));
            }
            stack.add(level + " .");
            digits();
            level--;
            stack.add(level + " " + part2);

            level = level - 2;
            index++;
            return true;
        }
        else
            return false;


    }
    public static boolean integer()
    {
        if(tokens.get(index).substring(0, 4).equals("$INT"))
        {
            level++;
            if(minus())
            {
                stack.add(level + " <int>");
                level++;
                digits();
                stack.add(level + " " + tokens.get(index).substring(6));
            }
            else

            {
                stack.add(level + " <int>");
                level++;
                digits();
                stack.add(level + " " + tokens.get(index).substring(5));
            }
            index++;
            return true;
        }
        else
            return false;
    }
    public static boolean string()
    {
        if(tokens.get(index).substring(0, 3).equals("$DB"))
        {
            stack.add(level + " <string>");
            stack.add(level + " \"");
            symbols();
            stack.add(level + " " + tokens.get(index).substring(11, tokens.get(index).length()-1));
            level--;
            stack.add(level + " \"");
            index++;
            return true;
        }
        return false;
    }
    public static boolean symbols()
    {
        level++;
        stack.add(level + " <symbols>");
        return true;
    }
    public static boolean not()
    {
        stack.add(level + " <not>");
        if(tokens.get(index).equals("$NOT"))
        {
            index++;
            stack.add(level + " !");
            return true;
        }
        return false;
    }
    public static boolean and()
    {
        stack.add(level + " <and>");
        if(tokens.get(index).equals("$AND"))
        {
            index++;
            stack.add(level + " &&");
            return true;
        }
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean or()
    {
        stack.add(level + " <or>");
        if(tokens.get(index).equals("$OR"))
        {
            index++;
            stack.add(level + " ||");
            return true;
        }
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean comparision()
    {
        stack.add(level + " <comparison>");
        if (tokens.get(index).equals("$BELOW")) {
            index++;
            stack.add(level + " <");
            return true;
        } else if (tokens.get(index).equals("$BELOWEQUAL")) {
            index++;
            stack.add(level + " <=");
            return true;
        } else if (tokens.get(index).equals("$ABOVE")) {
            index++;
            stack.add(level + " >");
            return true;
        } else if (tokens.get(index).equals("$ABOVEEQUAL")) {
            index++;
            stack.add(level + " >=");
            return true;
        } else if (tokens.get(index).equals("$NOTEQUAL")) {
            index++;
            stack.add(level + " !=");
            return true;
        } else if (tokens.get(index).equals("$EQUAL")) {
            index++;
            stack.add(level + " ==");
            return true;
        } else if (tokens.get(index).equals("$NOTEQUAL")) {
            index++;
            stack.add(level + " !=");
            return true;
        }
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean addition()
    {
        stack.add(level + " <addition>");
        if (plus())
            return true;
        else if(negativeSign())
            return true;
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean assigment()
    {
        stack.add(level + " <assignment>");
        if (tokens.get(index).equals("$ASSIGNMENT")) {
            stack.add(level + " =");
            return true;
        } else if (tokens.get(index).equals("$SUBASSIGNMENT")) {
            stack.add(level + " -=");
            return true;
        } else if (tokens.get(index).equals("$ADDASSIGNMENT")) {
            stack.add(level + " +=");
            return true;
        } else if (tokens.get(index).equals("$MULTASSIGNMENT")) {
            stack.add(level + " *=");
            return true;
        }
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean booleanE()
    {
        if(tokens.get(index).equals("$TRUE"))
        {
            stack.add(level + " <boolean>");
            index++;
            stack.add(level + " true" );
            return true;
        }
        else if(tokens.get(index).equals("$FALSE"))
        {
            stack.add(level + " <boolean>");
            index++;
            stack.add(level + " false" );
            return true;
        }
        return false;
    }
    public static boolean multiplication()
    {
        stack.add(level + " <multiplication>");
        if(tokens.get(index).equals("$MULT"))
        {
            index++;
            stack.add(level + " *" );
            return true;
        }
        else if(tokens.get(index).equals("$DIV"))
        {
            index++;
            stack.add(level + " /" );
            return true;
        }
        stack.remove(stack.size() - 1);
        return false;
    }

    /* Statements */
    public static boolean statements()
    {
        stack.add(level + " <statements>");
        level++;
        if( statement())
        {
            if( statements())
                return true;
        }
        else
            stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean statement()
    {
        stack.add(level + " <statement>");
        level++;
        if( simpleStmt() )
            return true;
        if( statement_return() ) {
            if (tokens.get(index).equals("$SEMICOLON")) {
                index++;
                stack.add(level + " ;");
                return true;
            }
        }
        if( functionCall() )
        {
            if(tokens.get(index).equals("$SEMICOLON"))
            {
                index++;
                stack.add(level + " ;");
                return true;
            }
        }
        if( controlStmt())
            return true;

        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean statement_return()
    {

        if(tokens.get(index).equals("$RETURN"))
        {
            index++;
            stack.add(level + " return");

            if( expression() ) {

                return true;
            }
            // Reikia su return 0 kažką padaryt
        }
        return false;

    }
    public static boolean functionCall()
    {
        stack.add(level + " <functionCall>");
        if( functionName() )
        {
            if(tokens.get(index).equals("$LBRACKET1"))
            {
                index++;
                stack.add(level + " (");
                if (tokens.get(index).equals("$RBRACKET1"))
                {
                    index++;
                    stack.add(level + " ')'");
                    return true;
                }
                else if (callParameters())
                {
                    if (tokens.get(index).equals("$RBRACKET1")) {
                        index++;
                        stack.add(level + " ')'");
                        return true;
                    }
                }
            }
            index = index - 1;
        }
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean callParameters()
    {
        stack.add(level + " <callParameters>");
        if( expression() )
        {
            if(tokens.get(index).equals("$COMMA")  )
            {
                index++;
                stack.add(level + " ','");

                if( callParameters())
                    return true;
            }
            else
                return true;
        }
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean simpleStmt()
    {
        stack.add(level + " <simpleStmt>");
        level++;
        if( statement_varDeclaration() )
            return true;
        if( statement_assignment( ))
            return true;
        if( io() )
            return true;
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean statement_varDeclaration()
    {
        stack.add(level + " <statement_varDeclaration>");
        level++;
        index = index + 2;
        assigment();
        index = index - 2;
        if (type())
        {
            if (variable())
            {
                if (tokens.get(index).equals("$SEMICOLON"))
                {
                    index++;
                    stack.add(level + " ;");
                    return true;
                }
                else if (tokens.get(index).equals("$ASSIGNMENT"))
                {
                    index++;
                    if (expression())
                    {
                        if (tokens.get(index).equals("$SEMICOLON"))
                        {
                            index++;
                            stack.add(level + " ;");
                            return true;
                        }
                        else
                            level--;
                    }
                    else
                        level--;
                    level--;
                }
                else
                    level--;
            }
            else
                level--;
        }
        level--;
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean globals()
    {
        stack.add(level + " <globals>");
        level++;
        if( global() )
        {
            if (globals()){
                level--;
                return true;
            }
            level--;
        }
        else
            level--;
        stack.remove(stack.size() - 1);
        return false;
    }
    public static boolean global()
    {
        stack.add(level + " <global>");
        level++;
        if(statement_varDeclaration())
            return true;
        stack.remove(stack.size() - 1);

        return false;
    }
    public static boolean statement_assignment()
    {
        index++;
        assigment();
        index--;
        if(variable())
        {
            if (tokens.get(index).equals("$ASSIGNMENT"))
            {
                index++;
                if( expression())
                {
                    index++;
                    if(tokens.get(index).equals("$SEMICOLON") )
                    {
                        index++;
                        stack.add(level + " ;");
                        return true;
                    }
                }
            }
        }
        return false;

    }
    public static boolean io()
    {
        if( input( ))
        {
            if (tokens.get(index).equals("$SEMICOLON")) {
                index++;
                stack.add(level + " ;");
                return true;
            }
            parserError(";");
            return false;
        }
        if( output( ))
        {
            if (tokens.get(index).equals("$SEMICOLON")) {
                index++;
                stack.add(level + " ;");
                return true;
            }
            parserError(";");
            return false;
        }
        return false;
    }
    public static boolean input()
    {
        if(tokens.get(index).equals("$IN"))
        {
            index++;
            stack.add(level + " 'input'");

            if( variable() )
                return true;

        }
        return false;
    }
    public static boolean output()
    {
        if(tokens.get(index).equals("$OUT"))
        {
            index++;
            stack.add(level + " 'echo'");

            if( expression( ))
                return true;
        }
        return false;
    }

    /* Errors */
    public static void parserError(String errorType)
    {
        System.out.println("Error! " + "'" + errorType + "' expected, not found.");
    }

    public static void print() throws IOException{
        FileWriter fileWriter = new FileWriter("C:/Users/Arnas/Desktop/Parser/src/parser.txt");
        PrintWriter printWriter = new PrintWriter(fileWriter);


        for (int i = 0; i < stack.size(); i++) {
            String buffer;
            buffer = stack.get(i);

            int n = buffer.indexOf(' ');
            String number = buffer.substring(0, n);
            String rest = buffer.substring(n+1);

            int no = Integer.parseInt(number);

            StringBuilder sb = new StringBuilder(no);
            for (int x=0; x < no; x++){
                sb.append(" ");
            }
            String s = sb.toString();

            printWriter.println(s  + rest );
        }
        printWriter.close();
    }

}