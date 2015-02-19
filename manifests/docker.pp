# Docker specific setup
class kibana3::docker {
  if($::virtual == 'physical') {

    class{'supervisor':
      service_enable => false
    }

    supervisor::service { 'nginx':
      ensure          => present,
      command         => '/usr/sbin/nginx -g "daemon off;" -c /etc/nginx/nginx.conf',
      environment     => '',
      user            => 'root',
      group           => 'root',
      autorestart     => true,
      stderr_logfile  => '/var/log/nginx_err.log',
      stdout_logfile  => '/var/log/nginx_out.log',
      redirect_stderr => true,
      stopsignal      => 'QUIT'
    }

    file { '/usr/local/bin/elasticsearch':
      ensure=> file,
      mode  => '0777',
      source=> 'puppet:///modules/kibana3/elasticsearch.sh',
      owner => root,
      group => root,
    } ->

    supervisor::service { 'elasticsearch':
      ensure          => present,
      command         => '/usr/local/bin/elasticsearch',
      environment     => '',
      user            => 'root',
      group           => 'root',
      priority        => '1',
      autorestart     => true,
      stderr_logfile  => '/var/log/elasticsearch_err.log',
      stdout_logfile  => '/var/log/elasticsearch_out.log',
      redirect_stderr => true,
      stopsignal      => 'QUIT'
    }


    supervisor::service { 'logstash':
      ensure          => present,
      command         => '/opt/logstash/bin/logstash agent -f /etc/logstash/conf.d/logstash.conf --log /var/log/logstash.log -vvv',
      environment     => '',
      user            => 'root',
      priority        => '3',
      group           => 'root',
      autorestart     => true,
      stderr_logfile  => '/var/log/logstash_err.log',
      stdout_logfile  => '/var/log/logstash_out.log',
      redirect_stderr => true,
      stopsignal      => 'QUIT'
    }

  }
}
