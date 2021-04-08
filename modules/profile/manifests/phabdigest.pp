class profile::phabdigest(
    $install_dir = '/srv/phabdigest',
){
 
    git::clone { 'MirahezeBots/phabdigests':
        ensure    => 'latest',
        directory => $install_dir,
        branch    => 'master',
        shared    => true,
    }
    systemd::timer::job { 'phabdigest-bots-weekly':
        ensure      => present,
        description => 'Weekly PhabDigest for botsphab',
        command     => "/usr/bin/python3 /srv/phabdigest/script.py /srv/phabdigest/weekly.csv bots",
        user        => root,
        monitoring_enabled => true,
        interval    => {'start' => 'OnCalendar', 'interval' => 'Mon *-*-* 15:00:00'},
    }
}
