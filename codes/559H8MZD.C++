joshndroid@joshndroid:~/temakernel$ make bootimage
============================================
PLATFORM_VERSION_CODENAME=REL
PLATFORM_VERSION=5.1.1
CM_VERSION=12.1-20150824-UNOFFICIAL-temasek-lt03wifi
TARGET_PRODUCT=cm_lt03wifi
TARGET_BUILD_VARIANT=userdebug
TARGET_BUILD_TYPE=release
TARGET_BUILD_APPS=
TARGET_ARCH=arm
TARGET_ARCH_VARIANT=armv7-a-neon
TARGET_CPU_VARIANT=cortex-a15
TARGET_2ND_ARCH=
TARGET_2ND_ARCH_VARIANT=
TARGET_2ND_CPU_VARIANT=
HOST_ARCH=x86_64
HOST_OS=linux
HOST_OS_EXTRA=Linux-3.16.0-4-amd64-x86_64-with-debian-8.1
HOST_BUILD_TYPE=release
BUILD_ID=LVY48E
OUT_DIR=/home/joshndroid/temakernel/out
============================================
"ebtables is disabled on this build"
find: `dummy': No such file or directory
PRODUCT_COPY_FILES device/samsung/lt03wifi/configs/audio_effects.conf:system/etc/audio_effects.conf ignored.
build/core/Makefile:46: warning: overriding recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/etc/wifi/wpa_supplicant.conf'
build/core/base_rules.mk:550: warning: ignoring old recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/etc/wifi/wpa_supplicant.conf'
build/core/Makefile:46: warning: overriding recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/vendor/lib/mediadrm/libdrmclearkeyplugin.so'
build/core/base_rules.mk:550: warning: ignoring old recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/vendor/lib/mediadrm/libdrmclearkeyplugin.so'
build/core/Makefile:46: warning: overriding recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.AVC.Decoder.so'
build/core/base_rules.mk:550: warning: ignoring old recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.AVC.Decoder.so'
build/core/Makefile:46: warning: overriding recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.AVC.Encoder.so'
build/core/base_rules.mk:550: warning: ignoring old recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.AVC.Encoder.so'
build/core/Makefile:46: warning: overriding recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.MPEG4.Decoder.so'
build/core/base_rules.mk:550: warning: ignoring old recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.MPEG4.Decoder.so'
build/core/Makefile:46: warning: overriding recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.MPEG4.Encoder.so'
build/core/base_rules.mk:550: warning: ignoring old recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.MPEG4.Encoder.so'
build/core/Makefile:46: warning: overriding recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.VP8.Decoder.so'
build/core/base_rules.mk:550: warning: ignoring old recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.VP8.Decoder.so'
build/core/Makefile:46: warning: overriding recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.VP8.Encoder.so'
build/core/base_rules.mk:550: warning: ignoring old recipe for target '/home/joshndroid/temakernel/out/target/product/lt03wifi/system/lib/omx/libOMX.Exynos.VP8.Encoder.so'
No private recovery resources for TARGET_DEVICE lt03wifi
make  -C kernel/samsung/lt03wifi O=/home/joshndroid/temakernel/out/target/product/lt03wifi/obj/KERNEL_OBJ ARCH=arm CROSS_COMPILE="/home/joshndroid/temakernel/prebuilts/misc/linux-x86/ccache/ccache arm-eabi-" VARIANT_DEFCONFIG= SELINUX_DEFCONFIG= cyanogenmod_lt03wifi_defconfig
make[1]: Entering directory '/home/joshndroid/temakernel/kernel/samsung/lt03wifi'
  GEN     /home/joshndroid/temakernel/out/target/product/lt03wifi/obj/KERNEL_OBJ/Makefile
arch/arm/mach-exynos/Kconfig:1586:warning: choice value used outside its choice group
arch/arm/mach-exynos/Kconfig:1587:warning: defaults for choice values not supported
drivers/misc/mdm_if/Kconfig:47:warning: defaults for choice values not supported
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:575:warning: override: reassigning to symbol COMPACTION
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:583:warning: override: reassigning to symbol CRYPTO_SHA256
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:586:warning: override: reassigning to symbol ECRYPT_FS
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:587:warning: override: reassigning to symbol WTL_ENCRYPTION_FILTER
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:588:warning: override: reassigning to symbol KEYS
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:589:warning: override: reassigning to symbol KEYS_DEBUG_PROC_KEYS
#
# configuration written to .config
#
make[1]: Leaving directory '/home/joshndroid/temakernel/kernel/samsung/lt03wifi'
make[1]: Entering directory '/home/joshndroid/temakernel/kernel/samsung/lt03wifi'
  GEN     /home/joshndroid/temakernel/out/target/product/lt03wifi/obj/KERNEL_OBJ/Makefile
arch/arm/mach-exynos/Kconfig:1586:warning: choice value used outside its choice group
arch/arm/mach-exynos/Kconfig:1587:warning: defaults for choice values not supported
drivers/misc/mdm_if/Kconfig:47:warning: defaults for choice values not supported
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:575:warning: override: reassigning to symbol COMPACTION
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:583:warning: override: reassigning to symbol CRYPTO_SHA256
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:586:warning: override: reassigning to symbol ECRYPT_FS
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:587:warning: override: reassigning to symbol WTL_ENCRYPTION_FILTER
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:588:warning: override: reassigning to symbol KEYS
arch/arm/configs/cyanogenmod_lt03wifi_defconfig:589:warning: override: reassigning to symbol KEYS_DEBUG_PROC_KEYS
#
# configuration written to .config
#
make[1]: Leaving directory '/home/joshndroid/temakernel/kernel/samsung/lt03wifi'
make[1]: Entering directory '/home/joshndroid/temakernel/kernel/samsung/lt03wifi'
  CHK     include/linux/version.h
make[1]: Leaving directory '/home/joshndroid/temakernel/kernel/samsung/lt03wifi'
make  -C kernel/samsung/lt03wifi O=/home/joshndroid/temakernel/out/target/product/lt03wifi/obj/KERNEL_OBJ ARCH=arm CROSS_COMPILE="/home/joshndroid/temakernel/prebuilts/misc/linux-x86/ccache/ccache arm-eabi-" zImage
make[1]: Entering directory '/home/joshndroid/temakernel/kernel/samsung/lt03wifi'
  GEN     /home/joshndroid/temakernel/out/target/product/lt03wifi/obj/KERNEL_OBJ/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
arch/arm/mach-exynos/Kconfig:1586:warning: choice value used outside its choice group
arch/arm/mach-exynos/Kconfig:1587:warning: defaults for choice values not supported
drivers/misc/mdm_if/Kconfig:47:warning: defaults for choice values not supported
  Using /home/joshndroid/temakernel/kernel/samsung/lt03wifi as source for kernel
  GEN     /home/joshndroid/temakernel/out/target/product/lt03wifi/obj/KERNEL_OBJ/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[3]: 'include/generated/mach-types.h' is up to date.
  CALL    /home/joshndroid/temakernel/kernel/samsung/lt03wifi/scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      drivers/cpufreq/cpufreq_smartass2.o
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:171:18: error: 'THIS_MODULE' undeclared here (not in a function)
         .owner = THIS_MODULE,
                  ^
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c: In function 'cpufreq_smartass_timer':
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:291:9: error: implicit declaration of function 'cputime64_sub' [-Werror=implicit-function-declaration]
         delta_idle = cputime64_sub(now_idle, this_smartass->time_in_idle);
         ^
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c: At top level:
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:793:9: error: unknown field 'suspend' specified in initializer
         .suspend = smartass_early_suspend,
         ^
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:793:9: error: excess elements in struct initializer [-Werror]
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:793:9: error: (near initialization for 'smartass_power_suspend') [-Werror]
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:794:9: error: unknown field 'resume' specified in initializer
         .resume = smartass_late_resume,
         ^
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:794:9: error: excess elements in struct initializer [-Werror]
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:794:9: error: (near initialization for 'smartass_power_suspend') [-Werror]
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:866:16: error: expected declaration specifiers or '...' before string constant
 MODULE_AUTHOR ("Erasmux");
                ^
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:867:21: error: expected declaration specifiers or '...' before string constant
 MODULE_DESCRIPTION ("'cpufreq_smartass2' - A smart cpufreq governor");
                     ^
../../../../../../kernel/samsung/lt03wifi/drivers/cpufreq/cpufreq_smartass2.c:868:17: error: expected declaration specifiers or '...' before string constant
 MODULE_LICENSE ("GPL");
                 ^
cc1: all warnings being treated as errors
/home/joshndroid/temakernel/kernel/samsung/lt03wifi/scripts/Makefile.build:307: recipe for target 'drivers/cpufreq/cpufreq_smartass2.o' failed
make[4]: *** [drivers/cpufreq/cpufreq_smartass2.o] Error 1
/home/joshndroid/temakernel/kernel/samsung/lt03wifi/scripts/Makefile.build:443: recipe for target 'drivers/cpufreq' failed
make[3]: *** [drivers/cpufreq] Error 2
/home/joshndroid/temakernel/kernel/samsung/lt03wifi/Makefile:953: recipe for target 'drivers' failed
make[2]: *** [drivers] Error 2
Makefile:130: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
make[1]: Leaving directory '/home/joshndroid/temakernel/kernel/samsung/lt03wifi'
build/core/tasks/kernel.mk:229: recipe for target 'TARGET_KERNEL_BINARIES' failed
make: *** [TARGET_KERNEL_BINARIES] Error 2

#### make failed to build some targets (01:02 (mm:ss)) ####

joshndroid@joshndroid:~/temakernel$