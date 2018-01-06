for$i(1..100){if($i%15==0){print"FizzBuzz"}elsif($i%3==0){print"Fizz"}elsif($i%5==0){print"Buzz"}else{print$i}print"\n";}

for$i(1..100){if($i%3==0){print"Fizz";$f=1}if($i%5==0){print"Buzz";$f=1}if($f==0){print"$i"}print"\n";$f=0}