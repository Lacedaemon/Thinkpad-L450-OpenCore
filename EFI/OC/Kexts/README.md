# Kexts

The following kexts are needed:

* [AppleALC](https://github.com/acidanthera/AppleALC/releases)
* [CPUFriend](https://github.com/acidanthera/CPUFriend/releases)
* [IntelMausi](https://github.com/acidanthera/IntelMausi/releases)
* [Lilu](https://github.com/acidanthera/Lilu/releases)
* [Sinetek-rtsx](https://github.com/syscl/Sinetek-rtsx)
* [USBInjectAll](https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/)
* [VirtualSMC](https://github.com/acidanthera/VirtualSMC/releases)
 * SMCBatteryManager
 * SMCLightSensor
 * SMCProcessor
 * SMCSuperIO
* [VoodooInput](https://github.com/acidanthera/VoodooInput/releases)
* [VoodooPS2Controller](https://github.com/acidanthera/VoodooPS2/releases)
* [WhateverGreen](https://github.com/acidanthera/whatevergreen/releases)

----

Kexts that do not have prebuilt releases can usually be compiled with Xcode:

```shell
$ cd [kext repo]
$ xcodebuild
```

*The compilation directions in a kext's README, if any, should supercede the above directions.*

[Lilu-and-Friends](https://github.com/corpnewt/Lilu-and-Friends) is an automated alternative to the above.
