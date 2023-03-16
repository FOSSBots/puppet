# == Class sopel
#
# Installs the shared stuff between both sopel instances.
#
class sopel(
){
    #include sopel::dev
    include sopel::prod
    $ensure = lookup('sopel::prod::timer')
    
    file { '/srv/sopelbots':
        ensure  => $ensure,
        mode    => '774',
        owner   => sopel,
        group   => sopel,
        force   => true
    }
    
    file { 'channelmgnt':
        ensure  => $ensure,
        path    => '/srv/sopelbots/channelmgnt.json',
        source  => 'puppet:///modules/sopel/channelmgnt.json',
        mode    => '774',
        owner   => sopel,
        group   => sopel,
    }
    file { 'statusv2config':
        ensure  => $ensure,
        path    => '/srv/sopelbots/status.json',
        source  => 'puppet:///modules/sopel/status.json',
        mode    => '774',
        owner   => sopel,
        group   => sopel,
    }
    file { 'phabconfig':
        ensure  => $ensure,
        path    => '/srv/sopelbots/phab.json',
        source  => 'puppet:///modules/sopel/phab.json',
        mode    => '774',
        owner   => sopel,
        group   => sopel,
    }
    git::clone { "FOSSBots/sopel-CVTFeed":
          ensure    => $ensure,
          directory => "/srv/sopelbots/cvtfeed",
          mode    => '774',
          owner   => sopel,
          group   => sopel,
          branch    => 'main',
    }
}
