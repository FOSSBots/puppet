class profile::sopeldev(
){
file { 'dev-venv':
        ensure  => directory,
        path    => '/srv/sopelbots/devvenv/',
        mode    => '0755',
        owner   => root,
        group   => root,
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
    exec { 'update dev':
          command     => '/usr/bin/sudo /srv/sopelbots/devvenv/bin/pip3.7 install /srv/sopelbots/devrequire.txt',
          cwd         => '/srv/sopelbots/devvenv',
          refreshonly => true,
          require     => File['dev-venv', 'dev-require']
    }
    file { 'dev-directory':
        ensure  => directory,
        path    => '/srv/sopelbots/devcode/',
        mode    => '0755',
        owner   => root,
        group   => root,
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
          command     => "/usr/bin/sudo /usr/bin/rm -rf /srv/sopelbots/devcode/${repo}/dist/*.whl && /usr/bin/sudo /srv/sopelbots/devvenv/bin/pyproject-build --wheel --outdir /srv/sopelbots/devcode/${repo}/dist /srv/sopelbots/devcode/${repo} && /usr/bin/find / -wholename \"/srv/sopelbots/devcode/${repo}/dist/*.whl\" | /usr/bin/xargs /usr/bin/sudo /srv/sopelbots/devvenv/bin/pip3.7 install --no-dependencies --force-reinstall",
          cwd         => "/srv/sopelbots/devcode/${repo}",
          refreshonly => true,
      }
    }
    systemd::service { 'mirahezebottest':
        ensure  => present,
        content => systemd_template('mirahezebottest'),
        restart => true,
        require => Git::Clone['MirahezeBots/sopel'],
    }
}
