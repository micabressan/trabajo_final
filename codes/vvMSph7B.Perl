# Change all AUTO_INCREMENT fields to SERIAL ones with a pre-defined sequence
                if(/([\W\d_]+)\sint.*auto_increment/i) {
                my $collname = $`;
                $collname =~ s/`//g;
                $collname =~ s/^\s+//g;
                $tmpseq=new_name("$table_name"."_"."$collname"."_SEQ",28);
                $tmpseq =~ s/"//g;
                $seq{$table_name}=$tmpseq;
                $primary{$table_name}=$+;
                s/(int.*?) .*?AUTO_INCREMENT/$1 DEFAULT nextval\('$tmpseq'\)/i;
                s/\),/\) NOT NULL,/;
                }