# == Class: puppet::package::repository
#
# Add Puppet Labs package repositories
#
# == Parameters
#
# [*devel*]
#   Include development repositories for bleeding edge releases.
#   Default: false
#
# == Requirements
#
# If used on apt based distributions, this requires the puppetlabs/apt module.
#
class puppet::package::repository($devel = false) {

  case $::osfamily {
    Redhat: {
      class { 'puppetlabs_yum':
        enable_devel   => $devel,
      }
    }
    Debian: {
      apt::source { 'puppetlabs':
        location   => 'http://apt.puppetlabs.com',
        repos      => 'main',
        key        => '4BD6EC30',
        key_server => 'pgp.mit.edu',
      }
    }
    default: { fail("Puppetlabs does not offer a package repository for ${::osfamily}") }
  }

}
