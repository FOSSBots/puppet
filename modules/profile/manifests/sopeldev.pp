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
        ensure  => absent,
        path    => '/srv/sopelbots/devcode/core/.git/hooks/post-merge',
    }
    file { 'post-dev-adminlist-hook':
        ensure  => absent,
        path    => '/srv/sopelbots/devcode/sopel-adminlist/.git/hooks/post-merge',
    }
    file { 'post-dev-channelmgnt-hook':
        ensure  => absent,
        path    => '/srv/sopelbots/devcode/sopel-channelmgnt/.git/hooks/post-merge',
    }
    file { 'post-dev-jsonparser-hook':
        ensure  => absent,
        path    => '/srv/sopelbots/devcode/jsonparser/.git/hooks/post-merge',
    }
    file { 'post-dev-pingpong-hook':
        ensure  => absent,
        path    => '/srv/sopelbots/devcode/sopel-pingpong/.git/hooks/post-merge',
    }
    file { 'post-dev-joinall-hook':
        ensure  => absent,
        path    => '/srv/sopelbots/devcode/sopel-joinall/.git/hooks/post-merge',
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
    }
    git::clone { 'MirahezeBots/sopel-adminlist':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/sopel-adminlist',
        branch    => 'dev',
    }
    git::clone { 'MirahezeBots/sopel-channelmgnt':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/sopel-channelmgnt',
        branch    => 'dev',
    }
    exec { 'rebuild jsonparser':
        command     => '/usr/bin/sudo /usr/bin/rm -rf /srv/sopelbots/devcode/jsonparser/dist/*.whl && /usr/bin/sudo /srv/sopelbots/devvenv/bin/pyproject-build --wheel --outdir dist . && /usr/bin/find dist -name "/srv/sopelbots/devcode/jsonparser/dist/*.whl" | /usr/bin/xargs /usr/bin/sudo /srv/sopelbots/devvenv/bin/pip3.7 install --no-dependencies --force-reinstall',
        cwd         => '/srv/sopelbots/devcode/jsonparser',
        refreshonly => true,
    }
    git::clone { 'MirahezeBots/jsonparser':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/jsonparser',
        branch    => 'dev',
        notify => Exec['rebuild jsonparser'],
    }
    exec { 'rebuild pingpong':
        command     => '/usr/bin/sudo /usr/bin/rm -rf /srv/sopelbots/devcode/sopel-pingpong/dist/*.whl && /usr/bin/sudo /srv/sopelbots/devvenv/bin/pyproject-build --wheel --outdir dist . && /usr/bin/find dist -name "/srv/sopelbots/devcode/sopel-pingpong/dist/*.whl" | /usr/bin/xargs /usr/bin/sudo /srv/sopelbots/devvenv/bin/pip3.7 install --no-dependencies --force-reinstall',
        cwd         => '/srv/sopelbots/devcode/sopel-pingpong',
        refreshonly => true,
    }
    git::clone { 'MirahezeBots/sopel-pingpong':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/sopel-pingpong',
        branch    => 'dev',
        notify => Exec['rebuild pingpong'],
    }
    exec { 'rebuild joinall':
        command     => '/usr/bin/sudo /usr/bin/rm -rf /srv/sopelbots/devcode/sopel-joinall/dist/*.whl && /usr/bin/sudo /srv/sopelbots/devvenv/bin/pyproject-build --wheel --outdir dist . && /usr/bin/find dist -name "/srv/sopelbots/devcode/sopel-joinall/dist/*.whl" | /usr/bin/xargs /usr/bin/sudo /srv/sopelbots/devvenv/bin/pip3.7 install --no-dependencies --force-reinstall',
        cwd         => '/srv/sopelbots/devcode/sopel-joinall',
        refreshonly => true,
    }
    git::clone { 'MirahezeBots/sopel-joinall':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/sopel-joinall',
        branch    => 'dev',
        notify => Exec['rebuild joinall'],
    }
    exec { 'rebuild sopel':
        command     => '/usr/bin/sudo /usr/bin/rm -rf /srv/sopelbots/devcode/sopel/dist/*.whl && /usr/bin/sudo /srv/sopelbots/devvenv/bin/pyproject-build --wheel --outdir dist . && /usr/bin/find dist -name "/srv/sopelbots/devcode/sopel/dist/*.whl" | /usr/bin/xargs /usr/bin/sudo /srv/sopelbots/devvenv/bin/pip3.7 install --no-dependencies --force-reinstall',
        cwd         => '/srv/sopelbots/devcode/sopel',
        refreshonly => true,
    }
    git::clone { 'MirahezeBots/sopel':
        ensure    => 'latest',
        directory => '/srv/sopelbots/devcode/sopel',
        branch    => 'Testing',
        notify => Exec['rebuild sopel'],
    }
}
