package Plugins::Crawler::checkUploadForm;

sub new {
    my $class    = shift;
    my $self     = {name => "checkUploadForm"};
	our %upload : shared = ();
	our $enabled = 1;

    return bless $self, $class;
}

sub execute {
    my $self = shift;
	my $url = shift;
	my $content = shift;
	while($content =~ m/<input(.+?)>/gi){
		my $params = $1;
		if($params =~ /type *= *"file"/i){
			$upload{$url}++;
		}
	}
	

}


sub showResults(){
	my $self = shift;
	print "|\n| File Upload Forms:\n";
	foreach my $url (%upload){
		print "| [+] Upload Form Found: ". $url . " " . $upload{$url} . "x times\n" if($upload{$url});
	}
}

sub getResults(){
	my $self = shift;
	return %upload;
}

sub clean(){
	my $self = shift;
	%upload = ();
}

sub status(){
	my $self = shift;
	return $enabled;
}

1;