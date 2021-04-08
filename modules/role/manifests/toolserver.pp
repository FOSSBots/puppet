class role::toolserver {
    include ::profile::phabdigest
    include ::profile::base
    include ::profile::web
    include phabricator
    include roundcube
    include nrpe
    include monitoring
}
