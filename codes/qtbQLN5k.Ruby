# Logfile created on 2017-12-14 01:00:00 +0000 by logger.rb/56815
  INFO ---------------------------------------------------------------------------
  INFO START 2017-12-14 01:00:00 +0000 cap production deploy
  INFO ---------------------------------------------------------------------------
  INFO [d7bbf2b4] Running /usr/bin/env mkdir -p /tmp as root@138.197.33.107
 DEBUG [d7bbf2b4] Command: /usr/bin/env mkdir -p /tmp
  INFO [d7bbf2b4] Finished in 1.753 seconds with exit status 0 (successful).
 DEBUG Uploading /tmp/git-ssh-maisjoias-production-vagrant.sh 0.0%
  INFO Uploading /tmp/git-ssh-maisjoias-production-vagrant.sh 100.0%
  INFO [2cf05f17] Running /usr/bin/env chmod 700 /tmp/git-ssh-maisjoias-production-vagrant.sh as root@138.197.33.107
 DEBUG [2cf05f17] Command: /usr/bin/env chmod 700 /tmp/git-ssh-maisjoias-production-vagrant.sh
  INFO [2cf05f17] Finished in 0.435 seconds with exit status 0 (successful).
  INFO [99bca8e2] Running /usr/bin/env git ls-remote https://davidejhonatan@bitbucket.org/davidejhonatan/maisjoias.git HEAD as root@138.197.33.107
 DEBUG [99bca8e2] Command: ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env git ls-remote https://davidejhonatan@bitbucket.org/davidejhonatan/maisjoias.git HEAD )
 DEBUG [99bca8e2] 	6aca0defdf8f7e6e7294f4bd3a637fac88bc7c65	HEAD
  INFO [99bca8e2] Finished in 0.758 seconds with exit status 0 (successful).
  INFO [68b62ef9] Running /usr/bin/env mkdir -p /var/www/maisjoias/shared /var/www/maisjoias/releases as root@138.197.33.107
 DEBUG [68b62ef9] Command: /usr/bin/env mkdir -p /var/www/maisjoias/shared /var/www/maisjoias/releases
  INFO [68b62ef9] Finished in 0.428 seconds with exit status 0 (successful).
  INFO [648d53ad] Running /usr/bin/env mkdir -p /var/www/maisjoias/shared/log /var/www/maisjoias/shared/tmp/pids /var/www/maisjoias/shared/tmp/cache /var/www/maisjoias/shared/tmp/sockets /var/www/maisjoias/shared/vendor/bundle /var/www/maisjoias/shared/public/system /var/www/maisjoias/shared/public/uploads /var/www/maisjoias/shared/public/assets as root@138.197.33.107
 DEBUG [648d53ad] Command: /usr/bin/env mkdir -p /var/www/maisjoias/shared/log /var/www/maisjoias/shared/tmp/pids /var/www/maisjoias/shared/tmp/cache /var/www/maisjoias/shared/tmp/sockets /var/www/maisjoias/shared/vendor/bundle /var/www/maisjoias/shared/public/system /var/www/maisjoias/shared/public/uploads /var/www/maisjoias/shared/public/assets
  INFO [648d53ad] Finished in 0.424 seconds with exit status 0 (successful).
  INFO [65ace30f] Running /usr/bin/env mkdir -p /var/www/maisjoias/shared/config as root@138.197.33.107
 DEBUG [65ace30f] Command: /usr/bin/env mkdir -p /var/www/maisjoias/shared/config
  INFO [65ace30f] Finished in 0.429 seconds with exit status 0 (successful).
 DEBUG [e3c5978b] Running [ -f /var/www/maisjoias/shared/config/database.yml ] as root@138.197.33.107
 DEBUG [e3c5978b] Command: [ -f /var/www/maisjoias/shared/config/database.yml ]
 DEBUG [e3c5978b] Finished in 0.435 seconds with exit status 0 (successful).
 DEBUG [96a05b9d] Running [ -f /var/www/maisjoias/shared/config/secrets.yml ] as root@138.197.33.107
 DEBUG [96a05b9d] Command: [ -f /var/www/maisjoias/shared/config/secrets.yml ]
 DEBUG [96a05b9d] Finished in 0.423 seconds with exit status 0 (successful).
 DEBUG [04159a83] Running [ -f /var/www/maisjoias/current/REVISION ] as root@138.197.33.107
 DEBUG [04159a83] Command: [ -f /var/www/maisjoias/current/REVISION ]
 DEBUG [04159a83] Finished in 0.423 seconds with exit status 1 (failed).
 DEBUG [2e8d9e32] Running [ -f /var/www/maisjoias/repo/HEAD ] as root@138.197.33.107
 DEBUG [2e8d9e32] Command: [ -f /var/www/maisjoias/repo/HEAD ]
 DEBUG [2e8d9e32] Finished in 0.425 seconds with exit status 0 (successful).
  INFO The repository mirror is at /var/www/maisjoias/repo
 DEBUG [95a9e670] Running if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [95a9e670] Command: if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi
 DEBUG [95a9e670] Finished in 0.396 seconds with exit status 0 (successful).
  INFO [57ffdba4] Running /usr/bin/env git remote set-url origin https://davidejhonatan@bitbucket.org/davidejhonatan/maisjoias.git as root@138.197.33.107
 DEBUG [57ffdba4] Command: cd /var/www/maisjoias/repo && ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env git remote set-url origin https://davidejhonatan@bitbucket.org/davidejhonatan/maisjoias.git )
  INFO [57ffdba4] Finished in 0.432 seconds with exit status 0 (successful).
  INFO [6cbac6b2] Running /usr/bin/env git remote update --prune as root@138.197.33.107
 DEBUG [6cbac6b2] Command: cd /var/www/maisjoias/repo && ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env git remote update --prune )
 DEBUG [6cbac6b2] 	Fetching origin
  INFO [6cbac6b2] Finished in 0.726 seconds with exit status 0 (successful).
 DEBUG [e20c5f5d] Running if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [e20c5f5d] Command: if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi
 DEBUG [e20c5f5d] Finished in 0.423 seconds with exit status 0 (successful).
  INFO [9e4ce1ba] Running /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214010007 as root@138.197.33.107
 DEBUG [9e4ce1ba] Command: cd /var/www/maisjoias/repo && ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214010007 )
  INFO [9e4ce1ba] Finished in 0.428 seconds with exit status 0 (successful).
  INFO [7fa91989] Running /usr/bin/env git archive master | /usr/bin/env tar -x -f - -C /var/www/maisjoias/releases/20171214010007 as root@138.197.33.107
 DEBUG [7fa91989] Command: cd /var/www/maisjoias/repo && ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env git archive master | /usr/bin/env tar -x -f - -C /var/www/maisjoias/releases/20171214010007 )
  INFO [7fa91989] Finished in 0.537 seconds with exit status 0 (successful).
 DEBUG [cd301def] Running if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [cd301def] Command: if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi
 DEBUG [cd301def] Finished in 0.421 seconds with exit status 0 (successful).
 DEBUG [d96b310f] Running /usr/bin/env git rev-list --max-count=1 master as root@138.197.33.107
 DEBUG [d96b310f] Command: cd /var/www/maisjoias/repo && ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env git rev-list --max-count=1 master )
 DEBUG [d96b310f] 	6aca0defdf8f7e6e7294f4bd3a637fac88bc7c65
 DEBUG [d96b310f] Finished in 0.427 seconds with exit status 0 (successful).
 DEBUG [108ec7aa] Running if test ! -d /var/www/maisjoias/releases/20171214010007; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214010007'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [108ec7aa] Command: if test ! -d /var/www/maisjoias/releases/20171214010007; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214010007'" 1>&2; false; fi
 DEBUG [108ec7aa] Finished in 0.422 seconds with exit status 0 (successful).
  INFO [0f1aa67e] Running /usr/bin/env echo "6aca0defdf8f7e6e7294f4bd3a637fac88bc7c65" >> REVISION as root@138.197.33.107
 DEBUG [0f1aa67e] Command: cd /var/www/maisjoias/releases/20171214010007 && /usr/bin/env echo "6aca0defdf8f7e6e7294f4bd3a637fac88bc7c65" >> REVISION
  INFO [0f1aa67e] Finished in 0.437 seconds with exit status 0 (successful).
  INFO [6e5a8e54] Running /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214010007/config as root@138.197.33.107
 DEBUG [6e5a8e54] Command: /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214010007/config
  INFO [6e5a8e54] Finished in 0.427 seconds with exit status 0 (successful).
 DEBUG [fcfaf287] Running [ -L /var/www/maisjoias/releases/20171214010007/config/database.yml ] as root@138.197.33.107
 DEBUG [fcfaf287] Command: [ -L /var/www/maisjoias/releases/20171214010007/config/database.yml ]
 DEBUG [fcfaf287] Finished in 0.423 seconds with exit status 1 (failed).
 DEBUG [79a19d0a] Running [ -f /var/www/maisjoias/releases/20171214010007/config/database.yml ] as root@138.197.33.107
 DEBUG [79a19d0a] Command: [ -f /var/www/maisjoias/releases/20171214010007/config/database.yml ]
 DEBUG [79a19d0a] Finished in 0.438 seconds with exit status 0 (successful).
  INFO [ce226d9f] Running /usr/bin/env rm /var/www/maisjoias/releases/20171214010007/config/database.yml as root@138.197.33.107
 DEBUG [ce226d9f] Command: /usr/bin/env rm /var/www/maisjoias/releases/20171214010007/config/database.yml
  INFO [ce226d9f] Finished in 0.419 seconds with exit status 0 (successful).
  INFO [811299f5] Running /usr/bin/env ln -s /var/www/maisjoias/shared/config/database.yml /var/www/maisjoias/releases/20171214010007/config/database.yml as root@138.197.33.107
 DEBUG [811299f5] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/config/database.yml /var/www/maisjoias/releases/20171214010007/config/database.yml
  INFO [811299f5] Finished in 0.424 seconds with exit status 0 (successful).
 DEBUG [4222d6fd] Running [ -L /var/www/maisjoias/releases/20171214010007/config/secrets.yml ] as root@138.197.33.107
 DEBUG [4222d6fd] Command: [ -L /var/www/maisjoias/releases/20171214010007/config/secrets.yml ]
 DEBUG [4222d6fd] Finished in 0.420 seconds with exit status 1 (failed).
 DEBUG [843dbff7] Running [ -f /var/www/maisjoias/releases/20171214010007/config/secrets.yml ] as root@138.197.33.107
 DEBUG [843dbff7] Command: [ -f /var/www/maisjoias/releases/20171214010007/config/secrets.yml ]
 DEBUG [843dbff7] Finished in 0.426 seconds with exit status 0 (successful).
  INFO [e6a6fc7b] Running /usr/bin/env rm /var/www/maisjoias/releases/20171214010007/config/secrets.yml as root@138.197.33.107
 DEBUG [e6a6fc7b] Command: /usr/bin/env rm /var/www/maisjoias/releases/20171214010007/config/secrets.yml
  INFO [e6a6fc7b] Finished in 0.424 seconds with exit status 0 (successful).
  INFO [0b9e30aa] Running /usr/bin/env ln -s /var/www/maisjoias/shared/config/secrets.yml /var/www/maisjoias/releases/20171214010007/config/secrets.yml as root@138.197.33.107
 DEBUG [0b9e30aa] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/config/secrets.yml /var/www/maisjoias/releases/20171214010007/config/secrets.yml
  INFO [0b9e30aa] Finished in 0.418 seconds with exit status 0 (successful).
  INFO [2113d3a0] Running /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214010007 /var/www/maisjoias/releases/20171214010007/tmp /var/www/maisjoias/releases/20171214010007/vendor /var/www/maisjoias/releases/20171214010007/public as root@138.197.33.107
 DEBUG [2113d3a0] Command: /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214010007 /var/www/maisjoias/releases/20171214010007/tmp /var/www/maisjoias/releases/20171214010007/vendor /var/www/maisjoias/releases/20171214010007/public
  INFO [2113d3a0] Finished in 0.423 seconds with exit status 0 (successful).
 DEBUG [6dad8713] Running [ -L /var/www/maisjoias/releases/20171214010007/log ] as root@138.197.33.107
 DEBUG [6dad8713] Command: [ -L /var/www/maisjoias/releases/20171214010007/log ]
 DEBUG [6dad8713] Finished in 0.437 seconds with exit status 1 (failed).
 DEBUG [0f0cbb68] Running [ -d /var/www/maisjoias/releases/20171214010007/log ] as root@138.197.33.107
 DEBUG [0f0cbb68] Command: [ -d /var/www/maisjoias/releases/20171214010007/log ]
 DEBUG [0f0cbb68] Finished in 0.418 seconds with exit status 0 (successful).
  INFO [5d65a1ef] Running /usr/bin/env rm -rf /var/www/maisjoias/releases/20171214010007/log as root@138.197.33.107
 DEBUG [5d65a1ef] Command: /usr/bin/env rm -rf /var/www/maisjoias/releases/20171214010007/log
  INFO [5d65a1ef] Finished in 0.426 seconds with exit status 0 (successful).
  INFO [2fce2076] Running /usr/bin/env ln -s /var/www/maisjoias/shared/log /var/www/maisjoias/releases/20171214010007/log as root@138.197.33.107
 DEBUG [2fce2076] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/log /var/www/maisjoias/releases/20171214010007/log
  INFO [2fce2076] Finished in 0.430 seconds with exit status 0 (successful).
 DEBUG [3b6ffcc4] Running [ -L /var/www/maisjoias/releases/20171214010007/tmp/pids ] as root@138.197.33.107
 DEBUG [3b6ffcc4] Command: [ -L /var/www/maisjoias/releases/20171214010007/tmp/pids ]
 DEBUG [3b6ffcc4] Finished in 0.427 seconds with exit status 1 (failed).
 DEBUG [786408ab] Running [ -d /var/www/maisjoias/releases/20171214010007/tmp/pids ] as root@138.197.33.107
 DEBUG [786408ab] Command: [ -d /var/www/maisjoias/releases/20171214010007/tmp/pids ]
 DEBUG [786408ab] Finished in 0.421 seconds with exit status 1 (failed).
  INFO [b76dc9c1] Running /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/pids /var/www/maisjoias/releases/20171214010007/tmp/pids as root@138.197.33.107
 DEBUG [b76dc9c1] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/pids /var/www/maisjoias/releases/20171214010007/tmp/pids
  INFO [b76dc9c1] Finished in 0.420 seconds with exit status 0 (successful).
 DEBUG [f4358c4d] Running [ -L /var/www/maisjoias/releases/20171214010007/tmp/cache ] as root@138.197.33.107
 DEBUG [f4358c4d] Command: [ -L /var/www/maisjoias/releases/20171214010007/tmp/cache ]
 DEBUG [f4358c4d] Finished in 0.432 seconds with exit status 1 (failed).
 DEBUG [33a5ae57] Running [ -d /var/www/maisjoias/releases/20171214010007/tmp/cache ] as root@138.197.33.107
 DEBUG [33a5ae57] Command: [ -d /var/www/maisjoias/releases/20171214010007/tmp/cache ]
 DEBUG [33a5ae57] Finished in 0.428 seconds with exit status 1 (failed).
  INFO [46fc831f] Running /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/cache /var/www/maisjoias/releases/20171214010007/tmp/cache as root@138.197.33.107
 DEBUG [46fc831f] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/cache /var/www/maisjoias/releases/20171214010007/tmp/cache
  INFO [46fc831f] Finished in 0.436 seconds with exit status 0 (successful).
 DEBUG [522bbd74] Running [ -L /var/www/maisjoias/releases/20171214010007/tmp/sockets ] as root@138.197.33.107
 DEBUG [522bbd74] Command: [ -L /var/www/maisjoias/releases/20171214010007/tmp/sockets ]
 DEBUG [522bbd74] Finished in 0.436 seconds with exit status 1 (failed).
 DEBUG [31ccaa00] Running [ -d /var/www/maisjoias/releases/20171214010007/tmp/sockets ] as root@138.197.33.107
 DEBUG [31ccaa00] Command: [ -d /var/www/maisjoias/releases/20171214010007/tmp/sockets ]
 DEBUG [31ccaa00] Finished in 0.424 seconds with exit status 1 (failed).
  INFO [990aa229] Running /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/sockets /var/www/maisjoias/releases/20171214010007/tmp/sockets as root@138.197.33.107
 DEBUG [990aa229] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/sockets /var/www/maisjoias/releases/20171214010007/tmp/sockets
  INFO [990aa229] Finished in 0.424 seconds with exit status 0 (successful).
 DEBUG [0e77fec1] Running [ -L /var/www/maisjoias/releases/20171214010007/vendor/bundle ] as root@138.197.33.107
 DEBUG [0e77fec1] Command: [ -L /var/www/maisjoias/releases/20171214010007/vendor/bundle ]
 DEBUG [0e77fec1] Finished in 0.421 seconds with exit status 1 (failed).
 DEBUG [bb2e1bb2] Running [ -d /var/www/maisjoias/releases/20171214010007/vendor/bundle ] as root@138.197.33.107
 DEBUG [bb2e1bb2] Command: [ -d /var/www/maisjoias/releases/20171214010007/vendor/bundle ]
 DEBUG [bb2e1bb2] Finished in 0.415 seconds with exit status 1 (failed).
  INFO [dee8ff09] Running /usr/bin/env ln -s /var/www/maisjoias/shared/vendor/bundle /var/www/maisjoias/releases/20171214010007/vendor/bundle as root@138.197.33.107
 DEBUG [dee8ff09] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/vendor/bundle /var/www/maisjoias/releases/20171214010007/vendor/bundle
  INFO [dee8ff09] Finished in 0.420 seconds with exit status 0 (successful).
 DEBUG [8a8d23e7] Running [ -L /var/www/maisjoias/releases/20171214010007/public/system ] as root@138.197.33.107
 DEBUG [8a8d23e7] Command: [ -L /var/www/maisjoias/releases/20171214010007/public/system ]
 DEBUG [8a8d23e7] Finished in 0.425 seconds with exit status 1 (failed).
 DEBUG [ec8d451e] Running [ -d /var/www/maisjoias/releases/20171214010007/public/system ] as root@138.197.33.107
 DEBUG [ec8d451e] Command: [ -d /var/www/maisjoias/releases/20171214010007/public/system ]
 DEBUG [ec8d451e] Finished in 0.420 seconds with exit status 1 (failed).
  INFO [24da896d] Running /usr/bin/env ln -s /var/www/maisjoias/shared/public/system /var/www/maisjoias/releases/20171214010007/public/system as root@138.197.33.107
 DEBUG [24da896d] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/public/system /var/www/maisjoias/releases/20171214010007/public/system
  INFO [24da896d] Finished in 0.422 seconds with exit status 0 (successful).
 DEBUG [973f532d] Running [ -L /var/www/maisjoias/releases/20171214010007/public/uploads ] as root@138.197.33.107
 DEBUG [973f532d] Command: [ -L /var/www/maisjoias/releases/20171214010007/public/uploads ]
 DEBUG [973f532d] Finished in 0.421 seconds with exit status 1 (failed).
 DEBUG [52de9544] Running [ -d /var/www/maisjoias/releases/20171214010007/public/uploads ] as root@138.197.33.107
 DEBUG [52de9544] Command: [ -d /var/www/maisjoias/releases/20171214010007/public/uploads ]
 DEBUG [52de9544] Finished in 0.428 seconds with exit status 1 (failed).
  INFO [fd6622b8] Running /usr/bin/env ln -s /var/www/maisjoias/shared/public/uploads /var/www/maisjoias/releases/20171214010007/public/uploads as root@138.197.33.107
 DEBUG [fd6622b8] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/public/uploads /var/www/maisjoias/releases/20171214010007/public/uploads
  INFO [fd6622b8] Finished in 0.428 seconds with exit status 0 (successful).
 DEBUG [bb0a6aa9] Running [ -L /var/www/maisjoias/releases/20171214010007/public/assets ] as root@138.197.33.107
 DEBUG [bb0a6aa9] Command: [ -L /var/www/maisjoias/releases/20171214010007/public/assets ]
 DEBUG [bb0a6aa9] Finished in 0.418 seconds with exit status 1 (failed).
 DEBUG [dec0db49] Running [ -d /var/www/maisjoias/releases/20171214010007/public/assets ] as root@138.197.33.107
 DEBUG [dec0db49] Command: [ -d /var/www/maisjoias/releases/20171214010007/public/assets ]
 DEBUG [dec0db49] Finished in 0.418 seconds with exit status 1 (failed).
  INFO [1c948186] Running /usr/bin/env ln -s /var/www/maisjoias/shared/public/assets /var/www/maisjoias/releases/20171214010007/public/assets as root@138.197.33.107
 DEBUG [1c948186] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/public/assets /var/www/maisjoias/releases/20171214010007/public/assets
  INFO [1c948186] Finished in 0.418 seconds with exit status 0 (successful).
 DEBUG [e7a06e27] Running if test ! -d /var/www/maisjoias/releases/20171214010007; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214010007'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [e7a06e27] Command: if test ! -d /var/www/maisjoias/releases/20171214010007; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214010007'" 1>&2; false; fi
 DEBUG [e7a06e27] Finished in 0.421 seconds with exit status 0 (successful).
 DEBUG [237b1f85] Running /usr/bin/env bundle check --path /var/www/maisjoias/shared/bundle as root@138.197.33.107
 DEBUG [237b1f85] Command: cd /var/www/maisjoias/releases/20171214010007 && /usr/bin/env bundle check --path /var/www/maisjoias/shared/bundle
 DEBUG [237b1f85] 	The following gems are missing
 DEBUG [237b1f85] 	 * public_suffix (3.0.1)
 DEBUG [237b1f85] 	 * addressable (2.5.2)
 DEBUG [237b1f85] 	 * net-ssh (4.2.0)
 DEBUG [237b1f85] 	 * net-scp (1.2.1)
 DEBUG [237b1f85] 	 * sshkit (1.15.1)
 DEBUG [237b1f85] 	 * airbrussh (1.3.0)
 DEBUG [237b1f85] 	 * coderay (1.1.2)
 DEBUG [237b1f85] 	 * better_errors (2.4.0)
 DEBUG [237b1f85] 	 * bindex (0.5.0)
 DEBUG [237b1f85] 	 * debug_inspector (0.0.3)
 DEBUG [237b1f85] 	 * binding_of_caller (0.7.3)
 DEBUG [237b1f85] 	 * byebug (9.1.0)
 DEBUG [237b1f85] 	 * capistrano (3.10.1)
 DEBUG [237b1f85] 	 * capistrano-bundler (1.3.0)
 DEBUG [237b1f85] 	 * capistrano-passenger (0.2.0)
 DEBUG [237b1f85] 	 * capistrano-rails (1.3.1)
 DEBUG [237b1f85] 	 * xpath (2.1.0)
 DEBUG [237b1f85] 	 * capybara (2.16.1)
 DEBUG [237b1f85] 	 * childprocess (0.8.0)
 DEBUG [237b1f85] 	 * choice (0.2.0)
 DEBUG [237b1f85] 	 * cpf_utils (1.2.1)
 DEBUG [237b1f85] 	 * faker (1.8.4)
 DEBUG [237b1f85] 	 * ruby_dep (1.5.0)
 DEBUG [237b1f85] 	 * listen (3.1.5)
 DEBUG [237b1f85] 	 * ruby-graphviz (1.2.3)
 DEBUG [237b1f85] 	 * rails-erd (1.5.2)
 DEBUG [237b1f85] 	 * rubyzip (1.2.1)
 DEBUG [237b1f85] 	 * selenium-webdriver (3.8.0)
 DEBUG [237b1f85] 	 * spring (2.0.2)
 DEBUG [237b1f85] 	 * spring-watcher-listen (2.0.1)
 DEBUG [237b1f85] 	 * web-console (3.5.1)
 DEBUG [237b1f85] 	Install missing gems with `bundle install`
 DEBUG [237b1f85] Finished in 0.986 seconds with exit status 1 (failed).
  INFO [954866ea] Running /usr/bin/env bundle install --path /var/www/maisjoias/shared/bundle --without development test --deployment --quiet as root@138.197.33.107
 DEBUG [954866ea] Command: cd /var/www/maisjoias/releases/20171214010007 && /usr/bin/env bundle install --path /var/www/maisjoias/shared/bundle --without development test --deployment --quiet
  INFO [954866ea] Finished in 0.894 seconds with exit status 0 (successful).
 DEBUG [d59326c3] Running if test ! -d /var/www/maisjoias/releases/20171214010007; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214010007'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [d59326c3] Command: if test ! -d /var/www/maisjoias/releases/20171214010007; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214010007'" 1>&2; false; fi
 DEBUG [d59326c3] Finished in 0.416 seconds with exit status 0 (successful).
  INFO [e1a537c4] Running bundle exec rake assets:precompile as root@138.197.33.107
 DEBUG [e1a537c4] Command: cd /var/www/maisjoias/releases/20171214010007 && ( export RAILS_ENV="production" RAILS_GROUPS="" ; bundle exec rake assets:precompile )
  INFO [e1a537c4] Finished in 3.226 seconds with exit status 0 (successful).
 DEBUG [66a7344a] Running if test ! -d /var/www/maisjoias/releases/20171214010007; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214010007'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [66a7344a] Command: if test ! -d /var/www/maisjoias/releases/20171214010007; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214010007'" 1>&2; false; fi
 DEBUG [66a7344a] Finished in 0.427 seconds with exit status 0 (successful).
  INFO [8b2660e7] Running /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214010007/assets_manifest_backup as root@138.197.33.107
 DEBUG [8b2660e7] Command: cd /var/www/maisjoias/releases/20171214010007 && /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214010007/assets_manifest_backup
  INFO [8b2660e7] Finished in 0.433 seconds with exit status 0 (successful).
 DEBUG [5ab5339a] Running /usr/bin/env ls /var/www/maisjoias/releases/20171214010007/public/assets/.sprockets-manifest* as root@138.197.33.107
 DEBUG [5ab5339a] Command: cd /var/www/maisjoias/releases/20171214010007 && /usr/bin/env ls /var/www/maisjoias/releases/20171214010007/public/assets/.sprockets-manifest*
 DEBUG [5ab5339a] 	/var/www/maisjoias/releases/20171214010007/public/assets/.sprockets-manifest-c1eaf3a48261a75ecfbe9dcd344b802d.json
 DEBUG [5ab5339a] Finished in 0.424 seconds with exit status 0 (successful).
 DEBUG [01d01f28] Running /usr/bin/env ls /var/www/maisjoias/releases/20171214010007/public/assets/.sprockets-manifest* as root@138.197.33.107
 DEBUG [01d01f28] Command: cd /var/www/maisjoias/releases/20171214010007 && /usr/bin/env ls /var/www/maisjoias/releases/20171214010007/public/assets/.sprockets-manifest*
 DEBUG [01d01f28] 	/var/www/maisjoias/releases/20171214010007/public/assets/.sprockets-manifest-c1eaf3a48261a75ecfbe9dcd344b802d.json
 DEBUG [01d01f28] Finished in 0.440 seconds with exit status 0 (successful).
  INFO [aeb17110] Running /usr/bin/env cp /var/www/maisjoias/releases/20171214010007/public/assets/.sprockets-manifest-c1eaf3a48261a75ecfbe9dcd344b802d.json /var/www/maisjoias/releases/20171214010007/assets_manifest_backup as root@138.197.33.107
 DEBUG [aeb17110] Command: cd /var/www/maisjoias/releases/20171214010007 && /usr/bin/env cp /var/www/maisjoias/releases/20171214010007/public/assets/.sprockets-manifest-c1eaf3a48261a75ecfbe9dcd344b802d.json /var/www/maisjoias/releases/20171214010007/assets_manifest_backup
  INFO [aeb17110] Finished in 0.424 seconds with exit status 0 (successful).
  INFO [deploy:migrate] Run `rake db:migrate`
 DEBUG [3cca5953] Running if test ! -d /var/www/maisjoias/releases/20171214010007; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214010007'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [3cca5953] Command: if test ! -d /var/www/maisjoias/releases/20171214010007; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214010007'" 1>&2; false; fi
 DEBUG [3cca5953] Finished in 0.410 seconds with exit status 0 (successful).
  INFO [8d674d4b] Running bundle exec rake db:migrate as root@138.197.33.107
 DEBUG [8d674d4b] Command: cd /var/www/maisjoias/releases/20171214010007 && ( export RAILS_ENV="production" ; bundle exec rake db:migrate )
 DEBUG [8d674d4b] 	rake aborted!
 DEBUG [8d674d4b] 	StandardError: An error has occurred, all later migrations canceled:

Mysql2::Error: Table 'maisjoias.banks' doesn't exist: SHOW FULL FIELDS FROM `banks`
 DEBUG [8d674d4b] 	/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:120:in `_query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:120:in `block in query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:119:in `handle_interrupt'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:119:in `query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:214:in `block (2 levels) in execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/dependencies/interlock.rb:46:in `block in permit_concurrent_loads'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/concurrency/share_lock.rb:185:in `yield_shares'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/dependencies/interlock.rb:45:in `permit_concurrent_loads'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:213:in `block in execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:612:in `block (2 levels) in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:611:in `block in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/notifications/instrumenter.rb:21:in `instrument'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:603:in `log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:212:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/mysql/database_statements.rb:26:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:223:in `execute_and_free'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:854:in `column_definitions'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:166:in `columns'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/errors.rb:140:in `column_type'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/errors.rb:123:in `initialize'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:876:in `new'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:876:in `mismatched_foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:694:in `translate_exception'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:597:in `translate_exception_class'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:616:in `rescue in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:610:in `log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:212:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/mysql/database_statements.rb:26:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_statements.rb:930:in `add_foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_definitions.rb:614:in `foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_definitions.rb:107:in `add_to'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_statements.rb:839:in `add_reference'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:849:in `block in method_missing'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:818:in `block in say_with_time'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:818:in `say_with_time'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:838:in `method_missing'
/var/www/maisjoias/releases/20171214010007/db/migrate/20171206140458_add_bank_ref_to_client.rb:3:in `change'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:792:in `exec_migration'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:776:in `block (2 levels) in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:775:in `block in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/connection_pool.rb:408:in `with_connection'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:774:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:953:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1230:in `block in execute_migration_in_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1300:in `ddl_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1229:in `execute_migration_in_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1201:in `block in migrate_without_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1200:in `each'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1200:in `migrate_without_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1148:in `block in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1317:in `with_advisory_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1148:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1007:in `up'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:985:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/tasks/database_tasks.rb:171:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/railties/databases.rake:58:in `block (2 levels) in <top (required)>'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/rake-12.3.0/exe/rake:27:in `<top (required)>'
/usr/local/bin/bundle:22:in `load'
/usr/local/bin/bundle:22:in `<main>'
 DEBUG [8d674d4b] 	
Caused by:
 DEBUG [8d674d4b] 	ActiveRecord::StatementInvalid: Mysql2::Error: Table 'maisjoias.banks' doesn't exist: SHOW FULL FIELDS FROM `banks`
 DEBUG [8d674d4b] 	/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:120:in `_query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:120:in `block in query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:119:in `handle_interrupt'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:119:in `query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:214:in `block (2 levels) in execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/dependencies/interlock.rb:46:in `block in permit_concurrent_loads'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/concurrency/share_lock.rb:185:in `yield_shares'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/dependencies/interlock.rb:45:in `permit_concurrent_loads'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:213:in `block in execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:612:in `block (2 levels) in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:611:in `block in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/notifications/instrumenter.rb:21:in `instrument'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:603:in `log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:212:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/mysql/database_statements.rb:26:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:223:in `execute_and_free'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:854:in `column_definitions'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:166:in `columns'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/errors.rb:140:in `column_type'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/errors.rb:123:in `initialize'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:876:in `new'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:876:in `mismatched_foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:694:in `translate_exception'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:597:in `translate_exception_class'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:616:in `rescue in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:610:in `log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:212:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/mysql/database_statements.rb:26:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_statements.rb:930:in `add_foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_definitions.rb:614:in `foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_definitions.rb:107:in `add_to'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_statements.rb:839:in `add_reference'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:849:in `block in method_missing'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:818:in `block in say_with_time'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:818:in `say_with_time'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:838:in `method_missing'
/var/www/maisjoias/releases/20171214010007/db/migrate/20171206140458_add_bank_ref_to_client.rb:3:in `change'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:792:in `exec_migration'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:776:in `block (2 levels) in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:775:in `block in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/connection_pool.rb:408:in `with_connection'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:774:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:953:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1230:in `block in execute_migration_in_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1300:in `ddl_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1229:in `execute_migration_in_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1201:in `block in migrate_without_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1200:in `each'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1200:in `migrate_without_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1148:in `block in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1317:in `with_advisory_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1148:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1007:in `up'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:985:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/tasks/database_tasks.rb:171:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/railties/databases.rake:58:in `block (2 levels) in <top (required)>'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/rake-12.3.0/exe/rake:27:in `<top (required)>'
/usr/local/bin/bundle:22:in `load'
/usr/local/bin/bundle:22:in `<main>'
 DEBUG [8d674d4b] 	
Caused by:
 DEBUG [8d674d4b] 	Mysql2::Error: Table 'maisjoias.banks' doesn't exist
 DEBUG [8d674d4b] 	/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:120:in `_query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:120:in `block in query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:119:in `handle_interrupt'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:119:in `query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:214:in `block (2 levels) in execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/dependencies/interlock.rb:46:in `block in permit_concurrent_loads'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/concurrency/share_lock.rb:185:in `yield_shares'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/dependencies/interlock.rb:45:in `permit_concurrent_loads'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:213:in `block in execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:612:in `block (2 levels) in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:611:in `block in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/notifications/instrumenter.rb:21:in `instrument'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:603:in `log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:212:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/mysql/database_statements.rb:26:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:223:in `execute_and_free'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:854:in `column_definitions'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:166:in `columns'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/errors.rb:140:in `column_type'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/errors.rb:123:in `initialize'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:876:in `new'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:876:in `mismatched_foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:694:in `translate_exception'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:597:in `translate_exception_class'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:616:in `rescue in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:610:in `log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:212:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/mysql/database_statements.rb:26:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_statements.rb:930:in `add_foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_definitions.rb:614:in `foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_definitions.rb:107:in `add_to'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_statements.rb:839:in `add_reference'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:849:in `block in method_missing'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:818:in `block in say_with_time'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:818:in `say_with_time'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:838:in `method_missing'
/var/www/maisjoias/releases/20171214010007/db/migrate/20171206140458_add_bank_ref_to_client.rb:3:in `change'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:792:in `exec_migration'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:776:in `block (2 levels) in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:775:in `block in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/connection_pool.rb:408:in `with_connection'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:774:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:953:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1230:in `block in execute_migration_in_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1300:in `ddl_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1229:in `execute_migration_in_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1201:in `block in migrate_without_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1200:in `each'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1200:in `migrate_without_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1148:in `block in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1317:in `with_advisory_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1148:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1007:in `up'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:985:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/tasks/database_tasks.rb:171:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/railties/databases.rake:58:in `block (2 levels) in <top (required)>'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/rake-12.3.0/exe/rake:27:in `<top (required)>'
/usr/local/bin/bundle:22:in `load'
/usr/local/bin/bundle:22:in `<main>'
 DEBUG [8d674d4b] 	
Caused by:
 DEBUG [8d674d4b] 	Mysql2::Error: Cannot add foreign key constraint
 DEBUG [8d674d4b] 	/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:120:in `_query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:120:in `block in query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:119:in `handle_interrupt'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:119:in `query'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:214:in `block (2 levels) in execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/dependencies/interlock.rb:46:in `block in permit_concurrent_loads'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/concurrency/share_lock.rb:185:in `yield_shares'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/dependencies/interlock.rb:45:in `permit_concurrent_loads'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:213:in `block in execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:612:in `block (2 levels) in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:611:in `block in log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activesupport-5.1.4/lib/active_support/notifications/instrumenter.rb:21:in `instrument'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_adapter.rb:603:in `log'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract_mysql_adapter.rb:212:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/mysql/database_statements.rb:26:in `execute'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_statements.rb:930:in `add_foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_definitions.rb:614:in `foreign_key'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_definitions.rb:107:in `add_to'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/schema_statements.rb:839:in `add_reference'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:849:in `block in method_missing'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:818:in `block in say_with_time'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:818:in `say_with_time'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:838:in `method_missing'
/var/www/maisjoias/releases/20171214010007/db/migrate/20171206140458_add_bank_ref_to_client.rb:3:in `change'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:792:in `exec_migration'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:776:in `block (2 levels) in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:775:in `block in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/connection_pool.rb:408:in `with_connection'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:774:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:953:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1230:in `block in execute_migration_in_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1300:in `ddl_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1229:in `execute_migration_in_transaction'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1201:in `block in migrate_without_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1200:in `each'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1200:in `migrate_without_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1148:in `block in migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1317:in `with_advisory_lock'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1148:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:1007:in `up'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/migration.rb:985:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/tasks/database_tasks.rb:171:in `migrate'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/railties/databases.rake:58:in `block (2 levels) in <top (required)>'
/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/rake-12.3.0/exe/rake:27:in `<top (required)>'
/usr/local/bin/bundle:22:in `load'
/usr/local/bin/bundle:22:in `<main>'
 DEBUG [8d674d4b] 	Tasks: TOP => db:migrate
 DEBUG [8d674d4b] 	(See full trace by running task with --trace)
 DEBUG [8d674d4b] 	== 20171121123321 DeviseCreateAdmins: migrating ===============================
-- create_table(:admins)
   -> 0.0342s
-- add_index(:admins, :email, {:unique=>true})
   -> 0.0256s
-- add_index(:admins, :reset_password_token, {:unique=>true})
   -> 0.0114s
== 20171121123321 DeviseCreateAdmins: migrated (0.0717s) ======================

== 20171121123357 DeviseCreateClients: migrating ==============================
-- create_table(:clients)
   -> 0.0098s
-- add_index(:clients, :email, {:unique=>true})
   -> 0.0085s
-- add_index(:clients, :reset_password_token, {:unique=>true})
   -> 0.0101s
== 20171121123357 DeviseCreateClients: migrated (0.0286s) =====================

== 20171128234105 CreateBranches: migrating ===================================
-- create_table(:branches)
   -> 0.0082s
== 20171128234105 CreateBranches: migrated (0.0083s) ==========================

== 20171129003639 AddNameAndRoleAndCpfAndRgAndStatusAndBranchRefToAdmin: migrating 
-- add_column(:admins, :name, :string)
   -> 0.0188s
-- add_column(:admins, :role, :integer)
   -> 0.0196s
-- add_column(:admins, :cpf, :string)
   -> 0.0198s
-- add_column(:admins, :rg, :string)
   -> 0.0187s
-- add_column(:admins, :status, :integer)
   -> 0.0187s
-- add_reference(:admins, :branch, {:foreign_key=>true})
   -> 0.0630s
== 20171129003639 AddNameAndRoleAndCpfAndRgAndStatusAndBranchRefToAdmin: migrated (0.1591s) 

== 20171129221615 AddNameAndCpfAndRgAndAddressAndNeighbohodAndCountryToClient: migrating 
-- add_column(:clients, :name, :string)
   -> 0.0173s
-- add_column(:clients, :cpf, :string)
   -> 0.0272s
-- add_column(:clients, :rg, :string)
   -> 0.0192s
-- add_column(:clients, :address, :string)
   -> 0.0186s
-- add_column(:clients, :neighbohod, :string)
   -> 0.0169s
-- add_column(:clients, :country, :string)
   -> 0.0160s
== 20171129221615 AddNameAndCpfAndRgAndAddressAndNeighbohodAndCountryToClient: migrated (0.1157s) 

== 20171129223022 AddComplementAndCityAndTotalPointsRescueAndBranchRefToClient: migrating 
-- add_column(:clients, :complement, :string)
   -> 0.0153s
-- add_column(:clients, :city, :string)
   -> 0.0167s
-- add_column(:clients, :total_points_rescue, :integer)
   -> 0.0153s
-- add_reference(:clients, :branch, {:foreign_key=>true})
   -> 0.0552s
== 20171129223022 AddComplementAndCityAndTotalPointsRescueAndBranchRefToClient: migrated (0.1027s) 

== 20171129223149 AddStateAndStatusAndTotalPointsAndAvailablePointsAndTotalReactiveAndPostalCodeToClient: migrating 
-- add_column(:clients, :state, :string)
   -> 0.0219s
-- add_column(:clients, :status, :integer)
   -> 0.0395s
-- add_column(:clients, :total_points, :integer)
   -> 0.0303s
-- add_column(:clients, :available_points, :integer)
   -> 0.0420s
-- add_column(:clients, :total_reactive, :integer)
   -> 0.0332s
-- add_column(:clients, :postal_code, :string)
   -> 0.0294s
== 20171129223149 AddStateAndStatusAndTotalPointsAndAvailablePointsAndTotalReactiveAndPostalCodeToClient: migrated (0.1970s) 

== 20171129235615 CreatePhones: migrating =====================================
-- create_table(:phones)
   -> 0.0103s
== 20171129235615 CreatePhones: migrated (0.0104s) ============================

== 20171201172901 CreateSells: migrating ======================================
-- create_table(:sells)
   -> 0.0098s
== 20171201172901 CreateSells: migrated (0.0098s) =============================

== 20171202013827 AddSellDateToSell: migrating ================================
-- add_column(:sells, :sell_date, :date)
   -> 0.0219s
== 20171202013827 AddSellDateToSell: migrated (0.0220s) =======================

== 20171205000750 AddSellTypeToSell: migrating ================================
-- add_column(:sells, :sell_type, :string)
   -> 0.0239s
== 20171205000750 AddSellTypeToSell: migrated (0.0240s) =======================

== 20171205180325 CreateParameters: migrating =================================
-- create_table(:parameters)
   -> 0.0102s
== 20171205180325 CreateParameters: migrated (0.0103s) ========================

== 20171205210813 AddNameToParameter: migrating ===============================
-- add_column(:parameters, :name, :string)
   -> 0.0352s
== 20171205210813 AddNameToParameter: migrated (0.0353s) ======================

== 20171205211037 AddStatusToSell: migrating ==================================
-- add_column(:sells, :status, :integer)
   -> 0.0291s
== 20171205211037 AddStatusToSell: migrated (0.0292s) =========================

== 20171206022240 CreateTrees: migrating ======================================
-- create_table(:trees)
   -> 0.0110s
== 20171206022240 CreateTrees: migrated (0.0111s) =============================

== 20171206022916 AddIndicatedToClient: migrating =============================
-- add_column(:clients, :indicated, :integer)
   -> 0.0355s
== 20171206022916 AddIndicatedToClient: migrated (0.0357s) ====================

== 20171206113728 AddBirthdateToClient: migrating =============================
-- add_column(:clients, :birthdate, :date)
   -> 0.0259s
== 20171206113728 AddBirthdateToClient: migrated (0.0260s) ====================

== 20171206123159 CreateRescuetypes: migrating ================================
-- create_table(:rescuetypes)
   -> 0.0116s
== 20171206123159 CreateRescuetypes: migrated (0.0117s) =======================

== 20171206140458 AddBankRefToClient: migrating ===============================
-- add_reference(:clients, :bank, {:foreign_key=>true})