class puppet {
    systemd::timer::job { 'run-puppet':
        ensure      => present,
        description => 'Puppet 10 Minute run',
        command     => "/usr/bin/puppet-run",
        user        => root,
        interval    => {'start' => 'OnCalendar', 'interval' => '*-*-* *:00/10:00'},
    }
    file { 'puppet-run':
        ensure  => file,
        path    => '/usr/bin/puppet-run',
        source  => 'puppet:///modules/puppet/puppet-run.sh',
        mode    => '770',
        owner   => sopel,
        group   => sopel,
        notify  => Exec['update dev'],
    }
}
