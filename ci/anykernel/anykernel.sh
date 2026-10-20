# AnyKernel3 installer for E404/HOS4.0 on Xiaomi Pad 6 (pipa)

properties() { '
kernel.string=HOS4.0 E404 Kernel for Xiaomi Pad 6
do.modules=0
do.systemless=1
do.cleanup=1
'; }

devicecheck() {
  local candidate
  for candidate in \
    "$(getprop ro.product.device)" \
    "$(getprop ro.build.product)" \
    "$(getprop ro.product.vendor.device)" \
    "$(getprop ro.vendor.product.device)"; do
    [ "$candidate" = "pipa" ] && return 0
  done
  abort "Unsupported device. This package is only for Xiaomi Pad 6 (pipa)."
}

devicename=pipa
is_slot_device=1
ramdisk_compression=auto
patch_vbmeta_flag=auto
block=/dev/block/bootdevice/by-name/boot

. tools/ak3-core.sh

if [ -f /vendor/OemPorts10T.prop ] ||
   [ -f /vendor/etc/init/OemPorts10T.rc ]; then
  abort "Unsupported OPLUS port ROM."
fi

ui_print "--> HOS4.0 / HyperOS configuration"
rom=rom_oem
dtbo=dtbo_oem_pipa
dtb=dtb_def
batt=batt_def

mv PIPA-Image "$home/Image"
mv PIPA-dtb "$home/dtb"
mv PIPA-dtbo.img "$home/dtbo.img"

dump_boot
patch_cmdline "e404_args" "e404_args=$rom,$dtbo,$dtb,$batt"
write_boot

ui_print "--> Installing matched Image/DTB/DTBO to vendor_boot"
block=/dev/block/bootdevice/by-name/vendor_boot
ramdisk_compression=auto
patch_vbmeta_flag=auto
reset_ak
dump_boot
write_boot

ui_print "--> HOS4.0 kernel installed"
