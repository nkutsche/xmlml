<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mlmlt="http://www.nkutsche.com/xmlml/test-helper"
    xmlns:err="http://www.w3.org/2005/xqt-errors"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jan 16, 2023</xd:p>
            <xd:p><xd:b>Author:</xd:b> Nico</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:function name="mlmlt:message" as="empty-sequence()">
        <xsl:param name="message" as="xs:string"/>
        <xsl:message select="$message"/>
    </xsl:function>
    
    <xsl:function name="mlmlt:try-catch">
        <xsl:param name="do" as="function(*)"/>
        <xsl:sequence select="mlmlt:try-catch($do, function($e){$e})"/>
    </xsl:function>
    
    <xsl:function name="mlmlt:try-catch">
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