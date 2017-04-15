# == Class: snmp::params
#
# This class handles OS-specific configuration of the snmp module.  It
# looks for variables in top scope (probably from an ENC such as Dashboard).  If
# the variable doesn't exist in top scope, it falls back to a hard coded default
# value.
#
# === Authors:
#
# Mike Arnold <mike@razorsedge.org>
#
# === Copyright:
#
# Copyright (C) 2012 Mike Arnold, unless otherwise noted.
#
class snmp::params {
  # If we have a top scope variable defined, use it, otherwise fall back to a
  # hardcoded value.
  if getvar('::snmp_agentaddress') {
    $agentaddress = $::snmp_agentaddress
  } else {
    $agentaddress = [ 'udp:127.0.0.1:161', 'udp6:[::1]:161' ]
  }

  if getvar('::snmp_snmptrapdaddr') {
    $snmptrapdaddr = $::snmp_snmptrapdaddr
  } else {
    $snmptrapdaddr =  [ 'udp:127.0.0.1:162', 'udp6:[::1]:162' ]
  }

  if getvar('::snmp_ro_community') {
    $ro_community = $::snmp_ro_community
  } else {
    $ro_community =  'public'
  }

  if getvar('::snmp_ro_community6') {
    $ro_community6 = $::snmp_ro_community6
  } else {
    $ro_community6 =  'public'
  }

  if getvar('::snmp_rw_community') {
    $rw_community = $::snmp_rw_community
  } else {
    $rw_community =  undef
  }

  if getvar('::snmp_rw_community6') {
    $rw_community6 =  $::snmp_rw_community6
  } else {
    $rw_community6 =  undef
  }

  if getvar('::snmp_ro_network') {
    $ro_network =  $::snmp_ro_network
  } else {
    $ro_network =  '127.0.0.1'
  }

  if getvar('::snmp_ro_network6') {
    $ro_network6 =  $::snmp_ro_network6
  } else {
    $ro_network6 =  '::1'
  }

  if getvar('::snmp_rw_network') {
    $rw_network =  $::snmp_rw_network
  } else {
    $rw_network =  '127.0.0.1'
  }

  if getvar('::snmp_rw_network6') {
    $rw_network6 =  $::snmp_rw_network6
  } else {
    $rw_network6 =  '::1'
  }

  if getvar('::snmp_contact') {
    $contact =  $::snmp_contact
  } else {
    $contact =  'Unknown'
  }

  if getvar('::snmp_location') {
    $location =  $::snmp_location
  } else {
    $location =  'Unknown'
  }

  if getvar('::snmp_sysname') {
    $sysname =  $::snmp_sysname
  } else {
    $sysname =  $::fqdn
  }

  if getvar('::snmp_com2sec') {
    $com2sec =  $::snmp_com2sec
  } else {
    $com2sec =  [ 'notConfigUser  default       public', ]
  }

  if getvar('::snmp_com2sec6') {
    $com2sec6 =  $::snmp_com2sec6
  } else {
    $com2sec6 =  [ 'notConfigUser  default       public', ]
  }

  if getvar('::snmp_groups') {
    $groups =  $::snmp_groups
  } else {
    $groups =  [
      'notConfigGroup v1            notConfigUser',
      'notConfigGroup v2c           notConfigUser',
    ]
  }

  if getvar('::snmp_services') {
    $services =  $::snmp_services
  } else {
    $services =  72
  }

  if getvar('::openmanage_enable') {
    $openmanage_enable =  $::openmanage_enable
  } else {
    $openmanage_enable =  false
  }

  if getvar('::snmp_views') {
    $views =  $::snmp_views
  } else {
    $views =  [
      'systemview    included   .1.3.6.1.2.1.1',
      'systemview    included   .1.3.6.1.2.1.25.1.1',
    ]
  }

  if getvar('::snmp_accesses') {
    $accesses =  $::snmp_accesses
  } else {
    $accesses =  [
      'notConfigGroup ""      any       noauth    exact  systemview none  none',
    ]
  }

  if getvar('::snmp_dlmod') {
    $dlmod =  $::snmp_dlmod
  } else {
    $dlmod =  []
  }

  if getvar('::snmp_disable_authorization') {
    $disable_authorization =  $::snmp_disable_authorization
  } else {
    $disable_authorization =  'no'
  }

  if getvar('::snmp_do_not_log_traps') {
    $do_not_log_traps =  $::snmp_do_not_log_traps
  } else {
    $do_not_log_traps =  'no'
  }

  if getvar('::snmp_do_not_log_tcpwrappers') {
    $do_not_log_tcpwrappers =  $::snmp_do_not_log_tcpwrappers
  } else {
    $do_not_log_tcpwrappers =  'no'
  }

  if getvar('::snmp_trap_handlers') {
    $trap_handlers =  $::snmp_trap_handlers
  } else {
    $trap_handlers =  []
  }

  if getvar('::snmp_trap_forwards') {
    $trap_forwards =  $::snmp_trap_forwards
  } else {
    $trap_forwards =  []
  }

  if getvar('::snmp_snmp_config') {
    $snmp_config =  $::snmp_snmp_config
  } else {
    $snmp_config =  []
  }

  if getvar('::snmp_snmpd_config') {
    $snmpd_config =  $::snmp_snmpd_config
  } else {
    $snmpd_config =  []
  }

  if getvar('::snmp_snmptrapd_config') {
    $snmptrapd_config =  $::snmp_snmptrapd_config
  } else {
    $snmptrapd_config =  []
  }

### The following parameters should not need to be changed.

  if getvar('::snmp_ensure') {
    $ensure =  $::snmp_ensure
  } else {
    $ensure =  'present'
  }

  if getvar('::snmp_service_ensure') {
    $service_ensure =  $::snmp_service_ensure
  } else {
    $service_ensure =  'running'
  }

  if getvar('::snmp_trap_service_ensure') {
    $trap_service_ensure =  $::snmp_trap_service_ensure
  } else {
    $trap_service_ensure =  'stopped'
  }

  # Since the top scope variable could be a string (if from an ENC), we might
  # need to convert it to a boolean.
  if getvar('::snmp_autoupgrade') {
    $autoupgrade =  $::snmp_autoupgrade
  } else {
    $autoupgrade =  false
  }
  if is_string($autoupgrade) {
    $safe_autoupgrade = str2bool($autoupgrade)
  } else {
    $safe_autoupgrade = $autoupgrade
  }

  if getvar('::snmp_install_client') {
    $install_client =  $::snmp_install_client
  } else {
    $install_client =  undef
  }

  if getvar('::snmp_manage_client') {
    $manage_client =  $::snmp_manage_client
  } else {
    $manage_client =  false
  }
  if is_string($manage_client) {
    $safe_manage_client = str2bool($manage_client)
  } else {
    $safe_manage_client = $manage_client
  }

  if getvar('::snmp_service_enable') {
    $service_enable =  $::snmp_service_enable
  } else {
    $service_enable =  true
  }
  if is_string($service_enable) {
    $safe_service_enable = str2bool($service_enable)
  } else {
    $safe_service_enable = $service_enable
  }

  if getvar('::snmp_service_hasstatus') {
    $service_hasstatus =  $::snmp_service_hasstatus
  } else {
    $service_hasstatus =  true
  }
  if is_string($service_hasstatus) {
    $safe_service_hasstatus = str2bool($service_hasstatus)
  } else {
    $safe_service_hasstatus = $service_hasstatus
  }

  if getvar('::snmp_service_hasrestart') {
    $service_hasrestart =  $::snmp_service_hasrestart
  } else {
    $service_hasrestart =  true
  }
  if is_string($service_hasrestart) {
    $safe_service_hasrestart = str2bool($service_hasrestart)
  } else {
    $safe_service_hasrestart = $service_hasrestart
  }

  if getvar('::snmp_trap_service_enable') {
    $trap_service_enable =  $::snmp_trap_service_enable
  } else {
    $trap_service_enable =  false
  }
  if is_string($trap_service_enable) {
    $safe_trap_service_enable = str2bool($trap_service_enable)
  } else {
    $safe_trap_service_enable = $trap_service_enable
  }

  if getvar('::snmp_trap_service_hasstatus') {
    $trap_service_hasstatus =  $::snmp_trap_service_hasstatus
  } else {
    $trap_service_hasstatus =  true
  }
  if is_string($trap_service_hasstatus) {
    $safe_trap_service_hasstatus = str2bool($trap_service_hasstatus)
  } else {
    $safe_trap_service_hasstatus = $trap_service_hasstatus
  }

  if getvar('::snmp_trap_service_hasrestart') {
    $trap_service_hasrestart =  $::snmp_trap_service_hasrestart
  } else {
    $trap_service_hasrestart =  true
  }
  if is_string($trap_service_hasrestart) {
    $safe_trap_service_hasrestart = str2bool($trap_service_hasrestart)
  } else {
    $safe_trap_service_hasrestart = $trap_service_hasrestart
  }

  if getvar('::snmp_proxy') {
    $proxy = $::snmp_proxy
  } else {
    $proxy   = []
  }

  if getvar('::snmp_master') {
    $master = $::snmp_master
  } else {
    $master = 'agentx'
  }

  if getvar('::snmp_rwusers') {
    $rwusers = $::snmp_rwusers
  } else {
    $rwusers = []
  }

  case $::osfamily {
    'RedHat': {
      if getvar('::operatingsystemmajrelease') { # facter 1.7+
        $majdistrelease = $::operatingsystemmajrelease
      } elsif getvar('::lsbmajdistrelease') {    # requires LSB to already be installed
        $majdistrelease = $::lsbmajdistrelease
      } else {
        $majdistrelease = regsubst($::operatingsystemrelease,'^(\d+)\.(\d+)','\1')
      }
      case $::operatingsystem {
        'Fedora': {
          $snmpd_options     = '-LS0-6d'
          $snmptrapd_options = '-Lsd'
          $sysconfig         = '/etc/sysconfig/snmpd'
          $trap_sysconfig    = '/etc/sysconfig/snmptrapd'
          $var_net_snmp      = '/var/lib/net-snmp'
          $varnetsnmp_perms  = '0755'
        }
        default: {
          if $majdistrelease <= '5' {
            $snmpd_options     = '-Lsd -Lf /dev/null -p /var/run/snmpd.pid -a'
            $sysconfig         = '/etc/sysconfig/snmpd.options'
            $trap_sysconfig    = '/etc/sysconfig/snmptrapd.options'
            $var_net_snmp      = '/var/net-snmp'
            $varnetsnmp_perms  = '0700'
            $snmptrapd_options = '-Lsd -p /var/run/snmptrapd.pid'
          } elsif $majdistrelease == '6' {
            $snmpd_options     = '-LS0-6d -Lf /dev/null -p /var/run/snmpd.pid'
            $sysconfig         = '/etc/sysconfig/snmpd'
            $trap_sysconfig    = '/etc/sysconfig/snmptrapd'
            $var_net_snmp      = '/var/lib/net-snmp'
            $varnetsnmp_perms  = '0755'
            $snmptrapd_options = '-Lsd -p /var/run/snmptrapd.pid'
          } else {
            $snmpd_options     = '-LS0-6d'
            $sysconfig         = '/etc/sysconfig/snmpd'
            $trap_sysconfig    = '/etc/sysconfig/snmptrapd'
            $var_net_snmp      = '/var/lib/net-snmp'
            $varnetsnmp_perms  = '0755'
            $snmptrapd_options = '-Lsd'
          }
        }
      }
      $package_name             = 'net-snmp'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0644'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $varnetsnmp_owner         = 'root'
      $varnetsnmp_group         = 'root'

      $client_package_name      = 'net-snmp-utils'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'snmptrapd'
    }
    'Debian': {
      $package_name             = 'snmpd'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0600'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $snmpd_options            = '-Lsd -Lf /dev/null -u snmp -g snmp -I -smux -p /var/run/snmpd.pid'
      $sysconfig                = '/etc/default/snmpd'
      $var_net_snmp             = '/var/lib/snmp'
      $varnetsnmp_perms         = '0755'
      $varnetsnmp_owner         = 'snmp'
      $varnetsnmp_group         = 'snmp'

      $client_package_name      = 'snmp'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_name        = 'snmptrapd'
      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $snmptrapd_options        = '-Lsd -p /var/run/snmptrapd.pid'
    }
    'Suse': {
      $package_name             = 'net-snmp'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0600'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $snmpd_options            = 'd'
      $sysconfig                = '/etc/sysconfig/net-snmp'
      $var_net_snmp             = '/var/lib/net-snmp'
      $varnetsnmp_perms         = '0755'
      $varnetsnmp_owner         = 'root'
      $varnetsnmp_group         = 'root'

      $client_package_name      = 'net-snmp'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'snmptrapd'
      $snmptrapd_options        = undef
    }
    'FreeBSD': {
      $package_name             = 'net-mgmt/net-snmp'
      $service_config_dir_path  = '/usr/local/etc/snmp'
      $service_config_dir_perms = '0755'
      $service_config_dir_owner = 'root'
      $service_config_dir_group = 'wheel'
      $service_config           = '/usr/local/etc/snmp/snmpd.conf'
      $service_config_perms     = '0755'
      $service_name             = 'snmpd'
      $snmpd_options            = 'd'
      $var_net_snmp             = '/var/net-snmp'
      $varnetsnmp_perms         = '0600'
      $varnetsnmp_owner         = 'root'
      $varnetsnmp_group         = 'wheel'

      $client_package_name      = 'net-mgmt/net-snmp'
      $client_config            = '/usr/local/etc/snmp/snmp.conf'

      $trap_service_config      = '/usr/local/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'snmptrapd'
      $snmptrapd_options        = undef
    }
    default: {
      fail("Module ${::module} is not supported on ${::operatingsystem}")
    }
  }
}
