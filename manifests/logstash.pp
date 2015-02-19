# Setting up logstash for streaming data into Kibana
class kibana3::logstash {

  class { '::logstash':
    init_defaults_file => 'puppet:///modules/kibana3/logstash',
    manage_repo        => true,
    repo_version       => '1.4'

  }

  logstash::configfile { 'elastic_output':
    source => 'puppet:///modules/kibana3/elastic_output',
    order  => 10
  }

  logstash::configfile { 'gelf_input':
    source => 'puppet:///modules/kibana3/gelf_input',
    order  => 10
  }

  logstash::configfile { 'tcp_input':
    source => 'puppet:///modules/kibana3/tcp_input',
    order  => 10
  }

  file_line { 'logstash LS_USER':
    ensure => absent,
    path   => '/etc/default/logstash',
    line   => 'LS_USER=logstash'
  } ->

  file_line { 'root LS_USER':
    path => '/etc/default/logstash',
    line => 'LS_USER=root'
  } ~> Service['logstash']
}
