# == Class staticweb
#
# Installs the staticweb tool for blackbox testing an HTTP server.
#
class profile::web(
    $install_dir = '/var/www/',
){
 
    git::clone { 'MirahezeBots/bots-web':
        directory => $install_dir,
        branch    => 'master',
        recurse_submodules => true,
    }
}
