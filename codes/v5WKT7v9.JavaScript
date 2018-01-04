var num = [50, 75];
function isEven(number) {
    number = Boolean(true);
    if (1 % num[0] == 0) {
        console.log(number);
    }
    else if (1 % num[1] == 0) {
        console.log(number);
    }
    num.find(isEven);
    
    
}
isEven(true);