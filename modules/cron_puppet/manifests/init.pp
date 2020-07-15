class cron_puppet {
    cron { 'puppet-pull':
        ensure  => present,
        command => "cd /etc/puppet/code ; /usr/bin/git pull ; sudo /usr/bin/puppet apply /etc/puppet/code/manifests/site.pp",
        user    => root,
        minute  => '*/10',
    }
}
