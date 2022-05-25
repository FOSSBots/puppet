class profile::botsbackups {
    systemd::timer::job { 'backup-bots':
        ensure      => present,
        description => 'Backup Bots',
        command     => "/usr/bin/backup-bots",
        user        => root,
        interval    => {'start' => 'OnCalendar', 'interval' => '* *-*-* 08:00:00'},
    }
    file { 'bots-backup-script':
        ensure  => file,
        path    => '/usr/bin/backup-bots',
        source  => 'puppet:///modules/profile/backup-bots.sh',
        mode    => '777',
        owner   => root,
        group   => root,
    }
}
