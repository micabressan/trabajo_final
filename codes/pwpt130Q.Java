
    }

    public void start() {

        init();

        wordToGuess = player1.setWordToGuess();
        substituteWordCharacters();

        while (numberOfGuesses > 0 && !hasWon) {
            System.out.println("Enter a single character:");
            String strEntered = "";

            while ((strEntered = player2.chooseChar()).length() != 1) {
                System.out.println("Enter one character only:");
            }

            char character = strEntered.charAt(0);
            if (!compareWords(character)) {
                numberOfGuesses--;
            }
            System.out.println(hiddenWord + numberOfGuesses + " left");
        }

        if (numberOfGuesses == 0) {
            System.out.println("Fuck you, you lose.");
        }
    }

    private void substituteWordCharacters() {