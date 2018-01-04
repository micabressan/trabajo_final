import readlineSync from 'readline-sync';

const userName = readlineSync.question('Welcome to Brain Games!\nAnswer "yes" if number even otherwise answer "no"!\n\nMay I have your name? ');

function getRandomInt() {
  return Math.round(Math.random() * 100);
}

const answer = readlineSync.question('Your answer: ');
const question = n => console.log(`Question: ${n}`);
const isEven = num => (num % 2 === 0 ? 'yes' : 'no');
const checkAnswer = (str, num) => (str === isEven(num));

const game = () => {
  let counter = 0;
  while (counter < 3) {
    const num = getRandomInt();
    question(num);
    answer();
    if (checkAnswer(answer, num) === true) {
      counter += 1;
      console.log('Correct!');
    } else {
      console.log(`${answer} is wrong answer ;(. Correct answer was ${isEven(num)}.
            Let's try again, ${userName}`);
      break;
    }
  }
  return console.log(`Congratulations, ${userName}`);
};

export { userName, game };