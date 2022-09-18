class apache {
    package { 'apache2':
        ensure => present,
    }

    service { 'apache2':
        ensure  => running,
        require => Package['apache2'],
    }

    exec { 'mod_remoteip':
        creates => '/etc/apache2/mods-enabled/remoteip.load',
        require => Package['apache2'],
        command => '/usr/sbin/a2enmod remoteip',
    }

    file { '/etc/apache2/conf-available/cloudflare.conf':
        ensure  => present,
        path    => '/etc/apache2/conf-available/cloudflare.conf',
        source  => 'puppet:///modules/apache/cloudflare.conf',
        mode    => '774',
        owner   => root,
        group   => root,
    }
    -> exec { 'conf_cloudflare':
        creates => '/etc/apache2/conf-enabled/cloudflare.conf',
        require => Package['apache2'],
        command => '/usr/sbin/a2enconf cloudflare',
    }

    file { '/etc/apache2/sites-available/mirahezebots.org-le-ssl.conf':
        ensure  => present,
        path    => '/etc/apache2/sites-available/mirahezebots.org-le-ssl.conf',
        source  => 'puppet:///modules/apache/mirahezebots.org-le-ssl.conf',
        mode    => '774',
        owner   => root,
        group   => root,
    }
    
    file { '/etc/apache2/sites-available/fossbots.org-le-ssl.conf':
        ensure  => present,
        path    => '/etc/apache2/sites-available/fossbots.org-le-ssl.conf',
        source  => 'puppet:///modules/apache/fossbots.org-le-ssl.conf',
        mode    => '774',
        owner   => root,
        group   => root,
    }

    file { '/etc/apache2/sites-available/www.mirahezebots.org-le-ssl.conf':
        ensure  => present,
        path    => '/etc/apache2/sites-available/www.mirahezebots.org-le-ssl.conf',
        source  => 'puppet:///modules/apache/www.mirahezebots.org-le-ssl.conf',
        mode    => '774',
        owner   => root,
        group   => root,
    }

    if $trusted['hostname'] == 'bots2002.mirahezebots.org' {

        file { '/etc/apache2/sites-available/bots1.mirahezebots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/bots1.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/bots1.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/sopel.mirahezebots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/sopel.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/sopel.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/100.node4.net.fosshost.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/100.node4.net.fosshost.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/100.node4.net.fosshost.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }
        
        file { '/etc/apache2/sites-available/sopel.fossbots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/sopel.fossbots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/sopel.fossbots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }
    }

    if $trusted['hostname'] == 'tools3001.fossbots.org' or $trusted['hostname'] == 'tools2002.fossbots.org' {

        file { '/etc/apache2/sites-available/icinga.mirahezebots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/icinga.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/icinga.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/phabdigests.mirahezebots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/phabdigests.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/phabdigests.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/phab.mirahezebots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/phab.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/phab.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/phab-storage.mirahezebots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/phab-storage.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/phab-storage.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/tools1.mirahezebots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/tools1.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/tools1.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }
        
        file { '/etc/apache2/sites-available/icinga.fossbots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/icinga.fossbots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/icinga.fossbots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/phabdigests.fossbots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/phabdigests.fossbots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/phabdigests.fossbots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/phab.fossbots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/phab.fossbots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/phab.fossbots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/phab-storage.fossbots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/phab-storage.fossbots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/phab-storage.fossbots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/webmail.mirahezebots.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/webmail.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/webmail.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/112.node1.net.fosshost.org-le-ssl.conf':
            ensure  => present,
            path    => '/etc/apache2/sites-available/112.node1.net.fosshost.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/112.node1.net.fosshost.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }
    }

    file { '/etc/apache2/apache2.conf':
        ensure  => present,
        path    => '/etc/apache2/apache2.conf',
        source  => 'puppet:///modules/apache/apache2.conf',
        mode    => '774',
        owner   => root,
        group   => root,
    }
}
