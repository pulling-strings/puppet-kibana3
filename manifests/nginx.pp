# Kibana3 nginx setup
class kibana3::nginx {

  class {'::nginx': }

  nginx::resource::vhost { $::hostname:
    ensure   => present,
    www_root => '/usr/src/kibana-3.1.0',
    require  => Archive['kibana-3.1.0']
  }
}
