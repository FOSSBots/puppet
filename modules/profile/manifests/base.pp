class role::base {	
    include users
    include cron_puppet
    include motd
    include ufw
}
