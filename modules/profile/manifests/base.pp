class role::base {	
    include users
    include puppet
    include motd
    include ufw
}
