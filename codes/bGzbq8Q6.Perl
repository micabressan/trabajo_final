package Games::Schema::Result::plays;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("plays");

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 1 },
  "GameIdentifier",
  { data_type => "bigint", is_nullable => 1 },
  "quarter",
  { data_type => "int", is_nullable => 1 },
  "down",
  { data_type => "int", is_nullable => 1 },
  "to_go",
  { data_type => "int", is_nullable => 1 },
  "to_goal",
  { data_type => "int", is_nullable => 1 },
  "b_rush",
  { data_type => "int", is_nullable => 1 },
  "b_pass",
  { data_type => "int", is_nullable => 1 },
  "b_punt",
  { data_type => "int", is_nullable => 1 },
  "b_kickoff",
  { data_type => "int", is_nullable => 1 },
  "b_fieldgoal",
  { data_type => "int", is_nullable => 1 },
  "b_fieldgoal_good",
  { data_type => "int", is_nullable => 1 },
  "b_conversion",
  { data_type => "int", is_nullable => 1 },
  "b_conversion_good",
  { data_type => "int", is_nullable => 1 },
  "b_extrapoint",
  { data_type => "int", is_nullable => 1 },
  "b_extrapoint_good",
  { data_type => "int", is_nullable => 1 },
  "b_penalty",
  { data_type => "int", is_nullable => 1 },
  "b_fumble",
  { data_type => "int", is_nullable => 1 },
  "b_firstdown",
  { data_type => "int", is_nullable => 1 },
  "b_timeout_home",
  { data_type => "int", is_nullable => 1 },
  "b_timeout_away",
  { data_type => "int", is_nullable => 1 },
  "b_touchdown",
  { data_type => "int", is_nullable => 1 },
  "b_safety",
  { data_type => "int", is_nullable => 1 },
  "b_intercepted",
  { data_type => "int", is_nullable => 1 },
  "b_incomplete",
  { data_type => "int", is_nullable => 1 },
  "b_touchback",
  { data_type => "int", is_nullable => 1 },
  "b_blocked",
  { data_type => "int", is_nullable => 1 },
  "b_home_possession",
  { data_type => "int", is_nullable => 1 },

  "b_out_of_bounds",
  { data_type => "int", is_nullable => 1 },
  "b_fair_catch",
  { data_type => "int", is_nullable => 1 },
  "b_downed",
  { data_type => "int", is_nullable => 1 },
  "b_sacked",
  { data_type => "int", is_nullable => 1 },


  "home_score",
  { data_type => "int", is_nullable => 1 },
  "away_score",
  { data_type => "int", is_nullable => 1 },

  "yards",
  { data_type => "int", is_nullable => 1 },
  "return_yards",
  { data_type => "int", is_nullable => 1 },
  "penalty_yards",
  { data_type => "int", is_nullable => 1 },
  "drive_start_time",	
  { data_type => "varchar", size => 50, is_nullable => 1 },
  "drive_end_time",	
  { data_type => "varchar", size => 50, is_nullable => 1 },
  "play_text",	
  { data_type => "text", is_nullable => 1 },

); 

__PACKAGE__->set_primary_key("id");


__PACKAGE__->belongs_to(
  "game",
  "Games::Schema::Result::espn_games",
  { "foreign.espn_id" => "self.GameIdentifier" },
  { join_type => 'left' },
);


#######################################################################################


=head2 off_team_name

Returns the offensive's team name

=cut

sub off_team_name {
	my $self = shift;

	if($self->b_home_possession) {
		return $self->home_team->drive_short;		
	}
	else {
		return $self->away_team->drive_short;		
	}
}

sub _get_pass_score {
	my $self = shift;
	my $score = '';
	return $score unless $self->b_pass;

	my $down = $self->down;
	my $to_go = $self->to_go;
	my $yards = $self->yards;

	if($self->b_incomplete) {
		$score = 0;
	}
	elsif($down == 1) {
		if($to_go == 0) {
			# Goal line
		}
		elsif($to_go > 5) {
			my $rp = $yards / $to_go;
			if($rp < .3) { 
				$score = 0; 
			}
			elsif($rp >= .3 && $rp < .4) { 
				$score = 0; 
			}
			elsif($rp >= .4 && $rp < .5) { 
				$score = .4; 
			}
			elsif($rp >= .5 && $rp < .6) { 
				$score = .5; 
			}
			elsif($rp >= .6 && $rp < .7) { 
				$score = .6; 
			}
			elsif($rp >= .7 && $rp < .8) { 
				$score = .7; 
			}
			elsif($rp >= .8 && $rp < .9) { 
				$score = .8; 
			}
			elsif($rp >= .9 && $rp < 1) { 
				$score = .9; 
			}
			elsif($rp >= 1) { 
				$score = 1; 
			}
		}
		elsif($to_go > 0 && $to_go <= 5) {
			my $rp = $yards / $to_go;
			if($rp < .5) { 						
				$score = 0; 
			}
			elsif($rp >= .5 && $rp < .8) {
				$score = .5; 
			}
			elsif($rp >= .8 && $rp < .9) { 
				$score = .75; 
			}
			elsif($rp >= .9) { 
				$score = 1; 
			}
		}
	}
	elsif($down == 2 || $down == 3) {
		my $rp = $yards / $to_go;
		if($to_go > 5) {
			$rp = $yards / ($to_go-5);
		}
		if($rp >= 1) {
			$score = 1;
		}	
		else {
			my $gscore = 1 - $rp;
			$gscore = '-' . $gscore;
			$score = $gscore;
		}
	}


	return $score;
}

sub _get_pass_pom {
	my $self = shift;
	my $pom = '';
	return $pom unless $self->b_pass;

	my $down = $self->down;
	my $to_go = $self->to_go;
	my $yards = $self->yards;


	if($self->b_incomplete) {
		$pom = '-';
	}
	elsif($down == 1) {
		if($to_go == 0) {
			# Goal line
		}
		elsif($to_go > 5) {
			my $rp = $yards / $to_go;
			if($rp < .3) { 
				$pom = "-";
			}
			elsif($rp >= .3 && $rp < .4) { 
				$pom = "o";
			}
			elsif($rp >= .4 && $rp < .5) { 
				$pom = "+"; 
			}
			elsif($rp >= .5 && $rp < .6) { 
				$pom = "+";
			}
			elsif($rp >= .6 && $rp < .7) { 
				$pom = "+";
			}
			elsif($rp >= .7 && $rp < .8) { 
				$pom = "+";
			}
			elsif($rp >= .8 && $rp < .9) { 
				$pom = "+";
			}
			elsif($rp >= .9 && $rp < 1) { 
				$pom = "+";
			}
			elsif($rp >= 1) { 
				$pom = "+";
			}
		}
		elsif($to_go > 0 && $to_go <= 5) {
			my $rp = $yards / $to_go;
			if($rp < .5) { 						
				$pom = "-";
			}
			elsif($rp >= .5 && $rp < .8) {
				$pom = "o";
			}
			elsif($rp >= .8 && $rp < .9) { 
				$pom = "+"; 
			}
			elsif($rp >= .9) { 
				$pom = "+";
			}
		}
	}
	elsif($down == 2 || $down == 3) {
		if($down == 2) {
			if($to_go > 0) { 
				my $rp = $yards / $to_go;
				if($rp > .7) {
					$pom = '+';
				}
				elsif($rp == .7) {
					$pom = 'o';
				}
				elsif($rp < .7) {
					$pom = '-';
				}
			}
		}
		elsif($down == 3) {
			if($to_go > 0) {
				my $rp = $yards / $to_go;
	
				if($rp >= 1) {
					$pom = '+';
				}
				else {
					$pom = '-';
				}
			}
		}
	}

	return $pom;
}


sub _get_rush_score {
	my $self = shift;
	my $score = '';
	return $score unless $self->b_rush;

	my $down = $self->down;
	my $to_go = $self->to_go;
	my $yards = $self->yards;


	if($down == 1) {
		if($to_go > 5) {
			my $rp = $yards / $to_go;
			if($rp < .3) { 
				$score = 0;
			}
			elsif($rp >= .3 && $rp < .4) { 	
				$score = .3;
			}
			elsif($rp >= .4 && $rp < .5) { 
				$score = .4;
			}
			elsif($rp >= .5 && $rp < .6) { 
				$score = .5;
			}
			elsif($rp >= .6 && $rp < .7) { 
				$score = .6;
			}
			elsif($rp >= .7 && $rp < .8) { 
				$score = .7;
			}
			elsif($rp >= .8 && $rp < .9) { 
				$score = .8; 
			}
			elsif($rp >= .9 && $rp < 1) { 
				$score = .9;
			}
			elsif($rp >= 1) { 
				$score = 1;
			}
		}
		elsif($to_go >= 0 && $to_go <= 5) {
			my $rp = $yards / $to_go;
			if($rp < .1) { 
				$score = 0; 
			}
			elsif($rp >= .1 && $rp < .29) { 
				$score = 0;
			}
			elsif($rp >= .3 && $rp < .59) { 
				$score = .3; 
			}
			elsif($rp >= .6 && $rp < .9) { 
				$score = .5;
			}
			elsif($rp >= .9) { 
				$score = .7;
			}
		}
	}
	elsif($down == 2 || $down == 3) {
		my $rp = $yards / $to_go;
		if($to_go > 5) {
			$rp = $yards / ($to_go-5);
		}
		if($rp >= 1) {
			$score = 1;
		}	
		else {
			my $gscore = 1 - $rp;
			$gscore = '-' . $gscore;
			$score = $gscore;											
		}
		if($down == 2) {
			my $rp = $yards / $to_go;
			if($rp > .7) {
				$score = 1;
			}
			elsif($rp == .7) {
				$score = 1;
			}
			elsif($rp < .7) {
				$score = 1;
			}						
		}
		elsif($down == 3) {
			my $rp = $yards / $to_go;
			
			if($rp >= 1) {
				$score = 1;
			}
			else {
				$score = 1;
			}
		}
	}

	return $score;
}



sub _get_rush_pom {
	my $self = shift;
	my $pom = '';
	return $pom unless $self->b_rush;

	my $down = $self->down;
	my $to_go = $self->to_go;
	my $yards = $self->yards;

	if($down == 1) {
		if($to_go > 5) {
			my $rp = $yards / $to_go;
			if($rp < .3) { 
				$pom = "-";
			}
			elsif($rp >= .3 && $rp < .4) { 	
				$pom = "o";
			}
			elsif($rp >= .4 && $rp < .5) { 
				$pom = "+";
			}
			elsif($rp >= .5 && $rp < .6) { 
				$pom = "+";
			}
			elsif($rp >= .6 && $rp < .7) { 
				$pom = "+";
			}
			elsif($rp >= .7 && $rp < .8) { 
				$pom = "+";
			}
			elsif($rp >= .8 && $rp < .9) { 
				$pom = "+";
			}
			elsif($rp >= .9 && $rp < 1) { 
				$pom = "+";
			}
			elsif($rp >= 1) { 
				$pom = "+";
			}
		}
		elsif($to_go >= 0 && $to_go <= 5) {
			my $rp = $yards / $to_go;
			if($rp < .1) { 
				$pom = "-";
			}
			elsif($rp >= .1 && $rp < .29) { 
				$pom = "o";
			}
			elsif($rp >= .3 && $rp < .59) { 
				$pom = "+";
			}
			elsif($rp >= .6 && $rp < .9) { 
				$pom = "+";
			}
			elsif($rp >= .9) { 
				$pom = "+";
			}
		}
	}
	elsif($down == 2 || $down == 3) {
		my $rp = $yards / $to_go;											

		if($down == 2) {
			my $rp = $yards / $to_go;
			if($rp > .7) {
				$pom = '+';
			}
			elsif($rp == .7) {
				$pom = 'o';
			}
			elsif($rp < .7) {
				$pom = '-';
			}						
		}
		elsif($down == 3) {
			my $rp = $yards / $to_go;
			
			if($rp >= 1) {
				$pom = '+';
			}
			else {
				$pom = '-';
			}
		}
	}

	return $pom;
} 



sub _get_kickoff_pom {
	my $self = shift;
	my $pom = '';
	return $pom unless $self->b_kickoff;

	if($self->b_kickoff) {
		my $ball_pos = 30;
		my $kick_yards;
		$kick_yards = $self->yards;
		my $kicked_to = ($ball_pos + $kick_yards);

		if($kicked_to >= 100) {
			$pom = '++';
		}
		elsif($kicked_to >= 95 && $kicked_to < 100) {
			$pom = '+';
		}
		elsif($kicked_to >= 90 && $kicked_to < 95) {
			$pom = '+';
		}
		elsif($kicked_to >= 85 && $kicked_to < 95) {
			$pom = '+';
		}
		elsif($kicked_to >= 80 && $kicked_to < 85) {
			$pom = '+';
		}
		elsif($kicked_to >= 75 && $kicked_to < 80) {
			$pom = '+';
		}
		elsif($kicked_to >= 70 && $kicked_to < 75) {
			$pom = 'o';
		}
		elsif($kicked_to >= 65 && $kicked_to < 70) {
			$pom = 'o';
		}
		elsif($kicked_to >= 60 && $kicked_to < 65) {
			$pom = '-';
		}
		elsif($kicked_to >= 55 && $kicked_to < 60) {
			$pom = '-';
		}
		elsif($kicked_to >= 50 && $kicked_to < 55) {
			$pom = '-';
		}
		elsif($kicked_to < 50) {
			$pom = '-';
		}

		return $pom;
	}
}

sub _get_kickoff_score {
	my $self = shift;
	my $score = '';
	return $score unless $self->b_kickoff;

	if($self->b_kickoff) {
		my $ball_pos = 30;
		my $kick_yards;
		$kick_yards = $self->yards;
		my $kicked_to = ($ball_pos + $kick_yards);

		if($kicked_to >= 100) {
			$score = .12;
		}
		elsif($kicked_to >= 95 && $kicked_to < 100) {
			$score = .1;
		}
		elsif($kicked_to >= 90 && $kicked_to < 95) {
			$score = .1;
		}
		elsif($kicked_to >= 85 && $kicked_to < 95) {
			$score = .08;
		}
		elsif($kicked_to >= 80 && $kicked_to < 85) {
			$score = .07;
		}
		elsif($kicked_to >= 75 && $kicked_to < 80) {
			$score = .06;
		}
		elsif($kicked_to >= 70 && $kicked_to < 75) {
			$score = .04;
		}
		elsif($kicked_to >= 65 && $kicked_to < 70) {
			$score = .02;
		}
		elsif($kicked_to >= 60 && $kicked_to < 65) {
			$score = 0
		}
		elsif($kicked_to >= 55 && $kicked_to < 60) {
			$score = -.02;
		}
		elsif($kicked_to >= 50 && $kicked_to < 55) {
			$score = -.05
		}
		elsif($kicked_to < 50) {
			$score = -.07
		}

		return $score;
	}
}


sub _get_kickoff_return_pom {
	my $self = shift;
	my $pom = '';
	return $pom unless $self->b_kickoff;

	if($self->b_kickoff) {
		my $ball_pos = 30;
		my $kick_yards;
		my $return_yards = $self->return_yards || 0;
		$kick_yards = $self->yards;
		my $kicked_to = ($ball_pos + $kick_yards);
		my $returned_to = (100 - $kicked_to) + $return_yards;

		if($returned_to >= 100) {
			$pom = '++';
		}
		elsif($returned_to >= 50 && $returned_to < 100) {
			$pom = '+';
		}
		elsif($returned_to >= 45 && $returned_to < 50) {
			$pom ='+';
		}
		elsif($returned_to >= 40 && $returned_to < 45) {
			$pom = '+';
		}
		elsif($returned_to >= 35 && $returned_to < 40) {
			$pom = '+';
		}
		elsif($returned_to >= 30 && $returned_to < 35) {
			$pom = 'o';
		}
		elsif($returned_to >= 25 && $returned_to < 30) {
			$pom = 'o';
		}
		elsif($returned_to >= 20 && $returned_to < 25) {
			$pom = 'o';
		}
		elsif($returned_to >= 15 && $returned_to < 20) {
			$pom = '-';
		}
		elsif($returned_to >= 10 && $returned_to < 15) {
			$pom = '-';
		}
		elsif($returned_to >= 5 && $returned_to < 10) {
			$pom = '-';
		}
		elsif($returned_to < 5) {
			$pom = '--';
		}


		return $pom;
	}
}


sub _get_kickoff_return_score {
	my $self = shift;
	my $score = '';
	return $score unless $self->b_kickoff;

	if($self->b_kickoff) {
		my $ball_pos = 30;
		my $kick_yards;
		my $return_yards = $self->return_yards || 0;
		$kick_yards = $self->yards;
		my $kicked_to = ($ball_pos + $kick_yards);
		my $returned_to = (100 - $kicked_to) + $return_yards;

		if($returned_to >= 100) {
			$score = .12;
		}
		elsif($returned_to >= 50 && $returned_to < 100) {
			$score = .1;
		}
		elsif($returned_to >= 45 && $returned_to < 50) {
			$score = .1;
		}
		elsif($returned_to >= 40 && $returned_to < 45) {
			$score = .08;
		}
		elsif($returned_to >= 35 && $returned_to < 40) {
			$score = .07;
		}
		elsif($returned_to >= 30 && $returned_to < 35) {
			$score = .06;
		}
		elsif($returned_to >= 25 && $returned_to < 30) {
			$score = .05;
		}
		elsif($returned_to >= 20 && $returned_to < 25) {
			$score = .08;
		}
		elsif($returned_to >= 15 && $returned_to < 20) {
			$score = -.05;
		}
		elsif($returned_to >= 10 && $returned_to < 15) {
			$score = -.1;
		}
		elsif($returned_to >= 5 && $returned_to < 10) {
			$score = -.12;
		}
		elsif($returned_to < 5) {
			$score = .13;
		}


		return $score;
	}
}


sub _get_punt_score {
	my $self = shift;
	my $score = '';
	return $score unless $self->b_punt;

	if($self->b_punt) {
		my $to_goal = $self->to_goal;
		my $ball_pos = (100-$to_goal);
		my $kick_yards = $self->yards;
		my $kicked_to = ($ball_pos + $kick_yards);

		if($to_goal <= 50) {
			if($kicked_to >= 95) {
				$score = .1;
			}
			elsif($kicked_to >= 90 && $kicked_to < 95) {
				$score = .08;
			}
			elsif($kicked_to >= 85 && $kicked_to < 90) {
				$score = .06;
			}
			elsif($kicked_to >= 80 && $kicked_to < 85) {
				$score = .03;
			}
			elsif($kicked_to >= 75 && $kicked_to < 80) {
				$score = 0;
			}
			elsif($kicked_to >= 70 && $kicked_to < 75) {
				$score = -.01;
			}
			elsif($kicked_to >= 65 && $kicked_to < 70) {
				$score = -.02;
			}
			elsif($kicked_to >= 55 && $kicked_to < 65) {
				$score = -.05;
			}
			elsif($kicked_to >= 45 && $kicked_to < 55) {
				$score = -.07;
			}
			elsif($kicked_to >= 20 && $kicked_to < 45) {
				$score = -.09;
			}
			elsif($kicked_to >= 10 && $kicked_to < 20) {
				$score = -.1;
			}
			elsif($kicked_to < 10) {
				$score = -.13;
			}
		}
		else {
			if($ball_pos < 10) {
				if($kicked_to <= 5) {
					$score = -.07;
				}
				elsif($kicked_to <= 10 && $kick_yards > 5) {
					$score = -.05;
				}
				elsif($kicked_to <= 15 && $kick_yards > 10) {
					$score = -.01;						
				}
				elsif($kicked_to <= 20 && $kick_yards > 15) {
					$score = .01;
				}
				elsif($kicked_to <= 25 && $kick_yards > 20) {
					$score = .03;
				}
				elsif($kicked_to <= 30 && $kick_yards > 25) {
					$score = .05;
				}
				elsif($kicked_to <= 35 && $kick_yards > 30) {
					$score = .07;
				}
				elsif($kicked_to <= 45 && $kick_yards > 35) {
					$score = .09;
				}
				elsif($kicked_to > 45) {
					$score = .1;
				}

			}
			elsif($ball_pos >= 10 && $ball_pos < 15) {
				if($kicked_to <= 0) {
					$score = -.1;	
				}
				elsif($kicked_to <= 5 && $kick_yards > 0) {
					$score = -.07;
				}
				elsif($kicked_to <= 10 && $kick_yards > 5) {
					$score = -.05;
				}
				elsif($kicked_to <= 15 && $kick_yards > 10) {
					$score = -.01;
				}
				elsif($kicked_to <= 20 && $kick_yards > 15) {
					$score = .01;
				}
				elsif($kicked_to <= 25 && $kick_yards > 20) {
					$score = .03;
				}
				elsif($kicked_to <= 30 && $kick_yards > 25) {
					$score = .05;
				}
				elsif($kicked_to <= 35 && $kick_yards > 30) {
					$score = .07;
				}
				elsif($kicked_to <= 45 && $kick_yards > 35) {
					$score = .09;
				}
				elsif($kicked_to > 45) {
					$score = .1;
				}

			}
			elsif($ball_pos >= 15 && $ball_pos < 20) {
				if($kicked_to <= -5) {
					$score = -.11;
				}
				elsif($kicked_to <= 0 && $kick_yards > -5) {
					$score = -.1;
				}
				elsif($kicked_to <= 5 && $kick_yards > 0) {
					$score = -.085;
				}
				elsif($kicked_to <= 10 && $kick_yards > 5) {
					$score = -.08;
				}
				elsif($kicked_to <= 15 && $kick_yards > 10) {
					$score = -.06;
				}
				elsif($kicked_to <= 20 && $kick_yards > 15) {
					$score = -.04;
				}
				elsif($kicked_to <= 25 && $kick_yards > 20) {
					$score = -.02;
				}
				elsif($kicked_to <= 30 && $kick_yards > 25) {
					$score = -0.1;
				}
				elsif($kicked_to <= 35 && $kick_yards > 30) {
					$score = .07;
				}
				elsif($kicked_to <= 45 && $kick_yards > 35) {
					$score = .09;
				}
				elsif($kicked_to > 45) {
					$score = .1;
				}

			}
			elsif($ball_pos >= 20) {
				if($kicked_to <= 0) {
					$score = -.1;
				}
				elsif($kicked_to <= 10 && $kick_yards > 0) {
					$score = -.08;
				}
				elsif($kicked_to <= 20 && $kick_yards > 10) {
					$score = -.06;
				}
				elsif($kicked_to <= 30 && $kick_yards > 20) {
					$score = -.02;
				}
				elsif($kicked_to <= 35 && $kick_yards > 30) {
					$score = -.04;
				}
				elsif($kicked_to <= 40 && $kick_yards > 35) {
					$score = .04;
				}
				elsif($kicked_to <= 45 && $kick_yards > 40) {
					$score = .07;
				}
				elsif($kicked_to <= 50 && $kick_yards > 45) {
					$score = .08;
				}
				elsif($kicked_to > 50) {
					$score = .1;
				}
			}
		}
	}

	return $score;
}


sub _get_punt_pom {
	my $self = shift;
	my $pom = '';
	return $pom unless $self->b_punt;

	if($self->b_punt) {
		my $to_goal = $self->to_goal;
		my $ball_pos = (100-$to_goal);
		my $kick_yards = $self->yards;
		my $kicked_to = ($ball_pos + $kick_yards);

		if($to_goal <= 50) {
			if($kicked_to >= 95) {
				$pom = '+';
			}
			elsif($kicked_to >= 90 && $kicked_to < 95) {
				$pom = '+';
			}
			elsif($kicked_to >= 85 && $kicked_to < 90) {
				$pom = '+';
			}
			elsif($kicked_to >= 80 && $kicked_to < 85) {
				$pom = 'o';
			}
			elsif($kicked_to >= 75 && $kicked_to < 80) {
				$pom = 'o';
			}
			elsif($kicked_to >= 70 && $kicked_to < 75) {
				$pom = '-';
			}
			elsif($kicked_to >= 65 && $kicked_to < 70) {
				$pom = '-';
			}
			elsif($kicked_to >= 55 && $kicked_to < 65) {
				$pom = '-';
			}
			elsif($kicked_to >= 45 && $kicked_to < 55) {
				$pom = '-';
			}
			elsif($kicked_to >= 20 && $kicked_to < 45) {
				$pom = '-';
			}
			elsif($kicked_to >= 10 && $kicked_to < 20) {
				$pom = '-';
			}
			elsif($kicked_to < 10) {
				$pom = '--';
			}
		}
		else {
			if($ball_pos < 10) {
				if($kicked_to <= 5) {
					$pom = '-';
				}
				elsif($kicked_to <= 10 && $kick_yards > 5) {
					$pom = '-';
				}
				elsif($kicked_to <= 15 && $kick_yards > 10) {
					$pom = '-';
				}
				elsif($kicked_to <= 20 && $kick_yards > 15) {
					$pom = '-';
				}
				elsif($kicked_to <= 25 && $kick_yards > 20) {
					$pom = '-';
				}
				elsif($kicked_to <= 30 && $kick_yards > 25) {
					$pom = 'o';
				}
				elsif($kicked_to <= 35 && $kick_yards > 30) {
					$pom = 'o';
				}
				elsif($kicked_to <= 45 && $kick_yards > 35) {
					$pom = '+';
				}
				elsif($kicked_to > 45) {
					$pom = '+';
				}

			}
			elsif($ball_pos >= 10 && $ball_pos < 15) {
				if($kicked_to <= 0) {
					$pom = '-';	
				}
				elsif($kicked_to <= 5 && $kick_yards > 0) {
					$pom = '-';
				}
				elsif($kicked_to <= 10 && $kick_yards > 5) {
					$pom = '-';
				}
				elsif($kicked_to <= 15 && $kick_yards > 10) {
					$pom = '-';
				}
				elsif($kicked_to <= 20 && $kick_yards > 15) {
					$pom = '-';
				}
				elsif($kicked_to <= 25 && $kick_yards > 20) {
					$pom = '-';
				}
				elsif($kicked_to <= 30 && $kick_yards > 25) {
					$pom = 'o';
				}
				elsif($kicked_to <= 35 && $kick_yards > 30) {
					$pom = 'o';
				}
				elsif($kicked_to <= 45 && $kick_yards > 35) {
					$pom = '+';
				}
				elsif($kicked_to > 45) {
					$pom = '+';
				}

			}
			elsif($ball_pos >= 15 && $ball_pos < 20) {
				if($kicked_to <= -5) {
					$pom = '-';	
				}
				elsif($kicked_to <= 0 && $kick_yards > -5) {
					$pom = '-';
				}
				elsif($kicked_to <= 5 && $kick_yards > 0) {
					$pom = '-';
				}
				elsif($kicked_to <= 10 && $kick_yards > 5) {
					$pom = '-';
				}
				elsif($kicked_to <= 15 && $kick_yards > 10) {
					$pom = '-';
				}
				elsif($kicked_to <= 20 && $kick_yards > 15) {
					$pom = '-';
				}
				elsif($kicked_to <= 25 && $kick_yards > 20) {
					$pom = '-';
				}
				elsif($kicked_to <= 30 && $kick_yards > 25) {
					$pom = 'o';
				}
				elsif($kicked_to <= 35 && $kick_yards > 30) {
					$pom = 'o';
				}
				elsif($kicked_to <= 45 && $kick_yards > 35) {
					$pom = '+';
				}
				elsif($kicked_to > 45) {
					$pom = '+';
				}

			}
			elsif($ball_pos >= 20) {
				if($kicked_to <= 0) {
					$pom = '-';
				}
				elsif($kicked_to <= 10 && $kick_yards > 0) {
					$pom = '-';
				}
				elsif($kicked_to <= 20 && $kick_yards > 10) {
					$pom = '-';
				}
				elsif($kicked_to <= 30 && $kick_yards > 20) {
					$pom = '-';
				}
				elsif($kicked_to <= 35 && $kick_yards > 30) {
					$pom = 'o';
				}
				elsif($kicked_to <= 40 && $kick_yards > 35) {
					$pom = '+';
				}
				elsif($kicked_to <= 45 && $kick_yards > 40) {
					$pom = '+';
				}
				elsif($kicked_to <= 50 && $kick_yards > 45) {
					$pom = '+';
				}
				elsif($kicked_to > 50) {
					$pom = '+';
				}
			}
		}
	}

	return $pom;
}


sub _get_punt_return_score {
	my $self = shift;
	my $score = '';
	return $score unless $self->b_punt;

	if($self->b_punt) {
		my $to_goal = $self->to_goal;
		my $ball_pos = (100-$to_goal);
		my $kick_yards = $self->yards;
		my $kicked_to = ($ball_pos + $kick_yards);
		my $return_yards = $self->return_yards;	
		my $returned_to = $kicked_to - $return_yards;

		if($to_goal <= 50) {
			if($returned_to >= 95) {
				$score = .1;
			}
			elsif($returned_to >= 90 && $returned_to < 95) {
				$score = .08;
			}
			elsif($returned_to >= 85 && $returned_to < 90) {
				$score = .06;
			}
			elsif($returned_to >= 80 && $returned_to < 85) {
				$score = .03;
			}
			elsif($returned_to >= 75 && $returned_to < 80) {
				$score = 0;
			}
			elsif($returned_to >= 70 && $returned_to < 75) {
				$score = -.01;
			}
			elsif($returned_to >= 65 && $returned_to < 70) {
				$score = -.02;
			}
			elsif($returned_to >= 55 && $returned_to < 65) {
				$score = -.05;
			}
			elsif($returned_to >= 45 && $returned_to < 55) {
				$score = -.07;
			}
			elsif($returned_to >= 20 && $returned_to < 45) {
				$score = -.09;
			}
			elsif($returned_to >= 10 && $returned_to < 20) {
				$score = -.1;
			}
			elsif($returned_to < 10) {
				$score = -.13;
			}
		}
		else {
			if($ball_pos < 10) {
				if($returned_to == 100) {
					$score = .11;
				}
				elsif($returned_to >= 95 && $returned_to < 100) {
					$score = .09;
				}
				elsif($returned_to >= 90 && $returned_to < 95) {
					$score = .08;
				}
				elsif($returned_to >= 85 && $returned_to < 90) {
					$score = .07;
				}
				elsif($returned_to >= 80 && $returned_to < 85) {
					$score = .04;
				}
				elsif($returned_to >= 75 && $returned_to < 80) {
					$score = .02;
				}
				elsif($returned_to >= 70 && $returned_to < 75) {
					$score = 0;
				}
				elsif($returned_to >= 65 && $returned_to < 70) {
					$score = -.02;
				}
				elsif($returned_to >= 55 && $returned_to < 65) {
					$score = -.04;
				}
				elsif($returned_to >= 65) {
					$score = -.06;
				}

			}
			elsif($ball_pos >= 10 && $ball_pos < 15) {
				if($returned_to == 100) {
					$score = .11;
				}
				elsif($returned_to >= 95 && $returned_to < 100) {
					$score = .09;
				}
				elsif($returned_to >= 90 && $returned_to < 95) {
					$score = .07;
				}
				elsif($returned_to >= 85 && $returned_to < 90) {
					$score = .05;
				}
				elsif($returned_to >= 80 && $returned_to < 85) {
					$score = .03;
				}
				elsif($returned_to >= 75 && $returned_to < 80) {
					$score = .01;
				}
				elsif($returned_to >= 70 && $returned_to < 75) {
					$score = 0;
				}
				elsif($returned_to >= 65 && $returned_to < 70) {
					$score = -.01;
				}
				elsif($returned_to >= 55 && $returned_to < 65) {
					$score = -.03;
				}
				elsif($returned_to >= 65) {
					$score = -.05;
				}

			}
			elsif($ball_pos >= 15 && $ball_pos < 20) {

				if($returned_to == 100) {
					$score = .11;
				}
				elsif($returned_to >= 95 && $returned_to < 100) {
					$score = .08;
				}
				elsif($returned_to >= 90 && $returned_to < 95) {
					$score = .07;
				}
				elsif($returned_to >= 85 && $returned_to < 90) {
					$score = .05;
				}
				elsif($returned_to >= 80 && $returned_to < 85) {
					$score = .05;
				}
				elsif($returned_to >= 75 && $returned_to < 80) {
					$score = .03;
				}
				elsif($returned_to >= 70 && $returned_to < 75) {
					$score = .02;
				}
				elsif($returned_to >= 65 && $returned_to < 70) {
					$score = 0;
				}
				elsif($returned_to >= 55 && $returned_to < 65) {
					$score = -.02;
				}
				elsif($returned_to >= 65) {
					$score = -.04;
				}
			}
			elsif($ball_pos >= 20) {
				if($returned_to == 100) {
					$score = .11;
				}
				elsif($returned_to >= 90 && $returned_to < 100) {
					$score = .08;
				}
				elsif($returned_to >= 80 && $returned_to < 90) {
					$score = .05;
				}
				elsif($returned_to >= 70 && $returned_to < 80) {
					$score = .03;
				}
				elsif($returned_to >= 65 && $returned_to < 70) {
					$score = 0;
				}
				elsif($returned_to >= 60 && $returned_to < 65) {
					$score = -.02;
				}
				elsif($returned_to >= 55 && $returned_to < 60) {
					$score = -.04;
				}
				elsif($returned_to >= 50 && $returned_to < 55) {
					$score = -.06;
				}
				elsif($returned_to < 50) {
					$score = -.08;
				}
			}
		}
	}

	return $score;
}


sub _get_punt_return_pom {
	my $self = shift;
	my $pom = '';
	return $pom unless $self->b_punt;

	if($self->b_punt) {
		my $to_goal = $self->to_goal;
		my $ball_pos = (100-$to_goal);
		my $kick_yards = $self->yards;
		my $kicked_to = ($ball_pos + $kick_yards);
		my $return_yards = $self->return_yards;	
		my $returned_to = $kicked_to - $return_yards;

		if($to_goal <= 50) {
			if($returned_to >= 95) {
				$pom = '+';
			}
			elsif($returned_to >= 90 && $returned_to < 95) {
				$pom = '+';
			}
			elsif($returned_to >= 85 && $returned_to < 90) {
				$pom = '+';
			}
			elsif($returned_to >= 80 && $returned_to < 85) {
				$pom = 'o';
			}
			elsif($returned_to >= 75 && $returned_to < 80) {
				$pom = 'o';
			}
			elsif($returned_to >= 70 && $returned_to < 75) {
				$pom = '-';
			}
			elsif($returned_to >= 65 && $returned_to < 70) {
				$pom = '-';
			}
			elsif($returned_to >= 55 && $returned_to < 65) {
				$pom = '-';
			}
			elsif($returned_to >= 45 && $returned_to < 55) {
				$pom = '-';
			}
			elsif($returned_to >= 20 && $returned_to < 45) {
				$pom = '-';
			}
			elsif($returned_to >= 10 && $returned_to < 20) {
				$pom = '-';
			}
			elsif($returned_to < 10) {
				$pom = '--';
			}
		}
		else {
			if($ball_pos < 10) {
				if($returned_to == 100) {
					$pom = '++';
				}
				elsif($returned_to >= 95 && $returned_to < 100) {
					$pom = '+';
				}
				elsif($returned_to >= 90 && $returned_to < 95) {
					$pom = '+';
				}
				elsif($returned_to >= 85 && $returned_to < 90) {
					$pom = '+';
				}
				elsif($returned_to >= 80 && $returned_to < 85) {
					$pom = '+';
				}
				elsif($returned_to >= 75 && $returned_to < 80) {
					$pom = '+';
				}
				elsif($returned_to >= 70 && $returned_to < 75) {
					$pom = 'o';
				}
				elsif($returned_to >= 65 && $returned_to < 70) {
					$pom = 'o';
				}
				elsif($returned_to >= 55 && $returned_to < 65) {
					$pom = '-';
				}
				elsif($returned_to >= 65) {
					$pom = '-';
				}

			}
			elsif($ball_pos >= 10 && $ball_pos < 15) {
				if($returned_to == 100) {
					$pom = '++';
				}
				elsif($returned_to >= 95 && $returned_to < 100) {
					$pom = '+';
				}
				elsif($returned_to >= 90 && $returned_to < 95) {
					$pom = '+';
				}
				elsif($returned_to >= 85 && $returned_to < 90) {
					$pom = '+';
				}
				elsif($returned_to >= 80 && $returned_to < 85) {
					$pom = '+';
				}
				elsif($returned_to >= 75 && $returned_to < 80) {
					$pom = '+';
				}
				elsif($returned_to >= 70 && $returned_to < 75) {
					$pom = 'o';
				}
				elsif($returned_to >= 65 && $returned_to < 70) {
					$pom = 'o';
				}
				elsif($returned_to >= 55 && $returned_to < 65) {
					$pom = '-';
				}
				elsif($returned_to >= 65) {
					$pom = '-';
				}

			}
			elsif($ball_pos >= 15 && $ball_pos < 20) {

				if($returned_to == 100) {
					$pom = '++';
				}
				elsif($returned_to >= 95 && $returned_to < 100) {
					$pom = '+';
				}
				elsif($returned_to >= 90 && $returned_to < 95) {
					$pom = '+';
				}
				elsif($returned_to >= 85 && $returned_to < 90) {
					$pom = '+';
				}
				elsif($returned_to >= 80 && $returned_to < 85) {
					$pom = '+';
				}
				elsif($returned_to >= 75 && $returned_to < 80) {
					$pom = '+';
				}
				elsif($returned_to >= 70 && $returned_to < 75) {
					$pom = 'o';
				}
				elsif($returned_to >= 65 && $returned_to < 70) {
					$pom = 'o';
				}
				elsif($returned_to >= 55 && $returned_to < 65) {
					$pom = '-';
				}
				elsif($returned_to >= 65) {
					$pom = '-';
				}


			}
			elsif($ball_pos >= 20) {
				if($returned_to == 100) {
					$pom = '++';
				}
				elsif($returned_to >= 90 && $returned_to < 100) {
					$pom = '+';
				}
				elsif($returned_to >= 80 && $returned_to < 90) {
					$pom = '+';
				}
				elsif($returned_to >= 70 && $returned_to < 80) {
					$pom = '+';
				}
				elsif($returned_to >= 65 && $returned_to < 70) {
					$pom = 'o';
				}
				elsif($returned_to >= 60 && $returned_to < 65) {
					$pom = '-';
				}
				elsif($returned_to >= 55 && $returned_to < 60) {
					$pom = '-';
				}
				elsif($returned_to >= 50 && $returned_to < 55) {
					$pom = '-';
				}
				elsif($returned_to < 50) {
					$pom = '-';
				}
			}
		}
	}

	return $pom;
}
1;