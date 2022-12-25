<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xsl:import href="rexparser/xml-parser.xsl"/>
    <xsl:import href="rexparser/xml-fragment-parser.xsl"/>
    <xsl:import href="rexparser/dtd-parser.xsl"/>
    <xsl:import href="rexparser/dtd-pe-parser.xsl"/>
    <xsl:import href="xmlml-lib.xsl"/>
    <xsl:import href="xmlml-parser.xsl"/>
    <xsl:import href="xmlml-parser-dtd.xsl"/>
    <xsl:import href="xmlml-serializer.xsl"/>
    <xsl:import href="xmlml-model.xsl"/>
</xsl:stylesheet>