UFW module for Puppet
=====================

Module for UFW (Uncomplicated Firewall) configuration.

Usage
-----

To have Puppet install UFW, include the ufw class.
This will install the UFW package, deny all incoming connections and enable UFW.

```puppet
class { 'ufw': }
```

To allow certain connections:

```puppet
ufw::allow { 'ssh':
  port => '22'
}

ufw::allow { 'ssh-from-trusted':
  port => '22'
  from => '10.0.0.1',
}

ufw::allow { 'ssh-on-specific-interface':
  port      => '22',
  interface => 'eth1'
}
```

To disable all IPv6 connections, you have to initialize ufw class with following parameter:

```puppet
class { 'ufw':
  ipv6 => false
}
```

To delete a rule, add `ensure => 'absent'` to the allow.

```puppet
ufw::allow { 'ssh':
  ensure => 'absent',
  port   => '22'
}
```

Allow this to successfully run on all your machines at least once before removing it,
in order to assure that the rule is gone.


Limitations
-----------

Currently it is not possible to purge unmanaged rules.
