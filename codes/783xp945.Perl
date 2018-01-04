File: ht.pl 

#!/usr/bin/perl

use HTML::Template;

my $base_dir = $ARGV[0];
my $tmpl_dir = "$base_dir/template";

opendir(my $dh, $tmpl_dir) || die "Can't opendir $base_dir: $!";
my @files = grep { /\.html$/ && -f "$tmpl_dir/$_" } readdir($dh);
closedir $dh;

for my $file (@files) {
    HTML::Template->new(
        path => $tmpl_dir,
        filename => "$file",
        cache => 1,
    );
}

exit;

File: htc.pl 

#!/usr/bin/perl

use HTML::Template::Compiled;

my $base_dir = $ARGV[0];
my $tmpl_dir = "$base_dir/template";
my $cache_dir = "$base_dir/cache/template";

opendir(my $dh, $tmpl_dir) || die "Can't opendir $tmpl_dir: $!";
my @files = grep { /\.html$/ && -f "$tmpl_dir/$_" } readdir($dh);
closedir $dh;

HTML::Template::Compiled->precompile(
    path => $tmpl_dir,
    file_cache => 1,
    file_cache_dir => $cache_dir,
    filenames => \@files,
);

exit;

File: htc_preload.pl

#!/usr/bin/perl

use HTML::Template::Compiled;

my $base_dir = $ARGV[0];
my $cache_dir = "$base_dir/cache/template";

HTML::Template::Compiled->preload($cache_dir);

Testing:

$ perl -Mfeature=say -MHTML::Template::Compiled -e'say $HTML::Template::Compiled::VERSION'
1.003

$ perl htc.pl $PWD

$ /usr/bin/time -av perl ht.pl $PWD 2>&1 | grep 'Maximum resident'
	Maximum resident set size (kbytes): 21064

$ /usr/bin/time -av perl htc_preload.pl $PWD 2>&1 | grep 'Maximum resident'
	Maximum resident set size (kbytes): 85632