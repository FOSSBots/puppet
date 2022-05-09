class profile::dbbackups {
    systemd::timer::job { 'backup-db':
        ensure      => present,
        description => 'Backup Database',
        command     => "/usr/bin/backup-db",
        user        => root,
        interval    => {'start' => 'OnCalendar', 'interval' => '*/7 *-*-* *:*:*'},
    }
    file { 'db-backup-script':
        ensure  => file,
        path    => '/usr/bin/backup-db',
        source  => 'puppet:///modules/profile/backup-db.sh',
        mode    => '777',
        owner   => root,
        group   => root,
    }
}
