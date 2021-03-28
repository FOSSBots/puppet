class roundcubemail{
    $db_user_password      = lookup('passwords::webmail::db'),
    $roundcubemail_des_key = lookup('passwords::webmail::des'),

    git::clone { 'roundcubemail':
        directory          => '/var/webmail',
        origin             => 'https://github.com/roundcube/roundcubemail',
        branch             => '1.4.11', # we are using the beta for the new skin
        recurse_submodules => true,
        owner              => 'www-data',
        group              => 'www-data',
    }

    file { '/var/webmail/config/config.inc.php':
        ensure => present,
        content => template('roundcube/config.inc.php.erb'),
        owner  => 'www-data',
        group  => 'www-data',
        require => Git::Clone['roundcubemail'],
    }
}
