class profile::phabdigest(
    $install_dir = '/srv/phabdigest',
){
 
    git::clone { 'MirahezeBots/phabdigests':
        ensure    => 'latest',
        directory => $install_dir,
        branch    => 'master',
    }
}
