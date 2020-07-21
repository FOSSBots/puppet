node '100.node4.net.fosshost.org' {
  include role::webserver
  include users
  include cron_puppet
  include motd
  include ufw
}
node '112.node1.net.fosshost.org' {
  include cron_puppet
  include users
  include role::webserver
  include motd
  include role::toolserver
<<<<<<< HEAD
  include ufw
=======
  include phabricator
>>>>>>> e65e66e213ff12d266d945a6c1fb3323e84f698b
}
node '113.node1.net.fosshost.org' {
  include cron_puppet
  include users
  include motd
  include ufw
}
