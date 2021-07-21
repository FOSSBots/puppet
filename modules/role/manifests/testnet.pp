class role::testnet {	
    include ::profile::base
    include ::profile::web
    include ::icinga2::node
    include ::role::toolserver
}
