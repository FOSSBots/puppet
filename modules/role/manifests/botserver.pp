class role::botserver {	
    include sopel
    include ::profile::base
    include ::profile::web
    include ::profile::discordirc
    include streambot
    include ::icinga2::node
}
