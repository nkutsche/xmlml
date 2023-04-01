<?xml version="1.0" encoding="UTF-8"?>
<!-- This file was generated on Sat Apr 1, 2023 14:10 (UTC+01) by REx v5.56 which is Copyright (c) 1979-2023 by Gunther Rademacher <grd@gmx.net> -->
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
    1, 2, 3, 4, 5, 6, 7, 8, 3849, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79
  "/>

  <!--~
   ! The DFA transition table.
  -->
  <xsl:variable name="p:TRANSITION" as="xs:integer+" select="
    1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1143, 1740, 1104, 2284, 1130, 1150, 1805, 1829, 1169, 2197,
    1740, 1740, 1740, 1740, 1740, 1740, 1193, 1740, 1104, 2284, 1130, 1150, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2517, 1740, 1740, 3360,
    2786, 1150, 3304, 1829, 1229, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2613, 1740, 2033, 2622, 1818, 1150, 1990, 1829, 1169, 2197, 1740, 1740, 1740, 1740,
    1740, 1740, 2517, 1739, 1736, 1620, 1249, 1150, 3498, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2517, 1740, 1740, 3360, 2786, 1150, 1805, 1829,
    1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2517, 1276, 1422, 3360, 2786, 1150, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 3600, 1740,
    1740, 3360, 2776, 1150, 3333, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 3013, 1294, 2641, 1586, 2003, 1150, 3560, 1829, 1169, 2197, 1740, 1740,
    1740, 1740, 1740, 1740, 2517, 1324, 3447, 2913, 1313, 1150, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2517, 3511, 1297, 1344, 1360, 1150,
    1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2517, 1740, 1740, 3360, 2940, 1388, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740,
    2517, 1740, 1740, 3360, 2369, 1150, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2517, 1740, 1441, 3627, 1404, 1150, 1805, 1829, 1169, 2197,
    1740, 1740, 1740, 1740, 1740, 1740, 2670, 1954, 1438, 3360, 2680, 1457, 1805, 1829, 1483, 2197, 1510, 1740, 1740, 1740, 1740, 1740, 2766, 1740, 1438, 3360,
    2680, 1527, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2886, 1740, 1438, 3360, 2680, 1553, 1805, 2729, 1169, 2197, 1740, 1740, 1740, 1740,
    1740, 1740, 3231, 1740, 1438, 3360, 2680, 1553, 1805, 2729, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 1576, 1740, 1602, 2311, 1636, 1677, 1805, 1829,
    1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2517, 1646, 1740, 3360, 2786, 1150, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 3600, 1740,
    1740, 1328, 2796, 1150, 1890, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2517, 3022, 3025, 3360, 2786, 1150, 1805, 1829, 1169, 2197, 1740, 1740,
    1740, 1740, 1740, 1740, 3600, 1654, 3052, 1661, 3147, 1696, 1805, 2707, 1723, 3362, 1740, 1740, 1740, 1740, 1740, 1740, 1943, 1534, 1537, 3360, 3258, 1757,
    3202, 2191, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 1776, 1740, 1851, 2414, 1917, 1553, 1805, 1707, 1976, 2197, 1560, 3690, 1760, 2030, 1740, 1740,
    1776, 1740, 1851, 2311, 1917, 1553, 1805, 2014, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 1776, 1740, 1851, 2311, 2049, 1553, 1805, 2718, 1169, 2197,
    1740, 1740, 3408, 1740, 1740, 1740, 1776, 1740, 1851, 2311, 1917, 2065, 1805, 2124, 1169, 2146, 1740, 1740, 2180, 1740, 2213, 1740, 1776, 1740, 1851, 2569,
    2257, 1553, 1805, 1829, 2273, 2197, 3609, 2300, 2327, 2345, 2385, 1740, 1776, 1740, 1851, 2311, 1917, 1553, 3546, 1829, 1169, 2197, 1740, 2959, 1740, 1740,
    1740, 1740, 3120, 1740, 1851, 2311, 1917, 2403, 2430, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1829,
    1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 3120, 1835, 2463, 2492, 2542, 1553, 1791, 1829, 2558, 2197, 1203, 2585, 2737, 2602, 2235, 1740, 3120, 1740,
    1851, 2311, 1917, 1553, 1805, 1829, 1169, 2197, 1740, 2387, 1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1829, 1169, 2840, 2638, 2103,
    3339, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 2657, 1416, 2696, 2197, 1740, 1740, 3157, 1740, 1740, 1740, 3120, 1233, 1851, 2753, 2812, 2828,
    2873, 2902, 2929, 2197, 2956, 1740, 1740, 3381, 2476, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 2158, 1169, 2091, 2358, 1740, 1740, 1153, 3516, 1740,
    3120, 1740, 1851, 1864, 2975, 3041, 1805, 1829, 3068, 2130, 1740, 1740, 1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1829, 1169, 3414,
    1740, 1740, 1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 3188, 1829, 3090, 2197, 2857, 1740, 1740, 3618, 1740, 1740, 3120, 1740, 1851, 1877,
    3106, 1553, 1805, 1260, 1169, 2197, 1740, 1740, 2586, 1740, 3136, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1829, 3173, 3218, 3247, 1213, 3274, 1960,
    2164, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 3291, 1829, 1169, 2197, 2447, 2224, 1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1829,
    1169, 2241, 1740, 1740, 1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 3320, 1829, 3355, 2197, 1740, 3378, 1680, 1740, 1615, 1740, 3600, 1173,
    1177, 3360, 2786, 1150, 1805, 1829, 3397, 3361, 1740, 1740, 1740, 1740, 1740, 1740, 3600, 1740, 1740, 3360, 2786, 1150, 1805, 1829, 1169, 2197, 1740, 1740,
    1740, 1740, 1740, 1740, 3600, 1740, 1740, 3467, 1467, 1150, 2078, 3430, 3463, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2989, 1740, 1851, 2311, 1917, 1553,
    1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 1776, 1740, 1851, 2311, 1917, 1553, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740,
    1776, 1740, 1851, 2311, 1917, 1553, 1805, 1901, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 1776, 1740, 1851, 2311, 1917, 1553, 1805, 1829, 1169, 2197,
    2329, 1740, 1740, 1740, 1740, 1740, 1776, 1278, 1851, 3572, 1917, 3483, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311,
    1917, 1553, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 3275, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1829, 1169, 2197, 1511, 1740, 2443, 1740,
    1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1829, 1169, 2197, 1740, 3074, 1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1829,
    1169, 2197, 2852, 1740, 1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 3532, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 3001, 1740, 1740, 3120, 1740,
    1851, 2311, 1917, 1553, 1805, 1829, 1169, 1114, 1740, 1740, 3442, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1494, 1169, 2197, 1740, 1740,
    1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1829, 1169, 2526, 1740, 1740, 1740, 1740, 1740, 1740, 3120, 1741, 1851, 1372, 1917, 1553,
    1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 3120, 1740, 1851, 2311, 1917, 1553, 1805, 1829, 3588, 2197, 1740, 1740, 1740, 1740, 1740, 1740,
    3600, 1740, 3669, 3643, 3658, 1150, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 2505, 1740, 1438, 3360, 2680, 3685, 1805, 1829, 1169, 2197,
    1740, 1740, 1740, 1740, 1740, 1740, 1931, 1740, 1851, 2311, 1917, 3685, 1805, 1829, 1169, 2197, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740,
    2108, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 1740, 0, 769, 769, 769, 769, 769, 769, 769, 769, 769, 0, 0, 0, 0, 0, 0, 175, 0, 0, 0,
    5988, 5988, 0, 0, 0, 0, 0, 769, 769, 769, 0, 769, 1897, 2155, 2412, 2669, 0, 769, 769, 769, 0, 0, 0, 2821, 3078, 0, 0, 3849, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 233, 0, 5988, 5988, 5988, 5988, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17664, 0, 0, 0, 0, 0, 0, 769, 0, 0, 0, 2821, 3078, 3335, 3592, 3849,
    83, 0, 0, 0, 0, 0, 0, 189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 203, 0, 205, 206, 0, 0, 207, 0, 0, 210, 155, 5988, 5988, 5988, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93,
    0, 0, 0, 0, 88, 0, 0, 0, 0, 1897, 2155, 2412, 2669, 110, 0, 0, 0, 0, 0, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 154, 0, 7424, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 94, 0, 0, 0, 8448, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8960, 8960, 0, 8704, 0, 0, 0, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 0, 8704, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 96, 0, 0, 0, 0, 0, 0, 8960, 8960, 96, 0, 0, 5988, 0, 0, 9056, 8960, 0, 9056, 8960, 0, 0, 1897, 2155, 2412, 2669, 0, 8960, 0,
    0, 0, 0, 95, 1361, 0, 0, 0, 0, 0, 1361, 5988, 0, 0, 0, 0, 3849, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9216, 9984, 0, 0, 9984, 0, 0, 1897, 2155, 2412,
    2669, 0, 9984, 0, 0, 0, 0, 145, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7424, 0, 0, 0, 0, 0, 0, 0, 1540, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9984, 0, 1361,
    0, 83, 0, 4693, 0, 5719, 0, 121, 0, 0, 0, 0, 0, 0, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 113, 0, 0, 5988, 5988, 5988, 5988, 0, 0, 0, 0, 0, 0, 161, 0, 0, 0, 0,
    0, 83, 0, 0, 0, 0, 0, 0, 0, 152, 0, 0, 10752, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 197, 1361, 3849, 83, 0, 4693, 119, 5719, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1361, 3849, 83, 0, 4693, 0, 5719, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 193, 0, 0, 16128, 0, 0, 0, 0, 1361, 1540, 2821, 3078,
    3335, 3592, 3849, 0, 0, 0, 0, 0, 0, 0, 8448, 0, 0, 0, 0, 0, 5988, 8448, 0, 0, 0, 1361, 1540, 0, 0, 0, 0, 0, 0, 0, 0, 1361, 1361, 0, 0, 0, 0, 11520, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 88, 5988, 0, 0, 0, 0, 1361, 0, 0, 0, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 0, 0, 0, 10496, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12800, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 5988, 12800, 0, 0, 1361, 3849, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14592, 0, 0, 3849, 83, 4352, 0, 0, 0, 0, 0, 13312, 0, 0,
    0, 0, 0, 0, 83, 0, 0, 0, 0, 0, 150, 0, 0, 0, 0, 5988, 5988, 5988, 17920, 0, 0, 0, 0, 0, 0, 0, 0, 17920, 0, 0, 0, 88, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 95, 0, 3849, 118, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220, 0, 0, 0, 1104, 1361, 1540, 2821, 3078, 3335, 3592, 3849, 0, 4693, 0, 0, 5390, 5719,
    0, 0, 0, 5988, 5988, 5988, 0, 0, 1897, 0, 2155, 2412, 2669, 137, 0, 0, 0, 5988, 5988, 5988, 0, 0, 1897, 0, 2155, 2412, 2669, 0, 0, 0, 0, 6144, 0, 6144,
    2155, 6144, 2669, 6144, 0, 0, 0, 0, 0, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 91, 92, 0, 0, 0, 0, 0, 1361, 1540, 0, 0, 0, 0, 0, 0, 0, 1104, 1361, 1361, 0, 0, 0,
    98, 0, 1361, 0, 0, 0, 0, 0, 1361, 5988, 0, 0, 0, 99, 0, 1361, 0, 0, 0, 0, 0, 1361, 5988, 0, 0, 0, 129, 5988, 5988, 0, 0, 1897, 0, 2155, 0, 0, 0, 0, 0, 83,
    0, 0, 0, 0, 0, 0, 151, 0, 0, 0, 0, 1361, 0, 0, 0, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 0, 0, 1104, 1361, 1540, 2821, 3078, 0, 0, 3849, 0, 4693, 0, 0, 0, 0,
    0, 2821, 3078, 3335, 3592, 3849, 84, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 229, 230, 0, 0, 0, 0, 5988, 5988, 5988, 5988, 0, 0, 0, 0, 0, 0,
    162, 0, 0, 166, 0, 0, 0, 5988, 5988, 5988, 0, 0, 0, 0, 2155, 0, 2669, 0, 0, 0, 0, 8448, 0, 1897, 8448, 2412, 8448, 8448, 0, 0, 0, 0, 0, 83, 0, 0, 0, 0, 0,
    0, 0, 0, 153, 0, 0, 0, 6912, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6144, 0, 0, 0, 1361, 0, 0, 0, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 0, 114, 1104, 1361,
    3849, 83, 0, 4693, 0, 5719, 0, 0, 0, 0, 0, 124, 0, 0, 0, 130, 5988, 132, 0, 0, 1897, 0, 2155, 2412, 2669, 0, 0, 0, 172, 0, 0, 0, 0, 0, 0, 5988, 5988, 0, 0,
    0, 0, 201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 512, 512, 0, 0, 0, 142, 0, 14992, 0, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5988, 5988, 0, 0, 181, 0, 0, 0, 171,
    0, 0, 0, 0, 0, 0, 0, 5988, 5988, 0, 0, 0, 0, 146, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11008, 11264, 0, 0, 0, 0, 0, 0, 212, 0, 0, 0, 0, 6400, 0, 0, 0, 0, 0, 0,
    0, 0, 118, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5988, 5988, 0, 0, 0, 0, 6656, 0, 0, 0, 0, 0, 0, 0, 0, 7168, 0, 0, 0, 0, 0, 0, 202, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    237, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5988, 5988, 0, 180, 0, 0, 0, 1361, 0, 0, 0, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 0, 115, 1104, 5988, 5988, 5988, 5988, 0,
    0, 0, 0, 0, 160, 163, 0, 0, 0, 0, 0, 769, 769, 769, 769, 769, 769, 0, 5988, 0, 0, 0, 0, 199, 0, 200, 0, 0, 0, 204, 0, 0, 0, 0, 0, 0, 0, 0, 1361, 0, 0, 0, 0,
    0, 1361, 5988, 0, 0, 0, 0, 15616, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 196, 0, 222, 0, 0, 15872, 0, 0, 225, 0, 0, 228, 0, 0, 231, 0, 0, 0, 186, 0, 0,
    0, 0, 191, 0, 0, 0, 0, 0, 0, 0, 9728, 1897, 2155, 2412, 2669, 0, 9728, 0, 0, 0, 0, 0, 234, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 209, 0, 1361, 3849, 83,
    0, 4693, 0, 5719, 0, 0, 0, 122, 0, 0, 0, 0, 0, 1361, 0, 0, 0, 0, 0, 1361, 5988, 0, 103, 0, 122, 0, 0, 5988, 5988, 5988, 0, 0, 1897, 0, 2155, 2412, 2669, 0,
    0, 0, 213, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 195, 0, 0, 0, 0, 1361, 1540, 0, 0, 0, 0, 91, 92, 0, 1104, 1361, 1361, 0, 0, 0, 236, 0, 0, 0, 0, 16896, 0, 0,
    0, 0, 11776, 0, 0, 0, 0, 97, 0, 0, 1361, 0, 0, 0, 0, 97, 1361, 5988, 0, 0, 0, 1540, 2821, 3078, 0, 0, 3849, 0, 0, 0, 0, 0, 0, 0, 2821, 3078, 3335, 3592,
    3849, 0, 0, 0, 0, 0, 0, 0, 176, 0, 0, 5988, 5988, 0, 0, 0, 0, 0, 1361, 0, 0, 0, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 0, 116, 1104, 5988, 5988, 5988, 5988, 0,
    0, 0, 158, 0, 0, 0, 0, 0, 0, 0, 0, 1361, 0, 0, 0, 0, 0, 1361, 5988, 0, 104, 0, 198, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15360, 0, 223, 0, 0, 0, 0,
    0, 0, 227, 0, 0, 0, 0, 0, 0, 0, 3078, 0, 0, 3849, 0, 0, 0, 0, 0, 0, 6144, 0, 0, 0, 0, 0, 5988, 6144, 0, 0, 0, 0, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    8448, 0, 0, 0, 0, 0, 5988, 5988, 5988, 0, 134, 1897, 0, 2155, 2412, 2669, 0, 0, 0, 1540, 2821, 3078, 3335, 3592, 82, 0, 0, 0, 0, 0, 0, 0, 1897, 2155, 2412,
    2669, 0, 0, 0, 0, 0, 1104, 5988, 5988, 5988, 5988, 0, 0, 0, 0, 159, 0, 0, 0, 0, 0, 0, 0, 4352, 0, 0, 10240, 0, 0, 0, 0, 0, 0, 0, 83, 0, 147, 0, 0, 149, 0,
    0, 0, 0, 0, 83, 4983, 0, 0, 0, 0, 0, 0, 0, 0, 0, 215, 216, 0, 0, 219, 0, 221, 0, 0, 93, 0, 0, 0, 1361, 0, 0, 0, 0, 0, 1361, 5988, 0, 0, 0, 1540, 2821, 3078,
    3335, 3592, 3849, 0, 0, 0, 0, 0, 0, 0, 7786, 7786, 7786, 7786, 0, 0, 0, 0, 0, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 0, 0, 0, 1897, 2155, 0, 0, 0, 0, 111, 112,
    0, 0, 0, 1361, 0, 0, 0, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 0, 117, 1104, 1361, 3849, 83, 0, 4693, 0, 5719, 0, 0, 0, 0, 123, 0, 0, 0, 0, 173, 0, 0, 0, 177,
    0, 5988, 5988, 0, 0, 0, 0, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 194, 0, 0, 0, 0, 123, 0, 0, 5988, 5988, 5988, 133, 0, 1897, 0, 2155, 2412, 2669, 0, 0, 0,
    1540, 2821, 3078, 3335, 3592, 3849, 0, 0, 0, 5133, 5390, 0, 0, 0, 0, 143, 0, 0, 83, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 8704, 0, 0, 0, 0, 0, 8704, 5988, 0,
    8704, 0, 5988, 5988, 5988, 5988, 0, 0, 0, 0, 0, 0, 164, 0, 0, 0, 0, 0, 9472, 1897, 2155, 2412, 2669, 0, 9472, 0, 0, 0, 0, 0, 0, 185, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 15312, 0, 0, 0, 1361, 0, 0, 98, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 0, 0, 1104, 1361, 1540, 2821, 3078, 3335, 3592, 3849, 0, 4693, 0, 0, 0,
    0, 0, 224, 18432, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2821, 0, 3335, 0, 3849, 0, 0, 0, 0, 0, 0, 0, 12544, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1361, 3849, 83, 0,
    4693, 0, 5719, 120, 0, 0, 0, 0, 0, 0, 0, 0, 12800, 0, 0, 0, 0, 0, 0, 12800, 0, 0, 0, 5988, 5988, 5988, 5988, 0, 157, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12288, 0,
    0, 0, 0, 0, 5988, 5988, 5988, 5988, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 168, 0, 1361, 0, 0, 99, 0, 1897, 2155, 2412, 2669, 0, 0, 0, 0, 0, 1104, 1361, 1540,
    2821, 3078, 3335, 3592, 3849, 0, 4693, 0, 0, 0, 5719, 0, 0, 0, 235, 0, 0, 0, 14336, 16640, 0, 0, 0, 0, 0, 0, 0, 0, 12800, 1897, 2155, 2412, 2669, 0, 0, 0,
    0, 0, 0, 17408, 0, 0, 0, 0, 218, 0, 0, 0, 0, 5988, 5988, 5988, 5988, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 167, 0, 0, 0, 5988, 5988, 5988, 0, 0, 1897, 0, 2155,
    2412, 2669, 138, 0, 0, 0, 5988, 5988, 5988, 0, 0, 1897, 0, 2155, 2412, 2669, 0, 4236, 4096, 169, 170, 0, 0, 0, 174, 0, 0, 0, 178, 5988, 5988, 179, 0, 0, 0,
    1540, 2821, 3078, 3335, 3592, 3849, 0, 0, 86, 5133, 5390, 0, 0, 0, 183, 0, 0, 0, 188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13056, 1897, 2155, 2412, 2669, 0, 13056,
    0, 0, 0, 0, 211, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18176, 0, 127, 0, 5988, 5988, 5988, 0, 0, 1897, 0, 2155, 2412, 2669, 0, 0, 0, 5988, 131, 5988,
    0, 0, 1897, 0, 2155, 2412, 2669, 0, 139, 139, 0, 0, 128, 5988, 5988, 5988, 0, 0, 1897, 0, 2155, 2412, 2669, 0, 0, 0, 5988, 5988, 5988, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 217, 0, 0, 0, 0, 0, 5988, 5988, 5988, 5988, 13568, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5988, 0, 0, 0, 0, 0, 0, 0, 14080, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 16616, 0, 0, 5988, 5988, 12032, 5988, 0, 0, 0, 0, 0, 0, 12032, 0, 0, 0, 0, 0, 17152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5988, 5988, 0, 0, 0, 182,
    141, 0, 0, 0, 0, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 214, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8704, 0, 0, 0, 0, 5988, 156, 5988, 5988, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 102, 0, 0, 0, 1361, 3849, 83, 0, 4693, 0, 5719, 0, 0, 0, 0, 0, 0, 0, 126, 0, 0, 0, 5988, 5988, 5988, 0, 0, 1897, 8071, 2155, 2412, 2669, 0, 0, 0,
    0, 8960, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 238, 0, 0, 0, 1361, 3849, 83, 0, 4693, 0, 5719, 0, 0, 0, 0, 0, 0, 125, 0, 0, 0, 5988, 5988, 5988, 0, 0, 1897,
    0, 2155, 2412, 2669, 136, 0, 0, 0, 5988, 5988, 5988, 0, 0, 1897, 0, 0, 2412, 0, 0, 0, 0, 94, 1361, 0, 0, 0, 0, 0, 1361, 5988, 0, 0, 0, 5988, 5988, 5988,
    5988, 0, 0, 8192, 0, 0, 0, 0, 165, 0, 0, 0, 0, 2821, 3078, 0, 0, 3849, 0, 0, 0, 0, 0, 0, 0, 190, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 0, 0, 9984,
    0, 0, 0, 0, 5988, 0, 0, 0, 18688, 0, 0, 0, 0, 0, 0, 0, 18688, 18688, 0, 0, 5988, 0, 0, 18688, 0, 18688, 18688, 0, 0, 1897, 2155, 2412, 2669, 0, 18688, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18688, 1361, 3849, 83, 0, 4693, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13824, 0, 0, 0, 0
  "/>

  <!--~
   ! The DFA-state to expected-token-set mapping.
  -->
  <xsl:variable name="p:EXPECTED" as="xs:integer+" select="
    224, 409, 179, 300, 273, 191, 191, 191, 185, 216, 201, 189, 191, 198, 217, 208, 214, 303, 221, 245, 204, 181, 191, 191, 383, 239, 255, 266, 191, 270, 191,
    191, 237, 275, 281, 191, 310, 191, 235, 279, 191, 191, 310, 191, 262, 281, 191, 191, 312, 262, 281, 191, 310, 425, 191, 191, 281, 191, 287, 191, 191, 191,
    191, 191, 293, 297, 353, 191, 417, 307, 251, 321, 249, 320, 325, 329, 333, 373, 337, 343, 191, 210, 353, 247, 401, 405, 191, 339, 348, 283, 354, 191, 403,
    191, 358, 366, 352, 191, 384, 289, 362, 366, 352, 191, 240, 409, 364, 350, 382, 191, 409, 370, 381, 407, 411, 191, 409, 190, 388, 191, 191, 191, 191, 191,
    191, 191, 392, 261, 191, 399, 344, 230, 415, 260, 227, 258, 233, 344, 421, 191, 191, 191, 315, 429, 434, 191, 191, 435, 423, 191, 394, 241, 191, 191, 435,
    376, 314, 430, 191, 191, 191, 376, 314, 430, 191, 191, 193, 313, 395, 191, 191, 376, 316, 191, 194, 191, 192, 377, 275, 16384, 65536, 131072, 262144,
    2097152, 67108864, 0, 20, 36, 67108868, 16, 8388608, 0, 0, 0, 0, 1, 2, 64, 0, 20, 8388612, 4, 4, 268435464, 16, 16384, 65536, 65536, 4194304, 8388608, 0, 0,
    128, 524288, 0, 67108884, 4, 4, 4, 4, 67108880, -528482048, -536870400, 192937984, 4, 8, 16, 32, 0, 0, 256, 0, 0, 12, 0, 0, 0, 4194304, 4194304, 4194304,
    4194304, 0, 0, 0, 32, 32774, 32774, 0, 8, 805306368, 0, 0, 2, 131072, 1, 64, -1073741824, 128, 256, 0, 256, 256, 0, 0, 0, 16777216, 512, 184549376, 32768,
    32768, 0, 65536, 262144, 67108864, 268435456, 0, 0, -2147483648, 16777216, 0, 16777216, 33554432, 134217728, 0, 0, 128, 268435456, 0, 134217728, 0, 0, 512,
    1024, 1, 2, 4, 128, 256, 65536, 131072, 524288, 1048576, 2097152, 8388608, 4, -528482240, -536870784, 524288, 268435456, 536870912, 0, 0, 67108864, 0, 0, 0,
    64, 128, 0, 0, 1, 68, 4, 8, 1073872896, 805306368, 2, 16384, 131073, 5242882, 12, 68, 2, 12, 68, 1, 393264, 1, 262260, 65024, 32256, 0, 2097152,
    -1885339646, 0, 0, 0, 256, 25165824, 234881024, -2147483648, 0, 0, 268435456, 536870912, 1073741824, 0, 0, 32256, 32768, 0, 2097152, 6144, 8192, 32768,
    2097152, 25165824, 201326592, -2147483648, 0, 25165824, 134217728, -2147483648, 0, 1, 0, 1, 2, 0, 0, 0, 0, 536870912, 0, 0, 0, 4194304, 0, 1024, 2048, 8192,
    8192, 0, 16, 64, 128, 4, 8, 0, 0, 16, 0, 0, 16384, 0, 1048576, 4194304, 0, 0, 1024, 2048, 4096, 8192, 8388608, -2147483648, 192, 0, 0, 0, 65536, 131072, 0,
    32, 3, 0, 0, 0, 33554432, 134217728, 0, 4, 8, 0, 0, 0, 32, 0, 0, 0
  "/>

  <!--~
   ! The token-string table.
  -->
  <xsl:variable name="p:TOKEN" as="xs:string+" select="
    '(0)',
    'EOF',
    'S',
    'NCName',
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
        <xsl:variable name="i0" select=". * 238 + $state - 1"/>
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
        <xsl:variable name="state" select="p:lookahead1(60, $input, $state)"/>      <!-- Ignore | '<![' | ']]>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 69">                                      <!-- ']]>' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 22">                                <!-- Ignore -->
                  <xsl:variable name="state" select="p:consume(22, $input, $state)"/> <!-- Ignore -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="state" select="p:consume(46, $input, $state)"/> <!-- '<![' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-ignoreSectContents($input, $state)
                  "/>
                  <xsl:variable name="state" select="p:consume(69, $input, $state)"/> <!-- ']]>' -->
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
    <xsl:variable name="state" select="p:consume(46, $input, $state)"/>             <!-- '<![' -->
    <xsl:variable name="state" select="p:lookahead1(39, $input, $state)"/>          <!-- S | 'IGNORE' -->
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
    <xsl:variable name="state" select="p:lookahead1(26, $input, $state)"/>          <!-- 'IGNORE' -->
    <xsl:variable name="state" select="p:consume(60, $input, $state)"/>             <!-- 'IGNORE' -->
    <xsl:variable name="state" select="p:lookahead1(41, $input, $state)"/>          <!-- S | '[' -->
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
    <xsl:variable name="state" select="p:lookahead1(29, $input, $state)"/>          <!-- '[' -->
    <xsl:variable name="state" select="p:consume(68, $input, $state)"/>             <!-- '[' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-ignoreSectContents($input, $state)
    "/>
    <xsl:variable name="state" select="p:consume(69, $input, $state)"/>             <!-- ']]>' -->
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
    <xsl:variable name="state" select="p:consume(46, $input, $state)"/>             <!-- '<![' -->
    <xsl:variable name="state" select="p:lookahead1(40, $input, $state)"/>          <!-- S | 'INCLUDE' -->
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
    <xsl:variable name="state" select="p:lookahead1(27, $input, $state)"/>          <!-- 'INCLUDE' -->
    <xsl:variable name="state" select="p:consume(61, $input, $state)"/>             <!-- 'INCLUDE' -->
    <xsl:variable name="state" select="p:lookahead1(41, $input, $state)"/>          <!-- S | '[' -->
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
    <xsl:variable name="state" select="p:lookahead1(29, $input, $state)"/>          <!-- '[' -->
    <xsl:variable name="state" select="p:consume(68, $input, $state)"/>             <!-- '[' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-extSubsetDecl($input, $state)
    "/>
    <xsl:variable name="state" select="p:consume(69, $input, $state)"/>             <!-- ']]>' -->
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
        <xsl:when test="$state[$p:l1] eq 46">                                       <!-- '<![' -->
          <xsl:variable name="state" select="p:lookahead2(58, $input, $state)"/>    <!-- S | 'IGNORE' | 'INCLUDE' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:lk] eq 302">                                <!-- '<![' S -->
                <xsl:variable name="state" select="p:lookahead3(50, $input, $state)"/> <!-- 'IGNORE' | 'INCLUDE' -->
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
        <xsl:when test="$state[$p:lk] = 7854                                          (: '&lt;![' 'INCLUDE' :)
                     or $state[$p:lk] = 999726">                                    <!-- '<![' S 'INCLUDE' -->
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
    <xsl:variable name="state" select="p:consume(41, $input, $state)"/>             <!-- '<!-' '-' -->
    <xsl:variable name="state" select="p:lookahead1(8, $input, $state)"/>           <!-- CommentContent -->
    <xsl:variable name="state" select="p:consume(14, $input, $state)"/>             <!-- CommentContent -->
    <xsl:variable name="state" select="p:lookahead1(21, $input, $state)"/>          <!-- '-' '->' -->
    <xsl:variable name="state" select="p:consume(39, $input, $state)"/>             <!-- '-' '->' -->
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
    <xsl:variable name="state" select="p:consume(15, $input, $state)"/>             <!-- PIStart -->
    <xsl:variable name="state" select="p:lookahead1(10, $input, $state)"/>          <!-- PITarget -->
    <xsl:variable name="state" select="p:consume(17, $input, $state)"/>             <!-- PITarget -->
    <xsl:variable name="state" select="p:lookahead1(9, $input, $state)"/>           <!-- PIContentEnd -->
    <xsl:variable name="state" select="p:consume(16, $input, $state)"/>             <!-- PIContentEnd -->
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
    <xsl:variable name="state" select="p:lookahead1(51, $input, $state)"/>          <!-- 'PUBLIC' | 'SYSTEM' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 67">                                        <!-- 'SYSTEM' -->
          <xsl:variable name="state" select="p:consume(67, $input, $state)"/>       <!-- 'SYSTEM' -->
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
          <xsl:variable name="state" select="p:consume(66, $input, $state)"/>       <!-- 'PUBLIC' -->
          <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>     <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-PubidLiteral($input, $state)
          "/>
          <xsl:variable name="state" select="p:lookahead1(37, $input, $state)"/>    <!-- S | '>' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:l1] eq 2">                                  <!-- S -->
                <xsl:variable name="state" select="p:lookahead2(61, $input, $state)"/> <!-- '"' | "'" | '>' -->
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
              <xsl:when test="$state[$p:lk] = 2946                                    (: S '&quot;' :)
                           or $state[$p:lk] = 4098">                                <!-- S "'" -->
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
    <xsl:variable name="state" select="p:consume(45, $input, $state)"/>             <!-- '<!NOTATION' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- NCName -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- NCName -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-ExternalOrPublicID($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(37, $input, $state)"/>          <!-- S | '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(49, $input, $state)"/>             <!-- '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(68, $input, $state)"/>          <!-- '"' | "'" | 'PUBLIC' | 'SYSTEM' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 23                                            (: '&quot;' :)
                     or $state[$p:l1] = 32">                                        <!-- "'" -->
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
    <xsl:variable name="state" select="p:consume(44, $input, $state)"/>             <!-- '<!ENTITY' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>          <!-- '%' -->
    <xsl:variable name="state" select="p:consume(28, $input, $state)"/>             <!-- '%' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- NCName -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- NCName -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-PEDef($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(37, $input, $state)"/>          <!-- S | '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(49, $input, $state)"/>             <!-- '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(28, $input, $state)"/>          <!-- 'NDATA' -->
    <xsl:variable name="state" select="p:consume(62, $input, $state)"/>             <!-- 'NDATA' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(4, $input, $state)"/>              <!-- Name -->
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
    <xsl:variable name="state" select="p:lookahead1(45, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 23">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(6, $input, $state)"/>     <!-- PubidLiteralDouble -->
          <xsl:variable name="state" select="p:consume(12, $input, $state)"/>       <!-- PubidLiteralDouble -->
          <xsl:variable name="state" select="p:lookahead1(15, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(7, $input, $state)"/>     <!-- PubidLiteralSingle -->
          <xsl:variable name="state" select="p:consume(13, $input, $state)"/>       <!-- PubidLiteralSingle -->
          <xsl:variable name="state" select="p:lookahead1(18, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
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
    <xsl:variable name="state" select="p:lookahead1(45, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 23">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(4, $input, $state)"/>     <!-- SystemLiteralDouble -->
          <xsl:variable name="state" select="p:consume(10, $input, $state)"/>       <!-- SystemLiteralDouble -->
          <xsl:variable name="state" select="p:lookahead1(15, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(5, $input, $state)"/>     <!-- SystemLiteralSingle -->
          <xsl:variable name="state" select="p:consume(11, $input, $state)"/>       <!-- SystemLiteralSingle -->
          <xsl:variable name="state" select="p:lookahead1(18, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
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
        <xsl:when test="$state[$p:l1] = 67">                                        <!-- 'SYSTEM' -->
          <xsl:variable name="state" select="p:consume(67, $input, $state)"/>       <!-- 'SYSTEM' -->
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
          <xsl:variable name="state" select="p:consume(66, $input, $state)"/>       <!-- 'PUBLIC' -->
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
        <xsl:variable name="state" select="p:lookahead1(71, $input, $state)"/>      <!-- EntityStaticValueSingle | '&' | '&#' | '&#x' | "'" -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 32">                                      <!-- "'" -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 7">                                 <!-- EntityStaticValueSingle -->
                  <xsl:variable name="state" select="p:consume(7, $input, $state)"/> <!-- EntityStaticValueSingle -->
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
        <xsl:variable name="state" select="p:lookahead1(70, $input, $state)"/>      <!-- EntityStaticValueDouble | '"' | '&' | '&#' | '&#x' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 23">                                      <!-- '"' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 6">                                 <!-- EntityStaticValueDouble -->
                  <xsl:variable name="state" select="p:consume(6, $input, $state)"/> <!-- EntityStaticValueDouble -->
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
        <xsl:when test="$state[$p:l1] = 23">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EntityValueDouble($input, $state)
          "/>
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EntityValueSingle($input, $state)
          "/>
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
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
    <xsl:variable name="state" select="p:lookahead1(68, $input, $state)"/>          <!-- '"' | "'" | 'PUBLIC' | 'SYSTEM' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 23                                            (: '&quot;' :)
                     or $state[$p:l1] = 32">                                        <!-- "'" -->
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
          <xsl:variable name="state" select="p:lookahead1(37, $input, $state)"/>    <!-- S | '>' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:l1] eq 2">                                  <!-- S -->
                <xsl:variable name="state" select="p:lookahead2(49, $input, $state)"/> <!-- '>' | 'NDATA' -->
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
              <xsl:when test="$state[$p:lk] = 7938">                                <!-- S 'NDATA' -->
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
    <xsl:variable name="state" select="p:consume(44, $input, $state)"/>             <!-- '<!ENTITY' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- NCName -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- NCName -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-EntityDef($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(37, $input, $state)"/>          <!-- S | '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(49, $input, $state)"/>             <!-- '>' -->
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
        <xsl:when test="$state[$p:l1] eq 44">                                       <!-- '<!ENTITY' -->
          <xsl:variable name="state" select="p:lookahead2(0, $input, $state)"/>     <!-- S -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:lk] eq 300">                                <!-- '<!ENTITY' S -->
                <xsl:variable name="state" select="p:lookahead3(42, $input, $state)"/> <!-- NCName | '%' -->
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
        <xsl:when test="$state[$p:lk] = 49452">                                     <!-- '<!ENTITY' S NCName -->
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
        <xsl:variable name="state" select="p:lookahead1(73, $input, $state)"/>      <!-- AttValueSingleVal | '&' | '&#' | '&#x' | "'" -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 32">                                      <!-- "'" -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 9">                                 <!-- AttValueSingleVal -->
                  <xsl:variable name="state" select="p:consume(9, $input, $state)"/> <!-- AttValueSingleVal -->
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
        <xsl:when test="$state[$p:l1] = 30">                                        <!-- '&#' -->
          <xsl:variable name="state" select="p:consume(30, $input, $state)"/>       <!-- '&#' -->
          <xsl:variable name="state" select="p:lookahead1(12, $input, $state)"/>    <!-- CharRefDec -->
          <xsl:variable name="state" select="p:consume(19, $input, $state)"/>       <!-- CharRefDec -->
          <xsl:variable name="state" select="p:lookahead1(22, $input, $state)"/>    <!-- ';' -->
          <xsl:variable name="state" select="p:consume(40, $input, $state)"/>       <!-- ';' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(31, $input, $state)"/>       <!-- '&#x' -->
          <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>    <!-- CharRefHex -->
          <xsl:variable name="state" select="p:consume(20, $input, $state)"/>       <!-- CharRefHex -->
          <xsl:variable name="state" select="p:lookahead1(22, $input, $state)"/>    <!-- ';' -->
          <xsl:variable name="state" select="p:consume(40, $input, $state)"/>       <!-- ';' -->
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
    <xsl:variable name="state" select="p:consume(29, $input, $state)"/>             <!-- '&' -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- NCName -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- NCName -->
    <xsl:variable name="state" select="p:lookahead1(22, $input, $state)"/>          <!-- ';' -->
    <xsl:variable name="state" select="p:consume(40, $input, $state)"/>             <!-- ';' -->
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
        <xsl:when test="$state[$p:l1] = 29">                                        <!-- '&' -->
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
        <xsl:variable name="state" select="p:lookahead1(72, $input, $state)"/>      <!-- AttValueDoubleVal | '"' | '&' | '&#' | '&#x' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 23">                                      <!-- '"' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 8">                                 <!-- AttValueDoubleVal -->
                  <xsl:variable name="state" select="p:consume(8, $input, $state)"/> <!-- AttValueDoubleVal -->
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
    <xsl:variable name="state" select="p:lookahead1(45, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 23">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-AttValueDouble($input, $state)
          "/>
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-AttValueSingle($input, $state)
          "/>
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
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
    <xsl:variable name="state" select="p:lookahead1(74, $input, $state)"/>          <!-- '"' | '#FIXED' | '#IMPLIED' | '#REQUIRED' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 27">                                        <!-- '#REQUIRED' -->
          <xsl:variable name="state" select="p:consume(27, $input, $state)"/>       <!-- '#REQUIRED' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 25">                                        <!-- '#IMPLIED' -->
          <xsl:variable name="state" select="p:consume(25, $input, $state)"/>       <!-- '#IMPLIED' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 24">                                  <!-- '#FIXED' -->
                <xsl:variable name="state" select="p:consume(24, $input, $state)"/> <!-- '#FIXED' -->
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
        <xsl:variable name="state" select="p:lookahead1(56, $input, $state)"/>      <!-- S | ')' | '|' -->
        <xsl:variable name="state" as="item()+">
          <xsl:choose>
            <xsl:when test="$state[$p:l1] eq 2">                                    <!-- S -->
              <xsl:variable name="state" select="p:lookahead2(47, $input, $state)"/> <!-- ')' | '|' -->
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$state[$p:lk] != 72                                         (: '|' :)
                      and $state[$p:lk] != 9218">                                   <!-- S '|' -->
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
            <xsl:variable name="state" select="p:lookahead1(32, $input, $state)"/>  <!-- '|' -->
            <xsl:variable name="state" select="p:consume(72, $input, $state)"/>     <!-- '|' -->
            <xsl:variable name="state" select="p:lookahead1(34, $input, $state)"/>  <!-- S | Nmtoken -->
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
            <xsl:variable name="state" select="p:lookahead1(3, $input, $state)"/>   <!-- Nmtoken -->
            <xsl:variable name="state" select="p:consume(5, $input, $state)"/>      <!-- Nmtoken -->
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
    <xsl:variable name="state" select="p:consume(33, $input, $state)"/>             <!-- '(' -->
    <xsl:variable name="state" select="p:lookahead1(34, $input, $state)"/>          <!-- S | Nmtoken -->
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
    <xsl:variable name="state" select="p:lookahead1(3, $input, $state)"/>           <!-- Nmtoken -->
    <xsl:variable name="state" select="p:consume(5, $input, $state)"/>              <!-- Nmtoken -->
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
    <xsl:variable name="state" select="p:lookahead1(20, $input, $state)"/>          <!-- ')' -->
    <xsl:variable name="state" select="p:consume(34, $input, $state)"/>             <!-- ')' -->
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
        <xsl:variable name="state" select="p:lookahead1(56, $input, $state)"/>      <!-- S | ')' | '|' -->
        <xsl:variable name="state" as="item()+">
          <xsl:choose>
            <xsl:when test="$state[$p:l1] eq 2">                                    <!-- S -->
              <xsl:variable name="state" select="p:lookahead2(47, $input, $state)"/> <!-- ')' | '|' -->
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$state[$p:lk] != 72                                         (: '|' :)
                      and $state[$p:lk] != 9218">                                   <!-- S '|' -->
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
            <xsl:variable name="state" select="p:lookahead1(32, $input, $state)"/>  <!-- '|' -->
            <xsl:variable name="state" select="p:consume(72, $input, $state)"/>     <!-- '|' -->
            <xsl:variable name="state" select="p:lookahead1(33, $input, $state)"/>  <!-- S | Name -->
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
            <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>   <!-- Name -->
            <xsl:variable name="state" select="p:consume(4, $input, $state)"/>      <!-- Name -->
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
    <xsl:variable name="state" select="p:consume(65, $input, $state)"/>             <!-- 'NOTATION' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(19, $input, $state)"/>          <!-- '(' -->
    <xsl:variable name="state" select="p:consume(33, $input, $state)"/>             <!-- '(' -->
    <xsl:variable name="state" select="p:lookahead1(33, $input, $state)"/>          <!-- S | Name -->
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
    <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(4, $input, $state)"/>              <!-- Name -->
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
    <xsl:variable name="state" select="p:lookahead1(20, $input, $state)"/>          <!-- ')' -->
    <xsl:variable name="state" select="p:consume(34, $input, $state)"/>             <!-- ')' -->
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
        <xsl:when test="$state[$p:l1] = 65">                                        <!-- 'NOTATION' -->
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
        <xsl:when test="$state[$p:l1] = 57">                                        <!-- 'ID' -->
          <xsl:variable name="state" select="p:consume(57, $input, $state)"/>       <!-- 'ID' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 58">                                        <!-- 'IDREF' -->
          <xsl:variable name="state" select="p:consume(58, $input, $state)"/>       <!-- 'IDREF' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 59">                                        <!-- 'IDREFS' -->
          <xsl:variable name="state" select="p:consume(59, $input, $state)"/>       <!-- 'IDREFS' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 56">                                        <!-- 'ENTITY' -->
          <xsl:variable name="state" select="p:consume(56, $input, $state)"/>       <!-- 'ENTITY' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 55">                                        <!-- 'ENTITIES' -->
          <xsl:variable name="state" select="p:consume(55, $input, $state)"/>       <!-- 'ENTITIES' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 63">                                        <!-- 'NMTOKEN' -->
          <xsl:variable name="state" select="p:consume(63, $input, $state)"/>       <!-- 'NMTOKEN' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(64, $input, $state)"/>       <!-- 'NMTOKENS' -->
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
    <xsl:variable name="state" select="p:consume(53, $input, $state)"/>             <!-- 'CDATA' -->
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
    <xsl:variable name="state" select="p:lookahead1(78, $input, $state)"/>          <!-- '(' | 'CDATA' | 'ENTITIES' | 'ENTITY' | 'ID' | 'IDREF' | 'IDREFS' |
                                                                                         'NMTOKEN' | 'NMTOKENS' | 'NOTATION' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 53">                                        <!-- 'CDATA' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-StringType($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 33                                            (: '(' :)
                     or $state[$p:l1] = 65">                                        <!-- 'NOTATION' -->
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
    <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(4, $input, $state)"/>              <!-- Name -->
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
        <xsl:variable name="state" select="p:lookahead1(37, $input, $state)"/>      <!-- S | '>' -->
        <xsl:variable name="state" as="item()+">
          <xsl:choose>
            <xsl:when test="$state[$p:l1] eq 2">                                    <!-- S -->
              <xsl:variable name="state" select="p:lookahead2(44, $input, $state)"/> <!-- Name | '>' -->
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$state[$p:lk] != 514">                                    <!-- S Name -->
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
    <xsl:variable name="state" select="p:consume(42, $input, $state)"/>             <!-- '<!ATTLIST' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(4, $input, $state)"/>              <!-- Name -->
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
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(49, $input, $state)"/>             <!-- '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(43, $input, $state)"/>          <!-- Name | '(' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 4">                                         <!-- Name -->
          <xsl:variable name="state" select="p:consume(4, $input, $state)"/>        <!-- Name -->
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
    <xsl:variable name="state" select="p:lookahead1(75, $input, $state)"/>          <!-- S | ')' | '*' | '+' | ',' | '?' | '|' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 36                                            (: '*' :)
                     or $state[$p:l1] = 37                                            (: '+' :)
                     or $state[$p:l1] = 50">                                        <!-- '?' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 50">                                  <!-- '?' -->
                <xsl:variable name="state" select="p:consume(50, $input, $state)"/> <!-- '?' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 36">                                  <!-- '*' -->
                <xsl:variable name="state" select="p:consume(36, $input, $state)"/> <!-- '*' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="state" select="p:consume(37, $input, $state)"/> <!-- '+' -->
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
        <xsl:variable name="state" select="p:consume(72, $input, $state)"/>         <!-- '|' -->
        <xsl:variable name="state" select="p:lookahead1(53, $input, $state)"/>      <!-- S | Name | '(' -->
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
        <xsl:variable name="state" select="p:lookahead1(56, $input, $state)"/>      <!-- S | ')' | '|' -->
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
        <xsl:variable name="state" select="p:lookahead1(47, $input, $state)"/>      <!-- ')' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 72">                                     <!-- '|' -->
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
        <xsl:variable name="state" select="p:lookahead1(46, $input, $state)"/>      <!-- ')' | ',' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 38">                                     <!-- ',' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(38, $input, $state)"/>     <!-- ',' -->
            <xsl:variable name="state" select="p:lookahead1(53, $input, $state)"/>  <!-- S | Name | '(' -->
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
            <xsl:variable name="state" select="p:lookahead1(55, $input, $state)"/>  <!-- S | ')' | ',' -->
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
    <xsl:variable name="state" select="p:consume(33, $input, $state)"/>             <!-- '(' -->
    <xsl:variable name="state" select="p:lookahead1(53, $input, $state)"/>          <!-- S | Name | '(' -->
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
    <xsl:variable name="state" select="p:lookahead1(67, $input, $state)"/>          <!-- S | ')' | ',' | '|' -->
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
    <xsl:variable name="state" select="p:lookahead1(64, $input, $state)"/>          <!-- ')' | ',' | '|' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 72">                                        <!-- '|' -->
          <xsl:variable name="state" select="p:parse-choiceOrSeq-1($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:parse-choiceOrSeq-2($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:consume(34, $input, $state)"/>             <!-- ')' -->
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
    <xsl:variable name="state" select="p:lookahead1(69, $input, $state)"/>          <!-- S | '*' | '+' | '>' | '?' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] != 2                                            (: S :)
                    and $state[$p:l1] != 49">                                       <!-- '>' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 50">                                  <!-- '?' -->
                <xsl:variable name="state" select="p:consume(50, $input, $state)"/> <!-- '?' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 36">                                  <!-- '*' -->
                <xsl:variable name="state" select="p:consume(36, $input, $state)"/> <!-- '*' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="state" select="p:consume(37, $input, $state)"/> <!-- '+' -->
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
        <xsl:variable name="state" select="p:lookahead1(48, $input, $state)"/>      <!-- ')*' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 72">                                     <!-- '|' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(72, $input, $state)"/>     <!-- '|' -->
            <xsl:variable name="state" select="p:lookahead1(33, $input, $state)"/>  <!-- S | Name -->
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
            <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>   <!-- Name -->
            <xsl:variable name="state" select="p:consume(4, $input, $state)"/>      <!-- Name -->
            <xsl:variable name="state" select="p:lookahead1(57, $input, $state)"/>  <!-- S | ')*' | '|' -->
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
    <xsl:variable name="state" select="p:consume(33, $input, $state)"/>             <!-- '(' -->
    <xsl:variable name="state" select="p:lookahead1(35, $input, $state)"/>          <!-- S | '#PCDATA' -->
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
    <xsl:variable name="state" select="p:lookahead1(16, $input, $state)"/>          <!-- '#PCDATA' -->
    <xsl:variable name="state" select="p:consume(26, $input, $state)"/>             <!-- '#PCDATA' -->
    <xsl:variable name="state" select="p:lookahead1(66, $input, $state)"/>          <!-- S | ')' | ')*' | '|' -->
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
    <xsl:variable name="state" select="p:lookahead1(63, $input, $state)"/>          <!-- ')' | ')*' | '|' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 34">                                        <!-- ')' -->
          <xsl:variable name="state" select="p:consume(34, $input, $state)"/>       <!-- ')' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:parse-Mixed-1($input, $state)"/>
          <xsl:variable name="state" select="p:consume(35, $input, $state)"/>       <!-- ')*' -->
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
    <xsl:variable name="state" select="p:lookahead1(62, $input, $state)"/>          <!-- '(' | 'ANY' | 'EMPTY' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 33">                                       <!-- '(' -->
          <xsl:variable name="state" select="p:lookahead2(65, $input, $state)"/>    <!-- S | Name | '#PCDATA' | '(' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:lk] eq 289">                                <!-- '(' S -->
                <xsl:variable name="state" select="p:lookahead3(59, $input, $state)"/> <!-- Name | '#PCDATA' | '(' -->
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
        <xsl:when test="$state[$p:lk] = 54">                                        <!-- 'EMPTY' -->
          <xsl:variable name="state" select="p:consume(54, $input, $state)"/>       <!-- 'EMPTY' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 52">                                        <!-- 'ANY' -->
          <xsl:variable name="state" select="p:consume(52, $input, $state)"/>       <!-- 'ANY' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 3361                                          (: '(' '#PCDATA' :)
                     or $state[$p:lk] = 426273">                                    <!-- '(' S '#PCDATA' -->
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
    <xsl:variable name="state" select="p:consume(43, $input, $state)"/>             <!-- '<!ELEMENT' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(4, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" select="p:consume(2, $input, $state)"/>              <!-- S -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-contentspec($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(37, $input, $state)"/>          <!-- S | '>' -->
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
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- '>' -->
    <xsl:variable name="state" select="p:consume(49, $input, $state)"/>             <!-- '>' -->
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
        <xsl:when test="$state[$p:l1] = 43">                                        <!-- '<!ELEMENT' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-elementdecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 42">                                        <!-- '<!ATTLIST' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-AttlistDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 44">                                        <!-- '<!ENTITY' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EntityDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 45">                                        <!-- '<!NOTATION' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-NotationDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 15">                                        <!-- PIStart -->
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
        <xsl:variable name="state" select="p:lookahead1(77, $input, $state)"/>      <!-- EOF | S | PIStart | '<!-' '-' | '<!ATTLIST' | '<!ELEMENT' | '<!ENTITY' |
                                                                                         '<!NOTATION' | '<![' | ']]>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 1                                           (: EOF :)
                       or $state[$p:l1] = 69">                                      <!-- ']]>' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 46">                                <!-- '<![' -->
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
    <xsl:variable name="state" select="p:lookahead1(30, $input, $state)"/>          <!-- 'encoding' -->
    <xsl:variable name="state" select="p:consume(70, $input, $state)"/>             <!-- 'encoding' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-Eq($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(45, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 23">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(14, $input, $state)"/>    <!-- EncName -->
          <xsl:variable name="state" select="p:consume(21, $input, $state)"/>       <!-- EncName -->
          <xsl:variable name="state" select="p:lookahead1(15, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(14, $input, $state)"/>    <!-- EncName -->
          <xsl:variable name="state" select="p:consume(21, $input, $state)"/>       <!-- EncName -->
          <xsl:variable name="state" select="p:lookahead1(18, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
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
    <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>          <!-- S | '=' -->
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
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- '=' -->
    <xsl:variable name="state" select="p:consume(48, $input, $state)"/>             <!-- '=' -->
    <xsl:variable name="state" select="p:lookahead1(54, $input, $state)"/>          <!-- S | '"' | "'" -->
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
    <xsl:variable name="state" select="p:lookahead1(31, $input, $state)"/>          <!-- 'version' -->
    <xsl:variable name="state" select="p:consume(71, $input, $state)"/>             <!-- 'version' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-Eq($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(45, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 32">                                        <!-- "'" -->
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(11, $input, $state)"/>    <!-- VersionNum -->
          <xsl:variable name="state" select="p:consume(18, $input, $state)"/>       <!-- VersionNum -->
          <xsl:variable name="state" select="p:lookahead1(18, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(32, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(11, $input, $state)"/>    <!-- VersionNum -->
          <xsl:variable name="state" select="p:consume(18, $input, $state)"/>       <!-- VersionNum -->
          <xsl:variable name="state" select="p:lookahead1(15, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- '"' -->
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
    <xsl:variable name="state" select="p:consume(47, $input, $state)"/>             <!-- '<?xml' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- S -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 2">                                        <!-- S -->
          <xsl:variable name="state" select="p:lookahead2(52, $input, $state)"/>    <!-- 'encoding' | 'version' -->
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
        <xsl:when test="$state[$p:lk] = 9090">                                      <!-- S 'version' -->
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
    <xsl:variable name="state" select="p:lookahead1(38, $input, $state)"/>          <!-- S | '?>' -->
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
    <xsl:variable name="state" select="p:lookahead1(25, $input, $state)"/>          <!-- '?>' -->
    <xsl:variable name="state" select="p:consume(51, $input, $state)"/>             <!-- '?>' -->
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
    <xsl:variable name="state" select="p:lookahead1(76, $input, $state)"/>          <!-- EOF | S | PIStart | '<!-' '-' | '<!ATTLIST' | '<!ELEMENT' | '<!ENTITY' |
                                                                                         '<!NOTATION' | '<![' | '<?xml' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 47">                                        <!-- '<?xml' -->
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