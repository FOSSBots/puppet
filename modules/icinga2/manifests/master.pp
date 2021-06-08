class icinga2::master{
    package { 'icinga2':
        ensure => present,
    }

    service { 'icinga':
        ensure  => running,
        require => Package['icinga2'],
    }
    
    file { '/etc/icinga2/conf.d/commands.conf':
        ensure  => present,
        content => template('icinga/commands.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
    
    file { '/etc/icinga2/conf.d/notifications.conf':
        ensure  => present,
        content => template('icinga/notifications.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
    
    file { '/etc/icinga2/conf.d/services.conf':
        ensure  => present,
        content => template('icinga/services.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
    
    file { '/etc/icinga2/conf.d/templates.conf':
        ensure  => present,
        content => template('icinga/templates.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
    
    file { '/etc/icinga2/conf.d/users.conf':
        ensure  => present,
        content => template('icinga/users.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
    
    file { '/etc/icinga2/zones.conf':
        ensure  => present,
        content => template('icinga/master-zones.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
    
    file { '/etc/icinga2/zones.d/master/services.conf':
        ensure  => present,
        content => template('icinga/zones.d/master/services.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
    
    file { '/etc/icinga2/zones.d/master/hosts.conf':
        ensure  => present,
        content => template('icinga/zones.d/master/hosts.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
    
    file { '/etc/icinga2/zones.d/global-templates/commands.conf':
        ensure  => present,
        content => template('icinga/zones.d/global-templates/commands.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
}
