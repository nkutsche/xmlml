<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:dml="http://www.nkutsche.com/xmlml"
    xmlns:p="http://www.nkutsche.com/xml-parser"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xsl:import href="../../../main/resource/xsl/xmlml-parser.xsl"/>
    

    <xsl:variable name="input" select="'entity/recursive-dtd-entity.xml'"/>
    
    <xsl:template match="/">
        <xsl:variable name="xml" select="'xml/' || $input"/>
        <xsl:variable name="xmlml" select="'xmlml/' || $input"/>
        
        <xsl:variable name="unparsed" select="resolve-uri($xml, static-base-uri())"/>
        <xsl:variable name="expectedXmlml" select="doc($xmlml)"/>
        
        <result>
            <xmlml>
                <xsl:sequence select="dml:parse($unparsed)"/>
            </xmlml>
            <raw>
                <xsl:sequence select="p:parse-document(unparsed-text($unparsed))"/>
            </raw>
            <!--<expectedXmlml>
                <xsl:sequence select="$expectedXmlml"/>
            </expectedXmlml>-->
        </result>
    </xsl:template>
        
    
    
</xsl:stylesheet>