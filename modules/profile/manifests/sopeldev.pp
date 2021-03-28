class profile::sopeldev(
){
  exec { 'update dev':
          command     => '/usr/bin/sudo /srv/sopelbots/devvenv/bin/pip3.7 install /srv/sopelbots/devrequire.txt',
          cwd         => '/srv/sopelbots',
          refreshonly => true,
      }
  file { 'dev-require':
        ensure  => file,
        path    => '/srv/sopelbots/devrequire.txt',
        source  => 'puppet:///modules/profile/devrequire.txt',
        mode    => '2755',
        owner   => root,
        group   => root,
        notify  => Exec['update dev'],
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
    git::clone { 'MirahezeBots/MirahezeBotsold':
        ensure    => absent,
        directory => '/srv/sopelbots/devcode/core',
        branch    => 'dev',
    }
    $repos = ['MirahezeBots', 'sopel-adminlist', 'sopel-channelmgnt', 'jsonparser', 'sopel-pingpong', 'sopel-joinall', 'sopel']
    $repos.each |$repo| {
      git::clone { "MirahezeBots/${repo}":
          ensure    => 'latest',
          directory => "/srv/sopelbots/devcode/${repo}",
          branch    => 'dev',
          notify => Exec["rebuild ${repo}"],
      }
      exec { "rebuild ${repo}":
          command     => "/usr/bin/sudo /usr/bin/rm -rf /srv/sopelbots/devcode/${repo}/dist/*.whl && /usr/bin/sudo /srv/sopelbots/devvenv/bin/pyproject-build --wheel --outdir /srv/sopelbots/devcode/${repo}/dist /srv/sopelbots/devcode/${repo} && /usr/bin/find dist -wholename \"/srv/sopelbots/devcode/${repo}/dist/*.whl\" | /usr/bin/xargs /usr/bin/sudo /srv/sopelbots/devvenv/bin/pip3.7 install --no-dependencies --force-reinstall",
          cwd         => "/srv/sopelbots/devcode/${repo}",
          refreshonly => true,
      }
    }
}
