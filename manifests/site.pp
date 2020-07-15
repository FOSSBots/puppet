node '100.node4.net.fosshost.org' {
  include role::webserver
  include cron_puppet
}
node '112.node1.net.fosshost.org' {
  include cron_puppet
  include users
  include role::webserver
}
