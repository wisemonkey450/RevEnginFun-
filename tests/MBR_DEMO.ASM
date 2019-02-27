

                 ASSEMBLY  CODE  LISTING  OF  MBR_DEMO.COM


       For a more detailed explanation of the instrucitons which I
  added to the standard MBR code, see the text file: MBR_DEMO.TXT.


       Here's a section which we could call the MBR 'loader':

  0100 FC            CLD
  0101 BE1001        MOV     SI,0110
  0104 BF007C        MOV     DI,7C00
  0107 B90001        MOV     CX,0100
  010A F3            REPZ
  010B A5            MOVSW
  010C E9F17A        JMP     7C00
  010F 90            NOP


     The following instructions are almost exactly the same as the
     Standard MBR from FDISK.  Exceptions which make it possible to
     run this code in a DOS-Window are noted by --'s under their
     machine code bytes.
 =========================================================================

  0110 FA            CLI
  0111 33C0          XOR     AX,AX
  0113 8CC8          MOV     AX,CS
       ----
  0115 BC007C        MOV     SP,7C00
  0118 8BF4          MOV     SI,SP

  011A 50            PUSH    AX
  011B 07            POP     ES
  011C 50            PUSH    AX
  011D 1F            POP     DS
  011E FB            STI
  011F FC            CLD
  0120 BF0006        MOV     DI,0600
  0123 B90001        MOV     CX,0100
  0126 F2            REPNZ
  0127 A5            MOVSW
  0128 E9028A        JMP     8B2D
       ------
  012B 90            NOP
       --
  012C 90            NOP
       --

  012D BEBE07        MOV     SI,07BE
  0130 B304          MOV     BL,04
  0132 803C80        CMP     BYTE PTR [SI],80
  0135 740E          JZ      0145
  0137 803C00        CMP     BYTE PTR [SI],00
  013A 751C          JNZ     0158
  013C 83C610        ADD     SI,+10
  013F FECB          DEC     BL
  0141 75EF          JNZ     0132
  0143 CD20          INT     20
         --
  0145 8B14          MOV     DX,[SI]
  0147 8B4C02        MOV     CX,[SI+02]
  014A 8BEE          MOV     BP,SI
  014C 83C610        ADD     SI,+10
  014F FECB          DEC     BL
  0151 741A          JZ      016D
  0153 803C00        CMP     BYTE PTR [SI],00
  0156 74F4          JZ      014C
  0158 BE8B06        MOV     SI,068B
  015B AC            LODSB
  015C 3C00          CMP     AL,00
  015E 740B          JZ      016B
  0160 56            PUSH    SI
  0161 BB0700        MOV     BX,0007
  0164 B40E          MOV     AH,0E
  0166 CD10          INT     10
  0168 5E            POP     SI
  0169 EBF0          JMP     015B
  016B CD20          INT     20
       ----
  016D BF0500        MOV     DI,0005
  0170 BB007C        MOV     BX,7C00
  0173 B80102        MOV     AX,0201
  0176 57            PUSH    DI
  0177 CD13          INT     13
  0179 5F            POP     DI
  017A 730C          JNB     0188
  017C 33C0          XOR     AX,AX
  017E CD13          INT     13
  0180 4F            DEC     DI
  0181 75ED          JNZ     0170
  0183 BEA306        MOV     SI,06A3
  0186 EBD3          JMP     015B
  0188 BEC206        MOV     SI,06C2
  018B BFFE7D        MOV     DI,7DFE
  018E 813D55AA      CMP     WORD PTR [DI],AA55
  0192 75C7          JNZ     015B
  0194 8BF5          MOV     SI,BP
  0196 E967FD        JMP     FF00
       ------
  0199 90            NOP
       --
  019A 90            NOP
       --

  019B                                   49 6E 76 61 6C              Inval
  01A0  69 64 20 70 61 72 74 69-74 69 6F 6E 20 74 61 62   id partition tab
  01B0  6C 65 00 45 72 72 6F 72-20 6C 6F 61 64 69 6E 67   le.Error loading
  01C0  20 6F 70 65 72 61 74 69-6E 67 20 73 79 73 74 65    operating syste
  01D0  6D 00 4D 69 73 73 69 6E-67 20 6F 70 65 72 61 74   m.Missing operat
  01E0  69 6E 67 20 73 79 73 74-65 6D 00 00 00 00 00 00   ing system......
  01F0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0200  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0210  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0220  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0240  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0250  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0260  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0270  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0280  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0290  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  02A0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  02B0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  02C0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 80 01   ................
  02D0  01 00 0B 7F BF FD 3F 00-00 00 C1 40 5E 00 00 00   ......?....@^...
  02E0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
  02F0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
  0300  00 00 00 00 00 00 00 00-00 00 00 00 00 00 55 AA   ..............U.


      This part of the code identifies the program's purpose:
 ==========================================================================

  0310  0D 0A 20 20 20 54 68 69-73 20 70 72 6F 67 72 61   ..   This progra
  0320  6D 20 64 65 6D 6F 6E 73-74 72 61 74 65 73 20 74   m demonstrates t
  0330  68 65 20 6F 70 65 72 61-74 69 6F 6E 20 6F 66 20   he operation of
  0340  61 20 4D 61 73 74 65 72-20 42 6F 6F 74 20 52 65   a Master Boot Re
  0350  63 6F 72 64 20 21 0D 0A-0D 0A 20 20 20 59 6F 75   cord !....   You
  0360  20 6D 75 73 74 20 6F 70-65 6E 20 74 68 69 73 20    must open this
  0370  66 69 6C 65 20 77 69 74-68 20 61 20 64 65 62 75   file with a debu
  0380  67 67 69 6E 67 20 70 72-6F 67 72 61 6D 20 73 75   gging program su
  0390  63 68 20 61 73 20 4D 53-2D 44 4F 53 20 44 45 42   ch as MS-DOS DEB
  03A0  55 47 0D 0A 20 20 20 74-6F 20 66 75 6C 6C 79 20   UG..   to fully
  03B0  75 6E 64 65 72 73 74 61-6E 64 20 69 74 2E 20 20   understand it.
  03C0  53 65 65 20 4D 42 52 5F-44 45 4D 4F 2E 54 58 54   See MBR_DEMO.TXT
  03D0  20 66 6F 72 20 61 20 63-6F 6D 70 6C 65 74 65 20    for a complete
  03E0  65 78 70 6C 61 6E 61 74-69 6F 6E 2E 0D 0A 24      explanation...$

  03EF 90            NOP

  03F0 BA1003        MOV     DX,0310
  03F3 B409          MOV     AH,09
  03F5 CD21          INT     21

  03F7 B8004C        MOV     AX,4C00
  03FA CD21          INT     21

  03FC 90            NOP               ;  Just some 'fill' to make the
  03FD 90            NOP               ;  size of the code come out to
  03FE 90            NOP               ;  an even 300 hex (768) bytes.
  03FF 90            NOP


 ========================================================================

                 A NOTE ABOUT MACHINE CODE EQUIVALENTS
                   FOR CERTAIN ASSEMBLY INSTRUCTIONS


    Certain assembly instructions are set to be converted into particular
  machine code (numerical hex bytes) by various ASSEMBLERS _when_ those
  instructions can be represented by different bytes that effectively do
  the same thing as far as a program is concerned...  If a program is
  large enough, it's sometimes possible for the manufacturer of a certain
  ASSEMBLER to state that the executable code of some program was most
  likely (or even positively in some cases?) created with their Assembler!
  (They say that the code contains a 'fingerprint' of sorts that matches
   the operation of their Assembler in how it chooses which equivalent
   machine code to use for these types of instructions.)

    Here are just a FEW examples of these types of instructions:

                                         DEBUG's Assembler
                                         =================
        XOR AX,AX   --->   33 C0     or       31 C0
        MOV SI,SP   --->   8B F4     or       89 E6
        MOV BP,SI   --->   8B EE     or       89 F5
        MOV SI,BP   --->   8B F5     or       89 EE



 [ The Starman.  23 AUG 2000.  Revised: 23 JUN 2003.]