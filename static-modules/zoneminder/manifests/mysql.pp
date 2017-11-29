# Setting up mysql for zoneminder
class zoneminder::mysql {

  exec{'/etc/mysql/my.cnf':
    command => '/bin/mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/my.cnf',
    user    => 'root',
    onlyif  => '/usr/bin/test -f /etc/mysql/mysql.conf.d/mysqld.cnf'
  }

  file_line { 'no-subs':
    path    => '/etc/mysql/my.cnf',
    line    => 'sql_mode = NO_ENGINE_SUBSTITUTION',
    require => Exec['/etc/mysql/my.cnf'],
    notify  => Service['mysql']
  }

  service{'mysql':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

  exec{'zm_create':
    command => 'mysql -uroot < /usr/share/zoneminder/db/zm_create.sql',
    user    => 'root',
    path    => ['/usr/bin'],
    notify  => Service['zoneminder'],
    require => [Exec['/etc/mysql/my.cnf'], Service['mysql']]
  }

  $grant = 'grant select,insert,update,delete,create,alter,index,lock tables on zm.*'

  exec{'grant':
    command => "mysql -uroot -e \"${grant} to 'zmuser'@localhost identified by 'zmpass';\"",
    user    => 'root',
    path    => ['/usr/bin'],
    notify  => Service['zoneminder'],
    require => [Exec['/etc/mysql/my.cnf'], Service['mysql']]
  }
}
