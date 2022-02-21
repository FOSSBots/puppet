node 'bots2002.mirahezebots.org' {
  include role::botserver
}
node 'tools2002.mirahezebots.org' {
  include role::toolserver
  include ::icinga2::master
}
node 'db2002.mirahezebots.org' {
  include profile::base
  include ::icinga2::node
}
