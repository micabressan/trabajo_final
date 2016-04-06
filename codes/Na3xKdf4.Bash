[louis@hostname ~]$ yaourt -S polari-git

==> Downloading polari-git PKGBUILD from AUR...
bsdtar: Failed to set default locale
x .SRCINFO
x PKGBUILD
x polari.install
polari-git 3.19.2.16.g3064de4-1  (2015-12-23 16:15)
( Unsupported package: Potentially dangerous ! )
==> Edit PKGBUILD ? [Y/n] ("A" to abort)
==> ------------------------------------
==> n

==> polari-git dependencies:
 - gjs (already installed)
 - gtk3 (already installed)
 - telepathy-glib (already installed)
 - telepathy-idle (already installed)
 - telepathy-mission-control (already installed)
 - telepathy-logger (already installed)
 - intltool (already installed) [makedepend]
 - gobject-introspection (already installed) [makedepend]
 - desktop-file-utils (already installed) [makedepend]
 - appdata-tools (already installed) [makedepend]


==> Edit polari.install ? [Y/n] ("A" to abort)
==> ------------------------------------------
==> n

==> Continue building polari-git ? [Y/n]
==> ------------------------------------
==> 

==> Building and installing package
==> Making package: polari-git 3.19.2.16.g3064de4-1 (Sun Mar 27 14:43:47 CEST 2016)
==> Checking runtime dependencies...
==> Checking buildtime dependencies...
==> Retrieving sources...
  -> Cloning polari git repo...
Cloning into bare repository '/tmp/yaourt-tmp-louis/aur-polari-git/polari'...
remote: Counting objects: 5965, done.
remote: Compressing objects: 100% (5344/5344), done.
remote: Total 5965 (delta 4436), reused 752 (delta 573)
Receiving objects: 100% (5965/5965), 3.66 MiB | 2.03 MiB/s, done.
Resolving deltas: 100% (4436/4436), done.
Checking connectivity... done.
==> Validating source files with sha256sums...
    polari ... Skipped
==> Extracting sources...
  -> Creating working copy of polari git repo...
Cloning into 'polari'...
done.
==> Starting pkgver()...
==> Updated version: polari-git 3.20.0.3.g4a23fd8-1
==> Starting build()...
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
aclocal: installing 'm4/appstream-xml.m4' from '/usr/share/aclocal/appstream-xml.m4'
aclocal: installing 'm4/gsettings.m4' from '/usr/share/aclocal/gsettings.m4'
aclocal: installing 'm4/intltool.m4' from '/usr/share/aclocal/intltool.m4'
aclocal: installing 'm4/introspection.m4' from '/usr/share/aclocal/introspection.m4'
aclocal: installing 'm4/libtool.m4' from '/usr/share/aclocal/libtool.m4'
aclocal: installing 'm4/ltoptions.m4' from '/usr/share/aclocal/ltoptions.m4'
aclocal: installing 'm4/ltsugar.m4' from '/usr/share/aclocal/ltsugar.m4'
aclocal: installing 'm4/ltversion.m4' from '/usr/share/aclocal/ltversion.m4'
aclocal: installing 'm4/lt~obsolete.m4' from '/usr/share/aclocal/lt~obsolete.m4'
aclocal: installing 'm4/nls.m4' from '/usr/share/aclocal/nls.m4'
aclocal: installing 'm4/pkg.m4' from '/usr/share/aclocal/pkg.m4'
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal --force --warnings=no-portability -I m4 ${ACLOCAL_FLAGS}
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
autoreconf: configure.ac: tracing
autoreconf: configure.ac: creating directory build-aux
autoreconf: running: libtoolize --copy --force
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, 'build-aux'.
libtoolize: copying file 'build-aux/ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIRS, 'm4'.
libtoolize: copying file 'm4/libtool.m4'
libtoolize: copying file 'm4/ltoptions.m4'
libtoolize: copying file 'm4/ltsugar.m4'
libtoolize: copying file 'm4/ltversion.m4'
libtoolize: copying file 'm4/lt~obsolete.m4'
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
autoreconf: running: /usr/bin/autoconf --force --warnings=no-portability
autoreconf: configure.ac: not using Autoheader
autoreconf: running: automake --add-missing --copy --force-missing --warnings=no-portability
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_DK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
Unescaped left brace in regex is deprecated, passed through in regex; marked by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line 3936.
configure.ac:27: installing 'build-aux/ar-lib'
configure.ac:21: installing 'build-aux/compile'
configure.ac:29: installing 'build-aux/config.guess'
configure.ac:29: installing 'build-aux/config.sub'
configure.ac:9: installing 'build-aux/install-sh'
configure.ac:9: installing 'build-aux/missing'
src/Makefile.am: installing 'build-aux/depcomp'
autoreconf: Leaving directory `.'
configure: WARNING: unrecognized options: --disable-Werror
./configure: line 2304: syntax error near unexpected token `git-directory'
./configure: line 2304: `AX_IS_RELEASE(git-directory)'
==> ERROR: A failure occurred in build().
    Aborting...
==> ERROR: Makepkg was unable to build polari-git.
==> Restart building polari-git ? [y/N]
==> -----------------------------------
==>