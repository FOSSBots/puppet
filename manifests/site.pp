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
  include mariadb
}
node 'bots3001.fossbots.org' {
  include role::botserver
}
node 'tools3001.fossbots.org' {
  include role::toolserver
  include ::icinga2::master
}
node 'db3001.fossbots.org' {
  include profile::base
  include ::icinga2::node
  include profile::dbbackups
  include mariadb
}
