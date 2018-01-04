	elsif($_[0] =~ /what is (.*)?/i){
	@words = split(' ',$_[0]);
	@query = splice(@words, 2, @words-1);
	$unknown = join(' ', @query);
	$definition = &define($unknown);
	return "WHAT IS XXX";
	}
	elsif($_[0] =~ /do you know what is/i){
	@words = split(' ',$_[0]);
	@query = splice(@words, 5, @words-1);
	$unknown = join(' ', @query);
	$definition = &define($unknown);
	return "DO YOU KNOW WHAT IS XXX";
	}
	elsif($_[0] =~ /do you know what is (.*)?/i){
	@words = split(' ',$_[0]);
	@query = splice(@words, 4, @words-2);
	$unknown = join(' ', @query);
	$definition = &define($unknown);
	return "DO YOU KNOW WHAT XXX IS";
	}