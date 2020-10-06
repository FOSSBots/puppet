class profile::sopeldev(
){
  file { 'dev-require':
        ensure  => file,
        path    => '/srv/sopelbots/devrequire.txt',
        source  => 'puppet:///modules/profile/devrequire.txt',
        mode    => '2755',
        owner   => root,
        group   => root,
    }
  file { 'post-dev-core-hook':
        ensure  => file,
        path    => '/srv/sopelbots/devcode/core/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-dev-core',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    file { 'post-dev-adminlist-hook':
        ensure  => file,
        path    => '/srv/sopelbots/devcode/adminlist/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-dev-adminlist',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    file { 'post-dev-adminlist-hook':
        ensure  => directory,
        path    => '/srv/sopelbots/devcode/',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    git::clone { 'MirahezeBots/MirahezeBots':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/core',
        branch    => 'dev',
    }
    git::clone { 'MirahezeBots/adminlist':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/adminlist',
        branch    => 'dev',
    }
}
