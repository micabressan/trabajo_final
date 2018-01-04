                    if ( CHECK_CRC32 ) {
                        delete @$heap{'crc32','valid_crc32','invalid_crc'};

                        $$heap{filename} =~ /[[(]([a-f0-9]{8})[])]\.\w+$/i;
                        $$heap{valid_crc32} = lc $1 if defined $1;

                        if ( $$heap{valid_crc32} && is_file( $$heap{filename} ) ) {
                            my $fh = file_open( '<', $$heap{filename} );
                            $$heap{crc_checking} = 1;
                            my $i = 0;
                            my $c = 0;
                            while ( sysread $fh, my $buf, 4096 ) {
                                $$heap{crc32} = crc32( $buf, $$heap{crc32} );
                                $$heap{pos} += length $buf;
                                unless ($i++) {
                                    print(" $c $i\n");
                                    $c++;
                                    $kernel->call( $session, 'file_progress' ) ;
                                }
                                $i %= 50;
                            }
                            close $fh;
                            $$heap{crc_checking} = 0;
                            # stop the progress display from compensating
                            $$heap{have_size} = 0;
                            print " $c $i out of loop\n";
                        }
                    }