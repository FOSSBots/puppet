class role::toolserver {
    include base::service_unit
    include ::profile::phabdigest
    include ::profile::base
    include ::profile::web
    include phabricator
    include roundcube
    include nrpe
    include monitoring
}
