class profile::discordirc(){
    $discordmh_token = lookup('passwords::discord::mh')
    $discordmhlibera_password = lookup('passwords::irc::mhlibera')
    $discordfh_token = lookup('passwords::discord::fh')
    $discordfhfn_token = lookup('passwords::discord::fhfn')
    $discordfh_password = lookup('passwords::irc::fh')
    $discordfhlibera_password = lookup('passwords::irc::fhlibera')
    $discordbuff_token = lookup('passwords::discord::buff')

    users::user { 'relays':
        ensure     => present,
        uid        => 996,
        gid        => 996,
        comment    => 'Discord<->IRC Relay System Account',
        system     => true,
        homedir    => '/discord-irc'
    }

    $relays = ['fhfreenode', 'fhlibera', 'mhlibera', 'buff']
    $relays.each |$relay| {
    $description = "Discord-IRC (${relay})"
    $exec = "npm start -- --config /discord-irc/${relay}config.json"

    systemd::service { "discordirc${relay}":
        ensure  => present,
        content => systemd_template("discordirc"),
        restart => true,
        require => [File["/discord-irc/${relay}config.json"], User['relays']],
    }
    
    file { "/discord-irc/${relay}config.json":
        ensure  => present,
        content => template("profile/${relay}config.json"),
        notify  => Service["discordirc${relay}"],
        mode    => '770',
        owner   => relays,
        group   => relays,
        require => User['relays']
    }
}
}
