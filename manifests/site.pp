node 'bots2002.fossbots.org' {
  include role::botserver
}
node 'tools2002.fossbots.org' {
  include role::toolserver
  include ::icinga2::master
}
node 'db2002.fossbots.org' {
  include profile::base
  include ::icinga2::node
  include profile::dbbackups
}

node 'dr3001.fossbots.org' {
  include profile::discordirc
  include profile::base
}
