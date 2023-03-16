class profile::phabdigest(
    $install_dir = '/srv/phabdigest',
){
    $ensure = lookup('digests::timer')
    git::clone { 'FOSSBots/phabdigests':
        ensure    => $ensure,
        directory => $install_dir,
        branch    => 'main',
        shared    => true,
    }
    systemd::timer::job { 'phabdigest-bots-weekly':
        ensure      => $ensure,
        description => 'Weekly PhabDigest for botsphab',
        command     => "/usr/bin/python3 /srv/phabdigest/script.py /srv/phabdigest/weekly.csv bots",
        user        => root,
        interval    => {'start' => 'OnCalendar', 'interval' => 'Mon *-*-* 15:00:00'},
    }
}
