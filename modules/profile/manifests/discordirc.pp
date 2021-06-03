class profile::discordirc(){
    $discordmh_token = lookup('passwords::discord::mh')
    $discordmhlibera_password = lookup('passwords::irc::mhlibera')
    $discordfh_token = lookup('passwords::discord::fh')
    $discordfhfn_token = lookup('passwords::discord::fhfn')
    $discordfh_password = lookup('passwords::irc::fh')
    $discordfhlibera_password = lookup('passwords::irc::fhlibera')
    $discordbuff_token = lookup('passwords::discord::buff')

    $relays = ['fhfreenode', 'fhlibera', 'mhlibera', 'buff']
    $relays.each |$relay| {

    systemd::service { "discordirc${relay}":
        ensure  => present,
        content => systemd_template("discordirc${relay}"),
        restart => true,
        require => File["/discord-irc/${relay}config.json"],
    }
    
    file { "/discord-irc/${relay}config.json":
        ensure  => present,
        content => template("profile/${relay}config.json"),
        notify  => Service["discordirc${relay}"],
        mode    => '770',
        owner   => relays,
        group   => relays,
    }
}
}
