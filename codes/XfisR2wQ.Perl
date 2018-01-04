		if(my $b = $all_current_home_plays->search({ b_pass => 1 })) {
			my $count = $b->count;
			if($count >0) {
				#CALCULATIONS NEEDING A PASS PLAY TO OCCUR
				my $completes = $count - $b->search({ b_incomplete => 1 })->count;
				my $sum = $b->get_column('yards')->sum;
				my $ints = $b->search({ b_intercepted => 1 })->count;

				$stats{HT_QB_Average_Yards} = $sum / $count;
				$stats{HT_Overall_Yards_Per_Pass} = $sum / $count;

				my $p18 = $b->search({ yards => {'>=', 1 } })->search({ yards => {'<=', 8} })->count;
				my $p917 = $b->search({ yards => {'>', 8 } })->search({ yards => {'<=', 17} })->count;
				my $p18100 = $b->search({ yards => {'>', 17 } })->count;

				$stats{HT_Passing_1_to_8_Percent} = $p18 / $count;
				$stats{HT_Passing_9_to_17_Percent} = $p917 / $count;
				$stats{HT_Passing_18_to_100_Percent} = $p18100 / $count;

				$home_pass_td = $all_current_home_plays->search({ b_touchdown => 1 })->count;

				if(my $c = $b->search({ down => 1 })) {
					my $acount = $c->count;

					if($acount > 0) {
						my $ccompletes = $count - $c->search({ b_incomplete => 1 })->count;
						my $csum = $c->get_column('yards')->sum;
						my $cints = $c->search({ b_intercepted => 1 })->count;

						$stats{HTO_QB_1st_Efficiency} = ((8.4*$csum)+(330+$home_pass_td)-(200*$cints)+(100*$ccompletes)) / $acount;
						$stats{HTO_1st_YPP} = $csum / $acount;	

						my $totals;
						while(my $d = $c->next) {
							$totals += $d->_get_pass_score;
						}
	
						$stats{HTO_1st_Pass_Score_Avg} = $totals / $acount;
					}
				}
				if(my $c = $b->search({ down => 2 })) {
					my $acount = $c->count;
					if($acount > 0) {
						$stats{HTO_2nd_YPP} = $c->get_column('yards')->sum / $acount;

						my $totals;
						while(my $d = $c->next) {
							$totals += $d->_get_pass_score;
						}
	
						$stats{HTO_2nd_Pass_Score_Avg} = $totals / $acount;
					}
				}
				if(my $c = $b->search({ down => 3 })) {
					my $acount = $c->count;

					if($acount > 0) {
						my $ccompletes = $count - $c->search({ b_incomplete => 1 })->count;
						my $csum = $c->get_column('yards')->sum;
						my $cints = $c->search({ b_intercepted => 1 })->count;
						$stats{HTO_3rd_YPP} = $csum / $acount;	

						$stats{HTO_QB_3rd_Efficiency} = ((8.4*$csum)+(330+$home_pass_td)-(200*$cints)+(100*$ccompletes)) / $acount;
					}
				}


				
				$stats{HT_QB_Efficiency_Total} = ((8.4*$sum)+(330+$home_pass_td)-(200*$ints)+(100*$completes)) / $count;
			}				
		}