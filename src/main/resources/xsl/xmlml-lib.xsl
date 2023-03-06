<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    xmlns:r="http://maxtoroq.github.io/rng.xsl"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xsl:import href="../rnc-compiler/rng.xsl"/>
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Dec 5, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> Nico</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:variable name="line-separators" select="
        map{
        'r' : '&#xD;',
        'n' : '&#xA;',
        'rn' : '&#xD;&#xA;',
        '#default' : system-property('line.separator') 
        }
        "/>
    
    <xsl:function name="mlml:validate-xmlml" as="node()">
        <xsl:param name="instance" as="node()"/>
        <xsl:sequence select="mlml:validate($instance, doc(resolve-uri('../rnc/xmlml.rng', static-base-uri())))"/>
    </xsl:function>
    
    <xsl:function name="mlml:validate-dtd" as="node()">
        <xsl:param name="instance" as="node()"/>
        <xsl:sequence select="mlml:validate($instance, doc(resolve-uri('../rnc/dtdml.rng', static-base-uri())))"/>
    </xsl:function>
    
    <xsl:function name="mlml:validate" as="node()">
        <xsl:param name="instance" as="node()"/>
        <xsl:param name="schema" as="document-node()"/>
        <xsl:try>
            <xsl:variable name="rng-validate" as="xs:boolean">
                <xsl:call-template name="r:main">
                    <xsl:with-param name="schema" select="$schema"/>
                    <xsl:with-param name="instance" select="$instance"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="$rng-validate">
                    <xsl:sequence select="$instance"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:sequence select="error(xs:QName('Invalid-Result'))"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:catch>
                <ERROR message="Invalid result:">
                    <xsl:sequence select="$instance"/>
                </ERROR>
            </xsl:catch>
        </xsl:try>
    </xsl:function>
    
    <xsl:function name="mlml:error" as="empty-sequence()">
        <xsl:param name="code" as="xs:string"/>
        <xsl:param name="description" as="xs:string"/>
        <xsl:variable name="name" select="xs:QName('mlml:code-' || $code)"/>
        <xsl:sequence select="error($name, $description)"/>
    </xsl:function>
    
</xsl:stylesheet>