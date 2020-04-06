# ACPI

Refer to the table below for an explanation of the necessary ACPI tables.

|Name|Associated config.plist patches|Notes|
|-----|-------------------------------|-----|
|ssdt-data|N/A|Used with CPUFriend to allow the CPU to step down to ~800MHz idle|
|SSDT-BATT|<ul><li>`_L0D - > XL0D`</li><li>`_WAK -> XWAK`</li><li>`GBIF - > XBIF`</li><li>`GBST - > XBST`</li></ul>|Patched methods for battery status.  Patch for lid wake is baked into this SSDT|
|SSDT-DEVICES|<ul><li>`HPET _CRS to XCRS Rename`</li><li>`TIMR IRQ 0 Patch`</li><li>`RTC IRQ 8 Patch`</li></ul>|Includes the following fixes: <ul><li>Add missing ALS0, MCHC, SMBUS devices</li><li>Inject `_PRW` PkgObj in AC device to allow AppleACPIACAdapter to load</li><li>Inject new `_CRS` section for HPET; this + the associated config.plist patches are required for working audio w/ AppleALC</li></ul>|
|SSDT-KBD|<ul><li>`(_Q14,0,N) -> XQ14`</li><li>`(_Q15,0,N) -> XQ15`</li></ul>|Brightness keys + VoodooPS2 properties|
|SSDT-PNLF|N/A|WhateverGreen SSDT-PNLF with rename for `PCI0.VID`|
|SSDT-UIAC|<ul><li>`EHC1 -> EH01`</li><li>`XHCI -> XHC_`</li></ul>|Used with USBInjectAll to define USB ports|
|SSDT-XOSI|`OSI -> XOSI`|Enables features locked behind newer _OSI values|
