# == Class sopel
#
# Installs the shared stuff between both sopel instances.
#
class sopel(
){
    include sopel::dev
    include sopel::prod
    file { 'channelmgnt':
        ensure  => file,
        path    => '/srv/sopelbots/channelmgnt.json',
        source  => 'puppet:///modules/sopel/channelmgnt.json',
        mode    => '774',
        owner   => sopel,
        group   => sopel,
    }
    file { 'statusv2config':
        ensure  => file,
        path    => '/srv/sopelbots/status.json',
        source  => 'puppet:///modules/sopel/status.json',
        mode    => '774',
        owner   => sopel,
        group   => sopel,
    }
    file { 'phabconfig':
        ensure  => file,
        path    => '/srv/sopelbots/phab.json',
        source  => 'puppet:///modules/sopel/phab.json',
        mode    => '774',
        owner   => sopel,
        group   => sopel,
    }
    git::clone { "MirahezeBots/sopel-CVTFeed":
          ensure    => 'latest',
          directory => "/srv/sopelbots/cvtfeed",
          mode    => '774',
          owner   => sopel,
          group   => sopel,
          branch    => 'main',
    }
}
