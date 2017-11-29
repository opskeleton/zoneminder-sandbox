# Setting up apache for zoneminder
class zoneminder::apache {

  exec{'a2enconf':
    command => '/usr/sbin/a2enconf zoneminder',
    user    => 'root',
    notify  => Service['apache2']
  }

  ['cgi', 'rewrite'].each |String $mod| {
    exec{$mod:
      command => "/usr/sbin/a2enmod ${mod}",
      user    => 'root',
      notify  => Service['apache2']
    }
  }

  service{'apache2':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

  file_line { 'timezone':
    path   => '/etc/php/7.0/apache2/php.ini',
    line   => 'date.timezone = Australia/Sydney',
    notify => Service['apache2']
  }

}
