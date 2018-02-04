	elsif($_[0] =~ m/do you know what is/i){
	@words = split(' ',$_[0]);
	shift(@words);
	shift(@words);
	shift(@words);
	shift(@words);
	shift(@words);
	$unknown = join(' ', @words);
	$definition = &define($unknown);
	return "ES";
	}
	elsif($_[0] =~ /do you know what\s.{1,}\sis/i){
	@words = split(' ',$_[0]);
	shift(@words);
	shift(@words);
	shift(@words);
	shift(@words);
	pop(@words);
	$unknown = join(' ', @words);
	$definition = &define($unknown);
	return $definition;
	}