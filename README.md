# Puppet-puppet

100% free range, organic, pesticide free Puppet module for managing Puppet.

## Usage


### Puppetmaster

At an absolute minimum, you need the following.

``` Puppet
class { "puppet::server":
  servertype   => 'standalone',
  manifest     => '/etc/puppet/manifests/site.pp',
  ca           => true,
}
```

This should get you a puppetmaster running under `webrick` which might scale to
about `10` nodes if the wind doesn't blow too hard.

If, however, the moon is in the next phase then you probably want to use
something that scales a bit more.

``` Puppet
class service::puppet::master($servertype, $ca = false) {

  class { "::puppet::server":
    modulepath   => [
      '$confdir/modules/site',
      '$confdir/env/$environment/dist',
    ],
    storeconfigs => "puppetdb",
    reporturl    => "https://my.puppet.dashboard/reports",
    servertype   => 'unicorn',
    manifest     => '$confdir/environments/$environment/site.pp',
    ca           => $ca,
    reports      => [
      'https',
      'graphite',
      'irccat',
      'store',
    ],
  }

  include puppet::deploy
  include puppet::reports::irccat
  include puppet::reports::graphite
}
```

## Known Issues / concerns
dependency 'ploperations/rack' # not actually published on forge, needed by
server/unicorn.pp

ruby::dev is required by manifests/dashboard.pp and indirectly by
unicorn/manifests/init.pp and ruby::dev tries to install 'ruby-bundler' which
isn't a valid package on Debian, possibly other distros. Resolved by locking puppetlabs/ruby to 0.1.1.

beaker tests failing on centos-65-x64

unicorn-puppetmaster init scripts do not work on RHEL-type systems

mod_passenger does not seem to exist in native CentOS 6.5 repos, unclear how this ever worked. Issue seems to be with puppetlabs/apache module.

On RHEL-type distros this module only seems to work with the standalone puppetmaster, no passenger or unicorn support
