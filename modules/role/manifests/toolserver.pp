class role::toolserver {	
    include ::profile::phabdigest
    include ::profile::base
    include ::profile::web
    include phabricator
}
