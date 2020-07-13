# == Class staticweb
#
# Installs the staticweb tool for blackbox testing an HTTP server.
#
class web(
    Stdlib::Unixpath $install_dir = '/var/www/',
){
 
    git::clone { 'MirahezeBots/bots-web':
        directory => $install_dir,
        branch    => 'master',
    }
}
