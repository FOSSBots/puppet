class profile::discordirc(){
    $discordmh_token = lookup('passwords::discord::mh')
    $discordmhlibera_password = lookup('passwords::irc::mhlibera')
    $discordfh_token = lookup('passwords::discord::fh')
    $discordfhlibera_password = lookup('passwords::irc::fhlibera')
    $discordbuff_token = lookup('passwords::discord::buff')
    $discordballmedia_token = lookup('passwords::discord::ballmedia')
    $zulipphorge_token = lookup('passwords::zulip::phorge')

    users::user { 'relays':
        ensure     => present,
        uid        => 996,
        comment    => 'Discord<->IRC Relay System Account',
        system     => true,
        homedir    => '/discord-irc',
        shell      => '/bin/sh',
    }

    $relays = ['fhlibera', 'mhlibera', 'buff', 'ballmedia']
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
    file { "/srv/matterbridge/matterbridge.toml":
        ensure  => present,
        content => template("profile/matterbridge.toml"),
        notify  => Service["matterbridge"],
        mode    => '770',
        owner   => relays,
        group   => relays,
        require => User['relays']
    }
    
    systemd::service { 'matterbridge':
        ensure  => present,
        content => systemd_template('matterbridge'),
        restart => true,
        require => [File['/srv/matterbridge/matterbridge.toml'], User['relays']],
    }
}
