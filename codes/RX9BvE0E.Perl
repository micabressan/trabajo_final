#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;
use List::Util qw/shuffle/;

# This is a list of available cards, 0 is stored as 10
# 10, 11 and 12 are stored as J Q K
# 2-9 are stored as 2-9
my @cardlist = (10, 'A', 2..9, qw(J Q K));
# This is a way to not write many conditions to convert key characters to numbers
my %cardhash = map {$cardlist[$_] => $_} 0..$#cardlist;
my $cardid;
# In this game suits are irrelevant
my @pool = map {($_,$_,$_,$_)} 0..$#cardlist;
# Shuffle cards
@pool = shuffle @pool;

# Cards template, every player has no cards by default
my @cards = map {0} 0..$#cardlist;
# Books array template, every player has no books by default
my @books;
# Players' default names
my @player = (qw(Player Computer));
# These are colors for player
my @colors = ("green on_black", "red on_black");
# Players' custom names
for (my $i = 0; $i <= $#player && $i <= $#ARGV; $i++) {
	$player[$i] = $ARGV[$i];
}
# Players' cards
my @card = map {[ @cards ]} 0..$#player;
# Player's books
my @book = map {[ @books ]} 0..$#player;
my $gameover = 0;
my $guess;
my $drew;
# Give enemy a little intellect
my @asked = map {0} 0..$#cardlist;
# Number of cards in players' hands
my @cnum;
# Randomly choose who goes first
my $turn = int rand scalar @player;
# Give 7 cards to each player
for (0..6) {
	for (0..$#player) {
		$card[$_][pop @pool] += 1;
	}
}

# Say it aloud!
print colored("$player[$turn]: I go first!", $colors[$turn]), "\n";

# And so we are playing
 
until ($gameover) {
	# Player's ID
	for my $i (0..$#player) {
		for my $j (0..$#{ $card[$i] }) {
			# It looks like someone has a book
			if ($card[$i][$j] == 4) {
				$card[$i][$j] = 0;
				print colored("$player[$i]: I have made a book of $cardlist[$j]\'s!", $colors[$i]), "\n";
				push @{ $book[$i] }, $cardlist[$j];
			}
		}
	}

	@cnum = map {0} 0..$#player;
	# Player's ID
	for my $i (0..$#player) {
		foreach (@{ $card[$i] }) {
			$cnum[$i]+=$_;
		}
		if ($cnum[$i] == 0) {
			$gameover = 1;
			last;
		}
	}

	last if $gameover;

	print "$cnum[1] cards are in $player[1]\'s hand\.\n";
	print $#pool + 1, " cards are left in pool\.\n";
	print "Your hand is:";
	for my $i (0..$#cardlist) {
		for (my $j = 0; $j < $card[0][$i]; $j++) {
			print colored(" $cardlist[$i]", "blue on_black");
		}
	}

	print "\n";

	for (0..$#player) {
		print "$player[$_]\'s books are: @{ $book[$_] }\n" if scalar @{ $book[$_]};
	}

	print colored("$player[$turn]: I ask you for ", $colors[$turn]);
	if ($turn) {
		do {
			$guess = int rand scalar @cardlist;
		} until ($card[1][$guess]);
		# If I allready asked for one of these cards and you have it, ask for it!
		for my $i (0..$#cardlist) {
			if ($card[1][$i] && $asked[$i]) {
				$guess = $i;
				$asked[$i] = 0;
				last;
			}
		}

		print "$cardlist[$guess]\n";

		if ($card[0][$guess]) {
			print colored("$player[0]: I have $card[0][$guess] $cardlist[$guess]\'s", $colors[0]), "\n";
			$card[1][$guess] += $card[0][$guess];
			$card[0][$guess] = 0;
		} else {
			if (scalar @pool) {
				print colored("$player[0]: GO FISH!", $colors[0]), "\n";
				$drew = pop @pool;
				$card[1][$drew] += 1;
			} else {
				print colored("$player[0]: Game over!", $colors[0]), "\n";
				$gameover = 1;
				last;
			}

			if ($drew == $guess) {
				print colored("$player[1]: I drew $cardlist[$drew]!", $colors[1]), "\n";
			} else {
				$turn = 0;
			}
		}
	} else {
		last if eof(STDIN);
		$guess = <STDIN>;
		chomp $guess;
		$guess = uc $guess;
		$cardid = $cardhash{$guess};
		if ($guess eq "QUIT") {
			print colored("$player[1]: You're such a chicken!", $colors[1]);
			last;
		} elsif ((exists($card[0][$cardid]) == 0) || ($card[0][$cardid] == 0)) {
			print colored("$player[0]: Oups, I don't have this card!", $colors[0]), "\n";
			next;
		}
		$asked[$cardid] = 1;
		if ($card[1][$cardid]) {
			print colored("$player[1]: I have $card[1][$cardid] $cardlist[$cardid]\'s", $colors[1]), "\n";
			$card[0][$cardid] += $card[1][$cardid];
			$card[1][$cardid] = 0;
		} else {
			if (scalar @pool) {
				print colored("$player[1]: GO FISH!", $colors[1]), "\n";
				$drew = pop @pool;
				$card[0][$drew] += 1;
			} else {
				print colored("$player[1]: Game over!", $colors[1]), "\n";
				$gameover = 1;
				last;
			}
			if ($drew eq $cardid) {
				print colored("$player[0]: I drew $cardlist[$drew]!", $colors[0]), "\n";
			} else {
				$turn = 1;
				print "You drew $cardlist[$drew]\.\n";
			}
		}
	}
}

# Print results
if ($gameover) {
	for (0..$#player) {
		print colored("$player[$_]: My books are: @{ $book[$_] }", $colors[$_]), "\n";
	}
	if ($#{ $book[0] } == $#{ $book[1] }) {
		print "No winner!\n";
	} else {
		my $winner = ($#{ $book[0] } < $#{ $book[1] });
		print colored("$player[$winner]: I win!", $colors[$winner]), "\n";
	}
} else {
	print "\n";
}