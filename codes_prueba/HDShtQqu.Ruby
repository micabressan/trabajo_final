== users/virt_users.pp ==

class virt_users {
	@user { "debian":
		ensure   => "present",
		uid      => 1000,
		gid      => 1000,
		comment  => 'Debian User',
		home     => '/home/debian',
		shell    => '/bin/bash',
		groups   => ['cdrom','floppy','sudo','audio','dip','video','plugdev','netdev','admin'],
		managehome => true
		}
	}

== notes.pp ==


node basenode {
	include sudo
	}

node 'puppet.localdomain' inherits basenode {
	include virt_users, virt_groups

	realize(Group["debian"])
	realize(Group["admin"])
	realize(Group["foobar"])
	realize(User["debian"])
	file { "/home/debian/.ssh":
		ensure => directory,
		owner  => 1000,
		group  => 1000,
		mode   => 700,
		require => User["debian"]
		}
	file { "/home/debian/.ssh/authorized_keys":
		ensure => present,
		owner  => 1000,
		group  => 1000,
		mode   => 600,
		require => File["/home/debian/.ssh"],
		}
	ssh_authorized_key { 'foo_on_debian':
		ensure => present,
		key    => 'AAAA…==',
		type   => 'ssh-dss',
		name   => 'foo@here',
		user   => User['debian'],
		require => User['debian'],
		}
	}

== Output ==

On first run (and any standalone run with —test), user is created, then SSH Authorized Keys file is created and populated as expected.

If the key file is deleted, puppet agent stops with this error:
puppet-agent[xxx]: Could not run Puppet configuration client: No such file or directory - /home/debian/.ssh/authorized_keys

If the file is created again, Puppet will resume normal operation.

If the user is deleted, puppet agent stops with this error:
puppet-agent[xxx]: The required user is not yet present on the system
puppet-agent[xxx]: Could not run Puppet configuration client: Target not defined and/or specified user does not exist yet

If the user is added later, the error will persist.