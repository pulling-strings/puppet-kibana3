# Sets up a kibana3 instance
class kibana3 {

  include kibana3::nginx
  include kibana3::logstash

  if($::virtual == 'docker') {
    include kibana3::runit
  }

  $url = 'https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.zip'

  package{['curl','unzip']:
    ensure  => present
  }

  Exec {
    path => ['/usr/bin/', '/bin']
  }

  archive { 'kibana-3.1.0':
    ensure         => present,
    checksum       => false,
    url            => $url,
    target         => '/usr/src',
    allow_insecure => true,
    extension      => 'zip',
    require        => [Package['curl'],Package['unzip']]
  }
}
