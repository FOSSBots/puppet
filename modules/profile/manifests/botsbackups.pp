class profile::botsbackups {
    $backups_run = lookup(backups::run)
    systemd::timer::job { 'backup-bots':
        ensure      => $backups_run,
        description => 'Backup Bots',
        command     => "/usr/bin/backup-bots",
        user        => root,
        interval    => {'start' => 'OnCalendar', 'interval' => '*-*-* 08:00:00'},
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
