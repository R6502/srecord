#!/bin/sh
#
# srecord - Manipulate EPROM load files
# Copyright (C) 2013 Peter Miller
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

TEST_SUBJECT="write Logisim"
. test_prelude

srec_cat - -motorola -disable=esa -o test.bin -bin << 'fubar'
S0220000687474703A2F2F737265636F72642E736F75726365666F7267652E6E65742F1D
S12300001FF38F46DDCCC11A0FE4E64DC0CD6DC1825F1F87CC8A6DE3B250CBC1CEC6204CD5
S12300209598FDBBAD725DFDE909FFE0F041ED568677064CBCAC4A9FDD996A7046BAD55103
S12300402D6BD57A6B2DFA954C8B3439806F6F3FE0DF8341BB51CD9462EBF8F2122200A5AD
S1230060DAB18AD410A9EF790AD57A54977C3639831D60C3D89CE9AD4233B111B122C87E26
S1230080249794BAC6BAB8F19FDD641C551242D7C88EB0E202392DD7AB0CC331963D2F7169
S12300A058B984E55B8369028DAB82E8F51FAA5313C1FA2763F5FDA4BBB44346385621CD64
S12300C039D0C45B1B62BCC04E181740B9F0386E8FBA0437B99D34FDCF3A5721D0EB05960D
S12300E01C108CCB8ABC2D3C6D598C15C68E1B48EFE8DC164099AA2E2292052726A107CEB6
S1230100D8591490D2B031F162A31F0E9DB8E172B780423D20CBD393038F46A8D0DA3ACF4E
S12301202107CFB4EB70898F5AF1D9D24D8F835C83CBD5EA1554B0B6E1B0BA0123EF82240C
S1230140946BACC301F23C87EDBECA79BE0811B6202300A85823DB43CAFDCD8A4AC6C9D8A9
S12301606318A1D8E89B0AE645E1DCBF7DC7607C8D29A0376830B45291A44D3A4E0BA86EDD
S12301809383C7C655E4352B2AE4B1C7CEA9F006BECE68FD67F4BFC6BCDB7159297308E274
S12301A0C3561C5D63239B5C0E8F0041CC414A077CED8080941FBE118D4EF804A12F68D323
S12301C005926EEC5DD3F6ABBE338FF0ACCB8FF4D91F19130276F04CDD9FAE80445B5ED59B
S12301E05738A43E7CB399467F56135B705E0884C53752F259B3BCE50AAF92C0C1E1B9523A
S1230200F765AA1A26092D8308D80B07C4244A977BCCB9EB783A13EE368072787DD0E8D5D8
S12302203994F5A4AEDDAE52C0DDEE4F0E45C1BF1BA697B5A43CF09B08D852BC19513A6CA6
S1230240B574052A562BB437E733F4075511305FFBA47CC53C1CF98D1ED7CC0CF639E8C06A
S12302601D2C8F3A8EE88E21527E5147A564268631BC381799E222D181E6950ACD72015ED8
S123028091F6B54F2B472E3B3C58E7CBB13F61103012CF3759D9E75C787931164379D76362
S12302A021D8E2ABC2EDA89BF80676CCE5EDB5DF7F1C58C013B4C9C49CF7D00B07B815498A
S12302C0012FF93EFA43F85A0F56261BB8108987A4FF594043BAFD3F796704D9B513574A0B
S12302E040663C4E718813950F39AD84A6BB3E69ECA1DC0D841EF6CA411A7485ECC7DB915D
S12303006CDBEDDB976EEA56F83DFC16141C771B70376943E09AE2D5B36CC60A9FDB1CD69D
S1230320F4BE227D2BE578A1FC3A1FC6EFF860F09973972807B4A9CB5A85C17DE5F8150FD5
S12303405407099F66F516CBE0CA0EB147A52C58DB9DECC4DDE32606BE38F44A204183470E
S1230360968D9CC6527468B52A2B450360291553FF6C582430207053E665C148AE6438C625
S1230380AFC463C3DEA3DF70256493D3DF8A6B24C1BF9E17E3C8B4780F6FB20001AB1C1BEA
S12303A0E9CC8C5B1EAB65894264CEBB7D8AA1A9C7C419DA3BD121D8FB0FA5C13EAFDCB4F6
S12303C067ACFAF813BF676D6623DA711AB69FD640D3D5D7DD7DDE9875D1B110FB293B5F01
S12303E0FAAA3B6CD0F971A7E1B022E6A210695E4BCC083CCB358D643E23E1A18E8AD4A5FB
S5030020DC
S9030000FC
fubar
if test $? -ne 0; then no_result; fi

cat > test.ok << 'fubar'
v2.0 raw

1F F3 8F 46 DD CC C1 1A F E4 E6 4D C0 CD 6D C1 82 5F 1F 87 CC 8A 6D E3 B2 50 CB
C1 CE C6 20 4C 95 98 FD BB AD 72 5D FD E9 9 FF E0 F0 41 ED 56 86 77 6 4C BC AC
4A 9F DD 99 6A 70 46 BA D5 51 2D 6B D5 7A 6B 2D FA 95 4C 8B 34 39 80 6F 6F 3F E0
DF 83 41 BB 51 CD 94 62 EB F8 F2 12 22 0 A5 DA B1 8A D4 10 A9 EF 79 A D5 7A 54
97 7C 36 39 83 1D 60 C3 D8 9C E9 AD 42 33 B1 11 B1 22 C8 7E 24 97 94 BA C6 BA B8
F1 9F DD 64 1C 55 12 42 D7 C8 8E B0 E2 2 39 2D D7 AB C C3 31 96 3D 2F 71 58 B9
84 E5 5B 83 69 2 8D AB 82 E8 F5 1F AA 53 13 C1 FA 27 63 F5 FD A4 BB B4 43 46 38
56 21 CD 39 D0 C4 5B 1B 62 BC C0 4E 18 17 40 B9 F0 38 6E 8F BA 4 37 B9 9D 34 FD
CF 3A 57 21 D0 EB 5 96 1C 10 8C CB 8A BC 2D 3C 6D 59 8C 15 C6 8E 1B 48 EF E8 DC
16 40 99 AA 2E 22 92 5 27 26 A1 7 CE D8 59 14 90 D2 B0 31 F1 62 A3 1F E 9D B8 E1
72 B7 80 42 3D 20 CB D3 93 3 8F 46 A8 D0 DA 3A CF 21 7 CF B4 EB 70 89 8F 5A F1
D9 D2 4D 8F 83 5C 83 CB D5 EA 15 54 B0 B6 E1 B0 BA 1 23 EF 82 24 94 6B AC C3 1
F2 3C 87 ED BE CA 79 BE 8 11 B6 20 23 0 A8 58 23 DB 43 CA FD CD 8A 4A C6 C9 D8
63 18 A1 D8 E8 9B A E6 45 E1 DC BF 7D C7 60 7C 8D 29 A0 37 68 30 B4 52 91 A4 4D
3A 4E B A8 6E 93 83 C7 C6 55 E4 35 2B 2A E4 B1 C7 CE A9 F0 6 BE CE 68 FD 67 F4
BF C6 BC DB 71 59 29 73 8 E2 C3 56 1C 5D 63 23 9B 5C E 8F 0 41 CC 41 4A 7 7C ED
80 80 94 1F BE 11 8D 4E F8 4 A1 2F 68 D3 5 92 6E EC 5D D3 F6 AB BE 33 8F F0 AC
CB 8F F4 D9 1F 19 13 2 76 F0 4C DD 9F AE 80 44 5B 5E D5 57 38 A4 3E 7C B3 99 46
7F 56 13 5B 70 5E 8 84 C5 37 52 F2 59 B3 BC E5 A AF 92 C0 C1 E1 B9 52 F7 65 AA
1A 26 9 2D 83 8 D8 B 7 C4 24 4A 97 7B CC B9 EB 78 3A 13 EE 36 80 72 78 7D D0 E8
D5 39 94 F5 A4 AE DD AE 52 C0 DD EE 4F E 45 C1 BF 1B A6 97 B5 A4 3C F0 9B 8 D8
52 BC 19 51 3A 6C B5 74 5 2A 56 2B B4 37 E7 33 F4 7 55 11 30 5F FB A4 7C C5 3C
1C F9 8D 1E D7 CC C F6 39 E8 C0 1D 2C 8F 3A 8E E8 8E 21 52 7E 51 47 A5 64 26 86
31 BC 38 17 99 E2 22 D1 81 E6 95 A CD 72 1 5E 91 F6 B5 4F 2B 47 2E 3B 3C 58 E7
CB B1 3F 61 10 30 12 CF 37 59 D9 E7 5C 78 79 31 16 43 79 D7 63 21 D8 E2 AB C2 ED
A8 9B F8 6 76 CC E5 ED B5 DF 7F 1C 58 C0 13 B4 C9 C4 9C F7 D0 B 7 B8 15 49 1 2F
F9 3E FA 43 F8 5A F 56 26 1B B8 10 89 87 A4 FF 59 40 43 BA FD 3F 79 67 4 D9 B5
13 57 4A 40 66 3C 4E 71 88 13 95 F 39 AD 84 A6 BB 3E 69 EC A1 DC D 84 1E F6 CA
41 1A 74 85 EC C7 DB 91 6C DB ED DB 97 6E EA 56 F8 3D FC 16 14 1C 77 1B 70 37 69
43 E0 9A E2 D5 B3 6C C6 A 9F DB 1C D6 F4 BE 22 7D 2B E5 78 A1 FC 3A 1F C6 EF F8
60 F0 99 73 97 28 7 B4 A9 CB 5A 85 C1 7D E5 F8 15 F 54 7 9 9F 66 F5 16 CB E0 CA
E B1 47 A5 2C 58 DB 9D EC C4 DD E3 26 6 BE 38 F4 4A 20 41 83 47 96 8D 9C C6 52
74 68 B5 2A 2B 45 3 60 29 15 53 FF 6C 58 24 30 20 70 53 E6 65 C1 48 AE 64 38 C6
AF C4 63 C3 DE A3 DF 70 25 64 93 D3 DF 8A 6B 24 C1 BF 9E 17 E3 C8 B4 78 F 6F B2
0 1 AB 1C 1B E9 CC 8C 5B 1E AB 65 89 42 64 CE BB 7D 8A A1 A9 C7 C4 19 DA 3B D1
21 D8 FB F A5 C1 3E AF DC B4 67 AC FA F8 13 BF 67 6D 66 23 DA 71 1A B6 9F D6 40
D3 D5 D7 DD 7D DE 98 75 D1 B1 10 FB 29 3B 5F FA AA 3B 6C D0 F9 71 A7 E1 B0 22 E6
A2 10 69 5E 4B CC 8 3C CB 35 8D 64 3E 23 E1 A1 8E 8A D4 A5
fubar
if test $? -ne 0; then no_result; fi

srec_cat test.bin -bin -o test.out -logisim
if test $? -ne 0; then fail; fi

diff test.ok test.out
if test $? -ne 0; then fail; fi

# dog food it
srec_cmp test.bin -bin test.out -logisim

#
# The things tested here, worked.
# No other guarantees are made.
#
pass
