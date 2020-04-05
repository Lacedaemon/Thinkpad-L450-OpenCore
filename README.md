# Lenovo Thinkpad L450 - OpenCore Setup

```
OS: macOS Catalina
Host: Hackintosh (SMBIOS: MacBookPro12,1)
Resolution: 1366x768
CPU: Intel i5-5300U (4) @ 2.30GHz
GPU: Intel HD Graphics 5500
Memory: 8192MiB
```

## Functionality

If a function is not explicitly mentioned below, it is most likely working.

|Function|Status|
|--------|------|
|Volume/brightness keys after wake from sleep|Not working, WIP|
|Battery status after sleep|Laggy, WIP|
|Audio jack|Untested|
|mDP Output|Untested|
|Card reader|Untested|
|WiFi / Bluetooth|Working with genuine Apple BCM94360CS|

## BIOS Settings

|Config|Security|Startup|Restart|
|------|--------|-------|-------|
|<ul><li>Network<ul><li>All [Disabled]</li></ul></li><li>USB<ul><li>USB UEFI BIOS Support [Enabled]</li><li>USB 3.0 Mode [Enabled]</li></ul></li><li>Keyboard/Mouse<ul><li>Trackpoint [Enabled]</li><li>Trackpad [Enabled]</li></ul></li><li>Display<ul><li>Total Graphics Memory [512MB]</li></ul></li><li>CPU<ul><li>Intel (R) Hyper-Threading Technology [Enabled]</li></ul></li></ul>|<ul><li>Security Chip<ul><li>Security Chip [Disabled]</li></ul></li><li>Memory Protection<ul><li>Execution Prevention [Enabled]</li></ul></li><li>Virtualization<ul><li>All [Enabled]<ul><li>VT-d is safe because of OpenCore’s `DisableIOMapper`</li></ul></li></ul></li><li>Secure Boot<ul><li>Secure Boot [Disabled]</li></ul></li></ul>|<ul><li>Startup<ul><li>UEFI/Legacy Boot [UEFI Only]<ul><li>CSM Support [No]</li></ul></li></ul></li></ul>|<ul><li>Restart<ul><li>OS Optimized Defaults [Enabled]</li></ul></li></ul>|

## To Use

0. Clone this repo:

```shell
$ git clone https://github.com/Lacedaemon/Thinkpad-L450-OpenCore
```

1. Per the `[Repo]/EFI/OC/config.plist`, download the corresponding version of [OpenCore](https://github.com/acidanthera/OpenCorePkg/releases).
 * *If the version used in this repo is newer than the latest prebuilt release, OpenCore must be compiled from source:*

 ```shell
$ git clone https://github.com/acidanthera/OpenCorePkg
$ cd [path to cloned repo]
$ ./macbuild.tool
 ```

2. From the downloaded OpenCore package, extract the following files to their respective places in the cloned repo:
 * `[OpenCore]/EFI/BOOT/BOOTx64.efi` -> `[Repo]/EFI/BOOT/BOOTx64.efi`
 * `[OpenCore]/EFI/OC/OpenCore.efi` -> `[Repo]/EFI/OC/OpenCore.efi`
 * `[OpenCore]/EFI/OC/Drivers/OpenRuntime.efi` -> `[Repo]/EFI/OC/Drivers/OpenRuntime.efi`
 * `[OpenCore]/EFI/OC/Drivers/OpenCanopy.efi` -> `[Repo]/EFI/OC/Drivers/OpenCanopy.efi`
3. Download and extract the latest compatible `ApfsDriverLoader.efi` from [AppleSupportPkg](https://github.com/acidanthera/AppleSupportPkg/releases) to `[Repo]/EFI/OC/Drivers`.
4. Download and copy the latest compatible `HfsPlus.efi` from [OcBinaryData](https://github.com/acidanthera/OcBinaryData/blob/master/Drivers/HfsPlus.efi) to `[Repo]/EFI/OC/Drivers`.
5. Follow the README's in the `[Repo]/EFI/OC/ACPI` and `[Repo]/EFI/OC/Kexts` folders.
6. Copy the finished `[Repo]/EFI` folder to a FAT32 partition (e.g. a USB drive or EFI System Partition), then boot from it.

## Credits

* [jsassu20](https://github.com/jsassu20/Lenovo-T450-Catalina-OpenCore),  [EchoSpirit](https://github.com/EchoEsprit/Hackintosh-Catalina-OpenCore-Lenovo-T450s-efi), and [Sniki](https://www.tonymacx86.com/threads/guide-lenovo-thinkpad-t440s-using-clover-uefi-hotpatch.279492/), whose configs were studied to put together this build
* acidanthera for OpenCorePkg et all
* khronokernel, for providing [the vanilla guide](https://khronokernel-2.gitbook.io/opencore-vanilla-desktop-guide/) which this config.plist is based on
* RehabMan, for his guides on [patching ACPI for battery status](https://www.tonymacx86.com/threads/guide-how-to-patch-dsdt-for-working-battery-status.116102/) and [converting those patches for hotpatching](https://www.tonymacx86.com/threads/guide-using-clover-to-hotpatch-acpi.200137/)
* [CorpNewt](https://github.com/CorpNewt), for Lilu-and-Friends, ProperTree, and SSDTTime
