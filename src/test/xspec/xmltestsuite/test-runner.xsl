<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    xmlns:dtdml="http://www.nkutsche.com/dtdml"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xsl:import href="http://www.nkutsche.com/xmlml/xmlml-main.xsl"/>
    <xsl:import href="../../resources/xsl/helper.xsl"/>
    
    <xsl:function name="mlml:parse-and-serialize" as="xs:string">
        <xsl:param name="src" as="xs:string"/>
        <xsl:sequence select="mlml:parse-and-serialize($src, false())"/>
    </xsl:function>
    <xsl:function name="mlml:parse-and-serialize" as="xs:string">
        <xsl:param name="src" as="xs:string"/>
        <xsl:param name="validate" as="xs:boolean"/>
        
        <xsl:variable name="xmlml" select="mlml:parse($src)"/>
        <xsl:variable name="validated" select="
            if ($validate) then mlml:validate-xmlml($xmlml) else $xmlml
            "/>
        <xsl:if test="$validated/self::ERROR">
            <xsl:sequence select="error(xs:QName('mlml:invalid'), 'Result: ' || serialize($validated))"/>
        </xsl:if>
        <xsl:variable name="serialized" select="mlml:serialize($xmlml)"/>
        <xsl:sequence select="$serialized"/>
    </xsl:function>
    
    <xsl:function name="mlml:parse-dtd-and-validate" as="xs:boolean">
        <xsl:param name="src" as="xs:string"/>
        
        <xsl:variable name="dtd" select="mlml:parse-dtds-from-xml($src, $default-config)"/>
        
        <xsl:try>
            <xsl:variable name="validate" select="mlml:validate-dtd($dtd)"/>
            <xsl:sequence select="exists($validate/self::dtdml:dtd)"/>
            <xsl:catch>
                <xsl:sequence select="false()"/>
            </xsl:catch>
        </xsl:try>
        
    </xsl:function>

    
    
    <xsl:function name="mlml:ignore-comments">
        <xsl:param name="node"/>
        <xsl:for-each select="$node">
            <xsl:choose>
                <xsl:when test="not(. instance of node())">
                    <xsl:sequence select="."/>
                </xsl:when>
                <xsl:when test=". instance of comment()"/>
                <xsl:otherwise>
                    <xsl:copy>
                        <xsl:sequence select="if(. instance of element()) then @* else ()"/>
                        <xsl:sequence select="mlml:ignore-comments(node())"/>
                    </xsl:copy>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>

    <xsl:variable name="cfg-w-outdef" select="
        map:put($default-config, $mlml:STRIP-WHITESPACE, 'none') 
        => map:put($mlml:IGNORE-INLINE-DTD-PIS, false())
        "/>    
    
    
</xsl:stylesheet>