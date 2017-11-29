# zoneminder own install
class zoneminder::install {
  package {'zoneminder':
    ensure => present,
  }

  exec{'chmod zm.conf':
    command => 'chmod 740 /etc/zm/zm.conf',
    user    => 'root',
    path    => ['/bin',],
    notify  => Service['zoneminder']
  }

  exec{'chown zm.conf':
    command => 'chown root:www-data /etc/zm/zm.conf' ,
    user    => 'root',
    path    => ['/bin',],
    notify  => Service['zoneminder']
  }

  exec{'chmod /usr/share/zoneminder':
    command => 'chown -R www-data:www-data /usr/share/zoneminder/',
    user    => 'root',
    path    => ['/bin',],
    notify  => Service['zoneminder']
  }
}
