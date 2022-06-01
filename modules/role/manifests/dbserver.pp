class role::dbserver {
    include profile::base
    include ::icinga2::node
    include profile::dbbackups
    include mariadb
}
