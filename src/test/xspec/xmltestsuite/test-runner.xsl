<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <!--<xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 11, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> Nico</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>-->
    <xsl:import href="http://www.nkutsche.com/xmlml/xmlml-main.xsl"/>
    
    <xsl:function name="mlml:parse-and-serialize" as="xs:string">
        <xsl:param name="src" as="xs:string"/>
        <xsl:variable name="xmlml" select="mlml:parse($src)"/>
        <xsl:variable name="serialized" select="mlml:serialize($xmlml)"/>
        <xsl:sequence select="$serialized"/>
    </xsl:function>
    
</xsl:stylesheet>