class profile::web(
    $install_dir = '/srv/phabdigest',
){
 
    git::clone { 'MirahezeBots/phabdigests':
        ensure    => 'latest',
        directory => $install_dir,
        branch    => 'master',
    }
}
