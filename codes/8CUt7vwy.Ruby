#/etc/puppet/environment/test/modules/test_varnish/manifests/init.pp
#Class that installs the config chosen below
class test_varnish {

    class {'varnish':
        $host = $test_varnish::params::host,
        config  => template('test_varnish/default.vcl.erb'),
        config1 => 'puppet:///modules/test_varnish/varnish',
    }
}

#/etc/puppet/environment/test/modules/test_varnish/templates/default.vcl.erb
backend default {
    .host = "<%= @host =%>";
    .port = "80";
    .probe = {
        .url = "/";
        .timeout = 0.1s;
        .interval = 1s;
        .window = 10;
        .threshold = 8;
    }
}

#/etc/puppet/environment/test/modules/test_varnish/manifests/params.pp
class test_varnish::params {
    if $::gh_node == 'v^[1-4]'{
        $host = 1.1.4.1,
    }
    else {
        $host = 2.2.2.2,
    }
}