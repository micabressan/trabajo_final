my $now= DateTime->now(time_zone=>"America/New_York" );
my $db = DBIx::DataStore->new('sitecontent');
my $items = MMFA::Item->find(db => $db, 
            types => ['countyfair','struppblog'], 
            query => 'full',
            env => 'production',
            inc_comments => 1,
            to => $now,
            tags => \@tags,
            page => $page,
            per_page => $per_page);