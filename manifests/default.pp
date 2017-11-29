node default {

  include apt

  if $operatingsystem == 'Ubuntu' {
    package{'software-properties-common':
      ensure  => present
    } -> Exec <||>

    Service {
      provider => systemd
    }
  }


  # apt::ppa {'ppa:iconnor/zoneminder': }

  package {'zoneminder':
    ensure  => present
  }


}
