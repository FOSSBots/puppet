class streambot{
    $streambot_pass = lookup('passwords::streambot::irc')
    $ensure = lookup('streambot::timer')
    git::clone { 'FOSSBots/snitchbot':
        ensure    => $ensure,
        directory => '/srv/streambot',
        branch    => 'master',
        owner     => streambot,
        group     => streambot,
        recurse_submodules => true,
    }
    systemd::service { 'streambot':
        ensure  => $ensure,
        content => systemd_template('streambot'),
        restart => true,
    }
    file { '/srv/streambot/settings.py':
        ensure  => $ensure,
        content => template('streambot/settings.py'),
        notify  => Service['streambot'],
        require => Git::Clone['FOSSBots/snitchbot'],
        mode    => '770',
        owner   => streambot,
        group   => streambot,
    }
}
