  my @sslv_versions = qw/sslv3 tlsv1 sslv2/;

    foreach my $sslv (@sslv_versions){
        my $ua = LWP::UserAgent->new;

        $ua->ssl_opts( verify_hostnames => 1,  SSL_version => $sslv );
        $ua->agent("MyApp/0.1 ");

        $res = $ua->post( $self->url, $self->body )->decoded_content;

        $res = Encode::encode( 'UTF-8', $res );
        $res =~ s/encoding="ISO-8859-1"//i;

        $res = XMLin($res);

        if ($res->{autorizacao}{codigo} == 4){
           return $res;
        }
        if ($sslv3 == $sslv_versions[-1]){
           return $res;
        }
    }