class profile::discordirc{
    $discordmh_token = lookup('passwords::discord::mh')
    $discordmh_password = lookup('passwords::irc::mh')
    $discordfh_token = lookup('passwords::discord::fh')
    $discordfh_password = lookup('passwords::irc::fh')

    file { '/discord-irc/mhconfig.json':
        ensure  => present,
        content => template('profile/mhconfig.json'),
    }
    
    file { '/discord-irc/fhconfig.json':
        ensure  => present,
        content => template('profile/fhconfig.json'),
    }
}
