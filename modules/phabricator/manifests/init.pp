# class: phabricator
class phabricator {

    require_package(['python3-pygments', 'subversion'])
    
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
    git::clone{ 'phab-fork':
        ensure    => present,
        directory => '/var/phab-deploy',
        origin    => 'https://github.com/FOSSBots/phabricator-deployment.git',
        branch    => 'wmf/stable',
        recurse_submodules => true,
    }
    
    file { '/var/phorge-deploy':
        ensure => directory,
        mode   => '0755',
        owner  => 'www-data',
        group  => 'www-data',
    }

    file { '/var/phab-deploy/phabricator/src/extensions':
        ensure => link,
        target => '/var/phab-deploy/libext/misc'
        
    }
    
    git::clone { 'phorge-arcanist':
        ensure    => present,
        directory => '/var/phorge-deploy/arcanist',
        origin    => 'https://we.phorge.it/source/arcanist.git',
    }

    git::clone { 'phorge':
        ensure    => present,
        directory => '/var/phorge-deploy/phorge',
        origin    => 'https://we.phorge.it/source/phorge.git',
    }

    exec { "chk_phorge_ext_git_exist":
        command => 'true',
        path    =>  ['/usr/bin', '/usr/sbin', '/bin'],
        onlyif  => 'test ! -d /var/phorge-deploy/phorge/src/extensions/.git'
    }

    file {'remove_phorge_ext_dir_if_no_git':
        ensure  => absent,
        path    => '/var/phorge-deploy/phorge/src/extensions',
        recurse => true,
        purge   => true,
        force   => true,
        require => Exec['chk_phorge_ext_git_exist'],
    }

    git::clone { 'phorge-extensions':
        ensure    => latest,
        directory => '/var/phorge-deploy/phorge/src/extensions',
        origin    => 'https://github.com/FOSSBots/phabricator-extensions.git',
    }

    file { '/var/phab':
        ensure => directory,
        mode   => '0755',
        owner  => 'www-data',
        group  => 'www-data',
    }

    file {'phab-robots-custom':
        ensure => file,
        path   => '/var/phab/robots.txt',
        source => 'puppet:///modules/phabricator/phabrobot.txt',
        mode   => '0755',
        owner  => 'www-data',
        group  => 'www-data',
    }

    file { '/var/phab/repos':
        ensure => directory,
        mode   => '0755',
        owner  => 'www-data',
        group  => 'www-data',
    }

    $module_path = get_module_path($module_name)
    $phab_yaml = loadyaml("${module_path}/data/config.yaml")
    $phab_private = {
        'mysql.pass' => lookup('passwords::db::phabricator'),
    }

    $phab_setting = {
        # smtp
        'cluster.mailers'      => [
            {
                'key'          => 'mirahezebots-smtp',
                'type'         => 'smtp',
                'options'      => {
                    'host'     => 'smtppro.zoho.eu',
                    'port'     => 587,
                    'user'     => 'noreply@fossbots.org',
                    'password' => lookup('passwords::mail::phab'),
                    'protocol' => 'tls',
                },
            },
        ],
        # database
        'cluster.databases'    => [
            {
                 'host'  => 'db2002.fossbots.org',
                 'role' => 'master',
                 'disabled' => false,
            },
            {
                 'host'  => 'db3001.fossbots.org',
                 'role' => 'replica',
                 'disabled' => false,
            },
        ],
    }

    $phab_settings = merge($phab_yaml, $phab_private, $phab_setting)

    file { '/var/phab-deploy/phabricator/conf/local/local.json':
        ensure  => present,
        content => template('phabricator/local.json.erb'),
        require => Git::Clone['phab-fork'],
        mode    => '440',
        owner   => www-data,
        group   => www-data,
        
    }
    file { '/var/phorge-deploy/phorge/conf/local/local.json':
        ensure  => present,
        content => template('phabricator/local.json.erb'),
        require => Git::Clone['phab-fork'],
        mode    => '440',
        owner   => www-data,
        group   => www-data,
        
    }
}
