node '100.node4.net.fosshost.org' {
  include role::webserver
  include profile::base
  include role::sopeltest
  include profile::discordirc
}
node '112.node1.net.fosshost.org' {
  include role::webserver
  include role::toolserver
  include profile::base
  include phabricator
  include roundcube
}
node '113.node1.net.fosshost.org' {
  include profile::base
}
