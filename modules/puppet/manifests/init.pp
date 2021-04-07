class puppet {
    systemd::timer::job { 'run-puppet':
        ensure      => present,
        description => 'Puppet 10 Minute run',
        command => "/usr/bin/cd /etc/puppet/code ; /usr/bin/git pull ; /usr/bin/puppet apply /etc/puppet/code/manifests/site.pp > /var/log/puppet.log",
        user    => root,
        interval    => {'start' => 'OnCalendar', 'interval' => '10min'},
    }
}
