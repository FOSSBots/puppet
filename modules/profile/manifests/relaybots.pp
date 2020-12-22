class relay_bot (
	String $secret
) {

	service { 'discordircfh':
		ensure    => running,
		enable    => true
	}
  service { 'discordircmh':
		ensure    => running,
		enable    => true
	}

	file { 'relaybotconfigfh':
		content => template("${module_name}/relay_bot_fh.erb"),
    path    => '/discord-irc/fhconfig2.json',
		notify  => Service['discordircfh'],
    mode    => '0755',
    owner   => root,
    group   => root,
	}
  file { 'relaybotconfigmh':
		content => template("${module_name}/relay_bot_mh.erb"),
    path    => '/discord-irc/mhconfig2.json',
		notify  => Service['discordircmh'],
    mode    => '0755',
    owner   => root,
    group   => root,
	}

}
