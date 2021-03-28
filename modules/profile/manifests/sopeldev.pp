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
        path    => '/srv/sopelbots/devcode/sopel-adminlist/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-dev-adminlist',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    file { 'post-dev-channelmgnt-hook':
        ensure  => file,
        path    => '/srv/sopelbots/devcode/sopel-channelmgnt/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-dev-channelmgnt',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    file { 'post-dev-jsonparser-hook':
        ensure  => file,
        path    => '/srv/sopelbots/devcode/jsonparser/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-dev-jsonparser',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    file { 'post-dev-pingpong-hook':
        ensure  => file,
        path    => '/srv/sopelbots/devcode/sopel-pingpong/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-dev-pingpong',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    file { 'post-dev-joinall-hook':
        ensure  => file,
        path    => '/srv/sopelbots/devcode/sopel-joinall/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-dev-joinall',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    file { 'dev-directory':
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
        recurse_submodules => true,
    }
    git::clone { 'MirahezeBots/sopel-adminlist':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/sopel-adminlist',
        branch    => 'dev',
        recurse_submodules => true,
    }
    git::clone { 'MirahezeBots/sopel-channelmgnt':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/sopel-channelmgnt',
        branch    => 'dev',
        recurse_submodules => true,
    }
    git::clone { 'MirahezeBots/jsonparser':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/jsonparser',
        branch    => 'dev',
        recurse_submodules => true,
    }
    git::clone { 'MirahezeBots/sopel-pingpong':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/sopel-pingpong',
        branch    => 'dev',
        recurse_submodules => true,
    }
    git::clone { 'MirahezeBots/sopel-joinall':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/sopel-joinall',
        branch    => 'dev',
        recurse_submodules => true,
    }
    exec { 'rebuild sopel':
        command     => 'cd /srv/sopelbots/devcode/sopel && sudo rm -rf /srv/sopelbots/devocde/sopel/dist/*.whl /srv/sopelbots/devocde/sopel/build/*.whl && sudo /srv/sopelbots/devvenv/bin/pyproject-build --wheel --outdir dist . && find dist -name "*.whl" | xargs sudo /srv/sopelbots/devvenv/bin/pip3.7 install --no-dependencies --force-reinstall',
    }
    git::clone { 'MirahezeBots/sopel':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/sopel',
        branch    => 'Testing',
        recurse_submodules => true,
        notify => Exec['rebuild sopel']
    }
    file { 'post-dev-sopel-hook':
        ensure  => absent,
        path    => '/srv/sopelbots/devcode/sopel/.git/hooks/post-merge',
    }
}
