function howManyMonthYouWillPayLoan(initialLoan, interestPercentPerMonth, monthlyPayment) {
    var months = 0;
    var loan = initialLoan;

    while (true) {
        if (initialLoan < loan) {
            return Infinity;
        }
        loan -= monthlyPayment;
        months++;

        if (loan < monthlyPayment) {
            return (loan === 0) ? months : months + 1;
        }

        loan += (loan * interestPercentPerMonth);
    }
}


var loan = 100000,
    interest = 6.8,
    monthly = 500;

var calcResult = howManyMonthYouWillPayLoan(
    loan,
    interest / 100 / 12,
    monthly
);
console.log(
    "task: I took out a $" + loan + " loan at " + interest + "% interest. If I pay $" + monthly + " on the loan every month, how long will it take me to pay off the loan?\n",
    calcResult + " months, or " + calcResult / 12 + " years."
);

if (!isFinite(calcResult)) {
    while (true) {
        var res = howManyMonthYouWillPayLoan(
            loan,
            interest / 100 / 12,
            monthly++
        );

        if (isFinite(res)) {
            console.log("But if you grow up your payment to " + monthly + "$ per month, you will finish in " + res + " month, or ~" + Math.round(res / 12) + " years");
            break;
        }
    }
}