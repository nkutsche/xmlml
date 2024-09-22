<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    xmlns:mlmlp="http://www.nkutsche.com/xmlml/xpath"
    xmlns="http://www.nkutsche.com/xmlml"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:use-package name="http://www.nkutsche.com/xmlml" package-version="*"/>
    <xsl:use-package name="http://www.nkutsche.com/xmlml/xpath" package-version="*"/>
    
    <xsl:output method="xml"/>
    
    <xsl:variable name="xmlml" select="mlml:parse(resolve-uri('xml/asterix-dtd.xml'))"/>
    
    <xsl:template name="xsl:initial-template">
        
        <xsl:variable name="xmlml_manipulated">
            <xsl:apply-templates select="$xmlml" mode="manipulation"/>
        </xsl:variable>
        
        <xsl:variable name="serialized" select="$xmlml => mlml:serialize()"/>
        
        <xsl:sequence select="$xmlml"/>
        
        <xsl:result-document href="roundtripped-sample.xml" method="text">
            <xsl:value-of select="$serialized"/>
        </xsl:result-document>

        <xsl:result-document href="manipulated-sample.xml" method="text">
            <xsl:value-of select="$xmlml_manipulated/* => mlml:serialize()"/>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:mode name="manipulation" on-no-match="shallow-copy"/>
    
<!--    
    Deletes all character elements that has no xml:id attribute
    -->
    
    <xsl:variable name="no_id_characters" select="mlmlp:xpath-evaluate($xmlml, '//character[not(@xml:id)]')"/>
    
    <xsl:template match="$no_id_characters" mode="manipulation"/>
    
<!--    
    Resolves the entity &r; to the replacement
    -->
    <xsl:template match="mlml:entity[@name = 'r']" mode="manipulation">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
</xsl:stylesheet>