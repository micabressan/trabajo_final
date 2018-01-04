# Logfile created on 2017-12-14 02:03:20 +0000 by logger.rb/56815
  INFO ---------------------------------------------------------------------------
  INFO START 2017-12-14 02:03:20 +0000 cap production deploy
  INFO ---------------------------------------------------------------------------
  INFO [8d3e6a1e] Running /usr/bin/env mkdir -p /tmp as root@138.197.33.107
 DEBUG [8d3e6a1e] Command: /usr/bin/env mkdir -p /tmp
  INFO [8d3e6a1e] Finished in 1.776 seconds with exit status 0 (successful).
 DEBUG Uploading /tmp/git-ssh-maisjoias-production-vagrant.sh 0.0%
  INFO Uploading /tmp/git-ssh-maisjoias-production-vagrant.sh 100.0%
  INFO [babb68f3] Running /usr/bin/env chmod 700 /tmp/git-ssh-maisjoias-production-vagrant.sh as root@138.197.33.107
 DEBUG [babb68f3] Command: /usr/bin/env chmod 700 /tmp/git-ssh-maisjoias-production-vagrant.sh
  INFO [babb68f3] Finished in 0.448 seconds with exit status 0 (successful).
  INFO [f6ea4fec] Running /usr/bin/env git ls-remote https://davidejhonatan@bitbucket.org/davidejhonatan/maisjoias.git HEAD as root@138.197.33.107
 DEBUG [f6ea4fec] Command: ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env git ls-remote https://davidejhonatan@bitbucket.org/davidejhonatan/maisjoias.git HEAD )
 DEBUG [f6ea4fec] 	6aca0defdf8f7e6e7294f4bd3a637fac88bc7c65	HEAD
  INFO [f6ea4fec] Finished in 0.733 seconds with exit status 0 (successful).
  INFO [a10110fe] Running /usr/bin/env mkdir -p /var/www/maisjoias/shared /var/www/maisjoias/releases as root@138.197.33.107
 DEBUG [a10110fe] Command: /usr/bin/env mkdir -p /var/www/maisjoias/shared /var/www/maisjoias/releases
  INFO [a10110fe] Finished in 0.439 seconds with exit status 0 (successful).
  INFO [6fd4e6ed] Running /usr/bin/env mkdir -p /var/www/maisjoias/shared/log /var/www/maisjoias/shared/tmp/pids /var/www/maisjoias/shared/tmp/cache /var/www/maisjoias/shared/tmp/sockets /var/www/maisjoias/shared/vendor/bundle /var/www/maisjoias/shared/public/system /var/www/maisjoias/shared/public/uploads /var/www/maisjoias/shared/public/assets as root@138.197.33.107
 DEBUG [6fd4e6ed] Command: /usr/bin/env mkdir -p /var/www/maisjoias/shared/log /var/www/maisjoias/shared/tmp/pids /var/www/maisjoias/shared/tmp/cache /var/www/maisjoias/shared/tmp/sockets /var/www/maisjoias/shared/vendor/bundle /var/www/maisjoias/shared/public/system /var/www/maisjoias/shared/public/uploads /var/www/maisjoias/shared/public/assets
  INFO [6fd4e6ed] Finished in 0.441 seconds with exit status 0 (successful).
  INFO [c511d0a7] Running /usr/bin/env mkdir -p /var/www/maisjoias/shared/config as root@138.197.33.107
 DEBUG [c511d0a7] Command: /usr/bin/env mkdir -p /var/www/maisjoias/shared/config
  INFO [c511d0a7] Finished in 0.438 seconds with exit status 0 (successful).
 DEBUG [591dbc7a] Running [ -f /var/www/maisjoias/shared/config/database.yml ] as root@138.197.33.107
 DEBUG [591dbc7a] Command: [ -f /var/www/maisjoias/shared/config/database.yml ]
 DEBUG [591dbc7a] Finished in 0.439 seconds with exit status 0 (successful).
 DEBUG [70393115] Running [ -f /var/www/maisjoias/shared/config/secrets.yml ] as root@138.197.33.107
 DEBUG [70393115] Command: [ -f /var/www/maisjoias/shared/config/secrets.yml ]
 DEBUG [70393115] Finished in 0.277 seconds with exit status 0 (successful).
 DEBUG [6bef1de5] Running [ -f /var/www/maisjoias/current/REVISION ] as root@138.197.33.107
 DEBUG [6bef1de5] Command: [ -f /var/www/maisjoias/current/REVISION ]
 DEBUG [6bef1de5] Finished in 0.442 seconds with exit status 1 (failed).
 DEBUG [0e4acc38] Running [ -f /var/www/maisjoias/repo/HEAD ] as root@138.197.33.107
 DEBUG [0e4acc38] Command: [ -f /var/www/maisjoias/repo/HEAD ]
 DEBUG [0e4acc38] Finished in 0.439 seconds with exit status 0 (successful).
  INFO The repository mirror is at /var/www/maisjoias/repo
 DEBUG [89860bd6] Running if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [89860bd6] Command: if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi
 DEBUG [89860bd6] Finished in 0.438 seconds with exit status 0 (successful).
  INFO [8c29198f] Running /usr/bin/env git remote set-url origin https://davidejhonatan@bitbucket.org/davidejhonatan/maisjoias.git as root@138.197.33.107
 DEBUG [8c29198f] Command: cd /var/www/maisjoias/repo && ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env git remote set-url origin https://davidejhonatan@bitbucket.org/davidejhonatan/maisjoias.git )
  INFO [8c29198f] Finished in 0.459 seconds with exit status 0 (successful).
  INFO [0238f96a] Running /usr/bin/env git remote update --prune as root@138.197.33.107
 DEBUG [0238f96a] Command: cd /var/www/maisjoias/repo && ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env git remote update --prune )
 DEBUG [0238f96a] 	Fetching origin
  INFO [0238f96a] Finished in 0.714 seconds with exit status 0 (successful).
 DEBUG [7ca36442] Running if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [7ca36442] Command: if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi
 DEBUG [7ca36442] Finished in 0.450 seconds with exit status 0 (successful).
  INFO [53a1e5ba] Running /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214020327 as root@138.197.33.107
 DEBUG [53a1e5ba] Command: cd /var/www/maisjoias/repo && ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214020327 )
  INFO [53a1e5ba] Finished in 0.451 seconds with exit status 0 (successful).
  INFO [840798b9] Running /usr/bin/env git archive master | /usr/bin/env tar -x -f - -C /var/www/maisjoias/releases/20171214020327 as root@138.197.33.107
 DEBUG [840798b9] Command: cd /var/www/maisjoias/repo && ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env git archive master | /usr/bin/env tar -x -f - -C /var/www/maisjoias/releases/20171214020327 )
  INFO [840798b9] Finished in 0.559 seconds with exit status 0 (successful).
 DEBUG [f3fee15f] Running if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [f3fee15f] Command: if test ! -d /var/www/maisjoias/repo; then echo "Directory does not exist '/var/www/maisjoias/repo'" 1>&2; false; fi
 DEBUG [f3fee15f] Finished in 0.436 seconds with exit status 0 (successful).
 DEBUG [fe5563d3] Running /usr/bin/env git rev-list --max-count=1 master as root@138.197.33.107
 DEBUG [fe5563d3] Command: cd /var/www/maisjoias/repo && ( export GIT_ASKPASS="/bin/echo" GIT_SSH="/tmp/git-ssh-maisjoias-production-vagrant.sh" ; /usr/bin/env git rev-list --max-count=1 master )
 DEBUG [fe5563d3] 	6aca0defdf8f7e6e7294f4bd3a637fac88bc7c65
 DEBUG [fe5563d3] Finished in 0.455 seconds with exit status 0 (successful).
 DEBUG [0e722046] Running if test ! -d /var/www/maisjoias/releases/20171214020327; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214020327'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [0e722046] Command: if test ! -d /var/www/maisjoias/releases/20171214020327; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214020327'" 1>&2; false; fi
 DEBUG [0e722046] Finished in 0.437 seconds with exit status 0 (successful).
  INFO [8b0679e3] Running /usr/bin/env echo "6aca0defdf8f7e6e7294f4bd3a637fac88bc7c65" >> REVISION as root@138.197.33.107
 DEBUG [8b0679e3] Command: cd /var/www/maisjoias/releases/20171214020327 && /usr/bin/env echo "6aca0defdf8f7e6e7294f4bd3a637fac88bc7c65" >> REVISION
  INFO [8b0679e3] Finished in 0.442 seconds with exit status 0 (successful).
  INFO [59a63128] Running /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214020327/config as root@138.197.33.107
 DEBUG [59a63128] Command: /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214020327/config
  INFO [59a63128] Finished in 0.442 seconds with exit status 0 (successful).
 DEBUG [aa75a270] Running [ -L /var/www/maisjoias/releases/20171214020327/config/database.yml ] as root@138.197.33.107
 DEBUG [aa75a270] Command: [ -L /var/www/maisjoias/releases/20171214020327/config/database.yml ]
 DEBUG [aa75a270] Finished in 0.436 seconds with exit status 1 (failed).
 DEBUG [458c1a1a] Running [ -f /var/www/maisjoias/releases/20171214020327/config/database.yml ] as root@138.197.33.107
 DEBUG [458c1a1a] Command: [ -f /var/www/maisjoias/releases/20171214020327/config/database.yml ]
 DEBUG [458c1a1a] Finished in 0.443 seconds with exit status 0 (successful).
  INFO [05d19e41] Running /usr/bin/env rm /var/www/maisjoias/releases/20171214020327/config/database.yml as root@138.197.33.107
 DEBUG [05d19e41] Command: /usr/bin/env rm /var/www/maisjoias/releases/20171214020327/config/database.yml
  INFO [05d19e41] Finished in 0.446 seconds with exit status 0 (successful).
  INFO [098e76ba] Running /usr/bin/env ln -s /var/www/maisjoias/shared/config/database.yml /var/www/maisjoias/releases/20171214020327/config/database.yml as root@138.197.33.107
 DEBUG [098e76ba] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/config/database.yml /var/www/maisjoias/releases/20171214020327/config/database.yml
  INFO [098e76ba] Finished in 0.444 seconds with exit status 0 (successful).
 DEBUG [857e2e82] Running [ -L /var/www/maisjoias/releases/20171214020327/config/secrets.yml ] as root@138.197.33.107
 DEBUG [857e2e82] Command: [ -L /var/www/maisjoias/releases/20171214020327/config/secrets.yml ]
 DEBUG [857e2e82] Finished in 0.437 seconds with exit status 1 (failed).
 DEBUG [2e3f7963] Running [ -f /var/www/maisjoias/releases/20171214020327/config/secrets.yml ] as root@138.197.33.107
 DEBUG [2e3f7963] Command: [ -f /var/www/maisjoias/releases/20171214020327/config/secrets.yml ]
 DEBUG [2e3f7963] Finished in 0.441 seconds with exit status 0 (successful).
  INFO [0d05fbe2] Running /usr/bin/env rm /var/www/maisjoias/releases/20171214020327/config/secrets.yml as root@138.197.33.107
 DEBUG [0d05fbe2] Command: /usr/bin/env rm /var/www/maisjoias/releases/20171214020327/config/secrets.yml
  INFO [0d05fbe2] Finished in 0.440 seconds with exit status 0 (successful).
  INFO [de82b560] Running /usr/bin/env ln -s /var/www/maisjoias/shared/config/secrets.yml /var/www/maisjoias/releases/20171214020327/config/secrets.yml as root@138.197.33.107
 DEBUG [de82b560] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/config/secrets.yml /var/www/maisjoias/releases/20171214020327/config/secrets.yml
  INFO [de82b560] Finished in 0.438 seconds with exit status 0 (successful).
  INFO [393da4ba] Running /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214020327 /var/www/maisjoias/releases/20171214020327/tmp /var/www/maisjoias/releases/20171214020327/vendor /var/www/maisjoias/releases/20171214020327/public as root@138.197.33.107
 DEBUG [393da4ba] Command: /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214020327 /var/www/maisjoias/releases/20171214020327/tmp /var/www/maisjoias/releases/20171214020327/vendor /var/www/maisjoias/releases/20171214020327/public
  INFO [393da4ba] Finished in 0.443 seconds with exit status 0 (successful).
 DEBUG [489f9789] Running [ -L /var/www/maisjoias/releases/20171214020327/log ] as root@138.197.33.107
 DEBUG [489f9789] Command: [ -L /var/www/maisjoias/releases/20171214020327/log ]
 DEBUG [489f9789] Finished in 0.436 seconds with exit status 1 (failed).
 DEBUG [d131a19e] Running [ -d /var/www/maisjoias/releases/20171214020327/log ] as root@138.197.33.107
 DEBUG [d131a19e] Command: [ -d /var/www/maisjoias/releases/20171214020327/log ]
 DEBUG [d131a19e] Finished in 0.444 seconds with exit status 0 (successful).
  INFO [cf42286c] Running /usr/bin/env rm -rf /var/www/maisjoias/releases/20171214020327/log as root@138.197.33.107
 DEBUG [cf42286c] Command: /usr/bin/env rm -rf /var/www/maisjoias/releases/20171214020327/log
  INFO [cf42286c] Finished in 0.458 seconds with exit status 0 (successful).
  INFO [c980fcd3] Running /usr/bin/env ln -s /var/www/maisjoias/shared/log /var/www/maisjoias/releases/20171214020327/log as root@138.197.33.107
 DEBUG [c980fcd3] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/log /var/www/maisjoias/releases/20171214020327/log
  INFO [c980fcd3] Finished in 0.437 seconds with exit status 0 (successful).
 DEBUG [aa5c959a] Running [ -L /var/www/maisjoias/releases/20171214020327/tmp/pids ] as root@138.197.33.107
 DEBUG [aa5c959a] Command: [ -L /var/www/maisjoias/releases/20171214020327/tmp/pids ]
 DEBUG [aa5c959a] Finished in 0.437 seconds with exit status 1 (failed).
 DEBUG [84cebc96] Running [ -d /var/www/maisjoias/releases/20171214020327/tmp/pids ] as root@138.197.33.107
 DEBUG [84cebc96] Command: [ -d /var/www/maisjoias/releases/20171214020327/tmp/pids ]
 DEBUG [84cebc96] Finished in 0.442 seconds with exit status 1 (failed).
  INFO [3351aaf5] Running /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/pids /var/www/maisjoias/releases/20171214020327/tmp/pids as root@138.197.33.107
 DEBUG [3351aaf5] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/pids /var/www/maisjoias/releases/20171214020327/tmp/pids
  INFO [3351aaf5] Finished in 0.441 seconds with exit status 0 (successful).
 DEBUG [1574f0c4] Running [ -L /var/www/maisjoias/releases/20171214020327/tmp/cache ] as root@138.197.33.107
 DEBUG [1574f0c4] Command: [ -L /var/www/maisjoias/releases/20171214020327/tmp/cache ]
 DEBUG [1574f0c4] Finished in 0.444 seconds with exit status 1 (failed).
 DEBUG [9cbd3d96] Running [ -d /var/www/maisjoias/releases/20171214020327/tmp/cache ] as root@138.197.33.107
 DEBUG [9cbd3d96] Command: [ -d /var/www/maisjoias/releases/20171214020327/tmp/cache ]
 DEBUG [9cbd3d96] Finished in 0.441 seconds with exit status 1 (failed).
  INFO [8eab118f] Running /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/cache /var/www/maisjoias/releases/20171214020327/tmp/cache as root@138.197.33.107
 DEBUG [8eab118f] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/cache /var/www/maisjoias/releases/20171214020327/tmp/cache
  INFO [8eab118f] Finished in 0.435 seconds with exit status 0 (successful).
 DEBUG [266b52c3] Running [ -L /var/www/maisjoias/releases/20171214020327/tmp/sockets ] as root@138.197.33.107
 DEBUG [266b52c3] Command: [ -L /var/www/maisjoias/releases/20171214020327/tmp/sockets ]
 DEBUG [266b52c3] Finished in 0.436 seconds with exit status 1 (failed).
 DEBUG [84760ad3] Running [ -d /var/www/maisjoias/releases/20171214020327/tmp/sockets ] as root@138.197.33.107
 DEBUG [84760ad3] Command: [ -d /var/www/maisjoias/releases/20171214020327/tmp/sockets ]
 DEBUG [84760ad3] Finished in 0.448 seconds with exit status 1 (failed).
  INFO [443a1efd] Running /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/sockets /var/www/maisjoias/releases/20171214020327/tmp/sockets as root@138.197.33.107
 DEBUG [443a1efd] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/tmp/sockets /var/www/maisjoias/releases/20171214020327/tmp/sockets
  INFO [443a1efd] Finished in 0.447 seconds with exit status 0 (successful).
 DEBUG [c76ef2a6] Running [ -L /var/www/maisjoias/releases/20171214020327/vendor/bundle ] as root@138.197.33.107
 DEBUG [c76ef2a6] Command: [ -L /var/www/maisjoias/releases/20171214020327/vendor/bundle ]
 DEBUG [c76ef2a6] Finished in 0.439 seconds with exit status 1 (failed).
 DEBUG [71c4eb34] Running [ -d /var/www/maisjoias/releases/20171214020327/vendor/bundle ] as root@138.197.33.107
 DEBUG [71c4eb34] Command: [ -d /var/www/maisjoias/releases/20171214020327/vendor/bundle ]
 DEBUG [71c4eb34] Finished in 0.439 seconds with exit status 1 (failed).
  INFO [70f5d892] Running /usr/bin/env ln -s /var/www/maisjoias/shared/vendor/bundle /var/www/maisjoias/releases/20171214020327/vendor/bundle as root@138.197.33.107
 DEBUG [70f5d892] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/vendor/bundle /var/www/maisjoias/releases/20171214020327/vendor/bundle
  INFO [70f5d892] Finished in 0.447 seconds with exit status 0 (successful).
 DEBUG [58c900e7] Running [ -L /var/www/maisjoias/releases/20171214020327/public/system ] as root@138.197.33.107
 DEBUG [58c900e7] Command: [ -L /var/www/maisjoias/releases/20171214020327/public/system ]
 DEBUG [58c900e7] Finished in 0.434 seconds with exit status 1 (failed).
 DEBUG [c3ce37aa] Running [ -d /var/www/maisjoias/releases/20171214020327/public/system ] as root@138.197.33.107
 DEBUG [c3ce37aa] Command: [ -d /var/www/maisjoias/releases/20171214020327/public/system ]
 DEBUG [c3ce37aa] Finished in 0.438 seconds with exit status 1 (failed).
  INFO [daf11197] Running /usr/bin/env ln -s /var/www/maisjoias/shared/public/system /var/www/maisjoias/releases/20171214020327/public/system as root@138.197.33.107
 DEBUG [daf11197] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/public/system /var/www/maisjoias/releases/20171214020327/public/system
  INFO [daf11197] Finished in 0.450 seconds with exit status 0 (successful).
 DEBUG [3b336fd4] Running [ -L /var/www/maisjoias/releases/20171214020327/public/uploads ] as root@138.197.33.107
 DEBUG [3b336fd4] Command: [ -L /var/www/maisjoias/releases/20171214020327/public/uploads ]
 DEBUG [3b336fd4] Finished in 0.473 seconds with exit status 1 (failed).
 DEBUG [ef4f635e] Running [ -d /var/www/maisjoias/releases/20171214020327/public/uploads ] as root@138.197.33.107
 DEBUG [ef4f635e] Command: [ -d /var/www/maisjoias/releases/20171214020327/public/uploads ]
 DEBUG [ef4f635e] Finished in 0.433 seconds with exit status 1 (failed).
  INFO [f10efb02] Running /usr/bin/env ln -s /var/www/maisjoias/shared/public/uploads /var/www/maisjoias/releases/20171214020327/public/uploads as root@138.197.33.107
 DEBUG [f10efb02] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/public/uploads /var/www/maisjoias/releases/20171214020327/public/uploads
  INFO [f10efb02] Finished in 0.440 seconds with exit status 0 (successful).
 DEBUG [bc1c885f] Running [ -L /var/www/maisjoias/releases/20171214020327/public/assets ] as root@138.197.33.107
 DEBUG [bc1c885f] Command: [ -L /var/www/maisjoias/releases/20171214020327/public/assets ]
 DEBUG [bc1c885f] Finished in 0.446 seconds with exit status 1 (failed).
 DEBUG [2301949a] Running [ -d /var/www/maisjoias/releases/20171214020327/public/assets ] as root@138.197.33.107
 DEBUG [2301949a] Command: [ -d /var/www/maisjoias/releases/20171214020327/public/assets ]
 DEBUG [2301949a] Finished in 0.447 seconds with exit status 1 (failed).
  INFO [e76c8880] Running /usr/bin/env ln -s /var/www/maisjoias/shared/public/assets /var/www/maisjoias/releases/20171214020327/public/assets as root@138.197.33.107
 DEBUG [e76c8880] Command: /usr/bin/env ln -s /var/www/maisjoias/shared/public/assets /var/www/maisjoias/releases/20171214020327/public/assets
  INFO [e76c8880] Finished in 0.440 seconds with exit status 0 (successful).
 DEBUG [d7f56012] Running if test ! -d /var/www/maisjoias/releases/20171214020327; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214020327'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [d7f56012] Command: if test ! -d /var/www/maisjoias/releases/20171214020327; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214020327'" 1>&2; false; fi
 DEBUG [d7f56012] Finished in 0.440 seconds with exit status 0 (successful).
 DEBUG [f0baf987] Running /usr/bin/env bundle check --path /var/www/maisjoias/shared/bundle as root@138.197.33.107
 DEBUG [f0baf987] Command: cd /var/www/maisjoias/releases/20171214020327 && /usr/bin/env bundle check --path /var/www/maisjoias/shared/bundle
 DEBUG [f0baf987] 	The following gems are missing
 DEBUG [f0baf987] 	 * public_suffix (3.0.1)
 DEBUG [f0baf987] 	 * addressable (2.5.2)
 DEBUG [f0baf987] 	 * net-ssh (4.2.0)
 DEBUG [f0baf987] 	 * net-scp (1.2.1)
 DEBUG [f0baf987] 	 * sshkit (1.15.1)
 DEBUG [f0baf987] 	 * airbrussh (1.3.0)
 DEBUG [f0baf987] 	 * coderay (1.1.2)
 DEBUG [f0baf987] 	 * better_errors (2.4.0)
 DEBUG [f0baf987] 	 * bindex (0.5.0)
 DEBUG [f0baf987] 	 * debug_inspector (0.0.3)
 DEBUG [f0baf987] 	 * binding_of_caller (0.7.3)
 DEBUG [f0baf987] 	 * byebug (9.1.0)
 DEBUG [f0baf987] 	 * capistrano (3.10.1)
 DEBUG [f0baf987] 	 * capistrano-bundler (1.3.0)
 DEBUG [f0baf987] 	 * capistrano-passenger (0.2.0)
 DEBUG [f0baf987] 	 * capistrano-rails (1.3.1)
 DEBUG [f0baf987] 	 * xpath (2.1.0)
 DEBUG [f0baf987] 	 * capybara (2.16.1)
 DEBUG [f0baf987] 	 * childprocess (0.8.0)
 DEBUG [f0baf987] 	 * choice (0.2.0)
 DEBUG [f0baf987] 	 * cpf_utils (1.2.1)
 DEBUG [f0baf987] 	 * faker (1.8.4)
 DEBUG [f0baf987] 	 * ruby_dep (1.5.0)
 DEBUG [f0baf987] 	 * listen (3.1.5)
 DEBUG [f0baf987] 	 * ruby-graphviz (1.2.3)
 DEBUG [f0baf987] 	 * rails-erd (1.5.2)
 DEBUG [f0baf987] 	 * rubyzip (1.2.1)
 DEBUG [f0baf987] 	 * selenium-webdriver (3.8.0)
 DEBUG [f0baf987] 	 * spring (2.0.2)
 DEBUG [f0baf987] 	 * spring-watcher-listen (2.0.1)
 DEBUG [f0baf987] 	 * web-console (3.5.1)
 DEBUG [f0baf987] 	Install missing gems with `bundle install`
 DEBUG [f0baf987] Finished in 1.070 seconds with exit status 1 (failed).
  INFO [11484067] Running /usr/bin/env bundle install --path /var/www/maisjoias/shared/bundle --without development test --deployment --quiet as root@138.197.33.107
 DEBUG [11484067] Command: cd /var/www/maisjoias/releases/20171214020327 && /usr/bin/env bundle install --path /var/www/maisjoias/shared/bundle --without development test --deployment --quiet
  INFO [11484067] Finished in 1.037 seconds with exit status 0 (successful).
 DEBUG [061daf08] Running if test ! -d /var/www/maisjoias/releases/20171214020327; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214020327'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [061daf08] Command: if test ! -d /var/www/maisjoias/releases/20171214020327; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214020327'" 1>&2; false; fi
 DEBUG [061daf08] Finished in 0.445 seconds with exit status 0 (successful).
  INFO [0c0199e8] Running bundle exec rake assets:precompile as root@138.197.33.107
 DEBUG [0c0199e8] Command: cd /var/www/maisjoias/releases/20171214020327 && ( export RAILS_ENV="production" RAILS_GROUPS="" ; bundle exec rake assets:precompile )
  INFO [0c0199e8] Finished in 3.605 seconds with exit status 0 (successful).
 DEBUG [3da599df] Running if test ! -d /var/www/maisjoias/releases/20171214020327; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214020327'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [3da599df] Command: if test ! -d /var/www/maisjoias/releases/20171214020327; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214020327'" 1>&2; false; fi
 DEBUG [3da599df] Finished in 0.432 seconds with exit status 0 (successful).
  INFO [ba153114] Running /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214020327/assets_manifest_backup as root@138.197.33.107
 DEBUG [ba153114] Command: cd /var/www/maisjoias/releases/20171214020327 && /usr/bin/env mkdir -p /var/www/maisjoias/releases/20171214020327/assets_manifest_backup
  INFO [ba153114] Finished in 0.329 seconds with exit status 0 (successful).
 DEBUG [2c1def49] Running /usr/bin/env ls /var/www/maisjoias/releases/20171214020327/public/assets/.sprockets-manifest* as root@138.197.33.107
 DEBUG [2c1def49] Command: cd /var/www/maisjoias/releases/20171214020327 && /usr/bin/env ls /var/www/maisjoias/releases/20171214020327/public/assets/.sprockets-manifest*
 DEBUG [2c1def49] 	/var/www/maisjoias/releases/20171214020327/public/assets/.sprockets-manifest-c1eaf3a48261a75ecfbe9dcd344b802d.json
 DEBUG [2c1def49] Finished in 0.449 seconds with exit status 0 (successful).
 DEBUG [531a4093] Running /usr/bin/env ls /var/www/maisjoias/releases/20171214020327/public/assets/.sprockets-manifest* as root@138.197.33.107
 DEBUG [531a4093] Command: cd /var/www/maisjoias/releases/20171214020327 && /usr/bin/env ls /var/www/maisjoias/releases/20171214020327/public/assets/.sprockets-manifest*
 DEBUG [531a4093] 	/var/www/maisjoias/releases/20171214020327/public/assets/.sprockets-manifest-c1eaf3a48261a75ecfbe9dcd344b802d.json
 DEBUG [531a4093] Finished in 0.449 seconds with exit status 0 (successful).
  INFO [2a13dc92] Running /usr/bin/env cp /var/www/maisjoias/releases/20171214020327/public/assets/.sprockets-manifest-c1eaf3a48261a75ecfbe9dcd344b802d.json /var/www/maisjoias/releases/20171214020327/assets_manifest_backup as root@138.197.33.107
 DEBUG [2a13dc92] Command: cd /var/www/maisjoias/releases/20171214020327 && /usr/bin/env cp /var/www/maisjoias/releases/20171214020327/public/assets/.sprockets-manifest-c1eaf3a48261a75ecfbe9dcd344b802d.json /var/www/maisjoias/releases/20171214020327/assets_manifest_backup
  INFO [2a13dc92] Finished in 0.444 seconds with exit status 0 (successful).
  INFO [deploy:migrate] Run `rake db:migrate`
 DEBUG [c2dae99e] Running if test ! -d /var/www/maisjoias/releases/20171214020327; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214020327'" 1>&2; false; fi as root@138.197.33.107
 DEBUG [c2dae99e] Command: if test ! -d /var/www/maisjoias/releases/20171214020327; then echo "Directory does not exist '/var/www/maisjoias/releases/20171214020327'" 1>&2; false; fi
 DEBUG [c2dae99e] Finished in 0.432 seconds with exit status 0 (successful).
  INFO [dfbbcc5f] Running bundle exec rake db:migrate as root@138.197.33.107
 DEBUG [dfbbcc5f] Command: cd /var/www/maisjoias/releases/20171214020327 && ( export RAILS_ENV="production" ; bundle exec rake db:migrate )
 DEBUG [dfbbcc5f] 	rake aborted!
 DEBUG [dfbbcc5f] 	StandardError: An error has occurred, all later migrations canceled:

undefined method `sql_type' for nil:NilClass
 DEBUG [dfbbcc5f] 	/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/errors.rb:140:in `column_type'
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
/var/www/maisjoias/releases/20171214020327/db/migrate/20171206140458_add_bank_ref_to_client.rb:3:in `change'
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
 DEBUG [dfbbcc5f] 	
Caused by:
 DEBUG [dfbbcc5f] 	NoMethodError: undefined method `sql_type' for nil:NilClass
 DEBUG [dfbbcc5f] 	/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/activerecord-5.1.4/lib/active_record/errors.rb:140:in `column_type'
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
/var/www/maisjoias/releases/20171214020327/db/migrate/20171206140458_add_bank_ref_to_client.rb:3:in `change'
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
 DEBUG [dfbbcc5f] 	
Caused by:
 DEBUG [dfbbcc5f] 	Mysql2::Error: Cannot add foreign key constraint
 DEBUG [dfbbcc5f] 	/var/www/maisjoias/shared/bundle/ruby/2.4.0/gems/mysql2-0.4.10/lib/mysql2/client.rb:120:in `_query'
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
/var/www/maisjoias/releases/20171214020327/db/migrate/20171206140458_add_bank_ref_to_client.rb:3:in `change'
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
 DEBUG [dfbbcc5f] 	Tasks: TOP => db:migrate
 DEBUG [dfbbcc5f] 	(See full trace by running task with --trace)
 DEBUG [dfbbcc5f] 	== 20171121123321 DeviseCreateAdmins: migrating ===============================
-- create_table(:admins)
   -> 0.0169s
-- add_index(:admins, :email, {:unique=>true})
   -> 0.0088s
-- add_index(:admins, :reset_password_token, {:unique=>true})
   -> 0.0139s
== 20171121123321 DeviseCreateAdmins: migrated (0.0398s) ======================

== 20171121123357 DeviseCreateClients: migrating ==============================
-- create_table(:clients)
   -> 0.0104s
-- add_index(:clients, :email, {:unique=>true})
   -> 0.0107s
-- add_index(:clients, :reset_password_token, {:unique=>true})
   -> 0.0243s
== 20171121123357 DeviseCreateClients: migrated (0.0458s) =====================

== 20171128234105 CreateBranches: migrating ===================================
-- create_table(:branches)
   -> 0.0146s
== 20171128234105 CreateBranches: migrated (0.0147s) ==========================

== 20171129003639 AddNameAndRoleAndCpfAndRgAndStatusAndBranchRefToAdmin: migrating 
-- add_column(:admins, :name, :string)
   -> 0.0277s
-- add_column(:admins, :role, :integer)
   -> 0.0316s
-- add_column(:admins, :cpf, :string)
   -> 0.0280s
-- add_column(:admins, :rg, :string)
   -> 0.0275s
-- add_column(:admins, :status, :integer)
   -> 0.0282s
-- add_reference(:admins, :branch, {:foreign_key=>true})
   -> 0.0845s
== 20171129003639 AddNameAndRoleAndCpfAndRgAndStatusAndBranchRefToAdmin: migrated (0.2282s) 

== 20171129221615 AddNameAndCpfAndRgAndAddressAndNeighbohodAndCountryToClient: migrating 
-- add_column(:clients, :name, :string)
   -> 0.0272s
-- add_column(:clients, :cpf, :string)
   -> 0.0217s
-- add_column(:clients, :rg, :string)
   -> 0.0249s
-- add_column(:clients, :address, :string)
   -> 0.0205s
-- add_column(:clients, :neighbohod, :string)
   -> 0.0191s
-- add_column(:clients, :country, :string)
   -> 0.0161s
== 20171129221615 AddNameAndCpfAndRgAndAddressAndNeighbohodAndCountryToClient: migrated (0.1299s) 

== 20171129223022 AddComplementAndCityAndTotalPointsRescueAndBranchRefToClient: migrating 
-- add_column(:clients, :complement, :string)
   -> 0.0181s
-- add_column(:clients, :city, :string)
   -> 0.0167s
-- add_column(:clients, :total_points_rescue, :integer)
   -> 0.0164s
-- add_reference(:clients, :branch, {:foreign_key=>true})
   -> 0.0517s
== 20171129223022 AddComplementAndCityAndTotalPointsRescueAndBranchRefToClient: migrated (0.1033s) 

== 20171129223149 AddStateAndStatusAndTotalPointsAndAvailablePointsAndTotalReactiveAndPostalCodeToClient: migrating 
-- add_column(:clients, :state, :string)
   -> 0.0330s
-- add_column(:clients, :status, :integer)
   -> 0.0384s
-- add_column(:clients, :total_points, :integer)
   -> 0.0260s
-- add_column(:clients, :available_points, :integer)
   -> 0.0291s
-- add_column(:clients, :total_reactive, :integer)
   -> 0.0253s
-- add_column(:clients, :postal_code, :string)
   -> 0.0351s
== 20171129223149 AddStateAndStatusAndTotalPointsAndAvailablePointsAndTotalReactiveAndPostalCodeToClient: migrated (0.1874s) 

== 20171129235615 CreatePhones: migrating =====================================
-- create_table(:phones)
   -> 0.0357s
== 20171129235615 CreatePhones: migrated (0.0358s) ============================

== 20171201172901 CreateSells: migrating ======================================
-- create_table(:sells)
   -> 0.0160s
== 20171201172901 CreateSells: migrated (0.0161s) =============================

== 20171202013827 AddSellDateToSell: migrating ================================
-- add_column(:sells, :sell_date, :date)
   -> 0.0284s
== 20171202013827 AddSellDateToSell: migrated (0.0285s) =======================

== 20171205000750 AddSellTypeToSell: migrating ================================
-- add_column(:sells, :sell_type, :string)
   -> 0.0270s
== 20171205000750 AddSellTypeToSell: migrated (0.0271s) =======================

== 20171205180325 CreateParameters: migrating =================================
-- create_table(:parameters)
   -> 0.0275s
== 20171205180325 CreateParameters: migrated (0.0276s) ========================

== 20171205210813 AddNameToParameter: migrating ===============================
-- add_column(:parameters, :name, :string)
   -> 0.0207s
== 20171205210813 AddNameToParameter: migrated (0.0208s) ======================

== 20171205211037 AddStatusToSell: migrating ==================================
-- add_column(:sells, :status, :integer)
   -> 0.0219s
== 20171205211037 AddStatusToSell: migrated (0.0220s) =========================

== 20171206022240 CreateTrees: migrating ======================================
-- create_table(:trees)
   -> 0.0106s
== 20171206022240 CreateTrees: migrated (0.0107s) =============================

== 20171206022916 AddIndicatedToClient: migrating =============================
-- add_column(:clients, :indicated, :integer)
   -> 0.0254s
== 20171206022916 AddIndicatedToClient: migrated (0.0255s) ====================

== 20171206113728 AddBirthdateToClient: migrating =============================
-- add_column(:clients, :birthdate, :date)
   -> 0.0298s
== 20171206113728 AddBirthdateToClient: migrated (0.0299s) ====================

== 20171206123159 CreateRescuetypes: migrating ================================
-- create_table(:rescuetypes)
   -> 0.0109s
== 20171206123159 CreateRescuetypes: migrated (0.0110s) =======================

== 20171206140458 AddBankRefToClient: migrating ===============================
-- add_reference(:clients, :bank, {:foreign_key=>true})