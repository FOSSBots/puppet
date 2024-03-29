class profile::discordirc(){
    $discordmhlibera_password = lookup('passwords::irc::mhlibera')
    $discordfh_token = lookup('passwords::discord::fh')
    $ensure = lookup('bridgebot::timer')

    users::user { 'relays':
        ensure     => $ensure,
        uid        => 996,
        comment    => 'Discord<->IRC Relay System Account',
        system     => true,
        homedir    => '/discord-irc',
        shell      => '/bin/sh',
    }

    file { "/srv/matterbridge/matterbridge.toml":
        ensure  => $ensure,
        content => template("profile/matterbridge.toml"),
        notify  => Service["matterbridge"],
        mode    => '770',
        owner   => relays,
        group   => relays,
        require => User['relays']
    }
    
    systemd::service { 'matterbridge':
        ensure  => $ensure,
        content => systemd_template('matterbridge'),
        restart => true,
        require => [File['/srv/matterbridge/matterbridge.toml'], User['relays']],
    }
}
