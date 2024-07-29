<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    xmlns:mlmlp="http://www.nkutsche.com/xmlml/xpath"
    xmlns:err="http://www.w3.org/2005/xqt-errors"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:import href="../../src/main/resources/xsl/xmlml-main.xsl"/>
    
    <xsl:use-package name="http://maxtoroq.github.io/rng-xsl" package-version="*"/>
    <xsl:use-package name="http://www.nkutsche.com/xmlml/xpath" package-version="*"/>
    
    <xsl:param name="xpath" as="xs:string" select="string-join(/*/*, ',')"/>
    <xsl:variable name="path" select="resolve-uri('asterix-dtd.xml')"/>
    
    <xsl:output method="text"/>
    
    <xsl:template name="xsl:initial-template">
        <xsl:variable name="result" select="mlmlp:xpath-evaluate(mlml:parse($path), $xpath)"/>
        
        <xsl:variable name="result" select="$result ! (if (. instance of node()) then mlml:serialize-node(.) else .)"/>
        
        <xsl:variable name="saxon-result" as="xs:string*">
            <xsl:try>
                <xsl:variable name="result" as="item()*">
                    <xsl:evaluate xpath="$xpath" context-item="doc($path)"/>
                </xsl:variable>
                <xsl:sequence select="$result ! serialize(.)"/>
                <xsl:catch>
                    <xsl:value-of select="$err:description"/>
                </xsl:catch>
            </xsl:try>
        </xsl:variable>
        
        <xsl:value-of select="
            '',
            'Result:',
            '',
            $result,
            '',
            '',
            'Saxon-Result:',
            '',
            $saxon-result,
            ''
            " separator="&#xA;"/>
    </xsl:template>
    
    
</xsl:stylesheet>