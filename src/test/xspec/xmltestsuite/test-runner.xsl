<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    xmlns:dtdml="http://www.nkutsche.com/dtdml"
    xmlns:err="http://www.w3.org/2005/xqt-errors"
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

    <xsl:function name="mlml:try-catch">
        <xsl:param name="do" as="function(*)"/>
        <xsl:sequence select="mlml:try-catch($do, function($e){$e})"/>
    </xsl:function>

    <xsl:function name="mlml:try-catch">
        <xsl:param name="do" as="function(*)"/>
        <xsl:param name="error" as="function(map(*)) as item()*"/>
        
        <xsl:try>
            <xsl:sequence select="$do()"/>
            <xsl:catch>
                <xsl:sequence select="$error(
                    map{
                    'code' : $err:code, 
                    'description' : $err:description, 
                    'line-number' : $err:line-number, 
                    'column-number' : $err:column-number, 
                    'module' : $err:module, 
                    'value' : $err:value 
                    }
                    )"/>
            </xsl:catch>
        </xsl:try>
    </xsl:function>
    
    
</xsl:stylesheet>