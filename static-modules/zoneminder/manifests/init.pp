# setting up zoneminder
class zoneminder {

  include zoneminder::apache
  include zoneminder::mysql

  stage { 'first':
    before => Stage['main'],
  }

  class{'zoneminder::install':
    stage  => 'first'
  }

  service{'zoneminder':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }
}
