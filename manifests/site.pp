node '100.node4.net.fosshost.org' {
  include role::botserver
  include profile::discordirc
}
node '112.node1.net.fosshost.org' {
  include role::toolserver
}
node '113.node1.net.fosshost.org' {
  include profile::base
}
