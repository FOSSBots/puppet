class role::botserver {	
    include sopel
    include ::profile::base
    include ::profile::web
    include ::profile::discordirc
    include streambot
}
