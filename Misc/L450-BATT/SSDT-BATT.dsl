/*
* SSDT-BATT for Lenovo ThinkPad L450
* by HackinDoge
*/

DefinitionBlock("", "SSDT", 2, "L450", "BATT", 0)
{
    External(\_SB.PCI0.LPC.EC, DeviceObj)
    External(XHCI, FieldUnitObj)
    External(WAKI, PkgObj)
    External(D80P, FieldUnitObj)
    External(SPS, IntObj)
    External(\_SB.PCI0.LPC.EC.HCMU, FieldUnitObj)
    External(\_SB.PCI0.LPC.EC.EVNT, MethodObj)
    External(\_SB.PCI0.LPC.EC.HKEY.MHKE, MethodObj)
    External(\_SB.PCI0.LPC.EC.FNST, MethodObj)
    External(UCMS, MethodObj)
    External(LIDB, FieldUnitObj)
    External(\_SB.PCI0.LPC.EC.HFNI, FieldUnitObj)
    External(FNID, IntObj)
    External(NVSS, MethodObj)
    External(\_SB.PCI0.LPC.EC.AC._PSR, MethodObj)
    External(PWRS, FieldUnitObj)
    External(OSC4, FieldUnitObj)
    External(PNTF, MethodObj)
    External(ACST, IntObj)
    External(\_SB.PCI0.LPC.EC.ATMC, MethodObj)
    External(SCRM, FieldUnitObj)
    External(\_SB.PCI0.LPC.EC.HFSP, FieldUnitObj)
    External(IOEN, FieldUnitObj)
    External(IOST, FieldUnitObj)
    External(ISWK, FieldUnitObj)
    External(\_SB.PCI0.LPC.EC.HKEY.DHKC, IntObj)
    External(\_SB.PCI0.LPC.EC.HKEY.MHKQ, MethodObj)
    External(FFCL, FieldUnitObj)
    External(IFRS, MethodObj)
    External(VIGD, FieldUnitObj)
    External(\_SB.PCI0.VID.GLIS, MethodObj)
    External(\_SB.LID._LID, MethodObj)
    External(WVIS, IntObj)
    External(VBTD, MethodObj)
    External(VCMS, MethodObj)
    External(AWON, MethodObj)
    External(CMPR, FieldUnitObj)
    External(\_SB.SLPB, DeviceObj)
    External(USBR, FieldUnitObj)
    External(\_SB.PCI0.XHCI.XRST, IntObj)
    External(\_SB.PCI0.XHCI.PR3, FieldUnitObj)
    External(\_SB.PCI0.XHCI.PR3M, FieldUnitObj)
    External(\_SB.PCI0.XHCI.PR2, FieldUnitObj)
    External(\_SB.PCI0.XHCI.PR2M, FieldUnitObj)
    External(\_SB.PCI0.LPC.EC.HSPA, FieldUnitObj)
    External(NBCF, IntObj)
    External(\_SB.PCI0.LPC.EC.BRNS, MethodObj)
    External(VBRC, MethodObj)
    External(BRLV, FieldUnitObj)
    External(AUDC, MethodObj)
    External(F1LD, FieldUnitObj)
    External(\_SB.PCI0.LPC.EC.BATW, MethodObj)
    External(\_SB.PCI0.LPC.EC.HKEY.WGWK, MethodObj)
    External(VSLD, MethodObj)
    External(RRBF, IntObj)
    External(CSUM, MethodObj)
    External(CHKC, FieldUnitObj)
    External(CHKE, FieldUnitObj)
    External(\_SB.PCI0.LPC.EC.HIID, FieldUnitObj)
    External(\_SB.PCI0.LPC.EC.BATM, MutexObj)
    External(\_TZ.THM0, ThermalZoneObj)
    External(_SI._SST, MethodObj)

    /*
     * BEGIN ADDED METHODS
     */
    Method (B1B2, 2, NotSerialized) { Return(Or(Arg0, ShiftLeft(Arg1, 8))) }
    Method (B1B4, 4, NotSerialized)
    {
        Store(Arg3, Local0)
        Or(Arg2, ShiftLeft(Local0, 8), Local0)
        Or(Arg1, ShiftLeft(Local0, 8), Local0)
        Or(Arg0, ShiftLeft(Local0, 8), Local0)
        Return(Local0)
    }
    /*
    * BEGIN PATCHED METHODS
    */
    Method (\_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        /*
        * BEGIN MANUAL PATCH
        */
        If ((0x03 == Arg0))
            {
                If (CondRefOf (\_SB.LID)) // Lid sleep
                {
                    Notify (\_SB.LID, 0x80)
                }
                If (CondRefOf(\_SI._SST)) // call _SI._SST to indicate system "working"
                { 
                    \_SI._SST(1)
                }
            }
         /*
         * END MANUAL PATCH
        */
ShiftLeft (Arg0, 0x04, D80P) /* \D80P */
        If (LOr (LEqual (Arg0, 0x00), LGreaterEqual (Arg0, 0x05)))
        {
            Return (WAKI) /* \WAKI */
        }

        Store (0x00, \SPS)
        Store (0x00, \_SB.PCI0.LPC.EC.HCMU)
        \_SB.PCI0.LPC.EC.EVNT (0x01)
        \_SB.PCI0.LPC.EC.HKEY.MHKE (0x01)
        \_SB.PCI0.LPC.EC.FNST ()
        \UCMS (0x0D)
        Store (0x00, \LIDB)
        If (LEqual (Arg0, 0x01))
        {
            Store (\_SB.PCI0.LPC.EC.HFNI, \FNID)
        }

        If (LEqual (Arg0, 0x03))
        {
            \NVSS (0x00)
            Store (\_SB.PCI0.LPC.EC.AC._PSR (), \PWRS)
            If (\OSC4)
            {
                \PNTF (0x81)
            }

            If (LNotEqual (\ACST, \_SB.PCI0.LPC.EC.AC._PSR ()))
            {
                \_SB.PCI0.LPC.EC.ATMC ()
            }

            If (\SCRM)
            {
                Store (0x07, \_SB.PCI0.LPC.EC.HFSP)
            }

            Store (0x00, \IOEN)
            Store (0x00, \IOST)
            If (LEqual (\ISWK, 0x01))
            {
                If (\_SB.PCI0.LPC.EC.HKEY.DHKC)
                {
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6070)
                }
            }

            If (\FFCL)
            {
                \IFRS (0x03, 0x00)
            }

            If (\VIGD)
            {
                \_SB.PCI0.VID.GLIS (\_SB.LID._LID ())
                If (\WVIS)
                {
                    \VBTD ()
                }
            }
            ElseIf (\WVIS)
            {
                \_SB.PCI0.VID.GLIS (\_SB.LID._LID ())
                \VBTD ()
            }

            \VCMS (0x01, \_SB.LID._LID ())
            \AWON (0x00)
            If (\CMPR)
            {
                Notify (\_SB.SLPB, 0x02) // Device Wake
                Store (0x00, \CMPR)
            }

            If (LOr (\USBR, \_SB.PCI0.XHCI.XRST))
            {
                If (LOr (LEqual (\XHCI, 0x02), LEqual (\XHCI, 0x03)))
                {
                    Store (0x00, Local0)
                    And (\_SB.PCI0.XHCI.PR3, 0xFFFFFFC0, Local0)
                    Or (Local0, \_SB.PCI0.XHCI.PR3M, \_SB.PCI0.XHCI.PR3)
                    Store (0x00, Local0)
                    And (\_SB.PCI0.XHCI.PR2, 0xFFFF8000, Local0)
                    Or (Local0, \_SB.PCI0.XHCI.PR2M, \_SB.PCI0.XHCI.PR2)
                }
            }
        }

        If (LEqual (Arg0, 0x04))
        {
            \NVSS (0x00)
            Store (0x00, \_SB.PCI0.LPC.EC.HSPA)
            Store (\_SB.PCI0.LPC.EC.AC._PSR (), \PWRS)
            If (\OSC4)
            {
                \PNTF (0x81)
            }

            \_SB.PCI0.LPC.EC.ATMC ()
            If (\SCRM)
            {
                Store (0x07, \_SB.PCI0.LPC.EC.HFSP)
            }

            If (LNot (\NBCF))
            {
                If (\VIGD)
                {
                    \_SB.PCI0.LPC.EC.BRNS ()
                }
                Else
                {
                    \VBRC (\BRLV)
                }
            }

            Store (\AUDC (0x00, 0x00), Local0)
            And (Local0, 0x01, Local0)
            If (LEqual (Local0, 0x00))
            {
                Store (0x00, F1LD) /* \F1LD */
            }
            Else
            {
                Store (0x01, F1LD) /* \F1LD */
            }

            Store (0x00, \IOEN)
            Store (0x00, \IOST)
            If (LEqual (\ISWK, 0x02))
            {
                If (\_SB.PCI0.LPC.EC.HKEY.DHKC)
                {
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6080)
                }
            }

            If (\_SB.PCI0.XHCI.XRST)
            {
                If (LOr (LEqual (\XHCI, 0x02), LEqual (\XHCI, 0x03)))
                {
                    Store (0x00, Local0)
                    And (\_SB.PCI0.XHCI.PR3, 0xFFFFFFC0, Local0)
                    Or (Local0, \_SB.PCI0.XHCI.PR3M, \_SB.PCI0.XHCI.PR3)
                    Store (0x00, Local0)
                    And (\_SB.PCI0.XHCI.PR2, 0xFFFF8000, Local0)
                    Or (Local0, \_SB.PCI0.XHCI.PR2M, \_SB.PCI0.XHCI.PR2)
                }
            }
        }

        \_SB.PCI0.LPC.EC.BATW (Arg0)
        \_SB.PCI0.LPC.EC.HKEY.WGWK (Arg0)
        Notify (\_TZ.THM0, 0x80) // Thermal Status Change
        \VSLD (\_SB.LID._LID ())
        If (\VIGD)
        {
            \_SB.PCI0.VID.GLIS (\_SB.LID._LID ())
        }
        ElseIf (\WVIS)
        {
            \_SB.PCI0.VID.GLIS (\_SB.LID._LID ())
        }

        If (LLess (Arg0, 0x04))
        {
            If (LOr (And (\RRBF, 0x02), And (B1B2(\_SB.PCI0.LPC.EC.WAK0,\_SB.PCI0.LPC.EC.WAK1), 0x02)))
            {
                ShiftLeft (Arg0, 0x08, Local0)
                Store (Or (0x2013, Local0), Local0)
                \_SB.PCI0.LPC.EC.HKEY.MHKQ (Local0)
            }
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (0x00, Local0)
            Store (\CSUM (0x00), Local1)
            If (LNotEqual (Local1, \CHKC))
            {
                Store (0x01, Local0)
                Store (Local1, \CHKC)
            }

            Store (\CSUM (0x01), Local1)
            If (LNotEqual (Local1, \CHKE))
            {
                Store (0x01, Local0)
                Store (Local1, \CHKE)
            }

            If (Local0)
            {
                Notify (\_SB, 0x00) // Bus Check
            }
        }

        Store (0x00, B1B2(\_SB.PCI0.LPC.EC.WAK0,\_SB.PCI0.LPC.EC.WAK1))
        Store (Zero, \RRBF)
        ShiftLeft (Arg0, 0x04, Local2)
        Or (Local2, 0x0E, Local2)
        Store (Local2, D80P) /* \D80P */
        Return (WAKI) /* \WAKI */
    }

    Scope (\_GPE)
    {
        /*
        * BEGIN PATCHED METHODS
        */
        Method (_L0D, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Store (B1B2(\_SB.PCI0.LPC.EC.WAK0,\_SB.PCI0.LPC.EC.WAK1), Local0)
            Store (Local0, \RRBF)
            Sleep (0x0A)
            If (And (Local0, 0x02)){}
            If (And (Local0, 0x04))
            {
                Notify (\_SB.LID, 0x02) // Device Wake
            }

            If (And (Local0, 0x08))
            {
                Notify (\_SB.SLPB, 0x02) // Device Wake
            }

            If (And (Local0, 0x10))
            {
                Notify (\_SB.SLPB, 0x02) // Device Wake
            }

            If (And (Local0, 0x40)){}
            If (And (Local0, 0x80))
            {
                Notify (\_SB.SLPB, 0x02) // Device Wake
            }

            Store (0x00, B1B2(\_SB.PCI0.LPC.EC.WAK0,\_SB.PCI0.LPC.EC.WAK1))
        }
    }

    Scope (\_SB.PCI0.LPC.EC)
    {
      /*
       * Patched OperationRegion
       */
        OperationRegion (CORX, EmbeddedControl, 0x00, 0x0100)
        Field(CORX, ByteAcc, NoLock, Preserve)
        {
            Offset (0x01),
            Offset (0x02),
            Offset (0x03),
            Offset (0x05),
            Offset (0x06),
            Offset (0x09),
            Offset (0x0C),
            Offset (0x0E),
            Offset (0x0F),
            Offset (0x10),
            Offset (0x23),
            Offset (0x26),
            Offset (0x27),
            Offset (0x28),
            Offset (0x29),
            Offset (0x2A),
            Offset (0x31),
            Offset (0x32),
            Offset (0x34),
            Offset (0x36),
            Offset (0x46),
            Offset (0x47),
            Offset (0x49),
            Offset (0x4C),
            WAK0,8,WAK1,8,
            Offset (0x78),
            Offset (0x80),
            Offset (0x81),
            Offset (0x83),
            Offset (0x88),
            Offset (0x8D),
            Offset (0x8F),
            Offset (0xB0),
            Offset (0xC8),
            Offset (0xCC),
            Offset (0xED)
      }
    Field (CORX, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        BRC0,8,BRC1,8, 
                        BFC0,8,BFC1,8, 
                        BAC0,8,BAC1,8, 
                        BVO0,8,BVO1,8 
                    }

                    Field (CORX, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        BBM0,8,BBM1,8 
                    }

                    Field (CORX, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        BDC0,8,BDC1,8, 
                        BDV0,8,BDV1,8,  
                        BSN0,8,BSN1,8
                    }

                    Field (CORX, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        CH00,8,CH01,8,CH02,8,CH03,8
                    }

                    Field (CORX, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        SBMX,128//SBMN,128
                    }

                    Field (CORX, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        SBDX,128//SBDN,128
                    }

      /*
       * BEGIN ADDED METHODS
       */
      Method (RE1B, 1, NotSerialized)
      {
          OperationRegion(ERAM, EmbeddedControl, Arg0, 1)
          Field(ERAM, ByteAcc, NoLock, Preserve) { BYTE, 8 }
          Return(BYTE)
      }
      Method (RECB, 2, Serialized)
      {
          ShiftRight(Add(Arg1,7), 3, Arg1)
          Name(TEMP, Buffer(Arg1) { })
          Add(Arg0, Arg1, Arg1)
          Store(0, Local0)
          While (LLess(Arg0, Arg1))
          {
              Store(RE1B(Arg0), Index(TEMP, Local0))
              Increment(Arg0)
              Increment(Local0)
          }
          Return(TEMP)
      }
      /*
      * BEGIN PATCHED METHODS
      */
      Method (GBIF, 3, NotSerialized)
      {
          Acquire (BATM, 0xFFFF)
          If (Arg2)
          {
              Or (Arg0, 0x01, HIID) /* \_SB_.PCI0.LPC_.EC__.HIID */
              Store (B1B2(BBM0,BBM1), Local7)
              ShiftRight (Local7, 0x0F, Local7)
              XOr (Local7, 0x01, Index (Arg1, 0x00))
              Store (Arg0, HIID) /* \_SB_.PCI0.LPC_.EC__.HIID */
              If (Local7)
              {
                  Multiply (B1B2(BFC0,BFC1), 0x0A, Local1)
              }
              Else
              {
                  Store (B1B2(BFC0,BFC1), Local1)
              }

              Store (Local1, Index (Arg1, 0x02))
              Or (Arg0, 0x02, HIID) /* \_SB_.PCI0.LPC_.EC__.HIID */
              If (Local7)
              {
                  Multiply (B1B2(BDC0,BDC1), 0x0A, Local0)
              }
              Else
              {
                  Store (B1B2(BDC0,BDC1), Local0)
              }

              Store (Local0, Index (Arg1, 0x01))
              Divide (Local1, 0x14, Local2, Index (Arg1, 0x05))
              If (Local7)
              {
                  Store (0xC8, Index (Arg1, 0x06))
              }
              ElseIf (B1B2(BDV0,BDV1))
              {
                  Divide (0x00030D40, B1B2(BDV0,BDV1), Local2, Index (Arg1, 0x06))
              }
              Else
              {
                  Store (0x00, Index (Arg1, 0x06))
              }

              Store (B1B2(BDV0,BDV1), Index (Arg1, 0x04))
              Store (B1B2(BSN0,BSN1), Local0)
              Name (SERN, Buffer (0x06)
              {
                  "     "
              })
              Store (0x04, Local2)
              While (Local0)
              {
                  Divide (Local0, 0x0A, Local1, Local0)
                  Add (Local1, 0x30, Index (SERN, Local2))
                  Decrement (Local2)
              }

              Store (SERN, Index (Arg1, 0x0A))
              Or (Arg0, 0x06, HIID) /* \_SB_.PCI0.LPC_.EC__.HIID */
              Store (RECB(0x0A,128), Index (Arg1, 0x09))
              Or (Arg0, 0x04, HIID) /* \_SB_.PCI0.LPC_.EC__.HIID */
              Name (BTYP, Buffer (0x05)
              {
                   0x00, 0x00, 0x00, 0x00, 0x00                     // .....
              })
              Store (B1B4(CH00,CH01,CH02,CH03), BTYP) /* \_SB_.PCI0.LPC_.EC__.GBIF.BTYP */
              Store (BTYP, Index (Arg1, 0x0B))
              Or (Arg0, 0x05, HIID) /* \_SB_.PCI0.LPC_.EC__.HIID */
              Store (RECB(0x0A,128), Index (Arg1, 0x0C))
          }
          Else
          {
              Store (0xFFFFFFFF, Index (Arg1, 0x01))
              Store (0x00, Index (Arg1, 0x05))
              Store (0x00, Index (Arg1, 0x06))
              Store (0xFFFFFFFF, Index (Arg1, 0x02))
          }

          Release (BATM)
          Return (Arg1)
      }

      Method (GBST, 4, NotSerialized)
      {
          Acquire (BATM, 0xFFFF)
          If (And (Arg1, 0x20))
          {
              Store (0x02, Local0)
          }
          ElseIf (And (Arg1, 0x40))
          {
              Store (0x01, Local0)
          }
          Else
          {
              Store (0x00, Local0)
          }

          If (And (Arg1, 0x07)){}
          Else
          {
              Or (Local0, 0x04, Local0)
          }

          If (LEqual (And (Arg1, 0x07), 0x07))
          {
              Store (0x04, Local0)
              Store (0x00, Local1)
              Store (0x00, Local2)
              Store (0x00, Local3)
          }
          Else
          {
              Store (Arg0, HIID) /* \_SB_.PCI0.LPC_.EC__.HIID */
              Store (B1B2(BVO0,BVO1), Local3)
              If (Arg2)
              {
                  Multiply (B1B2(BRC0,BRC1), 0x0A, Local2)
              }
              Else
              {
                  Store (B1B2(BRC0,BRC1), Local2)
              }

              Store (B1B2(BAC0,BAC1), Local1)
              If (LGreaterEqual (Local1, 0x8000))
              {
                  If (And (Local0, 0x01))
                  {
                      Subtract (0x00010000, Local1, Local1)
                  }
                  Else
                  {
                      Store (0x00, Local1)
                  }
              }
              ElseIf (LNot (And (Local0, 0x02)))
              {
                  Store (0x00, Local1)
              }

              If (Arg2)
              {
                  Multiply (Local3, Local1, Local1)
                  Divide (Local1, 0x03E8, Local1)
              }
          }

          Store (Local0, Index (Arg3, 0x00))
          Store (Local1, Index (Arg3, 0x01))
          Store (Local2, Index (Arg3, 0x02))
          Store (Local3, Index (Arg3, 0x03))
          Release (BATM)
          Return (Arg3)
      }
    }
}
