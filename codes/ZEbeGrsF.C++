 MyStack<Fraction> stack;
        Fraction a;
        Fraction b;
        Fraction c;

        std::string input; // user input
        std::string token; // token, separate by spacebar
        std::stringstream ss; // stream for tokenizering
        std::istringstream toConvert; // stream for converting text to number

        int code; // code of sign for if statement

        std::cout << "Enter fraze to calculate " << endl;

        std::cin.ignore();
        getline(std::cin, input); // reading fraze from console
        ss.str(input); // setting string in stream

        while (std::getline(ss, token, ' ')) { // tokenizering
            code = (int) token[0]; // code of first sign of token
            if (code == 42 || code == 43 || code == 45 || code == 47) {
                // user's input is an operator
                if (stack.getSize() >= 2) {
                    b = stack.pop();
                    a = stack.pop();
                    switch (code) {
                        case 43: // add
                            stack.push(a + b);
                            break;
                        case 45: // sub
                            stack.push(a - b);
                            break;
                        case 42: // mult
                            stack.push(a * b);
                            break;
                        case 47: // div
                            stack.push(a / b);
                            break;
                    }
                } else {
                    throw std::invalid_argument("You entered incorrect fraze");
                }

            } else if (code == 48) {
                throw std::invalid_argument("You cannot enter zero");
            } else if (code > 48 && code <= 57) {
                // user's input is a digit
                toConvert.str(token);
                toConvert >> c;
                stack.push(c);
                toConvert.clear();

            } else {
                throw std::invalid_argument("We cannot recognize " + token);
            }
        }

        std::cout << "result of " << input << " is " << stack.pop() << std::endl;