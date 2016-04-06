
class varnish {
    
    package { 'varnish':
      ensure => 'present',
    }
    service { 'varnish':
      ensure  => 'running',
      require => Package['varnish'],
    }
    file { '/etc/varnish/default.vcl':
      ensure  => 'present',
      require => Package['varnish'],
      content => template('default.vcl.erb'),
      notify  => Service['varnish'],
    }
    file { '/etc/default/varnish':
      ensure  => 'present',
      require => Package['varnish'],
      source  => 'puppet///modules/varnish/varnish',
      notify  => Service['varnish'],
    }

}

## my params file

class varnish::params {
    $host = '111.11.11.111'
}


##Template files

backend default {
    .host = "<%= @host %>";
    .port = "80";
    .probe = {
        .url = "/";
        .timeout = 0.1s;
        .interval = 1s;
        .window = 10;
        .threshold = 8;
    }
}

##Structure

cain@puppet:/etc/puppet/cain/varnish$ tree
.
├── manifests
│   ├── init.pp
│   └── params.pp
└── templates
    └── default.vcl.erb

##Error 
Could not find template 'default.vcl.erb' at /etc/puppet/cain/varnish/manifests/init.pp:15