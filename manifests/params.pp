class ntp::params {

  $autoupdate        = false
  $config_template   = 'ntp/ntp.conf.erb'
  $disable_monitor   = false
  $keys_enable       = false
  $keys_controlkey   = ''
  $keys_requestkey   = ''
  $keys_trusted      = []
  $preferred_servers = []
  $service_enable    = true
  $service_ensure    = 'running'
  $service_manage    = true
  $udlc              = false
  $interfaces        = []

  # On virtual machines allow large clock skews.
  $panic = str2bool($::is_virtual) ? {
    true    => false,
    default => true,
  }

  case $::osfamily {
    'AIX': {
      $config = '/etc/ntp.conf'
      $keys_file = '/etc/ntp.keys'
      $driftfile = '/etc/ntp.drift'
      $package_name = [ 'bos.net.tcp.client' ]
      $package_ensure    = 'present'
      $restrict          = [
        'default nomodify notrap nopeer noquery',
        '127.0.0.1',
      ]
      $service_name = 'xntpd'
      $servers = [
        '0.debian.pool.ntp.org iburst',
        '1.debian.pool.ntp.org iburst',
        '2.debian.pool.ntp.org iburst',
        '3.debian.pool.ntp.org iburst',
      ]
    }
    'Debian': {
      $config          = '/etc/ntp.conf'
      $keys_file       = '/etc/ntp/keys'
      $driftfile       = '/var/lib/ntp/drift'
      $package_name    = [ 'ntp' ]
      $package_ensure    = 'present'
      $restrict          = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = 'ntp'
      $servers         = [
        '0.debian.pool.ntp.org iburst',
        '1.debian.pool.ntp.org iburst',
        '2.debian.pool.ntp.org iburst',
        '3.debian.pool.ntp.org iburst',
      ]
    }
    'RedHat': {
      $config          = '/etc/ntp.conf'
      $driftfile       = '/var/lib/ntp/drift'
      $keys_file       = '/etc/ntp/keys'
      $package_name    = [ 'ntp' ]
      $package_ensure    = 'present'
      $restrict          = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = 'ntpd'
      $servers         = [
        '0.centos.pool.ntp.org',
        '1.centos.pool.ntp.org',
        '2.centos.pool.ntp.org',
      ]
    }
    'SuSE': {
      $config          = '/etc/ntp.conf'
      $driftfile       = '/var/lib/ntp/drift/ntp.drift'
      $keys_file       = '/etc/ntp/keys'
      $package_name    = [ 'ntp' ]
      $package_ensure    = 'present'
      $restrict          = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = 'ntp'
      $servers         = [
        '0.opensuse.pool.ntp.org',
        '1.opensuse.pool.ntp.org',
        '2.opensuse.pool.ntp.org',
        '3.opensuse.pool.ntp.org',
      ]
    }
    'FreeBSD': {
      $config          = '/etc/ntp.conf'
      $driftfile       = '/var/db/ntpd.drift'
      $keys_file       = '/etc/ntp/keys'
      $package_name    = ['net/ntp']
      $package_ensure    = 'present'
      $restrict          = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = 'ntpd'
      $servers         = [
        '0.freebsd.pool.ntp.org iburst maxpoll 9',
        '1.freebsd.pool.ntp.org iburst maxpoll 9',
        '2.freebsd.pool.ntp.org iburst maxpoll 9',
        '3.freebsd.pool.ntp.org iburst maxpoll 9',
      ]
    }
    'Archlinux': {
      $config          = '/etc/ntp.conf'
      $driftfile       = '/var/lib/ntp/drift'
      $keys_file       = '/etc/ntp/keys'
      $package_name    = [ 'ntp' ]
      $package_ensure    = 'present'
      $restrict          = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = 'ntpd'
      $servers         = [
        '0.pool.ntp.org',
        '1.pool.ntp.org',
        '2.pool.ntp.org',
      ]
    }
    'Solaris': {
      $config       = '/etc/inet/ntp.conf'
      $driftfile    = '/var/ntp/ntp.drift'
      $keys_file    = '/etc/inet/ntp.keys'
      $package_name = [ 'SUNWntpr', 'SUNWntpu' ]
      $package_ensure    = 'present'
      $restrict     = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name = 'network/ntp'
      $servers      = [
        '0.pool.ntp.org',
        '1.pool.ntp.org',
        '2.pool.ntp.org',
        '3.pool.ntp.org',
      ]
    }
    # Gentoo was added as its own $::osfamily in Facter 1.7.0
    'Gentoo': {
      $config          = '/etc/ntp.conf'
      $driftfile       = '/var/lib/ntp/drift'
      $keys_file       = '/etc/ntp/keys'
      $package_name    = ['net-misc/ntp']
      $package_ensure    = 'present'
      $restrict          = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = 'ntpd'
      $servers         = [
        '0.gentoo.pool.ntp.org',
        '1.gentoo.pool.ntp.org',
        '2.gentoo.pool.ntp.org',
        '3.gentoo.pool.ntp.org',
      ]
    }
    'Darwin': {
      $config          = '/etc/ntp.conf'
      $driftfile       = '/var/db/ntp.drift'
      $keys_file       = '/etc/ntp/keys'
      $package_name    = [ 'ntp' ]
      $package_ensure    = 'absent'
      $restrict          = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = 'org.ntp.ntpd'
      $servers         = [
        'time.apple.com',
      ]
    }
    'Linux': {
      # Account for distributions that don't have $::osfamily specific settings.
      # Before Facter 1.7.0 Gentoo did not have its own $::osfamily
      case $::operatingsystem {
        'Gentoo': {
          $config          = '/etc/ntp.conf'
          $driftfile       = '/var/lib/ntp/drift'
          $keys_file       = '/etc/ntp/keys'
          $package_name    = ['net-misc/ntp']
          $package_ensure    = 'present'
          $restrict          = [
            'default kod nomodify notrap nopeer noquery',
            '-6 default kod nomodify notrap nopeer noquery',
            '127.0.0.1',
            '-6 ::1',
          ]
          $service_name    = 'ntpd'
          $servers         = [
            '0.gentoo.pool.ntp.org',
            '1.gentoo.pool.ntp.org',
            '2.gentoo.pool.ntp.org',
            '3.gentoo.pool.ntp.org',
          ]
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} distribution.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
