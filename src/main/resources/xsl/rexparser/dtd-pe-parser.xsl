<?xml version="1.0" encoding="UTF-8"?>
<!-- This file was generated on Thu Jan 5, 2023 00:02 (UTC+01) by REx v5.55 which is Copyright (c) 1979-2022 by Gunther Rademacher <grd@gmx.net> -->
<!-- REx command line: DTD-param-entities.ebnf -xslt -tree -->

<xsl:stylesheet version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:p="http://www.nkutsche.com/dtd-pe-parser">
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
    53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 5, 5, 5, 5, 5, 9, 10, 5, 11, 12,
    11, 11, 11, 11, 11, 11, 11, 11, 13, 14, 15, 16, 17, 18, 5, 19, 20, 21, 22, 23, 20, 24, 25, 26, 25, 25, 27, 28, 29, 30, 25, 25, 31, 32, 33, 34, 25, 25, 25,
    35, 25, 36, 5, 37, 5, 38, 5, 20, 20, 39, 40, 41, 20, 42, 25, 43, 25, 25, 44, 45, 46, 47, 25, 25, 48, 49, 25, 25, 50, 25, 51, 25, 25, 5, 5, 5, 5, 5
  "/>

  <!--~
   ! The codepoint to charclass mapping for codepoints below the surrogate block.
  -->
  <xsl:variable name="p:MAP1" as="xs:integer+" select="
    108, 124, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 156, 181, 181, 181, 181, 181, 214, 215, 213, 214, 214, 214, 214, 214, 214,
    214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 247, 261, 277, 317, 333, 349, 365, 381, 300, 300, 300, 292, 439, 431, 439, 431,
    439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 408, 408, 408, 408, 408, 408, 408, 424, 439, 439, 439, 439, 439, 439, 439,
    439, 392, 300, 300, 301, 299, 300, 300, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 300, 300, 300, 300, 300,
    300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 438, 439, 439, 439,
    439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 439, 300, 53, 0,
    0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 5, 5, 5, 5, 5, 9, 10, 5, 5, 5, 5, 5, 5, 5, 52,
    5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 52, 11, 12, 11, 11, 11, 11, 11, 11, 11, 11, 13, 14, 15, 16, 17, 18, 5, 19, 20, 21, 22, 23, 20, 24, 25, 26,
    25, 25, 27, 28, 29, 30, 25, 25, 31, 32, 33, 34, 25, 25, 25, 35, 25, 36, 5, 37, 5, 38, 5, 20, 20, 39, 40, 41, 20, 42, 25, 43, 25, 25, 44, 45, 46, 47, 25, 25,
    48, 49, 25, 25, 50, 25, 51, 25, 25, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 13, 13, 5, 5, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 13,
    13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 5, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13
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
    1, 2, 1283, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40
  "/>

  <!--~
   ! The DFA transition table.
  -->
  <xsl:variable name="p:TRANSITION" as="xs:integer+" select="
    1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 864, 1487, 890, 934, 1516, 1223, 1935, 1935, 1935, 1935,
    1935, 1935, 1935, 1935, 1935, 1935, 950, 1662, 1860, 984, 1000, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1044, 1459, 1071, 1120,
    1516, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 950, 1662, 1860, 1136, 1516, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935,
    1935, 1935, 950, 1662, 1860, 934, 1516, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 950, 968, 1152, 1211, 1516, 1223, 1935, 1935,
    1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 950, 1662, 1246, 1284, 1516, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1312, 2183,
    1348, 1391, 1516, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1182, 1662, 1750, 1421, 1545, 1363, 1935, 1935, 1935, 1935, 1935, 1935,
    1935, 1935, 1935, 1935, 950, 1662, 1437, 934, 1545, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1475, 1662, 2028, 934, 1028, 1223,
    1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1503, 1662, 2028, 934, 1028, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935,
    1532, 1772, 1845, 1561, 1545, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1577, 1662, 1860, 934, 1918, 1223, 1935, 1935, 1935, 1935,
    1935, 1935, 1935, 1935, 1935, 1935, 1611, 2250, 1640, 1678, 2330, 1655, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1694, 1704, 1860, 934,
    1516, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 950, 1268, 1720, 1788, 1889, 1261, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935,
    1935, 1935, 1804, 1814, 1735, 934, 1830, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1905, 1772, 2028, 1561, 1545, 1765, 1935, 1934,
    1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1905, 1772, 2028, 1561, 1545, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1905, 1772,
    2028, 1561, 1624, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1905, 1772, 2028, 1561, 1545, 1223, 1595, 1935, 1935, 1935, 1935, 1935,
    1935, 1935, 1935, 1935, 1905, 1772, 2028, 1561, 1545, 1452, 1055, 2057, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1981, 1545, 1223,
    1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935,
    1952, 1997, 2013, 1561, 1545, 1223, 1936, 1375, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 1875, 2285, 1935, 1935, 1935,
    1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 1223, 2114, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 2079,
    2212, 2043, 1935, 1230, 2095, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 1167, 1935, 2096, 1935, 1935, 1935, 1935, 1935, 1935,
    1935, 1935, 1952, 1772, 2028, 1561, 1545, 1223, 2112, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 1223, 1935, 1332,
    1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 905, 1324, 874, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772,
    2028, 1561, 1545, 1223, 1591, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 1223, 1935, 2063, 1935, 1935, 1935, 1935,
    1935, 1935, 1935, 1935, 950, 2130, 1860, 934, 1195, 2176, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 2199, 2390, 2228, 2266, 2160, 2243,
    1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1532, 1772, 2028, 1561, 1545, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935,
    1905, 1772, 2028, 1561, 918, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1905, 1772, 2028, 1561, 1545, 1223, 2282, 1935, 1935, 1935,
    1935, 1935, 1935, 1935, 1935, 1935, 1905, 2145, 2028, 2301, 1545, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561,
    1545, 1223, 1935, 1095, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 1223, 2317, 1935, 1935, 1935, 1935, 1935, 1935, 1935,
    1935, 1935, 1952, 1772, 2028, 1561, 1545, 1223, 1104, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 1296, 1935, 1935,
    1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 2346, 1545, 1223, 1935, 2362, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772,
    2028, 1561, 1545, 1086, 2367, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1965, 1223, 1935, 1935, 1935, 1935, 1935, 1935,
    1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 1015, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1405, 2028, 1561, 1545, 1223,
    1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1952, 1772, 2028, 1561, 1545, 2383, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935,
    950, 1662, 1845, 934, 1545, 1223, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 1935, 960, 1935, 1935, 1935, 1935, 1935, 1935, 1935,
    1935, 1935, 1935, 1935, 1935, 1935, 769, 0, 1283, 43, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 124, 125, 0, 0, 0, 0, 0, 7168, 7424, 0, 48, 769, 4155, 4155,
    4414, 4672, 769, 769, 0, 1283, 43, 0, 0, 0, 0, 48, 0, 0, 0, 0, 48, 48, 0, 0, 0, 0, 0, 101, 0, 0, 0, 43, 0, 48, 48, 48, 48, 0, 0, 89, 0, 78, 0, 48, 48, 48,
    0, 0, 0, 0, 0, 0, 0, 48, 4155, 0, 48, 4414, 0, 4672, 0, 0, 1283, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 512, 512, 0, 0, 0, 0, 0, 0, 0, 0, 56, 48, 0, 56,
    56, 0, 56, 56, 72, 48, 0, 0, 0, 0, 0, 0, 0, 48, 4155, 0, 81, 4414, 0, 4672, 83, 83, 0, 43, 0, 86, 48, 48, 48, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 48, 48, 0,
    0, 99, 0, 0, 0, 0, 0, 0, 43, 2373, 48, 48, 48, 48, 0, 0, 0, 0, 78, 0, 48, 0, 0, 1283, 0, 0, 0, 0, 0, 0, 48, 4864, 0, 0, 0, 0, 0, 111, 0, 0, 0, 9472, 0, 0,
    0, 0, 0, 0, 48, 0, 4864, 4864, 4864, 4672, 0, 0, 0, 1283, 43, 0, 0, 0, 0, 48, 0, 0, 0, 0, 48, 48, 0, 98, 0, 0, 0, 0, 0, 0, 0, 0, 10496, 0, 0, 0, 0, 0, 0, 0,
    0, 8448, 0, 0, 0, 0, 0, 0, 0, 48, 48, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 48, 0, 0, 4672, 48, 48, 0, 0, 0, 0, 0, 0, 0, 48, 4155, 0, 48, 4414, 5714, 4672, 48, 56,
    56, 5120, 3384, 3384, 56, 56, 0, 1283, 43, 0, 0, 0, 0, 48, 0, 0, 0, 0, 48, 48, 97, 0, 0, 0, 0, 0, 0, 104, 0, 0, 42, 0, 0, 0, 0, 0, 0, 48, 0, 0, 51, 0, 0, 0,
    43, 0, 48, 48, 0, 48, 0, 0, 0, 0, 0, 0, 48, 48, 48, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 48, 0, 0, 0, 0, 48, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0,
    48, 0, 4155, 4155, 5439, 5439, 0, 0, 0, 1283, 43, 0, 0, 0, 0, 48, 0, 0, 0, 10240, 48, 52992, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 8960, 0, 48, 48, 0,
    0, 0, 0, 0, 0, 0, 48, 4155, 0, 48, 0, 0, 0, 0, 48, 48, 0, 0, 0, 0, 0, 0, 0, 0, 105, 0, 0, 1283, 0, 0, 0, 0, 0, 0, 48, 0, 6144, 0, 0, 0, 0, 110, 0, 112, 113,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 126, 0, 0, 0, 0, 0, 0, 48, 0, 6144, 6144, 4414, 6144, 0, 0, 0, 1283, 43, 0, 0, 0, 0, 48, 0, 92, 0, 0, 48, 48, 0, 0, 0, 0, 6912,
    0, 0, 0, 0, 122, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 48, 48, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 48, 4414, 0, 0, 0, 55, 0, 0, 0, 0, 0, 48, 0, 1065, 0, 0, 4155, 0,
    48, 48, 74, 0, 0, 0, 0, 0, 0, 48, 4155, 0, 48, 4414, 0, 4672, 48, 0, 4155, 4155, 4414, 4672, 0, 0, 1065, 1283, 43, 0, 2093, 69, 3631, 48, 0, 94, 0, 0, 48,
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 4864, 0, 0, 4864, 0, 0, 0, 0, 1283, 0, 0, 0, 2567, 2824, 0, 48, 0, 0, 0, 0, 0, 0, 769, 769, 769, 769, 0, 48, 0, 769, 769,
    769, 4155, 0, 0, 0, 1283, 0, 0, 46, 2567, 2824, 0, 48, 0, 0, 0, 0, 0, 0, 43, 0, 48, 48, 48, 48, 0, 0, 0, 0, 0, 0, 48, 0, 1065, 1283, 0, 2093, 0, 0, 0, 0,
    48, 0, 0, 0, 0, 0, 0, 43, 0, 48, 48, 48, 48, 0, 0, 0, 0, 78, 0, 48, 48, 48, 0, 0, 0, 0, 0, 78, 0, 48, 4155, 0, 48, 4414, 0, 4672, 0, 0, 1283, 0, 0, 0, 0, 0,
    0, 48, 0, 0, 0, 6656, 0, 0, 0, 109, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 116, 0, 0, 0, 0, 0, 1283, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 43, 0, 48, 48, 48,
    48, 0, 0, 0, 0, 78, 91, 48, 61, 0, 4155, 4155, 4414, 4672, 65, 66, 0, 1283, 43, 0, 0, 0, 0, 70, 0, 0, 0, 0, 70, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0,
    0, 4155, 0, 70, 70, 0, 0, 0, 0, 0, 0, 0, 70, 4155, 0, 70, 4414, 0, 4672, 0, 0, 1283, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 8704, 0, 0, 0, 0, 48, 0, 0, 0, 0,
    4155, 0, 48, 0, 8960, 8960, 4414, 4672, 0, 0, 0, 1283, 43, 1792, 0, 0, 0, 48, 0, 4155, 4155, 4414, 4672, 0, 0, 0, 1283, 68, 0, 0, 0, 0, 48, 0, 4155, 4155,
    4414, 4672, 0, 0, 1065, 0, 43, 0, 2093, 0, 3631, 48, 0, 93, 0, 0, 48, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 0, 1065, 0, 0, 4155, 0, 48, 48, 0, 9216, 0, 0, 0,
    0, 0, 48, 0, 0, 48, 4414, 0, 4672, 0, 0, 1283, 44, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 52, 0, 0, 0, 48, 0, 0, 0, 0, 4155, 0, 1620, 1536, 0, 68, 0, 48, 48, 48,
    48, 0, 0, 0, 0, 0, 0, 48, 0, 4155, 4155, 4414, 4672, 0, 0, 1065, 1283, 43, 0, 2093, 0, 0, 48, 0, 4155, 4155, 4414, 4672, 0, 0, 0, 1283, 43, 0, 0, 0, 0, 48,
    0, 0, 0, 0, 48, 48, 0, 0, 0, 100, 0, 0, 102, 0, 0, 0, 1792, 0, 48, 48, 48, 0, 6400, 0, 0, 0, 0, 0, 10240, 0, 1065, 1283, 0, 2093, 0, 0, 2824, 3631, 48, 0,
    0, 0, 0, 0, 0, 43, 0, 48, 48, 48, 48, 0, 0, 0, 0, 3072, 0, 48, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 119, 0, 1065, 1283, 0, 2093, 0, 0, 0,
    3631, 48, 0, 0, 0, 0, 0, 0, 43, 0, 48, 48, 48, 48, 0, 0, 0, 90, 78, 0, 48, 48, 48, 0, 0, 75, 0, 0, 78, 0, 48, 4155, 75, 48, 4414, 0, 4672, 53, 0, 0, 0, 0,
    0, 53, 0, 57, 48, 0, 1065, 57, 0, 4155, 60, 48, 60, 4155, 4155, 4414, 4672, 0, 0, 1065, 1283, 43, 0, 2093, 0, 3631, 48, 0, 4155, 4155, 4414, 4672, 0, 0,
    1065, 1283, 43, 0, 2093, 0, 3631, 48, 0, 95, 0, 0, 48, 48, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 9728, 0, 123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7680, 0, 0, 0, 0,
    48, 48, 0, 0, 0, 0, 0, 78, 79, 48, 4155, 79, 48, 4414, 0, 4672, 7936, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 129, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 118, 0, 0, 9984, 0, 0, 0, 0, 0, 9984, 0, 48, 0, 0, 0, 0, 4155, 0, 0, 54, 0, 0, 0, 0, 0, 0, 48, 0, 1065, 0, 0, 4155, 0, 0, 85, 43, 0, 71, 87,
    71, 87, 0, 0, 0, 0, 0, 0, 87, 8192, 0, 8192, 0, 0, 52992, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 6144, 0, 0, 6144, 0, 0, 0, 0, 1283, 0, 0, 0, 0, 0, 0, 50, 0, 0,
    0, 0, 0, 0, 43, 0, 48, 48, 48, 48, 0, 88, 0, 0, 78, 0, 48, 58, 0, 4155, 4155, 4414, 4672, 0, 67, 0, 1283, 43, 0, 0, 0, 0, 71, 0, 0, 0, 0, 71, 87, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 4155, 0, 71, 73, 0, 0, 0, 0, 0, 0, 0, 80, 4155, 0, 71, 4414, 0, 4672, 0, 107, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    117, 0, 0, 48, 48, 0, 0, 0, 0, 77, 78, 0, 48, 4155, 0, 48, 4414, 0, 4672, 0, 0, 108, 0, 0, 0, 0, 0, 0, 0, 114, 0, 0, 0, 0, 0, 43, 0, 70, 70, 70, 70, 0, 0,
    0, 0, 0, 0, 70, 48, 48, 0, 0, 0, 76, 0, 78, 0, 48, 4155, 0, 48, 4414, 0, 4672, 0, 121, 10752, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 115, 0, 0, 0, 0, 48,
    5888, 0, 96, 0, 48, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 4155, 0
  "/>

  <!--~
   ! The DFA-state to expected-token-set mapping.
  -->
  <xsl:variable name="p:EXPECTED" as="xs:integer+" select="
    65, 70, 101, 74, 148, 171, 87, 84, 91, 95, 66, 99, 129, 186, 137, 105, 109, 127, 130, 121, 134, 123, 198, 145, 148, 154, 148, 153, 147, 154, 153, 158, 147,
    148, 148, 149, 164, 162, 112, 80, 168, 174, 191, 148, 148, 180, 115, 185, 176, 148, 192, 78, 191, 190, 181, 148, 141, 197, 140, 196, 76, 197, 118, 148, 148,
    4, 8, 16, 64, 64, 128, 256, 512, 1024, 16777216, 33554432, 0, 0, 256, 512, 0, 32, 0, 4, 2052, 8650756, 34816, 2048, 16384, 8650752, 2060, -2147467264, 2052,
    8685568, 9207808, 7673856, 15865856, -67106778, -67106778, 128, 256, 8192, 16384, 262144, 8388608, -2147467264, 65536, 6291456, 131072, -67108832,
    -67108832, 0, 64, 32, 128, 0, 32, 128, 0, 256, 0, 0, 2048, 0, 16384, 16384, 0, 256, 16384, 16384, 16384, 16777216, 0, 0, -2147467264, 4194304, -67108864, 0,
    16384, 32768, 0, 1, 16, 256, 512, 134217728, 805306368, 1073741824, 0, 0, 0, 0, 2, 0, 134217728, 268435456, 536870912, 1073741824, 1073741824, 134217728,
    268435456, 1073741824, 512, 2, 8, 16, 64, 256, 48, 128, 48, 4, 4, 4, 4, 0, 0, 1, 0, 128, 8, 16, 256, 512, 32, 48, 0, 0, 0, 2048, 1, 128, 0, 0, 0, 16, 512,
    32, 0, 0, 0, 67108864
  "/>

  <!--~
   ! The token-string table.
  -->
  <xsl:variable name="p:TOKEN" as="xs:string+" select="
    '(0)',
    'EOF',
    'S',
    'Name',
    'CommentContent',
    &quot;'&lt;?'&quot;,
    'PIContentEnd',
    'PITarget',
    'VersionNum',
    'CharRefDec',
    'CharRefHex',
    'PEReference',
    &quot;'%'&quot;,
    'EncName',
    'Ignore',
    'declContent',
    'QuotedValueDouble',
    'QuotedValueSingle',
    &quot;'&quot;&quot;'&quot;,
    &quot;'%'&quot;,
    &quot;'&amp;'&quot;,
    &quot;'&amp;#'&quot;,
    &quot;'&amp;#x'&quot;,
    &quot;''''&quot;,
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
    &quot;'?&gt;'&quot;,
    &quot;'IGNORE'&quot;,
    &quot;'INCLUDE'&quot;,
    &quot;'['&quot;,
    &quot;']]&gt;'&quot;,
    &quot;'encoding'&quot;,
    &quot;'version'&quot;
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
        <xsl:variable name="end" select="$end - $result idiv 64"/>
        <xsl:variable name="end" select="if ($end gt string-length($input)) then string-length($input) + 1 else $end"/>
        <xsl:sequence select="
          if ($result ne 0) then
          (
            $result mod 64 - 1,
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
      <xsl:for-each select="0 to 1">
        <xsl:variable name="i0" select=". * 129 + $state - 1"/>
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
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 11">                                        <!-- PEReference -->
          <xsl:variable name="state" select="p:consume(11, $input, $state)"/>       <!-- PEReference -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
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
        <xsl:variable name="state" select="p:lookahead1(32, $input, $state)"/>      <!-- Ignore | '<![' | ']]>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 31">                                     <!-- '<![' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(31, $input, $state)"/>     <!-- '<![' -->
            <xsl:variable name="state" select="
              if ($state[$p:error]) then
                $state
              else
                p:parse-ignoreSectContents($input, $state)
            "/>
            <xsl:variable name="state" select="p:consume(39, $input, $state)"/>     <!-- ']]>' -->
            <xsl:variable name="state" select="p:lookahead1(9, $input, $state)"/>   <!-- Ignore -->
            <xsl:variable name="state" select="p:consume(14, $input, $state)"/>     <!-- Ignore -->
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
    <xsl:variable name="state" select="p:lookahead1(9, $input, $state)"/>           <!-- Ignore -->
    <xsl:variable name="state" select="p:consume(14, $input, $state)"/>             <!-- Ignore -->
    <xsl:variable name="state" select="p:parse-ignoreSectContents-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'ignoreSectContents', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production ignoreSect (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-ignoreSect-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(25, $input, $state)"/>      <!-- Ignore | ']]>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 14">                                     <!-- Ignore -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="
              if ($state[$p:error]) then
                $state
              else
                p:parse-ignoreSectContents($input, $state)
            "/>
            <xsl:sequence select="p:parse-ignoreSect-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
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
    <xsl:variable name="state" select="p:consume(31, $input, $state)"/>             <!-- '<![' -->
    <xsl:variable name="state" select="p:lookahead1(22, $input, $state)"/>          <!-- S | 'IGNORE' -->
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
    <xsl:variable name="state" select="p:lookahead1(16, $input, $state)"/>          <!-- 'IGNORE' -->
    <xsl:variable name="state" select="p:consume(36, $input, $state)"/>             <!-- 'IGNORE' -->
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- S | '[' -->
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
    <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>          <!-- '[' -->
    <xsl:variable name="state" select="p:consume(38, $input, $state)"/>             <!-- '[' -->
    <xsl:variable name="state" select="p:parse-ignoreSect-1($input, $state)"/>
    <xsl:variable name="state" select="p:consume(39, $input, $state)"/>             <!-- ']]>' -->
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
    <xsl:variable name="state" select="p:consume(31, $input, $state)"/>             <!-- '<![' -->
    <xsl:variable name="state" select="p:lookahead1(28, $input, $state)"/>          <!-- S | PEReference | 'INCLUDE' -->
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
    <xsl:variable name="state" select="p:lookahead1(24, $input, $state)"/>          <!-- PEReference | 'INCLUDE' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 37">                                        <!-- 'INCLUDE' -->
          <xsl:variable name="state" select="p:consume(37, $input, $state)"/>       <!-- 'INCLUDE' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(11, $input, $state)"/>       <!-- PEReference -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(23, $input, $state)"/>          <!-- S | '[' -->
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
    <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>          <!-- '[' -->
    <xsl:variable name="state" select="p:consume(38, $input, $state)"/>             <!-- '[' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-extSubsetDecl($input, $state)
    "/>
    <xsl:variable name="state" select="p:consume(39, $input, $state)"/>             <!-- ']]>' -->
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
        <xsl:when test="$state[$p:l1] eq 31">                                       <!-- '<![' -->
          <xsl:variable name="state" select="p:lookahead2(33, $input, $state)"/>    <!-- S | PEReference | 'IGNORE' | 'INCLUDE' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:lk] eq 159">                                <!-- '<![' S -->
                <xsl:variable name="state" select="p:lookahead3(31, $input, $state)"/> <!-- PEReference | 'IGNORE' | 'INCLUDE' -->
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
        <xsl:when test="$state[$p:lk] = 2335                                          (: '&lt;![' 'IGNORE' :)
                     or $state[$p:lk] = 147615">                                    <!-- '<![' S 'IGNORE' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-ignoreSect($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-includeSect($input, $state)
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
    <xsl:variable name="state" select="p:consume(26, $input, $state)"/>             <!-- '<!-' '-' -->
    <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>           <!-- CommentContent -->
    <xsl:variable name="state" select="p:consume(4, $input, $state)"/>              <!-- CommentContent -->
    <xsl:variable name="state" select="p:lookahead1(12, $input, $state)"/>          <!-- '-' '->' -->
    <xsl:variable name="state" select="p:consume(24, $input, $state)"/>             <!-- '-' '->' -->
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
    <xsl:variable name="state" select="p:consume(5, $input, $state)"/>              <!-- PIStart -->
    <xsl:variable name="state" select="p:lookahead1(4, $input, $state)"/>           <!-- PITarget -->
    <xsl:variable name="state" select="p:consume(7, $input, $state)"/>              <!-- PITarget -->
    <xsl:variable name="state" select="p:lookahead1(3, $input, $state)"/>           <!-- PIContentEnd -->
    <xsl:variable name="state" select="p:consume(6, $input, $state)"/>              <!-- PIContentEnd -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'PI', $count, $begin, $end)"/>
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
    <xsl:variable name="state" select="p:consume(30, $input, $state)"/>             <!-- '<!NOTATION' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-declContentWQuotes($input, $state)
    "/>
    <xsl:variable name="state" select="p:consume(34, $input, $state)"/>             <!-- '>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'NotationDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse PercentInEntityDecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-PercentInEntityDecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(19, $input, $state)"/>             <!-- '%' -->
    <xsl:variable name="state" select="p:lookahead1(27, $input, $state)"/>          <!-- S | Name | PEReference -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 3">                                         <!-- Name -->
          <xsl:variable name="state" select="p:consume(3, $input, $state)"/>        <!-- Name -->
          <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>    <!-- ';' -->
          <xsl:variable name="state" select="p:consume(25, $input, $state)"/>       <!-- ';' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 2">                                         <!-- S -->
          <xsl:variable name="state" select="p:consume(2, $input, $state)"/>        <!-- S -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(11, $input, $state)"/>       <!-- PEReference -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'PercentInEntityDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production EntityDecl (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-EntityDecl-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(35, $input, $state)"/>      <!-- declContent | '"' | '%' | "'" | '>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 34">                                      <!-- '>' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 19">                                <!-- '%' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-PercentInEntityDecl($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 15">                                <!-- declContent -->
                  <xsl:variable name="state" select="p:consume(15, $input, $state)"/> <!-- declContent -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-quotedDeclContent($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-EntityDecl-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
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
    <xsl:variable name="state" select="p:consume(29, $input, $state)"/>             <!-- '<!ENTITY' -->
    <xsl:variable name="state" select="p:parse-EntityDecl-1($input, $state)"/>
    <xsl:variable name="state" select="p:consume(34, $input, $state)"/>             <!-- '>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'EntityDecl', $count, $begin, $end)"/>
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
        <xsl:when test="$state[$p:l1] = 21">                                        <!-- '&#' -->
          <xsl:variable name="state" select="p:consume(21, $input, $state)"/>       <!-- '&#' -->
          <xsl:variable name="state" select="p:lookahead1(6, $input, $state)"/>     <!-- CharRefDec -->
          <xsl:variable name="state" select="p:consume(9, $input, $state)"/>        <!-- CharRefDec -->
          <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>    <!-- ';' -->
          <xsl:variable name="state" select="p:consume(25, $input, $state)"/>       <!-- ';' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(22, $input, $state)"/>       <!-- '&#x' -->
          <xsl:variable name="state" select="p:lookahead1(7, $input, $state)"/>     <!-- CharRefHex -->
          <xsl:variable name="state" select="p:consume(10, $input, $state)"/>       <!-- CharRefHex -->
          <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>    <!-- ';' -->
          <xsl:variable name="state" select="p:consume(25, $input, $state)"/>       <!-- ';' -->
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
    <xsl:variable name="state" select="p:consume(20, $input, $state)"/>             <!-- '&' -->
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- Name -->
    <xsl:variable name="state" select="p:consume(3, $input, $state)"/>              <!-- Name -->
    <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>          <!-- ';' -->
    <xsl:variable name="state" select="p:consume(25, $input, $state)"/>             <!-- ';' -->
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
        <xsl:when test="$state[$p:l1] = 20">                                        <!-- '&' -->
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
   ! Parse the 1st loop of production quotedDeclContent (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-quotedDeclContent-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(36, $input, $state)"/>      <!-- PEReference | PercentInQuote | QuotedValueDouble | '"' | '&' | '&#' |
                                                                                         '&#x' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 18">                                      <!-- '"' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 16">                                <!-- QuotedValueDouble -->
                  <xsl:variable name="state" select="p:consume(16, $input, $state)"/> <!-- QuotedValueDouble -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 11">                                <!-- PEReference -->
                  <xsl:variable name="state" select="p:consume(11, $input, $state)"/> <!-- PEReference -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 12">                                <!-- PercentInQuote -->
                  <xsl:variable name="state" select="p:consume(12, $input, $state)"/> <!-- PercentInQuote -->
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
            <xsl:sequence select="p:parse-quotedDeclContent-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 2nd loop of production quotedDeclContent (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-quotedDeclContent-2">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(37, $input, $state)"/>      <!-- PEReference | PercentInQuote | QuotedValueSingle | '&' | '&#' | '&#x' |
                                                                                         "'" -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 23">                                      <!-- "'" -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 17">                                <!-- QuotedValueSingle -->
                  <xsl:variable name="state" select="p:consume(17, $input, $state)"/> <!-- QuotedValueSingle -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 11">                                <!-- PEReference -->
                  <xsl:variable name="state" select="p:consume(11, $input, $state)"/> <!-- PEReference -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 12">                                <!-- PercentInQuote -->
                  <xsl:variable name="state" select="p:consume(12, $input, $state)"/> <!-- PercentInQuote -->
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
            <xsl:sequence select="p:parse-quotedDeclContent-2($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse quotedDeclContent.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-quotedDeclContent" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 18">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(18, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:parse-quotedDeclContent-1($input, $state)"/>
          <xsl:variable name="state" select="p:consume(18, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:parse-quotedDeclContent-2($input, $state)"/>
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'quotedDeclContent', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production declContentWQuotes (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-declContentWQuotes-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(34, $input, $state)"/>      <!-- PEReference | declContent | '"' | "'" | '>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 34">                                      <!-- '>' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 15">                                <!-- declContent -->
                  <xsl:variable name="state" select="p:consume(15, $input, $state)"/> <!-- declContent -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 11">                                <!-- PEReference -->
                  <xsl:variable name="state" select="p:consume(11, $input, $state)"/> <!-- PEReference -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-quotedDeclContent($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-declContentWQuotes-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse declContentWQuotes.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-declContentWQuotes" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:parse-declContentWQuotes-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'declContentWQuotes', $count, $begin, $end)"/>
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
    <xsl:variable name="state" select="p:consume(27, $input, $state)"/>             <!-- '<!ATTLIST' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-declContentWQuotes($input, $state)
    "/>
    <xsl:variable name="state" select="p:consume(34, $input, $state)"/>             <!-- '>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'AttlistDecl', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production Elementdecl (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-Elementdecl-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(30, $input, $state)"/>      <!-- PEReference | declContent | '>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 34">                                      <!-- '>' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 15">                                <!-- declContent -->
                  <xsl:variable name="state" select="p:consume(15, $input, $state)"/> <!-- declContent -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="state" select="p:consume(11, $input, $state)"/> <!-- PEReference -->
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-Elementdecl-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse Elementdecl.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-Elementdecl" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(28, $input, $state)"/>             <!-- '<!ELEMENT' -->
    <xsl:variable name="state" select="p:parse-Elementdecl-1($input, $state)"/>
    <xsl:variable name="state" select="p:consume(34, $input, $state)"/>             <!-- '>' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'Elementdecl', $count, $begin, $end)"/>
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
        <xsl:when test="$state[$p:l1] = 28">                                        <!-- '<!ELEMENT' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-Elementdecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 27">                                        <!-- '<!ATTLIST' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-AttlistDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 29">                                        <!-- '<!ENTITY' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-EntityDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 30">                                        <!-- '<!NOTATION' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-NotationDecl($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 5">                                         <!-- PIStart -->
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
        <xsl:variable name="state" select="p:lookahead1(39, $input, $state)"/>      <!-- EOF | S | PIStart | PEReference | '<!-' '-' | '<!ATTLIST' | '<!ELEMENT' |
                                                                                         '<!ENTITY' | '<!NOTATION' | '<![' | ']]>' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 1                                           (: EOF :)
                       or $state[$p:l1] = 39">                                      <!-- ']]>' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 31">                                <!-- '<![' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-conditionalSect($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 2                                     (: S :)
                             or $state[$p:l1] = 11">                                <!-- PEReference -->
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
    <xsl:variable name="state" select="p:lookahead1(18, $input, $state)"/>          <!-- 'encoding' -->
    <xsl:variable name="state" select="p:consume(40, $input, $state)"/>             <!-- 'encoding' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-Eq($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(26, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 18">                                        <!-- '"' -->
          <xsl:variable name="state" select="p:consume(18, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(8, $input, $state)"/>     <!-- EncName -->
          <xsl:variable name="state" select="p:consume(13, $input, $state)"/>       <!-- EncName -->
          <xsl:variable name="state" select="p:lookahead1(10, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(18, $input, $state)"/>       <!-- '"' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(8, $input, $state)"/>     <!-- EncName -->
          <xsl:variable name="state" select="p:consume(13, $input, $state)"/>       <!-- EncName -->
          <xsl:variable name="state" select="p:lookahead1(11, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- "'" -->
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
    <xsl:variable name="state" select="p:lookahead1(20, $input, $state)"/>          <!-- S | '=' -->
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
    <xsl:variable name="state" select="p:consume(33, $input, $state)"/>             <!-- '=' -->
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
    <xsl:variable name="state" select="p:lookahead1(19, $input, $state)"/>          <!-- 'version' -->
    <xsl:variable name="state" select="p:consume(41, $input, $state)"/>             <!-- 'version' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-Eq($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(26, $input, $state)"/>          <!-- '"' | "'" -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 23">                                        <!-- "'" -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- "'" -->
          <xsl:variable name="state" select="p:lookahead1(5, $input, $state)"/>     <!-- VersionNum -->
          <xsl:variable name="state" select="p:consume(8, $input, $state)"/>        <!-- VersionNum -->
          <xsl:variable name="state" select="p:lookahead1(11, $input, $state)"/>    <!-- "'" -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- "'" -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(18, $input, $state)"/>       <!-- '"' -->
          <xsl:variable name="state" select="p:lookahead1(5, $input, $state)"/>     <!-- VersionNum -->
          <xsl:variable name="state" select="p:consume(8, $input, $state)"/>        <!-- VersionNum -->
          <xsl:variable name="state" select="p:lookahead1(10, $input, $state)"/>    <!-- '"' -->
          <xsl:variable name="state" select="p:consume(18, $input, $state)"/>       <!-- '"' -->
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
    <xsl:variable name="state" select="p:consume(32, $input, $state)"/>             <!-- '<?xml' -->
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-VersionInfo($input, $state)
    "/>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-EncodingDecl($input, $state)
    "/>
    <xsl:variable name="state" select="p:lookahead1(21, $input, $state)"/>          <!-- S | '?>' -->
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
    <xsl:variable name="state" select="p:lookahead1(15, $input, $state)"/>          <!-- '?>' -->
    <xsl:variable name="state" select="p:consume(35, $input, $state)"/>             <!-- '?>' -->
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
    <xsl:variable name="state" select="p:lookahead1(38, $input, $state)"/>          <!-- EOF | S | PIStart | PEReference | '<!-' '-' | '<!ATTLIST' | '<!ELEMENT' |
                                                                                         '<!ENTITY' | '<!NOTATION' | '<![' | '<?xml' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 32">                                        <!-- '<?xml' -->
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
      $match[1] * 64 + $state[$p:l1],
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
      $match[1] * 4096 + $state[$p:lk],
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