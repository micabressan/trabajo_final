package md2html;

import md2html.containers.*;
import md2html.elements.*;

import java.io.*;
import java.util.*;
import java.util.regex.*;

public class Md2Html {
    private static Stack<Markup> mpElements = new Stack<>(); //стек элементов разметки
    private static Stack<String> charStack = new Stack<>(); //стек символов разметки
    private static StringBuilder s = new StringBuilder(); //строка, в которую будет записываться текст

    public static void main(String[] args) throws IOException {
        String inName;
        String outName;

        try {
            inName = args[0];
            outName = args[1];
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("File not stated. Usage: Md2Html <in> <out>");
            return;
        }
        BufferedReader in = null;
        PrintWriter out = null;
        try {
            in = new BufferedReader(
                    new InputStreamReader(
                            new FileInputStream(inName), "utf-8"));
            out = new PrintWriter(outName, "utf-8");

            Document doc = new Document();
            Markup block = new Paragraph(); //блок - либо абзац, либо заголовок
            Pattern headingPattern = Pattern.compile("#+ .+"); //паттерн заголовка
            boolean isFirstLine = true;
            boolean isNewBlock = true;
            boolean ignoreNewLine = false;

            //проходим по файлу
            while (in.ready()) {
                String currLine = in.readLine();

                // если пропущена строка, то начался либо новый заголовок, либо абзац
                // обнуляем блок, перед этим записывая его в документ
                if (currLine.equals("")) {
                    if (isFirstLine) {
                        ignoreNewLine = true;
                    }
                    if (ignoreNewLine) {
                        continue;
                    }
                    ignoreNewLine = true;
                    isNewBlock = true;
                    doc.add(block);
                    block = new Paragraph();
                    continue;
                }
                ignoreNewLine = false;
                isFirstLine = false;

                int i = 0; //указатель символа в строке
                s = new StringBuilder();

                //определение заголовка
                Matcher matcher = headingPattern.matcher(currLine);
                if (matcher.matches() && isNewBlock) {
                    Matcher headingLevelMatcher = Pattern.compile("#+ ").matcher(currLine);
                    headingLevelMatcher.find();
                    int headingLevel = headingLevelMatcher.group().length() - 1;
                    block = new Heading(headingLevel);
                    i += headingLevel + 1; //перемещаем указатель на символ после пробела
                }

                //если начался новый блок, то он уже не новый (think about it)
                if (isNewBlock) {
                    mpElements.push(block);
                    isNewBlock = false;
                }

                // проходим по строке
                while (i != currLine.length()) {
                    //парсим строку
                    char ch = currLine.charAt(i);
                    boolean isDouble = false; //двойной ли символ разметки
                    boolean isLastChar = (i == currLine.length() - 1); //true если символ последний
                    switch (ch) {
                        case '\\':
                            //если \, то запишем следуюший символ
                            if (!isLastChar) {
                                i++;
                            }
                            s.append(currLine.charAt(i));
                            break;
                        //символы разметки
                        case '*':
                            if (!isLastChar && currLine.charAt(i + 1) == '*')
                                isDouble = true;
                            //fall through
                        case '_':
                            if (!isLastChar && currLine.charAt(i + 1) == '_')
                                isDouble = true;
                            //если окружён пробелами - одиночный символ
                            if ((isLastChar && currLine.charAt(i - 1) == ' ') ||
                                    (i == 0 && currLine.charAt(i + 1) == ' ') ||
                                    (i != 0 && !isLastChar &&
                                            currLine.charAt(i + 1) == ' ' && currLine.charAt(i - 1) == ' ')) {
                                s.append(ch);
                                break;
                            }
                            //fall through
                        case '-':
                            //если не "--", то просто добавляем в строку "-"
                            if (ch == '-') {
                                if (i == currLine.length() - 1 || currLine.charAt(i + 1) != '-') {
                                    s.append(ch);
                                    break;
                                }
                                isDouble = true;
                            }
                            //fall through
                        case '+':
                            //если не "++", то просто добавляем в строку "+"
                            if (ch == '+') {
                                if (i == currLine.length() - 1 || currLine.charAt(i + 1) != '+') {
                                    s.append(ch);
                                    break;
                                }
                                isDouble = true;
                            }
                            //fall through
                        case '`':
                            pushMarkup(Character.toString(ch), isDouble);
                            if (isDouble) {
                                i++;
                            }
                            break;
                        //спецсимволы
                        case '>':
                            s.append("&gt;");
                            break;
                        case '<':
                            s.append("&lt;");
                            break;
                        case '&':
                            s.append("&amp;");
                            break;
                        default:
                            s.append(ch);
                            break;
                    }
                    i++; //переход на следующий символ
                }
                mpElements.peek().add(new Text(s.toString().concat("\n"))); //в последний элемент добавляем %s\n
            }
            //игнорирование пустых строк в конце документа
            if (block.size() != 0) {
                doc.add(block);
            }
            out.print(doc.toMarkup(MarkupType.HTML));

        } catch (FileNotFoundException e) {
            System.out.printf("Missing input file: %s\n", e.getMessage());
        } catch (UnsupportedMarkupTypeException e) {
            System.out.printf("Unsupported markup type: %s\n", e.getMarkupType());
        } finally {
            if (in != null) {
                in.close();
            }
            if (out != null) {
                out.close();
            }
        }
    }

    /**
     * На вход: символ разметки, двойной ли элемент.
     * Возможные варианты символов:
     * Двойные: "--"
     * Возможно двойные: "*", "_"
     * Одиночные: "`"
     * */
    private static void pushMarkup(String mpElem, boolean isDouble) {
        mpElements.peek().add(new Text(s.toString()));
        if (isDouble) {
            mpElem = mpElem.concat(mpElem); //если элемент двойной, то дублировать строку (* -> ** например)
        }
        s = new StringBuilder();
        //если тип разметки равен последнему в стеке
        if (!charStack.isEmpty() && charStack.peek().equals(mpElem)) {
            // [... el1, el2] - добавляем el2 в el1
            Markup t = mpElements.pop();
            mpElements.peek().add(t);
            charStack.pop();
        } else {
            charStack.push(mpElem);
            switch (mpElem) {
                case "*":
                case "_":
                    mpElements.push(new Emphasis());
                    break;
                case "**":
                case "__":
                    mpElements.push(new Strong());
                    break;
                case "--":
                    mpElements.push(new Strikeout());
                    break;
                case "++":
                    mpElements.push(new Underline());
                    break;
                case "`":
                    mpElements.push(new Code());
                    break;
            }
        }
    }
}