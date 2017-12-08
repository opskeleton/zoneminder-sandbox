node default {

  include zoneminder

  include baseline::mirror
  include baseline::update

  if $operatingsystem == 'Ubuntu' {
    Service {
      provider => systemd
    }
  }



}
