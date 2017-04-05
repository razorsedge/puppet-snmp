# == Definition: snmp::snmpv3_user
#
# This definition creates a SNMPv3 user.
#
# === Parameters:
#
# [*title*]
#   Name of the user.
#   Required
#
# [*authpass*]
#   Authentication password for the user.
#   Required
#
# [*authtype*]
#   Authentication type for the user.  SHA or MD5
#   Default: SHA
#
# [*privpass*]
#   Encryption password for the user.
#   Default: no encryption password
#
# [*privtype*]
#   Encryption type for the user.  AES or DES
#   Default: AES
#
# [*daemon*]
#   Which daemon file in which to write the user.  snmpd or snmptrapd
#   Default: snmpd
#
# === Actions:
#
# Creates a SNMPv3 user with authentication and encryption paswords.
#
# === Requires:
#
# Class['snmp']
#
# === Sample Usage:
#
#   snmp::snmpv3_user { 'myuser':
#     authtype => 'MD5',
#     authpass => '1234auth',
#     privpass => '5678priv',
#   }
#
# === Authors:
#
# Mike Arnold <mike@razorsedge.org>
# Michael Watters <wattersm@watters.ws>
#
# === Copyright:
#
# Copyright (C) 2017

define snmp::snmpv3_user (
  Variant[String, Enum['SHA', 'MD5']] $authtype = 'SHA',
  Variant[String, Enum['AES', 'DES']] $privtype = 'AES',
  Variant[String, Enum['snmpd', 'snmptrapd']] $daemon = 'snmpd',
  String $authpass = undef,
  String $privpass = undef,
  ) {

  include ::snmp

  if ($daemon == 'snmptrapd') and ($::osfamily != 'Debian') {
      $service_name   = 'snmptrapd'
      $service_before = Service['snmptrapd']
  }
  else {
      $service_name   = 'snmpd'
      $service_before = Service['snmpd']
  }

  if $privpass {
      $cmd = "createUser ${title} ${authtype} \\\"${authpass}\\\" ${privtype} \\\"${privpass}\\\""
  }
  else {
      $cmd = "createUser ${title} ${authtype} \\\"${authpass}\\\""
  }

  exec { "create-snmpv3-user-${title}":
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      # TODO: Add "rwuser ${title}" (or rouser) to /etc/snmp/${daemon}.conf
      command => "service ${service_name} stop ; sleep 5 ; echo \"${cmd}\" >>${snmp::var_net_snmp}/${daemon}.conf\
          && touch ${snmp::var_net_snmp}/${title}-${daemon}",
      creates => "${snmp::var_net_snmp}/${title}-${daemon}",
      user    => 'root',
      require => [ Package[$snmp::packages], File[$snmp::var_net_snmp], ],
      before  => $service_before,
  }
}
