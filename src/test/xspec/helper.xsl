<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mlml="http://www.nkutsche.com/xmlml" 
    xmlns:mlmlt="http://www.nkutsche.com/xmlml/tester" 
    xmlns:mlmlp="http://www.nkutsche.com/xmlml/xpath"  
    xmlns:mlmlpt="http://www.nkutsche.com/xmlml/xpath/tester"  
    xmlns:xpe="http://www.nkutsche.com/xpath-model/engine"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    
    <xsl:function name="mlmlt:xmlml-ignore-doc-meta" as="element(mlml:document)">
        <xsl:param name="doc" as="element(mlml:document)"/>
        <xsl:variable name="base-uri" select="'http://www.nkutsche.com/xmlml/sample-base/'"/>
        <xsl:copy select="$doc">
            <xsl:sequence select="@*"/>
            <xsl:attribute name="id" select="'...'"/>
            <xsl:if test="@xml:base">
                <xsl:attribute name="xml:base" select="'...'"/>
            </xsl:if>
            <xsl:if test="@document-uri">
                <xsl:attribute name="document-uri" select="'...'"/>
            </xsl:if>
            <xsl:sequence select="node()"/>
        </xsl:copy>
        
    </xsl:function>
    
</xsl:stylesheet>