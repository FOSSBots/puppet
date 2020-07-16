class profile::phabdigest(
    $install_dir = '/srv/phabdigest',
){
 
    git::clone { 'MirahezeBots/phabdigests':
        ensure    => 'latest',
        directory => $install_dir,
        branch    => 'master',
        shared    => true,
    }
    cron { 'phabdigest-bots-weekly':
        ensure      => present,
        command     => " cd /srv/phabdigest ; sudo python3 /srv/phabdigest/script.py weekly bots",
        user        => root,
        minute      => '0',
        hour        => '15',
        monthday    => '1',
        month       => '*',
        weekday     => '*',
    }
}
