# class: phabricator
class phabricator {

    require_package(['python3-pygments', 'subversion'])

    git::clone{ 'phab-fork':
        ensure    => present,
        directory => '/var/phab-deploy',
        origin    => 'https://github.com/FOSSBots/phabricator-deployment.git',
        branch    => 'wmf/stable',
        recurse_submodules => true,
    }

    file { '/var/phab-deploy/phabricator/src/extensions':
        ensure => link,
        target => '/var/phab-deploy/libext/misc'
        
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
        'amazon-s3.access-key' => lookup('passwords::s3::access'),
        'amazon-s3.secret-key' => lookup('passwords::s3::secret'),
        'amazon-s3.region' => lookup('passwords::s3::region'),
        'amazon-s3.endpoint' => lookup('passwords::s3::endpoint'),
        'storage.s3.bucket' => lookup('passwords::s3::bucket'),
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
        mode    => '444',
        owner   => www-data,
        group   => www-data,
        
    }
}
