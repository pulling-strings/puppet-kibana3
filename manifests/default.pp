# Setting up a default instance (mainly to be used from Celestial)
class kibana3::default {
  include 'kibana3'

  class{'jdk':
    version => '7'
  } -> Package['logstash']

  class { 'elasticsearch':
    manage_repo  => true,
    repo_version => '1.4',
  }

  elasticsearch::instance { 'kibana3':
    config                     => {
      'http.cors.enabled'      => true,
      'http.cors.allow-origin' => '"*"'
    }
  }
}
