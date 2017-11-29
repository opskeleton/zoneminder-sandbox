node default {

  include zoneminder

  if $operatingsystem == 'Ubuntu' {
    Service {
      provider => systemd
    }
  }



}
