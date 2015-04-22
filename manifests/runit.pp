# Kibana runit setup
class kibana3::runit {

  file{'/etc/service/logstash':
    ensure => directory,
  } ->

  file { '/etc/service/logstash/run':
    ensure=> file,
    mode  => 'u+x',
    source=> 'puppet:///modules/kibana3/logstash_run',
    owner => root,
    group => root,
  }

  file{'/etc/service/nginx':
    ensure => directory,
  } ->

  file{'/var/log/nginx/':
    ensure => directory,
  } ->

  file { '/etc/service/nginx/run':
    ensure=> file,
    mode  => 'u+x',
    source=> 'puppet:///modules/kibana3/nginx_run',
    owner => root,
    group => root,
  }

  file{'/etc/service/elasticsearch':
    ensure => directory,
  } ->

  file { '/etc/service/elasticsearch/run':
    ensure=> file,
    mode  => 'u+x',
    source=> 'puppet:///modules/kibana3/elasticsearch_run',
    owner => root,
    group => root,
  }


}
