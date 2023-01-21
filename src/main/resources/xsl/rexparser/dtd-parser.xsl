<?xml version="1.0" encoding="UTF-8"?>
<!-- This file was generated on Sat Jan 21, 2023 14:48 (UTC+01) by REx v5.55 which is Copyright (c) 1979-2022 by Gunther Rademacher <grd@gmx.net> -->
<!-- REx command line: DTD.ebnf -xslt -tree -->
<xsl:stylesheet version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:p="http://www.nkutsche.com/dtd-parser">
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
   ! The index of the lexer state for accessing the code of the
   ! level-3-lookahead token.
  -->
  <xsl:variable name="p:l3" as="xs:integer" select="10"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the begin of the level-3-lookahead token.
  -->
  <xsl:variable name="p:b3" as="xs:integer" select="11"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the end of the level-3-lookahead token.
  -->
  <xsl:variable name="p:e3" as="xs:integer" select="12"/>

  <!--~
   ! The index of the lexer state for accessing the token code that
   ! was expected when an error was found.
  -->
  <xsl:variable name="p:error" as="xs:integer" select="13"/>

  <!--~
   ! The index of the lexer state that points to the first entry
   ! used for collecting action results.
  -->
  <xsl:variable name="p:result" as="xs:integer" select="14"/>

  <!--~
   ! The codepoint to charclass mapping for 7 bit codepoints.
  -->
  <xsl:variable name="p:MAP0" as="xs:integer+" select="
    68, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 6, 17,
    18, 17, 17, 17, 17, 17, 17, 17, 17, 19, 20, 21, 22, 23, 24, 6, 25, 26, 27, 28, 29, 30, 31, 32, 33, 32, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 32, 32,
    45, 46, 32, 47, 48, 49, 48, 50, 48, 51, 51, 52, 53, 54, 51, 55, 32, 56, 32, 32, 57, 58, 59, 60, 32, 32, 61, 62, 32, 32, 63, 32, 64, 32, 32, 48, 65, 48, 48,
    48
  "/>

  <!--~
   ! The codepoint to charclass mapping for codepoints below the surrogate block.
  -->
  <xsl:variable name="p:MAP1" as="xs:integer+" select="
    108, 124, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 156, 181, 181, 181, 181, 181, 214, 215, 213, 214, 214, 214, 214, 214, 214,
    214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 247, 261, 277, 308, 292, 324, 340, 356, 393, 393, 393, 385, 441, 433, 441, 433,
    441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 410, 410, 410, 410, 410, 410, 410, 426, 441, 441, 441, 441, 441, 441, 441,
    441, 369, 393, 393, 394, 392, 393, 393, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 393, 393, 393, 393, 393,
    393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 393, 440, 441, 441, 441,
    441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 441, 393, 68, 0,
    0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 6, 25, 26, 27, 28,
    29, 30, 31, 32, 33, 32, 34, 35, 36, 37, 38, 17, 18, 17, 17, 17, 17, 17, 17, 17, 17, 19, 20, 21, 22, 23, 24, 39, 40, 41, 42, 43, 44, 32, 32, 45, 46, 32, 47,
    48, 49, 48, 50, 48, 51, 51, 52, 53, 54, 51, 55, 32, 56, 32, 32, 57, 58, 59, 60, 32, 32, 61, 62, 32, 32, 63, 32, 64, 32, 32, 48, 65, 48, 48, 48, 48, 48, 48,
    48, 48, 48, 48, 48, 48, 67, 67, 48, 48, 48, 48, 48, 48, 48, 48, 48, 66, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 66, 66, 66, 66, 66,
    66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 48, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67,
    67, 67, 67, 67
  "/>

  <!--~
   ! The codepoint to charclass mapping for codepoints above the surrogate block.
  -->
  <xsl:variable name="p:MAP2" as="xs:integer+" select="
    57344, 63744, 64976, 65008, 65536, 63743, 64975, 65007, 65533, 1114111, 48, 67, 48, 67, 48
  "/>

  <!--~
   ! The token-set-id to DFA-initial-state mapping.
  -->
  <xsl:variable name="p:INITIAL" as="xs:integer+" select="
    1, 2, 3, 4, 5, 6, 7, 3592, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78
  "/>

  <!--~
   ! The DFA transition table.
  -->
  <xsl:variable name="p:TRANSITION" as="xs:integer+" select="
    1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1104, 1113, 1131, 2320, 1156, 1112, 3659, 3310, 1898, 3316,
    1113, 1113, 1113, 1113, 1113, 1113, 1172, 1113, 1131, 2320, 1156, 1112, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1196, 1113, 1113, 3167,
    1927, 1112, 1223, 1672, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 2906, 1113, 2531, 2915, 1259, 1112, 3606, 3310, 1898, 3316, 1113, 1113, 1113, 1113,
    1113, 1113, 1275, 1113, 1288, 3245, 1307, 1112, 1323, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1196, 1113, 1113, 3167, 1927, 1112, 3659, 3310,
    1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1196, 1361, 2623, 3167, 1927, 1112, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1379, 1113,
    1113, 3167, 3082, 1112, 1896, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1403, 1427, 2551, 3146, 1445, 1112, 3484, 3310, 1898, 3316, 1113, 1113,
    1113, 1113, 1113, 1113, 1196, 1461, 2953, 2959, 1480, 1112, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1196, 1496, 1575, 1953, 1516, 1112,
    3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1196, 1113, 1113, 3167, 3011, 1180, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113,
    1196, 1113, 1113, 3167, 3039, 1112, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1196, 1113, 1801, 2220, 1532, 1112, 3659, 3310, 1898, 3316,
    1113, 1113, 1113, 1113, 1113, 1113, 1548, 2332, 1572, 3167, 2100, 1591, 3659, 3310, 2855, 1243, 1113, 1113, 1113, 1113, 1113, 1113, 1614, 1113, 1572, 3167,
    2578, 1638, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1659, 1113, 1572, 3167, 2578, 1688, 3659, 1237, 1898, 3316, 1113, 1113, 1113, 1113,
    1113, 1113, 1709, 1113, 1572, 3167, 2578, 1688, 3659, 1237, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1738, 1113, 1771, 2110, 1782, 1798, 3659, 3310,
    1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1196, 3239, 1113, 3167, 1927, 1112, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1379, 1113,
    1113, 1643, 1345, 1112, 1817, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1196, 3410, 3413, 3167, 1927, 1112, 3659, 3310, 1898, 3316, 1113, 1113,
    1113, 1113, 1113, 1113, 1379, 1835, 2014, 1842, 3344, 1858, 3659, 1883, 1916, 3170, 1113, 1113, 1113, 1113, 1113, 1113, 1943, 1204, 1207, 3167, 3372, 1969,
    2831, 2368, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1988, 1113, 1771, 2651, 1782, 1688, 3659, 3593, 2034, 3316, 1140, 2878, 3281, 2050, 1113, 1113,
    1988, 1113, 1771, 2110, 1782, 1688, 3659, 3471, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1988, 1113, 1771, 2110, 2401, 1688, 3659, 3646, 1898, 3316,
    1113, 1113, 2069, 1113, 1113, 1113, 1988, 1113, 1771, 2110, 1782, 2089, 2754, 2126, 1898, 2148, 1113, 1113, 2172, 1429, 1826, 1113, 1988, 1113, 1771, 2802,
    2194, 1688, 3659, 3310, 2210, 3316, 3617, 2236, 1363, 2252, 1113, 1113, 1988, 1113, 1771, 2110, 1782, 1688, 3536, 3310, 1898, 3316, 1113, 3191, 1113, 1113,
    1113, 1113, 2268, 1113, 1771, 2110, 1782, 2353, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 3310,
    1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 2268, 1598, 2390, 2417, 2445, 1688, 2308, 3310, 2461, 3316, 3548, 1113, 3494, 1748, 2483, 1113, 2268, 1113,
    1771, 2110, 1782, 1688, 3659, 3310, 1898, 3316, 1113, 2073, 1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 3310, 1898, 2503, 2527, 2547,
    1387, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 2567, 2594, 2616, 3316, 1113, 1113, 3400, 1113, 1113, 1113, 2268, 2337, 1771, 2639, 2667, 2683,
    2714, 2741, 3678, 3316, 2770, 1113, 1113, 3212, 2790, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 2818, 1898, 2847, 2871, 1113, 1113, 2487, 2467, 1113,
    2268, 1113, 1771, 2894, 2931, 2947, 3659, 3310, 2975, 2132, 1113, 1113, 1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 3310, 1898, 2374,
    1113, 1113, 1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 2999, 3310, 2156, 3316, 1755, 1113, 1113, 1334, 1113, 1113, 2268, 1113, 1771, 3027,
    3055, 1688, 3659, 3442, 1898, 3316, 1113, 1113, 1972, 1113, 3071, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 3310, 2511, 2698, 3276, 2429, 1113, 1411,
    1556, 1113, 2268, 1113, 1771, 2110, 1782, 3098, 3659, 3310, 1898, 3316, 2178, 3114, 1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 3310,
    1898, 2600, 1113, 1113, 1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3135, 3310, 3162, 3316, 1113, 3186, 2774, 1113, 3207, 1113, 1379, 2979,
    2983, 3167, 1927, 1112, 3659, 3310, 3228, 3169, 1113, 1113, 1113, 1113, 1113, 1113, 1379, 1113, 1113, 3167, 1927, 1112, 3659, 3310, 1898, 3316, 1113, 1113,
    1113, 1113, 1113, 1113, 1379, 1113, 1113, 1693, 2725, 1112, 3261, 1722, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1738, 1113, 1771, 2110, 1782, 1688,
    3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1988, 1113, 1771, 2110, 1782, 1688, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113,
    1988, 1113, 1771, 2110, 1782, 1688, 3659, 3523, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1988, 1113, 1771, 2110, 1782, 1688, 3659, 3310, 1898, 3316,
    1500, 1113, 1113, 1113, 1113, 1113, 1988, 1291, 1771, 2002, 1782, 3297, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110,
    1782, 1688, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 2053, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 3310, 1898, 3316, 1464, 1113, 3332, 1113,
    1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 3310, 1898, 3316, 1113, 1622, 1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 3310,
    1898, 3316, 3360, 1113, 1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 3388, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 3429, 1113, 1113, 2268, 1113,
    1771, 2110, 1782, 1688, 3659, 3310, 1898, 2026, 1113, 1113, 3458, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 2295, 1898, 3316, 1113, 1113,
    1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 3310, 1898, 3670, 1113, 1113, 1113, 1113, 1113, 1113, 2268, 1900, 1771, 2282, 1782, 1688,
    3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 2268, 1113, 1771, 2110, 1782, 1688, 3659, 3310, 3510, 3316, 1113, 1113, 1113, 1113, 1113, 1113,
    1379, 1114, 1115, 1867, 3564, 1112, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 3580, 1113, 1572, 3167, 2578, 1798, 3659, 3310, 1898, 3316,
    1113, 1113, 1113, 1113, 1113, 1113, 3633, 1113, 1771, 2110, 1782, 1798, 3659, 3310, 1898, 3316, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113,
    3119, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 769, 0, 0, 2564, 2821, 0, 0, 3592, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 18432, 18432, 769, 769, 769, 769, 769, 769, 769, 769, 769, 0, 0, 0, 0, 0, 0, 0, 190, 191, 0, 0, 15872, 0, 0, 0, 0, 769, 769, 769, 0, 769, 1639, 1897,
    2154, 2411, 0, 769, 769, 769, 0, 0, 3592, 769, 0, 0, 2564, 2821, 3078, 3335, 3592, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8960, 0, 0, 0, 0, 0, 2564, 2821,
    3078, 3335, 3592, 0, 0, 0, 0, 0, 0, 0, 0, 88, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5730, 129, 5730, 0, 0, 1639, 0, 1897, 2154, 2411, 0, 137, 137, 0, 0, 0, 81,
    4725, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5730, 5730, 0, 0, 0, 0, 10496, 0, 0, 0, 0, 5888, 0, 5888, 1897, 5888, 2411, 5888, 0, 0, 0, 0, 0, 3592, 0, 0, 0, 2564, 2821,
    3078, 3335, 3592, 0, 0, 0, 0, 0, 0, 0, 86, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 92, 0, 0, 86, 0, 0, 0, 0, 1639, 1897, 2154, 2411, 108, 0, 0, 0, 0, 0,
    3592, 0, 5730, 5730, 5730, 0, 0, 1639, 7813, 1897, 2154, 2411, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1639, 1897, 0, 0, 0, 0, 109, 110, 0, 0,
    3592, 7168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220, 0, 0, 0, 0, 2564, 2821, 0, 0, 3592, 0, 0, 0, 0, 0, 0, 0, 0, 215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    2564, 0, 3078, 0, 3592, 0, 0, 0, 0, 0, 0, 0, 0, 227, 228, 0, 0, 0, 0, 0, 0, 0, 8192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6400, 0, 0, 0, 0, 8192, 0,
    1639, 8192, 2154, 8192, 8192, 0, 0, 0, 0, 0, 3592, 0, 0, 8448, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 195, 0, 0, 8448, 0, 0, 0, 0, 1639, 1897, 2154, 2411,
    0, 0, 0, 0, 8448, 0, 3592, 0, 0, 0, 8704, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 194, 0, 0, 0, 0, 8798, 8704, 0, 0, 1639, 1897, 2154, 2411, 0, 8704, 0, 0, 0,
    0, 3592, 0, 0, 9728, 0, 0, 1639, 1897, 2154, 2411, 0, 9728, 0, 0, 0, 0, 3592, 0, 0, 1283, 2564, 2821, 3078, 3335, 80, 0, 0, 0, 0, 0, 0, 0, 0, 10752, 11008,
    0, 0, 0, 0, 0, 0, 0, 1283, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8704, 8704, 94, 81, 0, 4435, 0, 5461, 0, 119, 0, 0, 0, 0, 0, 0, 0, 0, 0, 89, 90, 0, 0,
    0, 0, 0, 0, 0, 1283, 2564, 2821, 3078, 3335, 3592, 0, 0, 0, 0, 0, 0, 0, 0, 12032, 0, 0, 0, 0, 0, 0, 0, 81, 0, 4435, 117, 5461, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 99, 0, 0, 0, 0, 0, 0, 1283, 2564, 2821, 3078, 3335, 3592, 0, 0, 0, 4876, 5133, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 153, 5730, 81, 0, 4435, 0,
    5461, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1283, 2564, 2821, 3078, 3335, 3592, 0, 0, 84, 4876, 5133, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 5730, 154, 0, 1103, 1283, 2564, 2821, 3078, 3335, 3592, 0, 4435, 0, 0, 0, 0, 0, 0, 225, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 0, 0, 0, 0, 0, 0, 1103, 1283,
    0, 0, 0, 0, 0, 0, 0, 1103, 1103, 1103, 0, 0, 0, 0, 1639, 1897, 2154, 2411, 0, 0, 0, 0, 0, 1103, 3592, 81, 0, 4435, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    9728, 0, 0, 0, 127, 5730, 5730, 0, 0, 1639, 0, 1897, 0, 0, 0, 0, 0, 0, 0, 6912, 0, 0, 0, 0, 0, 0, 0, 0, 12544, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5730, 12544, 0,
    0, 0, 81, 4096, 0, 0, 0, 0, 0, 13056, 0, 0, 0, 0, 0, 0, 0, 0, 18432, 18432, 0, 0, 5730, 0, 0, 18432, 18432, 0, 0, 0, 4096, 0, 0, 9984, 0, 0, 0, 0, 0, 0, 0,
    5730, 5730, 5730, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 0, 5730, 17664, 0, 0, 0, 0, 0, 0, 0, 0, 17664, 0, 0, 0, 0, 0, 1639, 1897, 2154, 2411, 0, 0,
    0, 0, 0, 0, 3592, 0, 0, 0, 2564, 2821, 3078, 3335, 3592, 82, 0, 0, 0, 0, 0, 0, 0, 8704, 8704, 94, 0, 0, 5730, 0, 0, 8798, 8704, 116, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 15104, 0, 0, 0, 1103, 1283, 2564, 2821, 3078, 3335, 3592, 0, 4435, 0, 0, 5133, 5461, 0, 0, 0, 92, 1103, 0, 0, 0, 0, 0, 1103, 5730, 0,
    0, 0, 0, 12544, 0, 0, 0, 0, 0, 0, 12544, 0, 0, 0, 0, 173, 0, 0, 0, 5730, 5730, 0, 0, 0, 0, 0, 0, 160, 0, 0, 164, 0, 0, 0, 0, 6656, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 17920, 0, 0, 0, 0, 0, 16896, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 207, 0, 0, 0, 81, 0, 4435, 0, 5461, 0, 0, 0, 0, 0, 122, 0, 0, 0, 0, 0,
    1639, 1897, 2154, 2411, 0, 0, 0, 0, 0, 1103, 0, 0, 0, 0, 0, 1103, 5730, 0, 0, 0, 0, 0, 14734, 0, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5730, 5730, 0, 0, 179, 0,
    0, 0, 169, 0, 0, 0, 0, 0, 0, 0, 5730, 5730, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 166, 0, 0, 210, 0, 0, 0, 0, 6144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 193, 0, 0, 0,
    0, 0, 1103, 0, 0, 0, 0, 1639, 1897, 2154, 2411, 0, 0, 0, 0, 113, 1103, 3592, 5730, 5730, 0, 0, 0, 0, 0, 158, 161, 0, 0, 0, 0, 0, 0, 0, 9728, 0, 0, 0, 0,
    5730, 0, 0, 0, 9728, 0, 198, 0, 0, 0, 202, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15360, 0, 15616, 0, 0, 223, 0, 0, 226, 0, 0, 229, 0, 0, 0, 0, 232, 0, 1103, 1283,
    2564, 2821, 3078, 3335, 3592, 0, 4435, 0, 0, 0, 5461, 0, 0, 0, 93, 1103, 0, 0, 0, 0, 0, 1103, 5730, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 0, 150, 0, 0, 5730,
    5730, 5730, 0, 0, 1639, 0, 1897, 2154, 2411, 135, 0, 0, 0, 0, 769, 769, 769, 769, 769, 769, 0, 5730, 0, 0, 0, 0, 87, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 91, 0,
    0, 0, 0, 81, 0, 4435, 0, 5461, 0, 0, 0, 120, 0, 0, 0, 0, 0, 120, 0, 0, 0, 116, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5730, 5730, 0, 0, 0, 180, 0, 0, 1103, 1283, 0,
    0, 0, 0, 89, 90, 0, 1103, 1103, 1103, 0, 0, 0, 0, 1639, 1897, 2154, 2411, 0, 0, 0, 0, 112, 1103, 3592, 0, 95, 0, 0, 1103, 0, 0, 0, 0, 95, 1103, 5730, 0, 0,
    0, 0, 201, 0, 203, 204, 0, 0, 205, 0, 0, 208, 209, 0, 1103, 0, 0, 0, 0, 1639, 1897, 2154, 2411, 0, 0, 0, 0, 114, 1103, 3592, 5730, 5730, 0, 0, 0, 156, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 236, 0, 0, 0, 0, 0, 0, 0, 0, 235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 231, 0, 0, 0, 0, 0, 171, 0, 0, 0, 175, 0, 5730, 5730, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 165, 0, 167, 168, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5888, 0, 0, 0, 0, 0, 199, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    8192, 0, 0, 0, 0, 5730, 5730, 5730, 0, 132, 1639, 0, 1897, 2154, 2411, 0, 0, 0, 0, 0, 1639, 1897, 2154, 2411, 0, 0, 0, 0, 0, 1103, 3592, 0, 0, 143, 81, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 5730, 5730, 0, 178, 0, 0, 0, 0, 5730, 5730, 0, 0, 0, 0, 157, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7168, 0, 0, 0, 0, 0, 0, 91, 0, 0, 0,
    1103, 0, 0, 0, 0, 0, 1103, 5730, 0, 0, 0, 0, 1103, 0, 0, 0, 0, 0, 1103, 5730, 0, 101, 0, 0, 1103, 0, 0, 0, 0, 1639, 1897, 2154, 2411, 0, 0, 0, 0, 115, 1103,
    3592, 81, 0, 4435, 0, 5461, 0, 0, 0, 0, 121, 0, 0, 0, 0, 121, 0, 0, 0, 172, 0, 0, 0, 176, 5730, 5730, 177, 0, 0, 0, 0, 181, 0, 5730, 5730, 5730, 131, 0,
    1639, 0, 1897, 2154, 2411, 0, 0, 0, 0, 0, 1639, 1897, 2154, 2411, 0, 0, 0, 111, 0, 0, 3592, 141, 0, 0, 81, 0, 0, 0, 146, 0, 0, 0, 0, 0, 0, 5730, 5730, 5730,
    0, 0, 1639, 0, 1897, 2154, 2411, 0, 0, 0, 0, 140, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14336, 0, 0, 0, 0, 234, 0, 0, 0, 0, 16640, 0, 0, 0, 0,
    11520, 0, 0, 0, 0, 1103, 0, 0, 0, 0, 0, 1103, 5730, 0, 102, 0, 0, 0, 0, 144, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5730, 5730, 5730, 0, 0, 1639, 0, 1897, 2154,
    2411, 0, 3978, 3840, 0, 0, 0, 170, 0, 0, 0, 0, 0, 0, 5730, 5730, 0, 0, 0, 0, 0, 0, 159, 0, 0, 0, 0, 0, 0, 0, 0, 184, 0, 0, 0, 0, 189, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 13568, 0, 0, 0, 0, 0, 0, 0, 0, 96, 0, 1103, 0, 0, 0, 0, 0, 1103, 5730, 0, 0, 0, 0, 2821, 0, 0, 3592, 0, 0, 0, 0, 0, 0, 5888, 0, 0, 0, 0, 0, 5730,
    5888, 0, 0, 0, 1103, 0, 0, 96, 0, 1639, 1897, 2154, 2411, 0, 0, 0, 0, 0, 1103, 3592, 81, 0, 4435, 0, 5461, 118, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8448, 0, 0, 0,
    0, 0, 8448, 5730, 0, 8448, 0, 0, 5730, 5730, 0, 155, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17408, 0, 0, 0, 0, 0, 0, 0, 0, 5730, 5730, 5730, 0, 0, 1639, 0,
    1897, 2154, 2411, 136, 0, 0, 0, 0, 9216, 1639, 1897, 2154, 2411, 0, 9216, 0, 0, 0, 0, 3592, 0, 0, 97, 0, 1103, 0, 0, 0, 0, 0, 1103, 5730, 0, 0, 0, 0, 9472,
    1639, 1897, 2154, 2411, 0, 9472, 0, 0, 0, 0, 3592, 1103, 0, 0, 97, 0, 1639, 1897, 2154, 2411, 0, 0, 0, 0, 0, 1103, 3592, 233, 0, 0, 0, 14080, 16384, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 7528, 7528, 7528, 7528, 0, 0, 0, 0, 0, 0, 3592, 81, 0, 4435, 0, 5461, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 125, 0, 0, 0, 200, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 512, 512, 0, 0, 0, 126, 5730, 5730, 5730, 0, 0, 1639, 0, 1897, 2154, 2411, 0, 0, 0, 0, 0, 8192, 0, 0, 0, 0, 0, 5730, 8192, 0, 0, 0,
    5730, 5730, 13312, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5730, 0, 0, 0, 0, 0, 0, 0, 13824, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15054, 0, 0, 0, 0,
    0, 0, 11264, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16358, 0, 0, 0, 0, 11776, 5730, 0, 0, 0, 0, 0, 0, 11776, 0, 0, 0, 0, 0, 0, 0, 10240, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 86, 5730, 0, 0, 0, 0, 0, 128, 5730, 130, 0, 0, 1639, 0, 1897, 2154, 2411, 0, 0, 0, 139, 0, 0, 0, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 218,
    0, 0, 0, 0, 81, 0, 4435, 0, 5461, 0, 0, 0, 0, 0, 0, 0, 124, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5730, 5730, 0, 0, 0, 0, 0, 0, 0, 211, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 12544, 1639, 1897, 2154, 2411, 0, 0, 0, 0, 0, 0, 3592, 0, 0, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12800, 1639, 1897, 2154,
    2411, 0, 12800, 0, 0, 0, 0, 3592, 81, 0, 4435, 0, 5461, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 17152, 0, 0, 0, 0, 216, 0, 0, 0, 0, 0, 0, 12288, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 222, 18176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 152, 5730, 5730, 0, 0, 212, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 0, 0, 151, 0, 5730, 5730, 5730, 0, 0, 1639, 0, 0, 2154, 0, 0, 0, 0, 0, 0, 213, 214, 0, 0, 217, 0, 219, 0, 0, 221,
    5730, 5730, 0, 0, 7936, 0, 0, 0, 0, 163, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 149, 0, 0, 0, 5730, 5730, 5730, 0, 0, 1639, 0, 1897, 2154, 2411, 134, 0, 0,
    0, 0, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 196, 0, 0, 18432, 18432, 0, 0, 1639, 1897, 2154, 2411, 0, 18432, 0, 0, 0, 0, 3592, 0, 0, 1283, 2564, 2821, 0, 0, 3592,
    0, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 5730, 5730, 5730, 0, 0, 0, 0, 1897, 0, 2411, 0, 0, 0, 0, 0, 188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 197,
    0, 1103, 1283, 2564, 2821, 0, 0, 3592, 0, 4435, 0, 0, 0, 0, 0, 0, 81, 0, 145, 0, 0, 147, 0, 0, 0, 0, 0, 5730, 5730, 5730, 0, 0, 1639, 0, 1897, 2154, 2411,
    0, 0, 0, 0, 0, 174, 0, 0, 5730, 5730, 0, 0, 0, 0, 0, 0, 162, 0, 0, 0, 0, 0, 0, 0
  "/>

  <!--~
   ! The DFA-state to expected-token-set mapping.
  -->
  <xsl:variable name="p:EXPECTED" as="xs:integer+" select="
    177, 221, 256, 184, 188, 237, 237, 237, 194, 227, 213, 236, 237, 225, 229, 236, 233, 244, 248, 251, 255, 343, 237, 237, 385, 283, 407, 260, 330, 266, 237,
    384, 272, 279, 237, 237, 344, 237, 287, 281, 237, 237, 344, 237, 289, 237, 237, 378, 237, 289, 237, 237, 344, 281, 237, 325, 237, 391, 237, 237, 237, 237,
    237, 190, 293, 297, 237, 330, 296, 262, 310, 303, 309, 314, 318, 322, 329, 427, 334, 237, 305, 298, 375, 202, 206, 237, 340, 352, 336, 299, 237, 204, 237,
    360, 368, 356, 237, 381, 401, 364, 368, 356, 237, 273, 220, 366, 354, 390, 237, 220, 372, 389, 218, 395, 237, 220, 399, 180, 237, 237, 237, 237, 237, 237,
    237, 405, 237, 237, 216, 208, 268, 274, 411, 208, 209, 237, 275, 200, 237, 237, 345, 417, 197, 237, 237, 412, 239, 237, 346, 420, 413, 237, 412, 238, 237,
    348, 237, 237, 237, 238, 237, 348, 237, 237, 237, 240, 347, 421, 237, 238, 346, 237, 237, 425, 237, 239, 237, 4, 8, 16, 512, 1024, 4096, 4096, 524288,
    1048576, 4194304, 33554432, 134217728, -2147483648, 0, 0, 1, 2, 12, 20, 33554436, 4, 0, 0, 16, 1, 0, 0, 8192, 0, 524288, 2097152, 0, 0, 128, 128, 6, 4,
    134217736, 8, 8, 0, 0, 0, 512, 1024, 2048, 4096, 8192, 12, -2143289340, 4, 4, 4, 4, 33554440, 2097152, 33554444, 4, 4, -2143289344, 0, 0, 0, 0, 1, 0, 0, 4,
    1883242528, -268435392, 1883242624, -268435200, -2051014656, 4, 16390, 0, 8, 8192, 32768, 32768, 65536, 131072, 262144, 16384, 16384, 0, 0, 1, 65536,
    131072, 33554432, 0, 0, 6, 96, 2097152, 2097152, 0, 0, 0, 128, 0, 1073741824, 8388608, 16777216, 67108864, 0, 0, 32, 1610612736, 2097152, 2097152, 0,
    8388608, 16777216, 67108864, 64, 128, 32768, 65536, 262144, 134217728, 268435456, 536870912, 0, 0, 536936448, 402653184, 0, 0, 64, 262144, 1, 0, 34, 2, 4,
    4, 402653184, 1, 8192, 65536, 2621441, 6, 34, 1, 6, 34, 0, 0, 16777216, 67108864, 196632, 0, 0, 0, 32768, 16128, -942669823, 0, 0, 64, 134217728, 32512,
    16128, 0, 1048576, 33554432, 0, 0, 0, 32, 64, 2, 4, 12582912, 117440512, -1073741824, 0, 0, 134217728, 268435456, 536870912, 16128, 16384, 0, 1048576, 3072,
    4096, 16384, 1048576, 12582912, 100663296, -1073741824, 0, 12582912, 67108864, -1073741824, 0, 4, 402653184, 0, 0, 33554432, 0, 0, 2097152, 0, 0, 2097152,
    2097152, 2097152, 0, 268435456, 0, 0, 0, 67108864, 2048, 4096, 4194304, -1073741824, 4194304, -2147483648, 0, 0, 256, 512, 8, 32, 64, 128, 256, 92274688,
    128, 0, 0, 16, 0, 0, 64, 0, 0, 2, 4, 0, 0, 0, 1, 32, 0, 0, 131130, 32512
  "/>

  <!--~
   ! The token-string table.
  -->
  <xsl:variable name="p:TOKEN" as="xs:string+" select="
    '(0)',
    'EOF',
    'S',
    'Name',
    'Nmtoken',
    'EntityStaticValueDouble',
    'EntityStaticValueSingle',
    'AttValueDoubleVal',
    'AttValueSingleVal',
    'SystemLiteralDouble',
    'SystemLiteralSingle',
    'PubidLiteralDouble',
    'PubidLiteralSingle',
    'CommentContent',
    &quot;'&lt;?'&quot;,
    'PIContentEnd',
    'PITarget',
    'VersionNum',
    'CharRefDec',
    'CharRefHex',
    'EncName',
    'Ignore',
    &quot;'&quot;&quot;'&quot;,
    &quot;'#FIXED'&quot;,
    &quot;'#IMPLIED'&quot;,
    &quot;'#PCDATA'&quot;,
    &quot;'#REQUIRED'&quot;,
    &quot;'%'&quot;,
    &quot;'&amp;'&quot;,
    &quot;'&amp;#'&quot;,
    &quot;'&amp;#x'&quot;,
    &quot;''''&quot;,
    &quot;'('&quot;,
    &quot;')'&quot;,
    &quot;')*'&quot;,
    &quot;'*'&quot;,
    &quot;'+'&quot;,
    &quot;','&quot;,
    &quot;'--&gt;'&quot;,
    &quot;';'&quot;,
    &quot;'&lt;!--'&quot;,
    &quot;'&lt;!ATTLIST'&quot;,
    &quot;'&lt;!ELEMENT'&quot;,
    &quot;'&lt;!ENTITY'&quot;,
    &quot;'&lt;!NOTATION'&quot;,
    &quot;'&lt;!['&quot;,
    &quot;'&lt;?xml'&quot;,
    &quot;'='&quot;,
    &quot;'&gt;'&quot;,
    &quot;'?'&quot;,
    &quot;'?&gt;'&quot;,
    &quot;'ANY'&quot;,
    &quot;'CDATA'&quot;,
    &quot;'EMPTY'&quot;,
    &quot;'ENTITIES'&quot;,
    &quot;'ENTITY'&quot;,
    &quot;'ID'&quot;,
    &quot;'IDREF'&quot;,
    &quot;'IDREFS'&quot;,
    &quot;'IGNORE'&quot;,
    &quot;'INCLUDE'&quot;,
    &quot;'NDATA'&quot;,
    &quot;'NMTOKEN'&quot;,
    &quot;'NMTOKENS'&quot;,
    &quot;'NOTATION'&quot;,
    &quot;'PUBLIC'&quot;,
    &quot;'SYSTEM'&quot;,
    &quot;'['&quot;,
    &quot;']]&gt;'&quot;,
    &quot;'encoding'&quot;,
    &quot;'version'&quot;,
    &quot;'|'&quot;
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
    <xsl:sequence select="p:transition($input, $begin, $begin, $begin, $result, $result mod 256, 0)"/>
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
        <xsl:variable name="result" select="$result idiv 256"/>
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
        <xsl:variable name="i0" select="256 * $c1 + $current-state - 1"/>
        <xsl:variable name="i1" select="$i0 idiv 16"/>
        <xsl:variable name="next-state" select="$p:TRANSITION[$i0 mod 16 + $p:TRANSITION[$i1 + 1] + 1]"/>
        <xsl:sequence select="
          if ($next-state &gt; 255) then
            p:transition($input, $begin, $current, $current, $next-state, $next-state mod 256, $current-state)
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
      <xsl:for-each select="0 to 2">
        <xsl:variable name="i0" select=". * 236 + $state - 1"/>
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
   ! Parse DeclSep.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-DeclSep" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'DeclSep', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production ignoreSectContents (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-ignoreSectContents-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(59, $input, $state)"/>      <!-- Ignore | '<![' | ']]>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 68">                                      <!-- ']]>' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 21">                                <!-- Ignore -->
                  <xsl:variable name="state" select="p:consume(21, $input, $state)"/> <!-- Ignore -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="state" select="p:consume(45, $input, $state)"/> <!-- '<![' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-ignoreSectContents($input, $state)
                  "/>
                  <xsl:variable name="state" select="p:consume(68, $input, $state)"/> <!-- ']]>' -->
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-ignoreSectContents-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse ignoreSectContents.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-ignoreSectContents" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:parse-ignoreSectContents-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'ignoreSectContents', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse ignoreSect.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-ignoreSect" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(45, $input, $state)"/>             <!-- '<![' -->
    <xsl:variable name="state" select="p:lookahead1(38, $input, $state)"/>          <!-- S | 'IGNORE' -->
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
    <xsl:variable name="state" select="p:lookahead1(25, $input, $state)"/>          <!-- 'IGNORE' -->
    <xsl:variable name="state" select="p:consume(59, $input, $state)"/>             <!-- 'IGNORE' -->
    <xsl:variable name="state" select="p:lookahead1(40, $input, $state)"/>          <!-- S | '[' -->
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
    <xsl:variable name="state" select="p:lookahead1(28, $input, $state)"/>          <!-- '[' -->
    <xsl:variable name="state" select="p:consume(67, $input, $state)"/>             <!-- '[' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-ignoreSectContents($input, $state)
    "/>
    <xsl:variable name="state" select="p:consume(68, $input, $state)"/>             <!-- ']]>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'ignoreSect', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse includeSect.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-includeSect" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(45, $input, $state)"/>             <!-- '<![' -->
    <xsl:variable name="state" select="p:lookahead1(39, $input, $state)"/>          <!-- S | 'INCLUDE' -->
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
    <xsl:variable name="state" select="p:lookahead1(26, $input, $state)"/>          <!-- 'INCLUDE' -->
    <xsl:variable name="state" select="p:consume(60, $input, $state)"/>             <!-- 'INCLUDE' -->
    <xsl:variable name="state" select="p:lookahead1(40, $input, $state)"/>          <!-- S | '[' -->
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
    <xsl:variable name="state" select="p:lookahead1(28, $input, $state)"/>          <!-- '[' -->
    <xsl:variable name="state" select="p:consume(67, $input, $state)"/>             <!-- '[' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-extSubsetDecl($input, $state)
    "/>
    <xsl:variable name="state" select="p:consume(68, $input, $state)"/>             <!-- ']]>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'includeSect', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse conditionalSect.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-conditionalSect" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 45">                                       <!-- '<![' -->
          <xsl:variable name="state" select="p:lookahead2(57, $input, $state)"/>    <!-- S | 'IGNORE' | 'INCLUDE' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:lk] eq 301">                                <!-- '<![' S -->
                <xsl:variable name="state" select="p:lookahead3(49, $input, $state)"/> <!-- 'IGNORE' | 'INCLUDE' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
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
        <xsl:when test="$state[$p:lk] = 7725                                          (: '&lt;![' 'INCLUDE' :)
                     or $state[$p:lk] = 983341">                                    <!-- '<![' S 'INCLUDE' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-includeSect($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-ignoreSect($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'conditionalSect', $count, $begin, $end)"/>
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
    <xsl:variable name="state" select="p:consume(40, $input, $state)"/>             <!-- '<!-' '-' -->
    <xsl:variable name="state" select="p:lookahead1(7, $input, $state)"/>           <!-- CommentContent -->
    <xsl:variable name="state" select="p:consume(13, $input, $state)"/>             <!-- CommentContent -->
    <xsl:variable name="state" select="p:lookahead1(20, $input, $state)"/>          <!-- '-' '->' -->
    <xsl:variable name="state" select="p:consume(38, $input, $state)"/>             <!-- '-' '->' -->
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
    <xsl:variable name="state" select="p:consume(14, $input, $state)"/>             <!-- PIStart -->
    <xsl:variable name="state" select="p:lookahead1(9, $input, $state)"/>           <!-- PITarget -->
    <xsl:variable name="state" select="p:consume(16, $input, $state)"/>             <!-- PITarget -->
    <xsl:variable name="state" select="p:lookahead1(8, $input, $state)"/>           <!-- PIContentEnd -->
    <xsl:variable name="state" select="p:consume(15, $input, $state)"/>             <!-- PIContentEnd -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'PI', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse ExternalOrPublicID.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-ExternalOrPublicID" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(50, $input, $state)"/>          <!-- 'PUBLIC' | 'SYSTEM' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 66">                                        <!-- 'SYSTEM' -->
          <xsl:variable name="state" select="p:consume(66, $input, $state)"/>       <!-- 'SYSTEM' -->
          <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>     <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-SystemLiteral($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(65, $input, $state)"/>       <!-- 'PUBLIC' -->
          <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>     <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-PubidLiteral($input, $state)
          "/>
          <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>    <!-- S | '>' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:l1] eq 2">                                  <!-- S -->
                <xsl:variable name="state" select="p:lookahead2(60, $input, $state)"/> <!-- '"' | "'" | '>' -->
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
              <xsl:when test="$state[$p:lk] = 2818                                    (: S '&quot;' :)
                           or $state[$p:lk] = 3970">                                <!-- S "'" -->
                <xsl:variable name="state" select="p:consume(2, $input, $state)"/>  <!-- S -->
                <xsl:variable name="state" select="
                  if ($state[$p:error]) then
                    $state
                  else
                    p:parse-SystemLiteral($input, $state)
                "/>
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'ExternalOrPublicID', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse NotationDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-NotationDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(44, $input, $state)"/>             <!-- '<!NOTATION' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-ExternalOrPublicID($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>          <!-- S | '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(48, $input, $state)"/>             <!-- '>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'NotationDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse PEDef.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-PEDef" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(67, $input, $state)"/>          <!-- '"' | "'" | 'PUBLIC' | 'SYSTEM' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 22                                            (: '&quot;' :)
                     or $state[$p:l1] = 31">                                        <!-- "'" -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EntityValue($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-ExternalID($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'PEDef', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse PEDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-PEDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(43, $input, $state)"/>             <!-- '<!ENTITY' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(16, $input, $state)"/>          <!-- '%' -->
    <xsl:variable name="state" select="p:consume(27, $input, $state)"/>             <!-- '%' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-PEDef($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>          <!-- S | '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(48, $input, $state)"/>             <!-- '>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'PEDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse NDataDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-NDataDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(27, $input, $state)"/>          <!-- 'NDATA' -->
    <xsl:variable name="state" select="p:consume(61, $input, $state)"/>             <!-- 'NDATA' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'NDataDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse PubidLiteral.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-PubidLiteral" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(44, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 22">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(5, $input, $state)"/>     <!-- PubidLiteralDouble -->
          <xsl:variable name="state" select="p:consume(11, $input, $state)"/>       <!-- PubidLiteralDouble -->
          <xsl:variable name="state" select="p:lookahead1(14, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(6, $input, $state)"/>     <!-- PubidLiteralSingle -->
          <xsl:variable name="state" select="p:consume(12, $input, $state)"/>       <!-- PubidLiteralSingle -->
          <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'PubidLiteral', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse SystemLiteral.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-SystemLiteral" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(44, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 22">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(3, $input, $state)"/>     <!-- SystemLiteralDouble -->
          <xsl:variable name="state" select="p:consume(9, $input, $state)"/>        <!-- SystemLiteralDouble -->
          <xsl:variable name="state" select="p:lookahead1(14, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(4, $input, $state)"/>     <!-- SystemLiteralSingle -->
          <xsl:variable name="state" select="p:consume(10, $input, $state)"/>       <!-- SystemLiteralSingle -->
          <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'SystemLiteral', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse ExternalID.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-ExternalID" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 66">                                        <!-- 'SYSTEM' -->
          <xsl:variable name="state" select="p:consume(66, $input, $state)"/>       <!-- 'SYSTEM' -->
          <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>     <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-SystemLiteral($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(65, $input, $state)"/>       <!-- 'PUBLIC' -->
          <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>     <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-PubidLiteral($input, $state)
          "/>
          <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>     <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-SystemLiteral($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'ExternalID', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production EntityValueSingle (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EntityValueSingle-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(70, $input, $state)"/>      <!-- EntityStaticValueSingle | '&' | '&#' | '&#x' | "'" -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 31">                                      <!-- "'" -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 6">                                 <!-- EntityStaticValueSingle -->
                  <xsl:variable name="state" select="p:consume(6, $input, $state)"/> <!-- EntityStaticValueSingle -->
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
            <xsl:sequence select="p:parse-EntityValueSingle-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse EntityValueSingle.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EntityValueSingle" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:parse-EntityValueSingle-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'EntityValueSingle', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production EntityValueDouble (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EntityValueDouble-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(69, $input, $state)"/>      <!-- EntityStaticValueDouble | '"' | '&' | '&#' | '&#x' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 22">                                      <!-- '"' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 5">                                 <!-- EntityStaticValueDouble -->
                  <xsl:variable name="state" select="p:consume(5, $input, $state)"/> <!-- EntityStaticValueDouble -->
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
            <xsl:sequence select="p:parse-EntityValueDouble-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse EntityValueDouble.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EntityValueDouble" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:parse-EntityValueDouble-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'EntityValueDouble', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse EntityValue.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EntityValue" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 22">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EntityValueDouble($input, $state)
          "/>
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EntityValueSingle($input, $state)
          "/>
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'EntityValue', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse EntityDef.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EntityDef" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(67, $input, $state)"/>          <!-- '"' | "'" | 'PUBLIC' | 'SYSTEM' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 22                                            (: '&quot;' :)
                     or $state[$p:l1] = 31">                                        <!-- "'" -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EntityValue($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-ExternalID($input, $state)
          "/>
          <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>    <!-- S | '>' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:l1] eq 2">                                  <!-- S -->
                <xsl:variable name="state" select="p:lookahead2(48, $input, $state)"/> <!-- '>' | 'NDATA' -->
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
              <xsl:when test="$state[$p:lk] = 7810">                                <!-- S 'NDATA' -->
                <xsl:variable name="state" select="
                  if ($state[$p:error]) then
                    $state
                  else
                    p:parse-NDataDecl($input, $state)
                "/>
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'EntityDef', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse GEDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-GEDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(43, $input, $state)"/>             <!-- '<!ENTITY' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-EntityDef($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>          <!-- S | '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(48, $input, $state)"/>             <!-- '>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'GEDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse EntityDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EntityDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 43">                                       <!-- '<!ENTITY' -->
          <xsl:variable name="state" select="p:lookahead2(0, $input, $state)"/>     <!-- S -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:lk] eq 299">                                <!-- '<!ENTITY' S -->
                <xsl:variable name="state" select="p:lookahead3(41, $input, $state)"/> <!-- Name | '%' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
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
        <xsl:when test="$state[$p:lk] = 49451">                                     <!-- '<!ENTITY' S Name -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-GEDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-PEDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'EntityDecl', $count, $begin, $end)"/>
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
        <xsl:variable name="state" select="p:lookahead1(72, $input, $state)"/>      <!-- AttValueSingleVal | '&' | '&#' | '&#x' | "'" -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 31">                                      <!-- "'" -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 8">                                 <!-- AttValueSingleVal -->
                  <xsl:variable name="state" select="p:consume(8, $input, $state)"/> <!-- AttValueSingleVal -->
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
        <xsl:when test="$state[$p:l1] = 29">                                        <!-- '&#' -->
          <xsl:variable name="state" select="p:consume(29, $input, $state)"/>       <!-- '&#' -->
          <xsl:variable name="state" select="p:lookahead1(11, $input, $state)"/>    <!-- CharRefDec -->
          <xsl:variable name="state" select="p:consume(18, $input, $state)"/>       <!-- CharRefDec -->
          <xsl:variable name="state" select="p:lookahead1(21, $input, $state)"/>    <!-- ';' -->
          <xsl:variable name="state" select="p:consume(39, $input, $state)"/>       <!-- ';' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(30, $input, $state)"/>       <!-- '&#x' -->
          <xsl:variable name="state" select="p:lookahead1(12, $input, $state)"/>    <!-- CharRefHex -->
          <xsl:variable name="state" select="p:consume(19, $input, $state)"/>       <!-- CharRefHex -->
          <xsl:variable name="state" select="p:lookahead1(21, $input, $state)"/>    <!-- ';' -->
          <xsl:variable name="state" select="p:consume(39, $input, $state)"/>       <!-- ';' -->
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
    <xsl:variable name="state" select="p:consume(28, $input, $state)"/>             <!-- '&' -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:lookahead1(21, $input, $state)"/>          <!-- ';' -->
    <xsl:variable name="state" select="p:consume(39, $input, $state)"/>             <!-- ';' -->
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
        <xsl:when test="$state[$p:l1] = 28">                                        <!-- '&' -->
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
        <xsl:variable name="state" select="p:lookahead1(71, $input, $state)"/>      <!-- AttValueDoubleVal | '"' | '&' | '&#' | '&#x' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 22">                                      <!-- '"' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 7">                                 <!-- AttValueDoubleVal -->
                  <xsl:variable name="state" select="p:consume(7, $input, $state)"/> <!-- AttValueDoubleVal -->
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
    <xsl:variable name="state" select="p:lookahead1(44, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 22">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-AttValueDouble($input, $state)
          "/>
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-AttValueSingle($input, $state)
          "/>
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'AttValue', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse DefaultDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-DefaultDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(73, $input, $state)"/>          <!-- '"' | '#FIXED' | '#IMPLIED' | '#REQUIRED' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 26">                                        <!-- '#REQUIRED' -->
          <xsl:variable name="state" select="p:consume(26, $input, $state)"/>       <!-- '#REQUIRED' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 24">                                        <!-- '#IMPLIED' -->
          <xsl:variable name="state" select="p:consume(24, $input, $state)"/>       <!-- '#IMPLIED' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 23">                                  <!-- '#FIXED' -->
                <xsl:variable name="state" select="p:consume(23, $input, $state)"/> <!-- '#FIXED' -->
                <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/> <!-- S -->
                <xsl:variable name="state" select="p:consume(2, $input, $state)"/>  <!-- S -->
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
              p:parse-AttValue($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'DefaultDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production Enumeration (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-Enumeration-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(55, $input, $state)"/>      <!-- S | ')' | '|' -->
        <xsl:variable name="state" as="item()+">
          <xsl:choose>
            <xsl:when test="$state[$p:l1] eq 2">                                    <!-- S -->
              <xsl:variable name="state" select="p:lookahead2(46, $input, $state)"/> <!-- ')' | '|' -->
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$state[$p:lk] != 71                                         (: '|' :)
                      and $state[$p:lk] != 9090">                                   <!-- S '|' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 2">                                 <!-- S -->
                  <xsl:variable name="state" select="p:consume(2, $input, $state)"/> <!-- S -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="state" select="p:lookahead1(31, $input, $state)"/>  <!-- '|' -->
            <xsl:variable name="state" select="p:consume(71, $input, $state)"/>     <!-- '|' -->
            <xsl:variable name="state" select="p:lookahead1(33, $input, $state)"/>  <!-- S | Nmtoken -->
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 2">                                 <!-- S -->
                  <xsl:variable name="state" select="p:consume(2, $input, $state)"/> <!-- S -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>   <!-- Nmtoken -->
            <xsl:variable name="state" select="p:consume(4, $input, $state)"/>      <!-- Nmtoken -->
            <xsl:sequence select="p:parse-Enumeration-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse Enumeration.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-Enumeration" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(32, $input, $state)"/>             <!-- '(' -->
    <xsl:variable name="state" select="p:lookahead1(33, $input, $state)"/>          <!-- S | Nmtoken -->
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
    <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>           <!-- Nmtoken -->
    <xsl:variable name="state" select="p:consume(4, $input, $state)"/>              <!-- Nmtoken -->
    <xsl:variable name="state" select="p:parse-Enumeration-1($input, $state)"/>
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
    <xsl:variable name="state" select="p:lookahead1(19, $input, $state)"/>          <!-- ')' -->
    <xsl:variable name="state" select="p:consume(33, $input, $state)"/>             <!-- ')' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'Enumeration', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production NotationType (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-NotationType-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(55, $input, $state)"/>      <!-- S | ')' | '|' -->
        <xsl:variable name="state" as="item()+">
          <xsl:choose>
            <xsl:when test="$state[$p:l1] eq 2">                                    <!-- S -->
              <xsl:variable name="state" select="p:lookahead2(46, $input, $state)"/> <!-- ')' | '|' -->
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$state[$p:lk] != 71                                         (: '|' :)
                      and $state[$p:lk] != 9090">                                   <!-- S '|' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 2">                                 <!-- S -->
                  <xsl:variable name="state" select="p:consume(2, $input, $state)"/> <!-- S -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="state" select="p:lookahead1(31, $input, $state)"/>  <!-- '|' -->
            <xsl:variable name="state" select="p:consume(71, $input, $state)"/>     <!-- '|' -->
            <xsl:variable name="state" select="p:lookahead1(32, $input, $state)"/>  <!-- S | Name -->
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 2">                                 <!-- S -->
                  <xsl:variable name="state" select="p:consume(2, $input, $state)"/> <!-- S -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>   <!-- Name -->
            <xsl:variable name="state" select="p:consume(3, $input, $state)"/>      <!-- Name -->
            <xsl:sequence select="p:parse-NotationType-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse NotationType.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-NotationType" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(64, $input, $state)"/>             <!-- 'NOTATION' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(18, $input, $state)"/>          <!-- '(' -->
    <xsl:variable name="state" select="p:consume(32, $input, $state)"/>             <!-- '(' -->
    <xsl:variable name="state" select="p:lookahead1(32, $input, $state)"/>          <!-- S | Name -->
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
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:parse-NotationType-1($input, $state)"/>
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
    <xsl:variable name="state" select="p:lookahead1(19, $input, $state)"/>          <!-- ')' -->
    <xsl:variable name="state" select="p:consume(33, $input, $state)"/>             <!-- ')' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'NotationType', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse EnumeratedType.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EnumeratedType" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 64">                                        <!-- 'NOTATION' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-NotationType($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-Enumeration($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'EnumeratedType', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse TokenizedType.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-TokenizedType" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 56">                                        <!-- 'ID' -->
          <xsl:variable name="state" select="p:consume(56, $input, $state)"/>       <!-- 'ID' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 57">                                        <!-- 'IDREF' -->
          <xsl:variable name="state" select="p:consume(57, $input, $state)"/>       <!-- 'IDREF' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 58">                                        <!-- 'IDREFS' -->
          <xsl:variable name="state" select="p:consume(58, $input, $state)"/>       <!-- 'IDREFS' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 55">                                        <!-- 'ENTITY' -->
          <xsl:variable name="state" select="p:consume(55, $input, $state)"/>       <!-- 'ENTITY' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 54">                                        <!-- 'ENTITIES' -->
          <xsl:variable name="state" select="p:consume(54, $input, $state)"/>       <!-- 'ENTITIES' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 62">                                        <!-- 'NMTOKEN' -->
          <xsl:variable name="state" select="p:consume(62, $input, $state)"/>       <!-- 'NMTOKEN' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(63, $input, $state)"/>       <!-- 'NMTOKENS' -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'TokenizedType', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse StringType.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-StringType" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(52, $input, $state)"/>             <!-- 'CDATA' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'StringType', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse AttType.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-AttType" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(77, $input, $state)"/>          <!-- '(' | 'CDATA' | 'ENTITIES' | 'ENTITY' | 'ID' | 'IDREF' | 'IDREFS' |
                                                                                         'NMTOKEN' | 'NMTOKENS' | 'NOTATION' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 52">                                        <!-- 'CDATA' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-StringType($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 32                                            (: '(' :)
                     or $state[$p:l1] = 64">                                        <!-- 'NOTATION' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EnumeratedType($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-TokenizedType($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'AttType', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse AttDef.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-AttDef" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-AttType($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-DefaultDecl($input, $state)
    "/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'AttDef', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production AttlistDecl (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-AttlistDecl-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>      <!-- S | '>' -->
        <xsl:variable name="state" as="item()+">
          <xsl:choose>
            <xsl:when test="$state[$p:l1] eq 2">                                    <!-- S -->
              <xsl:variable name="state" select="p:lookahead2(43, $input, $state)"/> <!-- Name | '>' -->
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$state[$p:lk] != 386">                                    <!-- S Name -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="
              if ($state[$p:error]) then
                $state
              else
                p:parse-AttDef($input, $state)
            "/>
            <xsl:sequence select="p:parse-AttlistDecl-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse AttlistDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-AttlistDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(41, $input, $state)"/>             <!-- '<!ATTLIST' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:parse-AttlistDecl-1($input, $state)"/>
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
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(48, $input, $state)"/>             <!-- '>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'AttlistDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse cp.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-cp" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(42, $input, $state)"/>          <!-- Name | '(' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 3">                                         <!-- Name -->
          <xsl:variable name="state" select="p:consume(3, $input, $state)"/>        <!-- Name -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-choiceOrSeq($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(74, $input, $state)"/>          <!-- S | ')' | '*' | '+' | ',' | '?' | '|' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 35                                            (: '*' :)
                     or $state[$p:l1] = 36                                            (: '+' :)
                     or $state[$p:l1] = 49">                                        <!-- '?' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 49">                                  <!-- '?' -->
                <xsl:variable name="state" select="p:consume(49, $input, $state)"/> <!-- '?' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 35">                                  <!-- '*' -->
                <xsl:variable name="state" select="p:consume(35, $input, $state)"/> <!-- '*' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="state" select="p:consume(36, $input, $state)"/> <!-- '+' -->
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'cp', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production choiceOrSeq (one or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-choiceOrSeq-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:consume(71, $input, $state)"/>         <!-- '|' -->
        <xsl:variable name="state" select="p:lookahead1(52, $input, $state)"/>      <!-- S | Name | '(' -->
        <xsl:variable name="state" as="item()+">
          <xsl:choose>
            <xsl:when test="$state[$p:error]">
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:when test="$state[$p:l1] = 2">                                     <!-- S -->
              <xsl:variable name="state" select="p:consume(2, $input, $state)"/>    <!-- S -->
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
            p:parse-cp($input, $state)
        "/>
        <xsl:variable name="state" select="p:lookahead1(55, $input, $state)"/>      <!-- S | ')' | '|' -->
        <xsl:variable name="state" as="item()+">
          <xsl:choose>
            <xsl:when test="$state[$p:error]">
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:when test="$state[$p:l1] = 2">                                     <!-- S -->
              <xsl:variable name="state" select="p:consume(2, $input, $state)"/>    <!-- S -->
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="$state"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="state" select="p:lookahead1(46, $input, $state)"/>      <!-- ')' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 71">                                     <!-- '|' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="p:parse-choiceOrSeq-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 2nd loop of production choiceOrSeq (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-choiceOrSeq-2">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(45, $input, $state)"/>      <!-- ')' | ',' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 37">                                     <!-- ',' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(37, $input, $state)"/>     <!-- ',' -->
            <xsl:variable name="state" select="p:lookahead1(52, $input, $state)"/>  <!-- S | Name | '(' -->
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 2">                                 <!-- S -->
                  <xsl:variable name="state" select="p:consume(2, $input, $state)"/> <!-- S -->
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
                p:parse-cp($input, $state)
            "/>
            <xsl:variable name="state" select="p:lookahead1(54, $input, $state)"/>  <!-- S | ')' | ',' -->
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 2">                                 <!-- S -->
                  <xsl:variable name="state" select="p:consume(2, $input, $state)"/> <!-- S -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-choiceOrSeq-2($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse choiceOrSeq.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-choiceOrSeq" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(32, $input, $state)"/>             <!-- '(' -->
    <xsl:variable name="state" select="p:lookahead1(52, $input, $state)"/>          <!-- S | Name | '(' -->
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
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-cp($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(66, $input, $state)"/>          <!-- S | ')' | ',' | '|' -->
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
    <xsl:variable name="state" select="p:lookahead1(63, $input, $state)"/>          <!-- ')' | ',' | '|' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 71">                                        <!-- '|' -->
          <xsl:variable name="state" select="p:parse-choiceOrSeq-1($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:parse-choiceOrSeq-2($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:consume(33, $input, $state)"/>             <!-- ')' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'choiceOrSeq', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse children.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-children" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-choiceOrSeq($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(68, $input, $state)"/>          <!-- S | '*' | '+' | '>' | '?' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] != 2                                            (: S :)
                    and $state[$p:l1] != 48">                                       <!-- '>' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 49">                                  <!-- '?' -->
                <xsl:variable name="state" select="p:consume(49, $input, $state)"/> <!-- '?' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 35">                                  <!-- '*' -->
                <xsl:variable name="state" select="p:consume(35, $input, $state)"/> <!-- '*' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="state" select="p:consume(36, $input, $state)"/> <!-- '+' -->
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'children', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production Mixed (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-Mixed-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(47, $input, $state)"/>      <!-- ')*' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 71">                                     <!-- '|' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(71, $input, $state)"/>     <!-- '|' -->
            <xsl:variable name="state" select="p:lookahead1(32, $input, $state)"/>  <!-- S | Name -->
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 2">                                 <!-- S -->
                  <xsl:variable name="state" select="p:consume(2, $input, $state)"/> <!-- S -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>   <!-- Name -->
            <xsl:variable name="state" select="p:consume(3, $input, $state)"/>      <!-- Name -->
            <xsl:variable name="state" select="p:lookahead1(56, $input, $state)"/>  <!-- S | ')*' | '|' -->
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 2">                                 <!-- S -->
                  <xsl:variable name="state" select="p:consume(2, $input, $state)"/> <!-- S -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-Mixed-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse Mixed.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-Mixed" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(32, $input, $state)"/>             <!-- '(' -->
    <xsl:variable name="state" select="p:lookahead1(34, $input, $state)"/>          <!-- S | '#PCDATA' -->
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
    <xsl:variable name="state" select="p:lookahead1(15, $input, $state)"/>          <!-- '#PCDATA' -->
    <xsl:variable name="state" select="p:consume(25, $input, $state)"/>             <!-- '#PCDATA' -->
    <xsl:variable name="state" select="p:lookahead1(65, $input, $state)"/>          <!-- S | ')' | ')*' | '|' -->
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
    <xsl:variable name="state" select="p:lookahead1(62, $input, $state)"/>          <!-- ')' | ')*' | '|' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 33">                                        <!-- ')' -->
          <xsl:variable name="state" select="p:consume(33, $input, $state)"/>       <!-- ')' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:parse-Mixed-1($input, $state)"/>
          <xsl:variable name="state" select="p:consume(34, $input, $state)"/>       <!-- ')*' -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'Mixed', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse contentspec.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-contentspec" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(61, $input, $state)"/>          <!-- '(' | 'ANY' | 'EMPTY' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 32">                                       <!-- '(' -->
          <xsl:variable name="state" select="p:lookahead2(64, $input, $state)"/>    <!-- S | Name | '#PCDATA' | '(' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:lk] eq 288">                                <!-- '(' S -->
                <xsl:variable name="state" select="p:lookahead3(58, $input, $state)"/> <!-- Name | '#PCDATA' | '(' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
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
        <xsl:when test="$state[$p:lk] = 53">                                        <!-- 'EMPTY' -->
          <xsl:variable name="state" select="p:consume(53, $input, $state)"/>       <!-- 'EMPTY' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 51">                                        <!-- 'ANY' -->
          <xsl:variable name="state" select="p:consume(51, $input, $state)"/>       <!-- 'ANY' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 3232                                          (: '(' '#PCDATA' :)
                     or $state[$p:lk] = 409888">                                    <!-- '(' S '#PCDATA' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-Mixed($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-children($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'contentspec', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse elementdecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-elementdecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(42, $input, $state)"/>             <!-- '<!ELEMENT' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-contentspec($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>          <!-- S | '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(48, $input, $state)"/>             <!-- '>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'elementdecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse markupdecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-markupdecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 42">                                        <!-- '<!ELEMENT' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-elementdecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 41">                                        <!-- '<!ATTLIST' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-AttlistDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 43">                                        <!-- '<!ENTITY' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EntityDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 44">                                        <!-- '<!NOTATION' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-NotationDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 14">                                        <!-- PIStart -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-PI($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-Comment($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'markupdecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production extSubsetDecl (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-extSubsetDecl-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(76, $input, $state)"/>      <!-- EOF | S | PIStart | '<!-' '-' | '<!ATTLIST' | '<!ELEMENT' | '<!ENTITY' |
                                                                                         '<!NOTATION' | '<![' | ']]>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 1                                           (: EOF :)
                       or $state[$p:l1] = 68">                                      <!-- ']]>' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 45">                                <!-- '<![' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-conditionalSect($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 2">                                 <!-- S -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-DeclSep($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-markupdecl($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-extSubsetDecl-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse extSubsetDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-extSubsetDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:parse-extSubsetDecl-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'extSubsetDecl', $count, $begin, $end)"/>
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
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(29, $input, $state)"/>          <!-- 'encoding' -->
    <xsl:variable name="state" select="p:consume(69, $input, $state)"/>             <!-- 'encoding' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-Eq($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(44, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 22">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>    <!-- EncName -->
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- EncName -->
          <xsl:variable name="state" select="p:lookahead1(14, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>    <!-- EncName -->
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- EncName -->
          <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
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
    <xsl:variable name="state" select="p:lookahead1(35, $input, $state)"/>          <!-- S | '=' -->
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
    <xsl:variable name="state" select="p:lookahead1(22, $input, $state)"/>          <!-- '=' -->
    <xsl:variable name="state" select="p:consume(47, $input, $state)"/>             <!-- '=' -->
    <xsl:variable name="state" select="p:lookahead1(53, $input, $state)"/>          <!-- S | '"' | "'" -->
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
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(30, $input, $state)"/>          <!-- 'version' -->
    <xsl:variable name="state" select="p:consume(70, $input, $state)"/>             <!-- 'version' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-Eq($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(44, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 31">                                        <!-- "'" -->
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(10, $input, $state)"/>    <!-- VersionNum -->
          <xsl:variable name="state" select="p:consume(17, $input, $state)"/>       <!-- VersionNum -->
          <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(10, $input, $state)"/>    <!-- VersionNum -->
          <xsl:variable name="state" select="p:consume(17, $input, $state)"/>       <!-- VersionNum -->
          <xsl:variable name="state" select="p:lookahead1(14, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '"' -->
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
    <xsl:variable name="state" select="p:consume(46, $input, $state)"/>             <!-- '<?xml' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 2">                                        <!-- S -->
          <xsl:variable name="state" select="p:lookahead2(51, $input, $state)"/>    <!-- 'encoding' | 'version' -->
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
        <xsl:when test="$state[$p:lk] = 8962">                                      <!-- S 'version' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-VersionInfo($input, $state)
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
        p:parse-EncodingDecl($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(37, $input, $state)"/>          <!-- S | '?>' -->
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
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- '?>' -->
    <xsl:variable name="state" select="p:consume(50, $input, $state)"/>             <!-- '?>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'XMLDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse prolog.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-prolog" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(75, $input, $state)"/>          <!-- EOF | S | PIStart | '<!-' '-' | '<!ATTLIST' | '<!ELEMENT' | '<!ENTITY' |
                                                                                         '<!NOTATION' | '<![' | '<?xml' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 46">                                        <!-- '<?xml' -->
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
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'prolog', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse document.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-document" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-prolog($input, $state)
    "/>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-extSubsetDecl($input, $state)
    "/>
    <xsl:variable name="state" select="p:consume(1, $input, $state)"/>              <!-- EOF -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'document', $count, $begin, $end)"/>
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
          subsequence($state, $p:l1, 9),
          0, 0, 0,
          subsequence($state, 13),
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
        subsequence($state, $p:l2, 6)
      else
      (
        p:match($input, $state[$p:e1], $set),
        0, 0, 0
      )
    "/>
    <xsl:sequence select="
      $match[1] * 128 + $state[$p:l1],
      subsequence($state, $p:b0, 5),
      $match,
      subsequence($state, 13)
    "/>
  </xsl:function>

  <!--~
   ! Lookahead one token on level 3.
   !
   ! @param $set the code of the DFA entry state for the set of valid tokens.
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result stack.
   ! @return the updated state.
  -->
  <xsl:function name="p:lookahead3" as="item()+">
    <xsl:param name="set" as="xs:integer"/>
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="match" select="
      if ($state[$p:l3] ne 0) then
        subsequence($state, $p:l3, 3)
      else
        p:match($input, $state[$p:e2], $set)
    "/>
    <xsl:sequence select="
      $match[1] * 16384 + $state[$p:lk],
      subsequence($state, $p:b0, 8),
      $match,
      subsequence($state, 13)
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
   ! Parse start symbol document from given string.
   !
   ! @param $s the string to be parsed.
   ! @return the result as generated by parser actions.
  -->
  <xsl:function name="p:parse-document" as="item()*">
    <xsl:param name="s" as="xs:string"/>

    <xsl:variable name="state" select="0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, false()"/>
    <xsl:variable name="state" select="p:parse-document($s, $state)"/>
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