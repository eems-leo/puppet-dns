# == Class dns::server::params
#
class dns::server::params {
  case $::osfamily {
    'Debian': {
      $cfg_dir             = '/etc/bind'
      $cfg_file            = '/etc/bind/named.conf'
      $cfg_file_template   = "${module_name}/deb.named.conf.erb"
      $replace_cfg_file    = false
      $data_dir            = '/etc/bind/zones'
      $working_dir         = '/var/cache/bind'
      $group               = 'bind'
      $owner               = 'bind'
      $package             = 'bind9'
      $service             = 'bind9'
      $necessary_packages  = [ 'bind9', 'dnssec-tools' ]
    }
    'RedHat': {
      $cfg_dir            = '/etc/named'
      $cfg_file           = '/etc/named.conf'
      $cfg_file_template  = "${module_name}/rhel.named.conf.erb"
      $replace_cfg_file   = true
      $data_dir           = '/var/named'
      $working_dir        = '/var/named'
      $group              = 'named'
      $owner              = 'named'
      $package            = 'bind'
      $service            = 'named'
      case $::operatingsystemmajrelease {
        '7': {
          $necessary_packages = [ 'bind', ]
        }
        default: {
          $necessary_packages = [ 'bind', 'dnssec-tools' ]
        }
      }
    }
    default: {
      fail("dns::server is incompatible with this osfamily: ${::osfamily}")
    }
  }
}
