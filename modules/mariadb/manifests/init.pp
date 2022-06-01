class apache {
    package { 'mariadb-server':
        ensure => present,
    }

    service { 'mysql':
        ensure  => running,
        require => Package['mariadb-server'],
    }

    file { '/etc/mysql/mariadb.conf.d/50-server.cnf':
        ensure  => present,
        path    => '/etc/mysql/mariadb.conf.d/50-server.cnf',
        content  => template('mariadb/50-server.cnf'),
        mode    => '774',
        owner   => root,
        group   => root,
    }
}
