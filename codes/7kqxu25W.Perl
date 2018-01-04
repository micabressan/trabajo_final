my $config = '';
my $bo_config = 'A';

given ($bo_conf){
        when ('SC_A'){
                $conf = 'ACC';
        }
        when ('SC_B'){
                $conf = 'BUS';
        }
        default {
                $conf = 'DEPT';
        }
}

print "$config";