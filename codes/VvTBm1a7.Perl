#3.Write a script that will print 10 random number cards from a deck. 
#a.The script will build a deck of 52 cards by using nested foreach loops.
#b.The outer loop will iterate through a list consisting of cards for each suit:
#  clubs,diamonds,hearts,spades. The inner loop will iterate through a list for 
#  each type of card within the suit: ace,1 through 10, jack,queen, and king. A 
#  card of each suit will be assigned to an array
#c.The rand() function will be used to get a random card from the pack. There 
#  should be no duplicates in the 10 cards selected from the deck.

use strict;

my @array_suits=( "hearts", "spades", "diamonds", "clubs" );
my @array_ranks=("Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King");
my $j;
my $index=0;
my @array_cards="";
foreach my $outer (@array_suits)
{
	foreach my $inner  (@array_ranks)
	{
		push @array_cards, "$inner of $outer";
		#$j++;  I get count of  52
	}
}
my $i=0;
foreach (@array_cards)
{
	#print $_;
#	print "\n";
	$j++; # test2 i get a count of 53
	      	
      while($i<10) { 
           $index= int(rand($#array_cards)); #this will generate the random #
	       print $array_cards[$index];
	       print "\n";
	       $i++;
         }
}
print $j;


exit(1);