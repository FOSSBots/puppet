class profile::toolsbackups {
    systemd::timer::job { 'backup-phab':
        ensure      => present,
        description => 'Backup Phabricator',
        command     => "/usr/bin/backup-phab",
        user        => root,
        interval    => {'start' => 'OnCalendar', 'interval' => '* *-*-* 10:00:00'},
    }
    file { 'phab-backup-script':
        ensure  => file,
        path    => '/usr/bin/backup-phab',
        source  => 'puppet:///modules/profile/backup-phab.sh',
        mode    => '777',
        owner   => root,
        group   => root,
    }
    systemd::timer::job { 'backup-phab-digest':
        ensure      => present,
        description => 'Backup Phabricator',
        command     => "/usr/bin/backup-phab-digest",
        user        => root,
        interval    => {'start' => 'OnCalendar', 'interval' => 'Tue *-*-* 11:00:00'},
    }
    file { 'digest-backup-script':
        ensure  => file,
        path    => '/usr/bin/backup-phab-digest',
        source  => 'puppet:///modules/profile/backup-digest.sh',
        mode    => '777',
        owner   => root,
        group   => root,
    }
}
