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
    
    <xsl:output method="text"/>
    
    
    <xsl:variable name="doc" select="mlml:parse(resolve-uri('asterix-dtd.xml'))"/>
    
    <xsl:template name="xsl:initial-template">
        <xsl:variable name="result" select="mlmlp:xpath-evaluate($doc, $xpath, map{})"/>
        
        <xsl:for-each select="$result">
            <xsl:sequence select="
                if (. instance of node()) 
                then mlml:serialize-node(.) 
                else .
                "/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:for-each>
        
        <xsl:call-template name="saxon-result"/>
    </xsl:template>
    
    <xsl:template name="saxon-result">
        <xsl:variable name="doc" select="doc(resolve-uri('asterix-dtd.xml'))"/>
        <xsl:result-document href="demo-saxon.txt">
            <xsl:try>
                <xsl:variable name="result" as="item()*">
                    <xsl:evaluate xpath="$xpath" context-item="$doc"/>
                </xsl:variable>
                <xsl:for-each select="$result">
                    <xsl:sequence select="
                        if (. instance of node()) 
                        then serialize(.) 
                        else .
                        "/>
                    <xsl:text>&#xA;</xsl:text>
                </xsl:for-each>
                <xsl:catch>
                    <xsl:value-of select="$err:description"/>
                </xsl:catch>
            </xsl:try>
        </xsl:result-document>
        
    </xsl:template>
    
</xsl:stylesheet>