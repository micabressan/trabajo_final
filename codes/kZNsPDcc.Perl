#!/usr/bin/perl -w

#this will print a sequence of numbers
print "Here is a list of increasing numbers: ",(1..6), "\n";

#This will not work, because range has to be specified in increasing fashion
print "Here is a list of decreasing numbers: ",(11..1), "\n";

#We can achieve "reverse" action by using the built-in reverse function
print "Here is a reverse list of numbers: ",reverse(1..11),"\n";

#printing a range of letters can be done similarly numbers
#This includes backward printing
print"How about printing a range of letters? ",('c'..'p'),"\n";

@months = qw/January Febuary March April May June July August Septtember October November December/;

#here are some examples involving lists
print"The first month's name is:$months[0]\n";
print"My favorite months are: @months[3,5,9..10]\n";

@summer=@months[5..7];
print"@summer are summer months\n";