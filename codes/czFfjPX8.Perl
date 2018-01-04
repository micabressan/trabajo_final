my @f = ("a", "b", "c");

for (my $i = 0; $i < 3; $i++)
{
	for (my $j = 0; $j < 3; $j++)
	{
		for (my $k = 0; $k < 3; $k++)
		{
			for (my $l = 0; $l < 3; $l++)
			{
				for (my $n = 0; $n < 3; $n++)
				{
					for (my $m = 0; $m < 3; $m++)
					{
						for (my $o = 0; $o < 3; $o++)
						{
							for (my $p = 0; $p < 3; $p++)
							{
								my $string = $f[$i];
								$string .= $f[$j];
								$string .= $f[$k];
								$string .= $f[$l];
								$string .= $f[$n];
								$string .= $f[$m];
								$string .= $f[$o];
								$string .= $f[$p];
								if (($string =~ m/a/) && ($string =~ m/b/) && ($string =~ m/c/))
								{
									print "$string\n";
								}
							}
						}
					}
				}
			}
		}
	}
}