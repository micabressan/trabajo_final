fringe@fringe-Alienware-17-R2 ~ $ cat /etc/modprobe.d/blacklist-ath_pci.conf
# For some Atheros 5K RF MACs, the madwifi driver loads buts fails to
# correctly initialize the hardware, leaving it in a state from
# which ath5k cannot recover. To prevent this condition, stop
# madwifi from loading by default. Use Jockey to select one driver
# or the other. (Ubuntu: #315056, #323830)
# blacklist ath_pci

fringe@fringe-Alienware-17-R2 ~ $ lsmod
Module                  Size  Used by
bbswitch               13943  0 
bnep                   19624  2 
rfcomm                 69509  8 
binfmt_misc            17468  1 
nls_iso8859_1          12713  2 
nvidia               8379764  35 
uvcvideo               81073  0 
videobuf2_vmalloc      13216  1 uvcvideo
videobuf2_memops       13362  1 videobuf2_vmalloc
videobuf2_core         59104  1 uvcvideo
v4l2_common            15681  1 videobuf2_core
videodev              153793  3 uvcvideo,v4l2_common,videobuf2_core
media                  21903  2 uvcvideo,videodev
dell_wmi               12761  0 
sparse_keymap          13948  1 dell_wmi
mxm_wmi                13021  0 
dm_multipath           22843  0 
scsi_dh                14882  1 dm_multipath
intel_rapl             18783  0 
x86_pkg_temp_thermal    14205  0 
intel_powerclamp       18823  0 
coretemp               13441  0 
kvm_intel             143590  0 
kvm                   452088  1 kvm_intel
crct10dif_pclmul       14307  0 
crc32_pclmul           13133  0 
ghash_clmulni_intel    13230  0 
aesni_intel           152552  0 
aes_x86_64             17131  1 aesni_intel
snd_hda_codec_ca0132    53571  1 
lrw                    13286  1 aesni_intel
gf128mul               14951  1 lrw
glue_helper            13990  1 aesni_intel
ablk_helper            13597  1 aesni_intel
cryptd                 20359  3 ghash_clmulni_intel,aesni_intel,ablk_helper
joydev                 17393  0 
snd_hda_codec_hdmi     47548  1 
serio_raw              13483  0 
rtsx_pci_ms            18168  0 
memstick               16966  1 rtsx_pci_ms
cfg80211              527227  0 
compat                 21657  1 cfg80211
snd_soc_rt5640         93042  0 
snd_hda_intel          30469  5 
snd_soc_rl6231         13037  1 snd_soc_rt5640
snd_hda_controller     30228  1 snd_hda_intel
snd_soc_core          200204  1 snd_soc_rt5640
snd_hda_codec         139682  4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec_ca0132
lpc_ich                21093  0 
snd_compress           19200  1 snd_soc_core
btusb                  32497  0 
snd_pcm_dmaengine      15172  1 snd_soc_core
snd_hwdep              17698  1 snd_hda_codec
bluetooth             446409  22 bnep,btusb,rfcomm
mei_me                 19696  0 
snd_seq_midi           13564  0 
mei                    87875  1 mei_me
snd_pcm               104112  7 snd_soc_rt5640,snd_soc_core,snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel,snd_hda_controller,snd_pcm_dmaengine
6lowpan_iphc           18702  1 bluetooth
snd_seq_midi_event     14899  1 snd_seq_midi
snd_rawmidi            30876  1 snd_seq_midi
shpchp                 37047  0 
snd_seq                63074  2 snd_seq_midi_event,snd_seq_midi
snd_seq_device         14497  3 snd_seq,snd_rawmidi,snd_seq_midi
int3403_thermal        12967  0 
snd_timer              29562  2 snd_pcm,snd_seq
snd_soc_sst_acpi       13007  0 
snd                    79468  22 snd_soc_core,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_seq,snd_rawmidi,snd_hda_codec,snd_hda_intel,snd_seq_device,snd_compress,snd_hda_codec_ca0132
dw_dmac                12835  0 
i2c_hid                18726  0 
dw_dmac_core           28390  1 dw_dmac
wmi                    19193  2 dell_wmi,mxm_wmi
soundcore              15047  2 snd,snd_hda_codec
i2c_designware_platform    12979  0 
8250_dw                13551  0 
mac_hid                13227  0 
spi_pxa2xx_platform    23079  0 
i2c_designware_core    14768  1 i2c_designware_platform
acpi_pad               17942  0 
parport_pc             32741  0 
ppdev                  17671  0 
lp                     17759  0 
parport                42348  3 lp,ppdev,parport_pc
dm_mirror              22135  0 
dm_region_hash         20862  1 dm_mirror
dm_log                 18411  2 dm_region_hash,dm_mirror
hid_logitech_dj        18469  0 
hid_generic            12559  0 
usbhid                 52616  0 
hid                   110426  6 i2c_hid,hid_generic,usbhid,hid_logitech_dj
uas                    23159  0 
usb_storage            66545  2 uas
rtsx_pci_sdmmc         23043  0 
i915                  906113  5 
i2c_algo_bit           13413  1 i915
drm_kms_helper         61574  1 i915
ahci                   34062  3 
psmouse               106610  0 
drm                   311018  6 i915,drm_kms_helper,nvidia
alx                    36817  0 
libahci                32424  1 ahci
rtsx_pci               46259  2 rtsx_pci_ms,rtsx_pci_sdmmc
mdio                   13561  1 alx
sdhci_acpi             13351  0 
video                  20128  1 i915
sdhci                  43685  1 sdhci_acpi
fringe@fringe-Alienware-17-R2 ~ $