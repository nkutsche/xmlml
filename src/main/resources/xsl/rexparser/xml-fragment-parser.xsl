<?xml version="1.0" encoding="UTF-8"?>
<!-- This file was generated on Mon Dec 19, 2022 18:35 (UTC+01) by REx v5.55 which is Copyright (c) 1979-2022 by Gunther Rademacher <grd@gmx.net> -->
<!-- REx command line: XML-fragment.ebnf -xslt -tree -backtrack -->

<xsl:stylesheet version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:p="http://www.nkutsche.com/xml-fragment-parser">
  <!--~
   ! The index of the lexer state for accessing the combined
   ! (i.e. level > 1) lookahead code.
  -->
  <xsl:variable name="p:lk" as="xs:integer" select="1"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the begin of the token that has been consumed.
  -->
  <xsl:variable name="p:b0" as="xs:integer" select="2"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the end of the token that has been consumed.
  -->
  <xsl:variable name="p:e0" as="xs:integer" select="3"/>

  <!--~
   ! The index of the lexer state for accessing the code of the
   ! level-1-lookahead token.
  -->
  <xsl:variable name="p:l1" as="xs:integer" select="4"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the begin of the level-1-lookahead token.
  -->
  <xsl:variable name="p:b1" as="xs:integer" select="5"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the end of the level-1-lookahead token.
  -->
  <xsl:variable name="p:e1" as="xs:integer" select="6"/>

  <!--~
   ! The index of the lexer state for accessing the code of the
   ! level-2-lookahead token.
  -->
  <xsl:variable name="p:l2" as="xs:integer" select="7"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the begin of the level-2-lookahead token.
  -->
  <xsl:variable name="p:b2" as="xs:integer" select="8"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the end of the level-2-lookahead token.
  -->
  <xsl:variable name="p:e2" as="xs:integer" select="9"/>

  <!--~
   ! The index of the lexer state for accessing the token code that
   ! was expected when an error was found.
  -->
  <xsl:variable name="p:error" as="xs:integer" select="10"/>

  <!--~
   ! The index of the lexer state that points to the first entry
   ! used for collecting action results.
  -->
  <xsl:variable name="p:result" as="xs:integer" select="11"/>

  <!--~
   ! The codepoint to charclass mapping for 7 bit codepoints.
  -->
  <xsl:variable name="p:MAP0" as="xs:integer+" select="
    45, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 6, 7, 5, 5, 5, 5, 5, 8, 9, 10, 11, 12,
    11, 11, 11, 11, 11, 11, 11, 11, 13, 14, 15, 16, 17, 18, 5, 19, 20, 21, 22, 20, 20, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 23, 23, 23, 23,
    23, 23, 25, 5, 26, 5, 27, 5, 28, 20, 29, 30, 31, 20, 32, 23, 33, 23, 23, 34, 35, 36, 37, 23, 23, 38, 39, 40, 23, 41, 23, 42, 43, 23, 5, 5, 5, 5, 5
  "/>

  <!--~
   ! The codepoint to charclass mapping for codepoints below the surrogate block.
  -->
  <xsl:variable name="p:MAP1" as="xs:integer+" select="
    108, 124, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 156, 181, 181, 181, 181, 181, 214, 215, 213, 214, 214, 214, 214, 214, 214,
    214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 247, 261, 277, 293, 309, 321, 337, 353, 388, 388, 388, 380, 436, 428, 436, 428,
    436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 405, 405, 405, 405, 405, 405, 405, 421, 436, 436, 436, 436, 436, 436, 436,
    436, 364, 388, 388, 389, 387, 388, 388, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 388, 388, 388, 388, 388,
    388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 388, 435, 436, 436, 436,
    436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 436, 388, 45, 0,
    0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 6, 7, 5, 5, 5, 5, 5, 8, 9, 10, 11, 12, 11, 11, 11, 11,
    11, 11, 11, 11, 13, 14, 15, 16, 17, 18, 5, 19, 20, 21, 22, 20, 20, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 23, 23, 23, 23, 23, 23, 25, 5, 26, 5, 27, 5, 28,
    20, 29, 30, 31, 20, 32, 23, 33, 23, 23, 34, 35, 36, 37, 23, 23, 38, 39, 40, 23, 41, 23, 42, 43, 23, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 13, 13, 5, 5, 5, 5,
    5, 5, 5, 5, 5, 44, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 13, 13, 13, 13, 13,
    13, 13, 13, 13, 13, 13, 13, 13, 13, 5, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13
  "/>

  <!--~
   ! The codepoint to charclass mapping for codepoints above the surrogate block.
  -->
  <xsl:variable name="p:MAP2" as="xs:integer+" select="
    57344, 63744, 64976, 65008, 65536, 63743, 64975, 65007, 65533, 1114111, 5, 13, 5, 13, 5
  "/>

  <!--~
   ! The token-set-id to DFA-initial-state mapping.
  -->
  <xsl:variable name="p:INITIAL" as="xs:integer+" select="
    1, 2, 1027, 4, 5, 1542, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 674, 803, 36, 37, 38
  "/>

  <!--~
   ! The DFA transition table.
  -->
  <xsl:variable name="p:TRANSITION" as="xs:integer+" select="
    771, 771, 771, 771, 771, 771, 771, 771, 771, 771, 771, 771, 771, 771, 771, 771, 736, 771, 880, 814, 792, 750, 1288, 762, 771, 770, 771, 771, 771, 771, 771,
    771, 780, 771, 771, 771, 792, 750, 1288, 800, 771, 770, 771, 771, 771, 771, 771, 771, 780, 811, 771, 808, 822, 750, 771, 762, 771, 770, 771, 771, 771, 771,
    771, 771, 780, 771, 771, 771, 792, 750, 1288, 830, 771, 770, 771, 771, 771, 771, 771, 771, 780, 771, 771, 771, 792, 750, 1288, 762, 771, 770, 771, 771, 771,
    771, 771, 771, 780, 771, 771, 771, 838, 750, 771, 1110, 771, 771, 771, 771, 771, 771, 771, 771, 780, 848, 771, 846, 856, 750, 1288, 742, 771, 770, 771, 771,
    771, 771, 771, 771, 912, 754, 771, 771, 1248, 864, 1288, 762, 772, 888, 771, 771, 771, 771, 771, 771, 780, 771, 771, 771, 1338, 906, 1288, 762, 771, 770,
    771, 771, 771, 771, 771, 771, 780, 771, 771, 926, 792, 750, 1288, 934, 771, 770, 771, 771, 771, 771, 771, 771, 942, 950, 771, 771, 1338, 959, 1288, 762,
    973, 770, 771, 771, 771, 771, 771, 771, 982, 950, 771, 771, 1338, 959, 1288, 762, 973, 770, 771, 771, 771, 771, 771, 771, 990, 771, 771, 1196, 1338, 1006,
    1288, 762, 771, 770, 771, 771, 771, 771, 771, 771, 780, 1072, 771, 771, 792, 750, 1288, 762, 771, 770, 771, 771, 771, 771, 771, 771, 780, 771, 771, 771,
    918, 750, 771, 1110, 771, 771, 771, 771, 771, 771, 771, 771, 780, 1206, 1207, 771, 792, 750, 1288, 762, 771, 770, 771, 771, 771, 771, 771, 771, 780, 1054,
    1055, 1018, 792, 1026, 786, 1034, 1052, 771, 771, 771, 771, 771, 771, 771, 1063, 771, 998, 996, 1080, 1088, 1288, 1100, 771, 770, 771, 771, 771, 771, 771,
    771, 990, 1108, 771, 1196, 1338, 959, 1288, 762, 771, 770, 771, 1118, 771, 771, 771, 771, 990, 1108, 771, 1196, 1338, 959, 1288, 762, 771, 770, 771, 771,
    771, 771, 771, 771, 990, 1108, 771, 1196, 1338, 959, 1288, 762, 771, 1126, 771, 771, 771, 771, 771, 771, 990, 1108, 771, 1196, 1338, 959, 1288, 762, 771,
    770, 1320, 771, 771, 771, 771, 771, 990, 963, 771, 1196, 1338, 959, 1288, 762, 771, 770, 771, 771, 771, 771, 771, 771, 990, 963, 771, 1196, 1338, 959, 1288,
    762, 771, 770, 771, 1179, 771, 771, 771, 771, 780, 771, 771, 771, 792, 750, 1288, 762, 951, 770, 771, 771, 1147, 771, 771, 771, 1133, 771, 1157, 894, 1167,
    1175, 1288, 1187, 771, 1195, 771, 771, 771, 771, 771, 771, 990, 771, 771, 1196, 1338, 959, 1288, 762, 771, 770, 771, 771, 771, 771, 771, 771, 990, 1108,
    771, 1196, 1338, 959, 1288, 762, 1275, 770, 965, 771, 771, 771, 771, 771, 990, 1108, 771, 1196, 1338, 959, 1288, 762, 877, 770, 771, 771, 771, 771, 771,
    771, 990, 1108, 771, 1196, 1338, 959, 1288, 762, 771, 770, 1204, 771, 771, 771, 771, 771, 990, 1108, 1069, 1196, 1215, 959, 1139, 762, 771, 770, 771, 771,
    1223, 771, 771, 771, 990, 963, 771, 1196, 1338, 959, 1288, 762, 771, 770, 771, 1226, 771, 771, 771, 771, 990, 963, 771, 1196, 1338, 959, 1288, 762, 771,
    770, 871, 771, 771, 771, 771, 771, 990, 963, 771, 1196, 1338, 959, 1288, 762, 771, 770, 1279, 1041, 771, 771, 771, 771, 990, 963, 771, 1196, 1338, 959,
    1288, 762, 771, 1234, 771, 771, 771, 771, 771, 771, 990, 963, 771, 1092, 1338, 959, 1242, 762, 771, 1256, 771, 1270, 1287, 771, 771, 771, 990, 963, 771,
    1196, 1338, 959, 1044, 762, 771, 1296, 974, 1149, 771, 771, 771, 771, 990, 963, 771, 1196, 1338, 959, 1288, 762, 898, 770, 771, 771, 771, 771, 771, 771,
    990, 963, 1261, 1262, 1307, 959, 1288, 762, 1299, 1315, 771, 771, 771, 771, 771, 771, 990, 963, 771, 1196, 1338, 959, 1332, 762, 771, 770, 771, 771, 771,
    771, 771, 771, 990, 963, 1010, 1196, 1338, 959, 1288, 762, 771, 770, 771, 771, 771, 771, 771, 771, 990, 963, 771, 1196, 1338, 959, 1288, 762, 1159, 1346,
    771, 771, 771, 771, 771, 771, 990, 963, 771, 1324, 1338, 959, 1288, 762, 771, 770, 771, 771, 771, 771, 771, 771, 780, 771, 771, 771, 1338, 1006, 1288, 762,
    771, 770, 771, 771, 771, 771, 771, 771, 771, 771, 771, 771, 1351, 771, 771, 771, 771, 771, 771, 771, 771, 771, 771, 771, 385, 0, 1027, 41, 0, 1542, 0, 0, 0,
    956, 956, 0, 41, 1542, 41, 0, 0, 1542, 0, 0, 0, 0, 47, 0, 0, 0, 0, 826, 0, 956, 956, 0, 41, 1542, 956, 0, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 1027, 0, 0, 1542,
    0, 0, 0, 2944, 4352, 0, 0, 696, 826, 0, 956, 956, 0, 1027, 0, 826, 72, 956, 956, 72, 41, 1542, 2176, 0, 0, 0, 0, 2176, 0, 0, 0, 0, 0, 385, 385, 0, 0, 2176,
    826, 0, 956, 956, 0, 1027, 2503, 826, 0, 956, 956, 0, 41, 1542, 0, 2361, 2361, 2361, 2361, 2361, 0, 1027, 2688, 0, 0, 0, 0, 2688, 0, 0, 0, 0, 0, 696, 2688,
    0, 956, 956, 0, 1027, 41, 0, 1451, 1542, 0, 2094, 66, 0, 0, 88, 0, 0, 90, 0, 0, 75, 0, 0, 0, 0, 0, 385, 385, 385, 956, 0, 0, 0, 0, 3328, 0, 0, 0, 4277, 0,
    0, 0, 0, 77, 0, 0, 0, 41, 0, 1451, 1542, 65, 2094, 0, 0, 40, 0, 0, 1542, 0, 0, 0, 3259, 3259, 3262, 0, 1027, 0, 52, 0, 0, 0, 0, 52, 52, 0, 826, 3584, 956,
    956, 0, 41, 1542, 0, 0, 1027, 0, 0, 1542, 0, 1800, 1929, 0, 0, 0, 0, 0, 0, 0, 79, 41, 0, 1451, 1542, 0, 2094, 0, 0, 0, 0, 0, 0, 91, 0, 1729, 0, 0, 0, 0, 0,
    0, 0, 92, 0, 0, 1027, 0, 0, 1542, 45, 1800, 0, 551, 1027, 0, 1451, 1542, 0, 0, 48, 0, 0, 0, 0, 0, 0, 48, 41, 0, 1451, 1542, 0, 0, 0, 0, 51, 0, 0, 0, 0,
    3968, 0, 0, 0, 0, 3968, 3968, 41, 1280, 0, 1542, 0, 0, 0, 4096, 0, 826, 0, 956, 956, 0, 1280, 0, 0, 95, 0, 0, 0, 0, 0, 4608, 0, 696, 0, 2816, 0, 0, 0, 0, 0,
    0, 0, 3968, 0, 0, 0, 1027, 42, 0, 1542, 0, 0, 49, 0, 0, 0, 0, 0, 3072, 0, 0, 48, 696, 826, 0, 956, 956, 0, 1027, 63, 0, 0, 1542, 0, 0, 0, 0, 54, 0, 0, 551,
    0, 826, 1152, 956, 956, 1226, 63, 1542, 1929, 2094, 0, 0, 0, 0, 0, 0, 41, 1542, 93, 0, 0, 0, 0, 0, 0, 98, 956, 0, 0, 0, 0, 0, 84, 0, 0, 1027, 0, 0, 44, 0,
    0, 69, 0, 0, 0, 70, 696, 0, 3456, 0, 0, 0, 0, 0, 0, 97, 0, 0, 4224, 0, 0, 0, 0, 0, 0, 2560, 0, 0, 696, 826, 0, 957, 957, 0, 1027, 41, 0, 0, 64, 0, 0, 0, 0,
    96, 0, 0, 0, 0, 826, 0, 957, 969, 0, 41, 64, 969, 0, 0, 0, 0, 0, 0, 0, 551, 86, 87, 0, 0, 0, 0, 0, 0, 3840, 0, 0, 49, 696, 826, 0, 956, 956, 551, 1027, 0,
    0, 4736, 0, 0, 0, 0, 0, 4480, 0, 0, 956, 0, 0, 0, 0, 0, 0, 85, 67, 0, 0, 0, 0, 0, 0, 696, 826, 0, 956, 956, 551, 0, 956, 0, 0, 82, 0, 0, 0, 0, 50, 0, 0, 0,
    0, 551, 0, 94, 0, 4864, 0, 0, 0, 0, 76, 0, 0, 0, 0, 3712, 0, 0, 0, 99, 0, 0, 0, 0, 0, 0, 0, 696, 956, 0, 81, 0, 0, 0, 0, 0, 4992, 0, 0, 50, 696, 826, 0,
    956, 956, 551, 1027, 956, 0, 0, 0, 83, 0, 0, 0, 89, 0, 0, 0, 0, 55, 0, 0, 551, 0, 68, 0, 0, 0, 0, 0, 696, 826, 0, 956, 956, 551, 1027, 956, 80, 0, 0, 0, 0,
    0, 0, 256, 256, 256, 0, 0
  "/>

  <!--~
   ! The DFA-state to expected-token-set mapping.
  -->
  <xsl:variable name="p:EXPECTED" as="xs:integer+" select="
    50, 55, 59, 63, 73, 67, 71, 79, 90, 83, 53, 87, 137, 99, 94, 103, 107, 117, 97, 121, 109, 98, 112, 125, 111, 74, 74, 74, 74, 129, 74, 149, 113, 74, 74, 74,
    75, 143, 135, 74, 74, 141, 136, 141, 75, 131, 130, 130, 147, 149, 4, 8, 128, 512, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 1048576, 2097152,
    8388608, 536870912, 1073741824, 0, 536870916, 1073741828, -2147483644, 1114112, 1077936128, -2147483648, 0, 0, 0, 0, 4, 0, 1114116, 1077936132, 1077936136,
    252576066, 386793794, 8, 128, 4096, 32768, 2097152, -2147483648, 983056, 1966112, 252576002, 786432, 32, 234881280, 64, 268435456, 0, 0, 0, 16, 64,
    369099008, 512, 2048, 4096, 2097152, 0, 0, 0, 67108864, 0, 0, 0, 20, 0, 0, 524288, 100663296, 0, 33554432, 67108864, 268435456, 67108864, 0, 0, 67108864, 1,
    4, 16, 32, 0, 0, 8, 64, 0, 0, 0, 4194304, 0, 4, 16, 32, 0, 2, 4, 16, 0, 16, 3, 72
  "/>

  <!--~
   ! The token-string table.
  -->
  <xsl:variable name="p:TOKEN" as="xs:string+" select="
    '(0)',
    'EOF',
    'S',
    'Name',
    'AttValueDoubleVal',
    'AttValueSingleVal',
    'CharData',
    'CommentContent',
    &quot;'&lt;?'&quot;,
    'PIContentEnd',
    'PITarget',
    'CDSectContent',
    'VersionNum',
    'CharRefDec',
    'CharRefHex',
    'EncName',
    &quot;'&quot;&quot;'&quot;,
    &quot;'&amp;'&quot;,
    &quot;'&amp;#'&quot;,
    &quot;'&amp;#x'&quot;,
    &quot;''''&quot;,
    &quot;'--&gt;'&quot;,
    &quot;'/&gt;'&quot;,
    &quot;';'&quot;,
    &quot;'&lt;'&quot;,
    &quot;'&lt;!--'&quot;,
    &quot;'&lt;![CDATA['&quot;,
    &quot;'&lt;/'&quot;,
    &quot;'&lt;?xml'&quot;,
    &quot;'='&quot;,
    &quot;'&gt;'&quot;,
    &quot;'?&gt;'&quot;,
    &quot;']'&quot;,
    &quot;']&gt;'&quot;,
    &quot;'encoding'&quot;,
    &quot;'no'&quot;,
    &quot;'standalone'&quot;,
    &quot;'version'&quot;,
    &quot;'yes'&quot;
  "/>

  <!--~
   ! Match next token in input string, starting at given index, using
   ! the DFA entry state for the set of tokens that are expected in
   ! the current context.
   !
   ! @param $input the input string.
   ! @param $begin the index where to start in input string.
   ! @param $token-set the expected token set id.
   ! @return a sequence of three: the token code of the result token,
   ! with input string begin and end positions. If there is no valid
   ! token, return the negative id of the DFA state that failed, along
   ! with begin and end positions of the longest viable prefix.
  -->
  <xsl:function name="p:match" as="xs:integer+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="begin" as="xs:integer"/>
    <xsl:param name="token-set" as="xs:integer"/>

    <xsl:variable name="result" select="$p:INITIAL[1 + $token-set]"/>
    <xsl:sequence select="p:transition($input, $begin, $begin, $begin, $result, $result mod 128, 0)"/>
  </xsl:function>

  <!--~
   ! The DFA state transition function. If we are in a valid DFA state, save
   ! it's result annotation, consume one input codepoint, calculate the next
   ! state, and use tail recursion to do the same again. Otherwise, return
   ! any valid result or a negative DFA state id in case of an error.
   !
   ! @param $input the input string.
   ! @param $begin the begin index of the current token in the input string.
   ! @param $current the index of the current position in the input string.
   ! @param $end the end index of the result in the input string.
   ! @param $result the result code.
   ! @param $current-state the current DFA state.
   ! @param $previous-state the  previous DFA state.
   ! @return a sequence of three: the token code of the result token,
   ! with input string begin and end positions. If there is no valid
   ! token, return the negative id of the DFA state that failed, along
   ! with begin and end positions of the longest viable prefix.
  -->
  <xsl:function name="p:transition">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="begin" as="xs:integer"/>
    <xsl:param name="current" as="xs:integer"/>
    <xsl:param name="end" as="xs:integer"/>
    <xsl:param name="result" as="xs:integer"/>
    <xsl:param name="current-state" as="xs:integer"/>
    <xsl:param name="previous-state" as="xs:integer"/>

    <xsl:choose>
      <xsl:when test="$current-state eq 0">
        <xsl:variable name="result" select="$result idiv 128"/>
        <xsl:variable name="end" select="if ($end gt string-length($input)) then string-length($input) + 1 else $end"/>
        <xsl:sequence select="
          if ($result ne 0) then
          (
            $result - 1,
            $begin,
            $end
          )
          else
          (
            - $previous-state,
            $begin,
            $current - 1
          )
        "/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="c0" select="(string-to-codepoints(substring($input, $current, 1)), 0)[1]"/>
        <xsl:variable name="c1" as="xs:integer">
          <xsl:choose>
            <xsl:when test="$c0 &lt; 128">
              <xsl:sequence select="$p:MAP0[1 + $c0]"/>
            </xsl:when>
            <xsl:when test="$c0 &lt; 55296">
              <xsl:variable name="c1" select="$c0 idiv 16"/>
              <xsl:variable name="c2" select="$c1 idiv 32"/>
              <xsl:sequence select="$p:MAP1[1 + $c0 mod 16 + $p:MAP1[1 + $c1 mod 32 + $p:MAP1[1 + $c2]]]"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="p:map2($c0, 1, 5)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="current" select="$current + 1"/>
        <xsl:variable name="i0" select="128 * $c1 + $current-state - 1"/>
        <xsl:variable name="i1" select="$i0 idiv 8"/>
        <xsl:variable name="next-state" select="$p:TRANSITION[$i0 mod 8 + $p:TRANSITION[$i1 + 1] + 1]"/>
        <xsl:sequence select="
          if ($next-state &gt; 127) then
            p:transition($input, $begin, $current, $current, $next-state, $next-state mod 128, $current-state)
          else
            p:transition($input, $begin, $current, $end, $result, $next-state, $current-state)
        "/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Recursively translate one 32-bit chunk of an expected token bitset
   ! to the corresponding sequence of token strings.
   !
   ! @param $result the result of previous recursion levels.
   ! @param $chunk the 32-bit chunk of the expected token bitset.
   ! @param $base-token-code the token code of bit 0 in the current chunk.
   ! @return the set of token strings.
  -->
  <xsl:function name="p:token">
    <xsl:param name="result" as="xs:string*"/>
    <xsl:param name="chunk" as="xs:integer"/>
    <xsl:param name="base-token-code" as="xs:integer"/>

    <xsl:sequence select="
      if ($chunk = 0) then
        $result
      else
        p:token
        (
          ($result, if ($chunk mod 2 != 0) then $p:TOKEN[$base-token-code] else ()),
          if ($chunk &lt; 0) then $chunk idiv 2 + 2147483648 else $chunk idiv 2,
          $base-token-code + 1
        )
    "/>
  </xsl:function>

  <!--~
   ! Calculate expected token set for a given DFA state as a sequence
   ! of strings.
   !
   ! @param $state the DFA state.
   ! @return the set of token strings
  -->
  <xsl:function name="p:expected-token-set" as="xs:string*">
    <xsl:param name="state" as="xs:integer"/>

    <xsl:if test="$state > 0">
      <xsl:for-each select="0 to 1">
        <xsl:variable name="i0" select=". * 99 + $state - 1"/>
        <xsl:variable name="i1" select="$i0 idiv 4"/>
        <xsl:sequence select="p:token((), $p:EXPECTED[$i0 mod 4 + $p:EXPECTED[$i1 + 1] + 1], . * 32 + 1)"/>
      </xsl:for-each>
    </xsl:if>
  </xsl:function>

  <!--~
   ! Classify codepoint by doing a tail recursive binary search for a
   ! matching codepoint range entry in MAP2, the codepoint to charclass
   ! map for codepoints above the surrogate block.
   !
   ! @param $c the codepoint.
   ! @param $lo the binary search lower bound map index.
   ! @param $hi the binary search upper bound map index.
   ! @return the character class.
  -->
  <xsl:function name="p:map2" as="xs:integer">
    <xsl:param name="c" as="xs:integer"/>
    <xsl:param name="lo" as="xs:integer"/>
    <xsl:param name="hi" as="xs:integer"/>

    <xsl:variable name="m" select="($hi + $lo) idiv 2"/>
    <xsl:choose>
      <xsl:when test="$lo &gt; $hi">
        <xsl:sequence select="0"/>
      </xsl:when>
      <xsl:when test="$p:MAP2[$m] &gt; $c">
        <xsl:sequence select="p:map2($c, $lo, $m - 1)"/>
      </xsl:when>
      <xsl:when test="$p:MAP2[5 + $m] &lt; $c">
        <xsl:sequence select="p:map2($c, $m + 1, $hi)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="$p:MAP2[10 + $m]"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse Comment.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-Comment" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(25, $input, $state)"/>             <!-- '<!-' '-' -->
    <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>           <!-- CommentContent -->
    <xsl:variable name="state" select="p:consume(7, $input, $state)"/>              <!-- CommentContent -->
    <xsl:variable name="state" select="p:lookahead1(12, $input, $state)"/>          <!-- '-' '->' -->
    <xsl:variable name="state" select="p:consume(21, $input, $state)"/>             <!-- '-' '->' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'Comment', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse PI.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-PI" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(8, $input, $state)"/>              <!-- PIStart -->
    <xsl:variable name="state" select="p:lookahead1(4, $input, $state)"/>           <!-- PITarget -->
    <xsl:variable name="state" select="p:consume(10, $input, $state)"/>             <!-- PITarget -->
    <xsl:variable name="state" select="p:lookahead1(3, $input, $state)"/>           <!-- PIContentEnd -->
    <xsl:variable name="state" select="p:consume(9, $input, $state)"/>              <!-- PIContentEnd -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'PI', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production CDSect (one or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-CDSect-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>      <!-- ']' -->
        <xsl:variable name="state" select="p:consume(32, $input, $state)"/>         <!-- ']' -->
        <xsl:variable name="state" select="p:lookahead1(27, $input, $state)"/>      <!-- ']' | ']>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 32">                                     <!-- ']' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="p:parse-CDSect-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse CDSect.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-CDSect" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(26, $input, $state)"/>             <!-- '<![CDATA[' -->
    <xsl:variable name="state" select="p:lookahead1(5, $input, $state)"/>           <!-- CDSectContent -->
    <xsl:variable name="state" select="p:consume(11, $input, $state)"/>             <!-- CDSectContent -->
    <xsl:variable name="state" select="p:parse-CDSect-1($input, $state)"/>
    <xsl:variable name="state" select="p:consume(33, $input, $state)"/>             <!-- ']>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'CDSect', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse ETag.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-ETag" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(27, $input, $state)"/>             <!-- '</' -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:lookahead1(22, $input, $state)"/>          <!-- S | '>' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 2">                                         <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(15, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(30, $input, $state)"/>             <!-- '>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'ETag', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production AttValueSingle (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-AttValueSingle-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(34, $input, $state)"/>      <!-- AttValueSingleVal | '&' | '&#' | '&#x' | "'" -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 20">                                      <!-- "'" -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 5">                                 <!-- AttValueSingleVal -->
                  <xsl:variable name="state" select="p:consume(5, $input, $state)"/> <!-- AttValueSingleVal -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-Reference($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-AttValueSingle-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse AttValueSingle.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-AttValueSingle" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:parse-AttValueSingle-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'AttValueSingle', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse CharRef.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-CharRef" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 18">                                        <!-- '&#' -->
          <xsl:variable name="state" select="p:consume(18, $input, $state)"/>       <!-- '&#' -->
          <xsl:variable name="state" select="p:lookahead1(7, $input, $state)"/>     <!-- CharRefDec -->
          <xsl:variable name="state" select="p:consume(13, $input, $state)"/>       <!-- CharRefDec -->
          <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>    <!-- ';' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- ';' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(19, $input, $state)"/>       <!-- '&#x' -->
          <xsl:variable name="state" select="p:lookahead1(8, $input, $state)"/>     <!-- CharRefHex -->
          <xsl:variable name="state" select="p:consume(14, $input, $state)"/>       <!-- CharRefHex -->
          <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>    <!-- ';' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- ';' -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'CharRef', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse EntityRef.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EntityRef" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(17, $input, $state)"/>             <!-- '&' -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>          <!-- ';' -->
    <xsl:variable name="state" select="p:consume(23, $input, $state)"/>             <!-- ';' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'EntityRef', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse Reference.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-Reference" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 17">                                        <!-- '&' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EntityRef($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-CharRef($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'Reference', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production AttValueDouble (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-AttValueDouble-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(33, $input, $state)"/>      <!-- AttValueDoubleVal | '"' | '&' | '&#' | '&#x' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 16">                                      <!-- '"' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 4">                                 <!-- AttValueDoubleVal -->
                  <xsl:variable name="state" select="p:consume(4, $input, $state)"/> <!-- AttValueDoubleVal -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-Reference($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-AttValueDouble-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse AttValueDouble.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-AttValueDouble" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:parse-AttValueDouble-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'AttValueDouble', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse AttValue.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-AttValue" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 16">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(16, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-AttValueDouble($input, $state)
          "/>
          <xsl:variable name="state" select="p:consume(16, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-AttValueSingle($input, $state)
          "/>
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'AttValue', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse Attribute.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-Attribute" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-Eq($input, $state)
    "/>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-AttValue($input, $state)
    "/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'Attribute', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production element (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-element-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(30, $input, $state)"/>      <!-- S | '/>' | '>' -->
        <xsl:variable name="state" as="item()+">
          <xsl:choose>
            <xsl:when test="$state[$p:l1] eq 2">                                    <!-- S -->
              <xsl:variable name="state" select="p:lookahead2(31, $input, $state)"/> <!-- Name | '/>' | '>' -->
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$state[$p:lk] != 194">                                    <!-- S Name -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="
              if ($state[$p:error]) then
                $state
              else
                p:parse-Attribute($input, $state)
            "/>
            <xsl:sequence select="p:parse-element-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse element.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-element" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(24, $input, $state)"/>             <!-- '<' -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:parse-element-1($input, $state)"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 2">                                         <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(25, $input, $state)"/>          <!-- '/>' | '>' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 22">                                        <!-- '/>' -->
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '/>' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(30, $input, $state)"/>       <!-- '>' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-content($input, $state)
          "/>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-ETag($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'element', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production content (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-content-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(35, $input, $state)"/>      <!-- EOF | PIStart | '&' | '&#' | '&#x' | '<' | '<!-' '-' | '<![CDATA[' |
                                                                                         '</' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 1                                           (: EOF :)
                       or $state[$p:l1] = 27">                                      <!-- '</' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 24">                                <!-- '<' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-element($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 26">                                <!-- '<![CDATA[' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-CDSect($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 8">                                 <!-- PIStart -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-PI($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 25">                                <!-- '<!-' '-' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-Comment($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-Reference($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>  <!-- EOF | CharData | PIStart | '&' | '&#' | '&#x' | '<' | '<!-' '-' |
                                                                                         '<![CDATA[' | '</' -->
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 6">                                 <!-- CharData -->
                  <xsl:variable name="state" select="p:consume(6, $input, $state)"/> <!-- CharData -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-content-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse content.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-content" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>          <!-- EOF | CharData | PIStart | '&' | '&#' | '&#x' | '<' | '<!-' '-' |
                                                                                         '<![CDATA[' | '</' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 6">                                         <!-- CharData -->
          <xsl:variable name="state" select="p:consume(6, $input, $state)"/>        <!-- CharData -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:parse-content-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'content', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse SDDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-SDDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(19, $input, $state)"/>          <!-- 'standalone' -->
    <xsl:variable name="state" select="p:consume(36, $input, $state)"/>             <!-- 'standalone' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-Eq($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 20">                                        <!-- "'" -->
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(28, $input, $state)"/>    <!-- 'no' | 'yes' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 38">                                  <!-- 'yes' -->
                <xsl:variable name="state" select="p:consume(38, $input, $state)"/> <!-- 'yes' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="state" select="p:consume(35, $input, $state)"/> <!-- 'no' -->
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="state" select="p:lookahead1(11, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(16, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(28, $input, $state)"/>    <!-- 'no' | 'yes' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 38">                                  <!-- 'yes' -->
                <xsl:variable name="state" select="p:consume(38, $input, $state)"/> <!-- 'yes' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="state" select="p:consume(35, $input, $state)"/> <!-- 'no' -->
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="state" select="p:lookahead1(10, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(16, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'SDDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse EncodingDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EncodingDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(18, $input, $state)"/>          <!-- 'encoding' -->
    <xsl:variable name="state" select="p:consume(34, $input, $state)"/>             <!-- 'encoding' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-Eq($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 16">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(16, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(9, $input, $state)"/>     <!-- EncName -->
          <xsl:variable name="state" select="p:consume(15, $input, $state)"/>       <!-- EncName -->
          <xsl:variable name="state" select="p:lookahead1(10, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(16, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(9, $input, $state)"/>     <!-- EncName -->
          <xsl:variable name="state" select="p:consume(15, $input, $state)"/>       <!-- EncName -->
          <xsl:variable name="state" select="p:lookahead1(11, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'EncodingDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse Eq.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-Eq" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(21, $input, $state)"/>          <!-- S | '=' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 2">                                         <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(14, $input, $state)"/>          <!-- '=' -->
    <xsl:variable name="state" select="p:consume(29, $input, $state)"/>             <!-- '=' -->
    <xsl:variable name="state" select="p:lookahead1(29, $input, $state)"/>          <!-- S | '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 2">                                         <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'Eq', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse VersionInfo.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-VersionInfo" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(20, $input, $state)"/>          <!-- 'version' -->
    <xsl:variable name="state" select="p:consume(37, $input, $state)"/>             <!-- 'version' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-Eq($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 20">                                        <!-- "'" -->
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(6, $input, $state)"/>     <!-- VersionNum -->
          <xsl:variable name="state" select="p:consume(12, $input, $state)"/>       <!-- VersionNum -->
          <xsl:variable name="state" select="p:lookahead1(11, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(16, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(6, $input, $state)"/>     <!-- VersionNum -->
          <xsl:variable name="state" select="p:consume(12, $input, $state)"/>       <!-- VersionNum -->
          <xsl:variable name="state" select="p:lookahead1(10, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(16, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'VersionInfo', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse XMLDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-XMLDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(28, $input, $state)"/>             <!-- '<?xml' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-VersionInfo($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- S | '?>' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 2">                                        <!-- S -->
          <xsl:variable name="state" select="p:lookahead2(32, $input, $state)"/>    <!-- '?>' | 'encoding' | 'standalone' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 2178">                                      <!-- S 'encoding' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EncodingDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- S | '?>' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 2">                                        <!-- S -->
          <xsl:variable name="state" select="p:lookahead2(26, $input, $state)"/>    <!-- '?>' | 'standalone' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 2306">                                      <!-- S 'standalone' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-SDDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- S | '?>' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 2">                                         <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(16, $input, $state)"/>          <!-- '?>' -->
    <xsl:variable name="state" select="p:consume(31, $input, $state)"/>             <!-- '?>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'XMLDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse document-fragment.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-document-fragment" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(37, $input, $state)"/>          <!-- EOF | CharData | PIStart | '&' | '&#' | '&#x' | '<' | '<!-' '-' |
                                                                                         '<![CDATA[' | '<?xml' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 28">                                        <!-- '<?xml' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-XMLDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-content($input, $state)
    "/>
    <xsl:variable name="state" select="p:consume(1, $input, $state)"/>              <!-- EOF -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'document-fragment', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Create a textual error message from a parsing error.
   !
   ! @param $input the input string.
   ! @param $error the parsing error descriptor.
   ! @return the error message.
  -->
  <xsl:function name="p:error-message" as="xs:string">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="error" as="element(error)"/>

    <xsl:variable name="begin" select="xs:integer($error/@b)"/>
    <xsl:variable name="context" select="string-to-codepoints(substring($input, 1, $begin - 1))"/>
    <xsl:variable name="linefeeds" select="index-of($context, 10)"/>
    <xsl:variable name="line" select="count($linefeeds) + 1"/>
    <xsl:variable name="column" select="($begin - $linefeeds[last()], $begin)[1]"/>
    <xsl:variable name="expected" select="if ($error/@x or $error/@ambiguous-input) then () else p:expected-token-set($error/@s)"/>
    <xsl:sequence select="
      string-join
      (
        (
          if ($error/@o) then
            ('syntax error, found ', $p:TOKEN[$error/@o + 1])
          else
            'lexical analysis failed',
          '&#10;',
          'while expecting ',
          if ($error/@x) then
            $p:TOKEN[$error/@x + 1]
          else
          (
            '['[exists($expected[2])],
            string-join($expected, ', '),
            ']'[exists($expected[2])]
          ),
          '&#10;',
          if ($error/@o or $error/@e = $begin) then
            ()
          else
            ('after successfully scanning ', string($error/@e - $begin), ' characters beginning '),
          'at line ', string($line), ', column ', string($column), ':&#10;',
          '...', substring($input, $begin, 64), '...'
        ),
        ''
      )
    "/>
  </xsl:function>

  <!--~
   ! Consume one token, i.e. compare lookahead token 1 with expected
   ! token and in case of a match, shift lookahead tokens down such that
   ! l1 becomes the current token, and higher lookahead tokens move down.
   ! When lookahead token 1 does not match the expected token, raise an
   ! error by saving the expected token code in the error field of the
   ! lexer state.
   !
   ! @param $code the expected token.
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:consume" as="item()+">
    <xsl:param name="code" as="xs:integer"/>
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:when test="$state[$p:l1] eq $code">
        <xsl:variable name="begin" select="$state[$p:e0]"/>
        <xsl:variable name="end" select="$state[$p:b1]"/>
        <xsl:variable name="whitespace">
          <xsl:if test="$begin ne $end">
            <xsl:value-of select="substring($input, $begin, $end - $begin)"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="token" select="$p:TOKEN[1 + $state[$p:l1]]"/>
        <xsl:variable name="name" select="if (starts-with($token, &quot;'&quot;)) then 'TOKEN' else $token"/>
        <xsl:variable name="begin" select="$state[$p:b1]"/>
        <xsl:variable name="end" select="$state[$p:e1]"/>
        <xsl:variable name="node">
          <xsl:element name="{$name}">
            <xsl:sequence select="substring($input, $begin, $end - $begin)"/>
          </xsl:element>
        </xsl:variable>
        <xsl:sequence select="
          subsequence($state, $p:l1, 6),
          0, 0, 0,
          subsequence($state, 10),
          $whitespace/node(),
          $node/node()
        "/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="error">
          <xsl:element name="error">
            <xsl:attribute name="b" select="$state[$p:b1]"/>
            <xsl:attribute name="e" select="$state[$p:e1]"/>
            <xsl:choose>
              <xsl:when test="$state[$p:l1] lt 0">
                <xsl:attribute name="s" select="- $state[$p:l1]"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="o" select="$state[$p:l1]"/>
                <xsl:attribute name="x" select="$code"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:element>
        </xsl:variable>
        <xsl:sequence select="
          subsequence($state, 1, $p:error - 1),
          $error/node(),
          subsequence($state, $p:error + 1)
        "/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Lookahead one token on level 1.
   !
   ! @param $set the code of the DFA entry state for the set of valid tokens.
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result stack.
   ! @return the updated state.
  -->
  <xsl:function name="p:lookahead1" as="item()+">
    <xsl:param name="set" as="xs:integer"/>
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:l1] ne 0">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="match" select="
          p:match($input, $state[$p:e0], $set),
          0, 0, 0
        "/>
        <xsl:sequence select="
          $match[1],
          subsequence($state, $p:b0, 2),
          $match,
          subsequence($state, 10)
        "/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Lookahead one token on level 2.
   !
   ! @param $set the code of the DFA entry state for the set of valid tokens.
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result stack.
   ! @return the updated state.
  -->
  <xsl:function name="p:lookahead2" as="item()+">
    <xsl:param name="set" as="xs:integer"/>
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="match" select="
      if ($state[$p:l2] ne 0) then
        subsequence($state, $p:l2, 3)
      else
        p:match($input, $state[$p:e1], $set)
    "/>
    <xsl:sequence select="
      $match[1] * 64 + $state[$p:l1],
      subsequence($state, $p:b0, 5),
      $match,
      subsequence($state, 10)
    "/>
  </xsl:function>

  <!--~
   ! Reduce the result stack, creating a nonterminal element. Pop
   ! $count elements off the stack, wrap them in a new element
   ! named $name, and push the new element.
   !
   ! @param $state lexer state, error indicator, and result.
   ! @param $name the name of the result node.
   ! @param $count the number of child nodes.
   ! @param $begin the input index where the nonterminal begins.
   ! @param $end the input index where the nonterminal ends.
   ! @return the updated state.
  -->
  <xsl:function name="p:reduce" as="item()+">
    <xsl:param name="state" as="item()+"/>
    <xsl:param name="name" as="xs:string"/>
    <xsl:param name="count" as="xs:integer"/>
    <xsl:param name="begin" as="xs:integer"/>
    <xsl:param name="end" as="xs:integer"/>

    <xsl:variable name="node">
      <xsl:element name="{$name}">
        <xsl:sequence select="subsequence($state, $count + 1)"/>
      </xsl:element>
    </xsl:variable>
    <xsl:sequence select="subsequence($state, 1, $count), $node/node()"/>
  </xsl:function>

  <!--~
   ! Parse start symbol document-fragment from given string.
   !
   ! @param $s the string to be parsed.
   ! @return the result as generated by parser actions.
  -->
  <xsl:function name="p:parse-document-fragment" as="item()*">
    <xsl:param name="s" as="xs:string"/>

    <xsl:variable name="state" select="0, 1, 1, 0, 0, 0, 0, 0, 0, false()"/>
    <xsl:variable name="state" select="p:parse-document-fragment($s, $state)"/>
    <xsl:variable name="error" select="$state[$p:error]"/>
    <xsl:choose>
      <xsl:when test="$error">
        <xsl:variable name="ERROR">
          <xsl:element name="ERROR">
            <xsl:sequence select="$error/@*, p:error-message($s, $error)"/>
          </xsl:element>
        </xsl:variable>
        <xsl:sequence select="$ERROR/node()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="subsequence($state, $p:result)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

</xsl:stylesheet>