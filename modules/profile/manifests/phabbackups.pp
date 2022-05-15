class profile::phabbackups {
    systemd::timer::job { 'backup-phab':
        ensure      => present,
        description => 'Backup Phabricator',
        command     => "/usr/bin/backup-phab",
        user        => root,
        interval    => {'start' => 'OnCalendar', 'interval' => 'Tue *-*-* 10:00:00'},
    }
    file { 'db-backup-script':
        ensure  => file,
        path    => '/usr/bin/backup-phab',
        source  => 'puppet:///modules/profile/backup-phab.sh',
        mode    => '777',
        owner   => root,
        group   => root,
    }
}
