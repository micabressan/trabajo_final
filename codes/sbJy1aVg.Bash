U-Boot SPL 2013.10-rc4 (Aug 16 2015 - 13:45:26)
Boot Device: microSD card


U-Boot 2013.10-rc4 (Aug 16 2015 - 13:45:26)

CPU:   Freescale i.MX6Q rev1.2 at 792 MHz
Reset cause: POR
Board: Udoo Quad
DRAM:  1 GiB
MMC:   FSL_SDHC: 0
*** Warning - bad CRC, using default environment

No panel detected: default to LDB-WVGA
Display: LDB-WVGA (800x480)
In:    serial
Out:   serial
Err:   serial
Net:   using phy at 6
FEC [PRIME]
Hit any key to stop autoboot:  0
mmc0 is current device
SD/MMC found on device 0
593 bytes read in 9 ms (63.5 KiB/s)
Importing environment from mmc (uEnv.txt)...
Checking if uenvcmd is set ...
Running default loadimage ...
5634560 bytes read in 259 ms (20.7 MiB/s)
34894 bytes read in 16 ms (2.1 MiB/s)
Booting from mmc ...
Kernel image @ 0x12000000 [ 0x000000 - 0x55fa00 ]
## Flattened Device Tree blob at 18000000
   Booting using the fdt blob at 0x18000000
   Using Device Tree in place at 18000000, end 1800b84d

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.14.48 (vpeter@server) (gcc version 4.9.3 (GCC) ) #1 SMP Sun Aug 16 13:23:15 CEST 2015
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Udoo i.MX6 Quad Board
[    0.000000] cma: CMA: reserved 256 MiB at 2e000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] PERCPU: Embedded 7 pages/cpu @eef45000 s6848 r8192 d13632 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
[    0.000000] Kernel command line: boot=/dev/mmcblk0p1 disk=/dev/mmcblk0p2 ssh console=ttymxc1,115200 video=mxcfb0:dev=hdmi,1920x1080M@60,if=RGB24,bpp=32 dmfc=3 consoleblank=0
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 766184K/1048576K available (6623K kernel code, 343K rwdata, 1788K rodata, 1438K init, 292K bss, 282392K reserved, 270336K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc083f004   (8413 kB)
[    0.000000]       .init : 0xc0840000 - 0xc09a7ac0   (1439 kB)
[    0.000000]       .data : 0xc09a8000 - 0xc09fdd60   ( 344 kB)
[    0.000000]        .bss : 0xc09fdd68 - 0xc0a4703c   ( 293 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Offload RCU callbacks from all CPUs
[    0.000000]  Offload RCU callbacks from CPUs: 0-3.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x72070000
[    0.000000] Switching to timer-based delay loop
[    0.000007] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 1431655765682ns
[    0.000497] Console: colour dummy device 80x30
[    0.000524] Calibrating delay loop (skipped), value calculated using timer frequency.. 6.25 BogoMIPS (lpj=10000)
[    0.000538] pid_max: default: 32768 minimum: 301
[    0.000714] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000725] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001350] Initializing cgroup subsys bfqio
[    0.001380] CPU: Testing write buffer coherency: ok
[    0.001615] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001667] Setting up static identity map for 0x1067e050 - 0x1067e0a8
[    0.003567] CPU1: Booted secondary processor
[    0.003588] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.004394] CPU2: Booted secondary processor
[    0.004414] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.005205] CPU3: Booted secondary processor
[    0.005224] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.005326] Brought up 4 CPUs
[    0.005354] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.005361] CPU: All CPU(s) started in SVC mode.
[    0.005782] devtmpfs: initialized
[    0.009258] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.022384] pinctrl core: initialized pinctrl subsystem
[    0.022806] regulator-dummy: no parameters
[    0.023078] NET: Registered protocol family 16
[    0.030993] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.031669] CPU identified as i.MX6Q, silicon rev 1.2
[    0.031770] Use WDOG1 as reset source
[    0.040019] syscon 20c8000.anatop: regmap [mem 0x020c8000-0x020c8fff] registered
[    0.040334] vdd1p1: 800 <--> 1375 mV at 1100 mV
[    0.040655] vdd3p0: 2800 <--> 3150 mV at 3000 mV
[    0.040986] vdd2p5: 2000 <--> 2750 mV at 2400 mV
[    0.041308] vddarm: 725 <--> 1450 mV at 1150 mV
[    0.043629] vddpu: 725 <--> 1450 mV at 1150 mV
[    0.043975] vddsoc: 725 <--> 1450 mV at 1200 mV
[    0.045842] syscon 20e0000.iomuxc-gpr: regmap [mem 0x020e0000-0x020e0037] registered
[    0.048649] syscon 21bc000.ocotp-ctrl: regmap [mem 0x021bc000-0x021bffff] registered
[    0.053152] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.064619] bio: create slab <bio-0> at 0
[    0.066684] mxs-dma 110000.dma-apbh: initialized
[    0.067345] usb_h1_vbus: 5000 mV
[    0.067556] usb_otg_vbus: 5000 mV
[    0.067751] 2P5V: 2500 mV
[    0.068029] vgaarb: loaded
[    0.068670] SCSI subsystem initialized
[    0.069096] usbcore: registered new interface driver usbfs
[    0.069159] usbcore: registered new interface driver hub
[    0.069247] usbcore: registered new device driver usb
[    0.069777] i2c i2c-0: IMX I2C adapter registered
[    0.070515] i2c i2c-1: IMX I2C adapter registered
[    0.070811] i2c i2c-2: IMX I2C adapter registered
[    0.070926] Linux video capture interface: v2.00
[    0.071015] pps_core: LinuxPPS API ver. 1 registered
[    0.071024] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.071047] PTP clock support registered
[    0.077016] imx-ipuv3 2400000.ipu: IPU DMFC ONLY-DP HIGH RESOLUTION: 5B(0~3), 5F(4~7)
[    0.083674] imx-ipuv3 2800000.ipu: IPU DMFC ONLY-DP HIGH RESOLUTION: 5B(0~3), 5F(4~7)
[    0.084420] MIPI CSI2 driver module loaded
[    0.084500] Advanced Linux Sound Architecture Driver Initialized.
[    0.085609] Switched to clocksource mxc_timer1
[    0.095801] NET: Registered protocol family 2
[    0.096564] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.096646] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.096770] TCP: Hash tables configured (established 8192 bind 8192)
[    0.096832] TCP: reno registered
[    0.096846] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.096885] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.097150] NET: Registered protocol family 1
[    0.097430] RPC: Registered named UNIX socket transport module.
[    0.097439] RPC: Registered udp transport module.
[    0.097446] RPC: Registered tcp transport module.
[    0.097452] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.148701] imx6_busfreq busfreq.14: DDR medium rate not supported.
[    0.149202] Bus freq driver module loaded
[    0.150154] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.151267] bounce pool size: 64 pages
[    0.160753] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.162468] NFS: Registering the id_resolver key type
[    0.162505] Key type id_resolver registered
[    0.162514] Key type id_legacy registered
[    0.162530] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.163646] msgmni has been set to 1480
[    0.165193] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.165205] io scheduler noop registered
[    0.165213] io scheduler deadline registered
[    0.165399] io scheduler cfq registered
[    0.165578] io scheduler bfq registered (default)
[    0.165587] BFQ I/O-scheduler: v7r8
[    0.166095] imx-weim 21b8000.weim: Driver registered.
[    0.168829] mxc_hdmi 20e0000.hdmi_video: Detected HDMI controller 0x13:0xa:0xa0:0xc1
[    0.168856] fbcvt: 1920x1080@60: CVT Name - 2.073M9
[    0.168974] mxc_sdc_fb fb.23: registered mxc display driver hdmi
[    0.284978] Console: switching to colour frame buffer device 240x67
[    0.337758] imx-sdma 20ec000.sdma: no iram assigned, using external mem
[    0.338212] imx-sdma 20ec000.sdma: no event needs to be remapped
[    0.338647] imx-sdma 20ec000.sdma: loaded firmware 3.1
[    0.341452] imx-sdma 20ec000.sdma: initialized
[    0.341861] Serial: IMX driver
[    0.342297] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 59, base_baud = 5000000) is a IMX
[    1.079741] console [ttymxc1] enabled
[    1.083862] 21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq = 61, base_baud = 5000000) is a IMX
[    1.093841] Galcore version 5.0.11.25762
[    1.462718] brd: module loaded
[    1.465927] loop: module loaded
[    1.470775] nbd: registered device at major 43
[    1.482507] Loading iSCSI transport class v2.0-870.
[    1.487779] iscsi: registered transport (tcp)
[    1.493035] ahci-imx 2200000.sata: fsl,transmit-level-mV not specified, using 00000024
[    1.500989] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not specified, using 00000480
[    1.509021] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not specified, using 00002000
[    1.517223] ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, using 05000000
[    1.528191] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disabled
[    1.535205] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[    1.544030] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo only pmp pio slum part ccc apst
[    1.555315] scsi0 : ahci_platform
[    1.559017] ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] port 0x100 irq 71
[    1.569839] tun: Universal TUN/TAP device driver, 1.6
[    1.574915] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.581965] 2188000.ethernet supply phy not found, using dummy regulator
[    1.589122] pps pps0: new PPS source ptp0
[    1.598870] libphy: fec_enet_mii_bus: probed
[    1.662972] fec 2188000.ethernet eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=2188000.ethernet:06, irq=-1)
[    1.674525] fec 2188000.ethernet eth0: registered PHC device 0
[    1.680601] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.687155] ehci-pci: EHCI PCI platform driver
[    1.691768] usbcore: registered new interface driver usb-storage
[    1.698639] 2184800.usbmisc supply vbus-wakeup not found, using dummy regulator
[    1.714448] ci_hdrc ci_hdrc.1: doesn't support gadget
[    1.719546] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    1.724466] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
[    1.742304] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    1.747879] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.754699] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.761944] usb usb1: Product: EHCI Host Controller
[    1.766844] usb usb1: Manufacturer: Linux 3.14.48 ehci_hcd
[    1.772350] usb usb1: SerialNumber: ci_hdrc.1
[    1.777396] hub 1-0:1.0: USB hub found
[    1.781210] hub 1-0:1.0: 1 port detected
[    1.785939] mousedev: PS/2 mouse device common for all mice
[    1.792345] snvs_rtc 20cc034.snvs-rtc-lp: rtc core: registered 20cc034.snvs-rtc-lp as rtc0
[    1.800748] i2c /dev entries driver
[    1.805114] mxc_v4l2_output v4l2_out.21: V4L2 device registered as video16
[    1.812169] mxc_v4l2_output v4l2_out.21: V4L2 device registered as video17
[    1.819218] mxc_v4l2_output v4l2_out.21: V4L2 device registered as video18
[    1.826283] sdhci: Secure Digital Host Controller Interface driver
[    1.832487] sdhci: Copyright(c) Pierre Ossman
[    1.836860] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.844092] mmc0: no vqmmc regulator found
[    1.848219] mmc0: no vmmc regulator found
[    1.852471] 2198000.usdhc supply card-external-vcc not found, using dummy regulator
[    1.885644] ata1: SATA link down (SStatus 0 SControl 300)
[    1.891101] ahci-imx 2200000.sata: no device found, disabling link.
[    1.897396] ahci-imx 2200000.sata: pass ahci_imx..hotplug=1 to enable hotplug
[    1.935631] mmc0: SDHCI controller on 2198000.usdhc [2198000.usdhc] using ADMA
[    1.943381] mxc_vdoa 21e4000.vdoa: i.MX Video Data Order Adapter(VDOA) driver probed
[    1.951662] mxc_vpu 2040000.vpu: VPU initialized
[    1.983194] mmc0: host does not support reading read-only switch. assuming write-enable.
[    1.998058] mmc0: new high speed SDHC card at address e624
[    2.003985] mmcblk0: mmc0:e624 SP16G 14.8 GiB
[    2.009618]  mmcblk0: p1 p2
[    2.207583] caam 2100000.caam: Instantiated RNG4 SH0
[    2.454778] caam 2100000.caam: Instantiated RNG4 SH1
[    2.459765] caam 2100000.caam: device ID = 0x0a160100 (Era 4)
[    2.465534] caam 2100000.caam: job rings = 2, qi = 0
[    2.488787] caam algorithms registered in /proc/crypto
[    2.497665] caam_jr 2101000.jr0: registering rng-caam
[    2.503595] snvs-secvio 20cc000.caam-snvs: violation handlers armed - non-secure state
[    2.511945] hidraw: raw HID events driver (C) Jiri Kosina
[    2.518656] usbcore: registered new interface driver usbhid
[    2.524260] usbhid: USB HID core driver
[    2.529796] fsl-asrc 2034000.asrc: driver registered
[    2.559279] VT1613 SoC Audio Codec [ID = 5649 - 4123]
[    2.566593] imx-ac97-vt1613 sound.17: vt1613-hifi-analog <-> 2028000.ssi mapping ok
[    2.575676] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    2.594864] imx-audio-hdmi sound-hdmi.18: hdmi-hifi <-> hdmi_audio.3 mapping ok
[    2.603014] TCP: cubic registered
[    2.607107] NET: Registered protocol family 10
[    2.612503] NET: Registered protocol family 17
[    2.617035] Key type dns_resolver registered
[    2.622910] usb_otg_vbus: disabling
[    2.626477] regulator-dummy: disabling
[    2.630564] console [netcon0] enabled
[    2.634259] netconsole: network logging started
[    2.638850] snvs_rtc 20cc034.snvs-rtc-lp: setting system clock to 1970-01-01 00:00:00 UTC (0)
[    2.656288] ALSA device list:
[    2.659294]   #0: imx-vt1613-audio
[    2.662712]   #1: imx-hdmi-soc
[    2.665915] Warning: unable to open an initial console.
[    2.671345] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -2
[    2.678850] Please append a correct "root=" boot option; here are the available partitions:
[    2.687249] b300        15558144 mmcblk0  driver: mmcblk
[    2.692618]   b301          262144 mmcblk0p1 4a5914f0-01
[    2.697964]   b302           32768 mmcblk0p2 4a5914f0-02
[    2.703307] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    2.709407] usb 1-1: New USB device found, idVendor=0424, idProduct=2514
[    2.709415] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.710041] hub 1-1:1.0: USB hub found
[    2.710148] hub 1-1:1.0: 4 ports detected
[    2.733172] CPU1: stopping
[    2.735893] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.14.48 #1
[    2.741905] Backtrace:
[    2.744393] [<c0011ae4>] (dump_backtrace) from [<c0011cf8>] (show_stack+0x18/0x1c)
[    2.751967]  r6:00000000 r5:c09c6260 r4:00000000 r3:00000000
[    2.757710] [<c0011ce0>] (show_stack) from [<c0678d7c>] (dump_stack+0x90/0xa0)
[    2.764943] [<c0678cec>] (dump_stack) from [<c00149f8>] (handle_IPI+0x154/0x174)
[    2.772342]  r5:00000001 r4:c09fe06c
[    2.775960] [<c00148a4>] (handle_IPI) from [<c000854c>] (gic_handle_irq+0x60/0x64)
[    2.783532]  r6:dc0b9f68 r5:c09b08a8 r4:f4a0010c r3:c000f550
[    2.789269] [<c00084ec>] (gic_handle_irq) from [<c0012840>] (__irq_svc+0x40/0x50)
[    2.796755] Exception stack(0xdc0b9f68 to 0xdc0b9fb0)
[    2.801815] 9f60:                   eef4d678 00000000 00007744 c001a860 dc0b8000 c09b0448
[    2.810001] 9f80: c09b04ac c067fb4c dc0b8000 dc0b8000 dc0b8000 dc0b9fbc dc0b9fc0 dc0b9fb0
[    2.818183] 9fa0: c000f550 c000f554 60000113 ffffffff
[    2.823238]  r7:dc0b9f9c r6:ffffffff r5:60000113 r4:c000f554
[    2.828983] [<c000f514>] (arch_cpu_idle) from [<c00635ac>] (cpu_startup_entry+0x100/0x150)
[    2.837256] [<c00634ac>] (cpu_startup_entry) from [<c001464c>] (secondary_start_kernel+0x128/0x134)
[    2.846304]  r7:c09fe094
[    2.848864] [<c0014524>] (secondary_start_kernel) from [<100085e4>] (0x100085e4)
[    2.856263]  r5:00000015 r4:2c09006a
[    2.859876] CPU0: stopping
[    2.862594] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.14.48 #1
[    2.868604] Backtrace:
[    2.871083] [<c0011ae4>] (dump_backtrace) from [<c0011cf8>] (show_stack+0x18/0x1c)
[    2.878656]  r6:00000000 r5:c09c6260 r4:00000000 r3:00000000
[    2.884393] [<c0011ce0>] (show_stack) from [<c0678d7c>] (dump_stack+0x90/0xa0)
[    2.891624] [<c0678cec>] (dump_stack) from [<c00149f8>] (handle_IPI+0x154/0x174)
[    2.899023]  r5:00000000 r4:c09fe06c
[    2.902640] [<c00148a4>] (handle_IPI) from [<c000854c>] (gic_handle_irq+0x60/0x64)
[    2.910213]  r6:c09a9f30 r5:c09b08a8 r4:f4a0010c r3:c000f550
[    2.915950] [<c00084ec>] (gic_handle_irq) from [<c0012840>] (__irq_svc+0x40/0x50)
[    2.923436] Exception stack(0xc09a9f30 to 0xc09a9f78)
[    2.928495] 9f20:                                     eef45678 00000000 00054260 c001a860
[    2.936680] 9f40: c09a8000 c09b0448 c09b04ac c067fb4c c09a8008 c09a8000 c09a8000 c09a9f84
[    2.944863] 9f60: c09a9f88 c09a9f78 c000f550 c000f554 60000113 ffffffff
[    2.951481]  r7:c09a9f64 r6:ffffffff r5:60000113 r4:c000f554
[    2.957220] [<c000f514>] (arch_cpu_idle) from [<c00635ac>] (cpu_startup_entry+0x100/0x150)
[    2.965500] [<c00634ac>] (cpu_startup_entry) from [<c06755a8>] (rest_init+0x7c/0x80)
[    2.973246]  r7:c08803e0
[    2.975814] [<c067552c>] (rest_init) from [<c0840b8c>] (start_kernel+0x358/0x364)
[    2.983304] [<c0840834>] (start_kernel) from [<10008074>] (0x10008074)
[    2.989834]  r8:1000406a r7:c09b4748 r6:c08803dc r5:c09b043c r4:10c53c7d
[    2.996625] CPU3: stopping
[    2.999343] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 3.14.48 #1
[    3.005353] Backtrace:
[    3.007832] [<c0011ae4>] (dump_backtrace) from [<c0011cf8>] (show_stack+0x18/0x1c)
[    3.015405]  r6:00000000 r5:c09c6260 r4:00000000 r3:00000000
[    3.021143] [<c0011ce0>] (show_stack) from [<c0678d7c>] (dump_stack+0x90/0xa0)
[    3.028374] [<c0678cec>] (dump_stack) from [<c00149f8>] (handle_IPI+0x154/0x174)
[    3.035773]  r5:00000003 r4:c09fe06c
[    3.039390] [<c00148a4>] (handle_IPI) from [<c000854c>] (gic_handle_irq+0x60/0x64)
[    3.046963]  r6:dc0bdf68 r5:c09b08a8 r4:f4a0010c r3:c000f550
[    3.052698] [<c00084ec>] (gic_handle_irq) from [<c0012840>] (__irq_svc+0x40/0x50)
[    3.060185] Exception stack(0xdc0bdf68 to 0xdc0bdfb0)
[    3.065244] df60:                   eef5d678 00000000 0005ddb6 c001a860 dc0bc000 c09b0448
[    3.073430] df80: c09b04ac c067fb4c dc0bc000 dc0bc000 dc0bc000 dc0bdfbc dc0bdfc0 dc0bdfb0
[    3.081613] dfa0: c000f550 c000f554 60000113 ffffffff
[    3.086668]  r7:dc0bdf9c r6:ffffffff r5:60000113 r4:c000f554
[    3.092406] [<c000f514>] (arch_cpu_idle) from [<c00635ac>] (cpu_startup_entry+0x100/0x150)
[    3.100680] [<c00634ac>] (cpu_startup_entry) from [<c001464c>] (secondary_start_kernel+0x128/0x134)
[    3.109728]  r7:c09fe094
[    3.112285] [<c0014524>] (secondary_start_kernel) from [<100085e4>] (0x100085e4)
[    3.119683]  r5:00000015 r4:2c09006a