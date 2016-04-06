emerge -v udev

These are the packages that would be merged, in order:

Calculating dependencies... done!
[ebuild   R    ] sys-fs/udev-216::gentoo  USE="acl firmware-loader gudev introspection kmod -doc (-selinux) -static-libs" ABI_X86="(64) -32* (-x32)" 0 KiB

Total: 1 package (1 reinstall), Size of downloads: 0 KiB

!!! Multiple package instances within a single package slot have been pulled
!!! into the dependency graph, resulting in a slot conflict:

sys-fs/udev:0

  (sys-fs/udev-216:0/0::gentoo, ebuild scheduled for merge) pulled in by
    sys-fs/udev (Argument)

  (sys-fs/udev-216:0/0::gentoo, installed) pulled in by
    >=sys-fs/udev-208-r1:0/0[abi_x86_32(-)?,abi_x86_64(-)?,abi_x86_x32(-)?,abi_mips_n32(-)?,abi_mips_n64(-)?,abi_mips_o32(-)?,abi_ppc_32(-)?,abi_ppc_64(-)?,abi_s390_32(-)?,abi_s390_64(-)?,static-libs?] required by (virtual/libudev-215-r1:0/1::gentoo, installed)
                                                                                                                                                                                                                                                                                      


It may be possible to solve this problem by using package.mask to
prevent one of those packages from being selected. However, it is also
possible that conflicting dependencies exist such that they are
impossible to satisfy simultaneously.  If such a conflict exists in
the dependencies of two different packages, then those packages can
not be installed simultaneously. You may want to try a larger value of
the --backtrack option, such as --backtrack=30, in order to see if
that will solve this conflict automatically.

For more information, see MASKED PACKAGES section in the emerge man
page or refer to the Gentoo Handbook.