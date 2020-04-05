/*
 * SMBus compatibility table.
 */
DefinitionBlock ("", "SSDT", 2, "L450", "DEVICES", 0x00000000)
{
    External (\_SB.PCI0.LPC.EC.AC, DeviceObj)
    External (\_SB.PCI0.LPC.HPET, DeviceObj)
    External (\_SB.PCI0, DeviceObj)
    External (\_SB.PCI0.SMBU, DeviceObj)
    
    Device(\_SB.ALS0)
    {
        Name(_HID, "ACPI0008")
        Name(_CID, "smc-als")
        Name(_ALI, 300)
        Name(_ALR, Package()
        {
            //Package() { 70, 0 },
            //Package() { 73, 10 },
            //Package() { 85, 80 },
            Package() { 100, 300 },
            //Package() { 150, 1000 },
        })
    }
    
    Name (\_SB.PCI0.LPC.EC.AC._PRW, Package() { 0x18, 0x03 })
    
    Name (\_SB.PCI0.LPC.HPET._CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
    {
        IRQNoFlags ()
        {0}
        IRQNoFlags ()
        {8}
        IRQNoFlags ()
        {11}
        Memory32Fixed (ReadWrite,
            0xFED00000,         // Address Base
            0x00000400,         // Address Length
            )
    })

    Device (\_SB.PCI0.MCHC)
    {
        Name (_ADR, Zero)
    }
    
    Device (\_SB.PCI0.SMBU.BUS0)
    {
        Name (_CID, "smbus")
        Name (_ADR, Zero)
        Device (DVL0)
        {
            Name (_ADR, 0x57)
            Name (_CID, "diagsvault")
            Method (_DSM, 4)
            {
                If (!Arg2) { Return (Buffer() { 0x03 } ) }
                Return (Package() { "address", 0x57 })
            }
        }
    }
}
