class profile::sopeldev(
){
  file { 'userconfig':
        ensure  => file,
        path    => '/srv/sopelbots/devrequire.txt',
        source  => 'puppet:///modules/profile/devrequire.txt',
        mode    => '2755',
        owner   => root,
        group   => root,
    }
  file { 'post-hook':
        ensure  => file,
        path    => '/srv/sopelbots/devcode/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-dev',
        mode    => 0755,
        owner   => root,
        group   => root,
    }
    git::clone { 'MirahezeBots/MirahezeBots':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode',
        branch    => 'dev',
    }
}
