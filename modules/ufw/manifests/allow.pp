# Creates a new allow rule in UFW
define ufw::allow (

  String $port,
  Enum['tcp', 'udp'] $proto = 'tcp',
  String $interface = '',
  String $from = '',
  Enum['present', 'absent'] $ensure = 'present'

) {

  if !defined(Class['ufw']) {
    fail('You must include the UFW base class first')
  }

  $_port_match = inline_template('<%= Regexp.quote(@port) %>')

  $_interface = $interface ? {
    ''      => '',
    default => " on ${interface}"
  }

  $_interface_match = $interface ? {
    ''      => '',
    default => inline_template('<%= " on " + Regexp.quote(@interface) %>')
  }

  $_from = $from ? {
    ''      => '',
    default => " from ${from}"
  }

  $_from_match = $from ? {
    ''      => 'Anywhere',
    'any'   => 'Anywhere',
    default => inline_template('<%= Regexp.quote(@from) %>')
  }

  $_rule   = "allow in${_interface} proto ${proto}${_from} to any port ${port}"
  $_exists = "ufw status | grep -qE '^${_port_match}\\/${proto}${_interface_match} +ALLOW +${_from_match}( +.*)?$'"

  if $ensure == 'present' {

    exec { "ufw-allow-${name}":
      command => "ufw ${_rule}",
      unless  => $_exists,
      path    => '/bin:/usr/bin:/sbin:/usr/sbin',
      require => Package['ufw']
    }

  } else {

    exec { "ufw-delete-${name}":
      command => "ufw delete ${_rule}",
      onlyif  => $_exists,
      path    => '/bin:/usr/bin:/sbin:/usr/sbin',
      require => Package['ufw']
    }

  }

}
