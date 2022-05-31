class profile::dbbackups {
    $backups_run = lookup(backups::run)
    systemd::timer::job { 'backup-db':
        ensure      => $backups_run,
        description => 'Backup Database',
        command     => "/usr/bin/backup-db",
        user        => root,
        interval    => {'start' => 'OnCalendar', 'interval' => '*-*-* 09:00:00'},
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
