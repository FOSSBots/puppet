node 'bots1.mirahezebots.org' {
  include role::botserver
}
node 'tools1.mirahezebots.org' {
  include role::toolserver
}
node 'db1.mirahezebots.org' {
  include profile::base
  include ::icinga2::node
}
node 'test2001.mirahezebots.org' {
  include role::testnet
}
