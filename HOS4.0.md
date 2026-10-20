# HOS4.0

`HOS4.0` is based on the E404 `staging2` branch and targets Xiaomi Pad 6
(`pipa`) with HyperOS 4 / Android 17.

## Kernel changes

- Keep the Pipa panels' physical dimensions at 148 x 237 mm so framework
  density remains correct.
- Keep the known-good Pipa SPI clock and charging limits used by the current
  port.
- Reject invalid Xiaomi touch modes before indexing the mode table.
- Retry Novatek firmware recovery up to three times during resume.
- Avoid destroying the touchfeature workqueue twice during driver removal.

## Root

- Replace the stock backslashxx KernelSU submodule with the tested
  SukiSU-Ultra v4.2.0 kernel source.
- Use the SUSFS v2 kernel hooks and compatibility fixes from the existing
  `n0_17` kernel.
- Enable suspicious path, mount, kstat, umount, uname, cmdline and logging
  support. Experimental map, open redirect and symbol hiding remain disabled.
- Keep SukiSU's SELinux-hide feature available through the manager.

## CI

`.github/workflows/build-hos4-pipa.yml` builds `vendor/pipa_defconfig` on
Ubuntu with the pinned Neutron Clang/LLD `30072026` toolchain
(`24.0.0git`). The workflow uploads the raw Image, DTB, DTBO, generated config,
compile log, a raw-artifact zip, and a flashable AnyKernel3 zip. The AnyKernel
package updates both the active `boot` and `vendor_boot` images with the matched
Image, DTB, and DTBO for the current slot.
