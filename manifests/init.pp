# Sets up a kibana3 instance
class kibana3(
  $version = '3.1.2'
){

  $archive = "kibana-${version}"

  include kibana3::nginx
  include kibana3::logstash

  if($::virtual == 'docker') {
    include kibana3::runit
  }

  $url = "https://download.elasticsearch.org/kibana/kibana/${archive}.zip"

  ensure_resource('package',['curl','unzip'],{ensure => present})

  Exec {
    path => ['/usr/bin/', '/bin']
  }

  archive { $archive:
    ensure         => present,
    checksum       => false,
    url            => $url,
    target         => '/usr/src',
    allow_insecure => true,
    extension      => 'zip',
    require        => [Package['curl'],Package['unzip']]
  }
}
