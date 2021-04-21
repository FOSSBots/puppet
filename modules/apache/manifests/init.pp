class apache {
    package { 'apache2':
        ensure => present,
    }

    service { 'apache2':
        ensure  => running,
        require => Package['apache2'],
    }

    file { '/etc/apache2/sites-available/mirahezebots.org-le-ssl.conf':
        ensure  => file,
        path    => '/etc/apache2/sites-available/mirahezebots.org-le-ssl.conf',
        source  => 'puppet:///modules/apache/mirahezebots.org-le-ssl.conf',
        mode    => '774',
        owner   => root,
        group   => root,
    }

    file { '/etc/apache2/sites-available/www.mirahezebots.org-le-ssl.conf':
        ensure  => file,
        path    => '/etc/apache2/sites-available/www.mirahezebots.org-le-ssl.conf',
        source  => 'puppet:///modules/apache/www.mirahezebots.org-le-ssl.conf',
        mode    => '774',
        owner   => root,
        group   => root,
    }

    if $trusted['hostname'] == 'bots1.miraheaebots.org' {

        file { '/etc/apache2/sites-available/bots1.mirahezebots.org-le-ssl.conf':
            ensure  => file,
            path    => '/etc/apache2/sites-available/bots1.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/bots1.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/sopel.mirahezebots.org-le-ssl.conf':
            ensure  => file,
            path    => '/etc/apache2/sites-available/sopel.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/sopel.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/100.node4.net.fosshost.org-le-ssl.conf':
            ensure  => file,
            path    => '/etc/apache2/sites-available/100.node4.net.fosshost.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/100.node4.net.fosshost.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }
    }

    if $trusted['hostname'] == 'tools1.miraheaebots.org' {

        file { '/etc/apache2/sites-available/icinga.mirahezebots.org-le-ssl.conf':
            ensure  => file,
            path    => '/etc/apache2/sites-available/icinga.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/icinga.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/phabdigests.mirahezebots.org-le-ssl.conf':
            ensure  => file,
            path    => '/etc/apache2/sites-available/phabdigests.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/phabdigests.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/phab.mirahezebots.org-le-ssl.conf':
            ensure  => file,
            path    => '/etc/apache2/sites-available/phab.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/phab.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/phab-storage.mirahezebots.org-le-ssl.conf':
            ensure  => file,
            path    => '/etc/apache2/sites-available/phab-storage.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/phab-storage.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/tools1.mirahezebots.org-le-ssl.conf':
            ensure  => file,
            path    => '/etc/apache2/sites-available/tools1.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/tools1.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/webmail.mirahezebots.org-le-ssl.conf':
            ensure  => file,
            path    => '/etc/apache2/sites-available/webmail.mirahezebots.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/webmail.mirahezebots.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }

        file { '/etc/apache2/sites-available/112.node1.net.fosshost.org-le-ssl.conf':
            ensure  => file,
            path    => '/etc/apache2/sites-available/112.node1.net.fosshost.org-le-ssl.conf',
            source  => 'puppet:///modules/apache/112.node1.net.fosshost.org-le-ssl.conf',
            mode    => '774',
            owner   => root,
            group   => root,
        }
    }

    file { '/etc/apache2/apache2.conf':
        ensure  => file,
        path    => '/etc/apache2/apache2.conf',
        source  => 'puppet:///modules/apache/apache2.conf',
        mode    => '774',
        owner   => root,
        group   => root,
    }
}
