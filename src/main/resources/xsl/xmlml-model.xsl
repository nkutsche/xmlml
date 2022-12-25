<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:mlml="http://www.nkutsche.com/xmlml" xmlns="http://www.nkutsche.com/xmlml" xmlns:p="http://www.nkutsche.com/xml-parser" xmlns:map="http://www.w3.org/2005/xpath-functions/map" exclude-result-prefixes="#all" version="3.0" xpath-default-namespace="http://www.nkutsche.com/xmlml">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 11, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> Nico</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <xsl:function name="mlml:doc" as="document-node()">
        <xsl:param name="xmlml-documuent" as="element(mlml:document)"/>
        <xsl:apply-templates select="$xmlml-documuent" mode="mlml:doc"/>
    </xsl:function>

    <xsl:template match="document" mode="mlml:doc">
        <xsl:variable name="dtd" select="mlml:get-dtd-declarations(.)"/>
        <xsl:document>
            <xsl:apply-templates select="pi | comment | element" mode="#current">
                <xsl:with-param name="dtd" select="$dtd" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:document>
    </xsl:template>

    <xsl:template match="ws" mode="mlml:doc"/>



    <xsl:template match="element" mode="mlml:doc">
        <xsl:param name="inherit-default-namespace" select="''" as="xs:string" tunnel="yes"/>
        <xsl:param name="dtd" as="element()*" tunnel="yes"/>

        <xsl:variable name="default-namespace" select="
                (@element-default-namespace/string(), $inherit-default-namespace)[1]
                "/>
        <xsl:variable name="elname" select="name"/>

        <xsl:variable name="attlist" select="$dtd/self::attlist-decl[name = $elname]"/>
        <xsl:variable name="default-attr" select="$attlist/attribute-decl[value | fixed/value]"/>

        <xsl:element name="{$elname}" namespace="{mlml:namespace($elname, $default-namespace)}">
            <xsl:apply-templates select="$default-attr" mode="#current"/>
            <xsl:variable name="content" select="content/(text | pi | comment | element)"/>
            <xsl:apply-templates select="(attribute | namespace), $content" mode="#current">
                <xsl:with-param name="inherit-default-namespace" select="$default-namespace" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>


    <xsl:template match="attribute | attribute-decl" mode="mlml:doc">
        <xsl:attribute name="{name}" namespace="{mlml:namespace(name)}">
            <xsl:apply-templates select="value | fixed/value" mode="#current"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="namespace" mode="mlml:doc">
        <xsl:namespace name="{name}">
            <xsl:apply-templates select="value" mode="#current"/>
        </xsl:namespace>
    </xsl:template>

    <xsl:template match="pi" mode="mlml:doc">
        <xsl:processing-instruction name="{name}">
            <xsl:apply-templates select="value" mode="#current"/>
        </xsl:processing-instruction>
    </xsl:template>

    <xsl:template match="nl[@amount]" mode="mlml:doc" priority="20">
        <xsl:variable name="next-match" as="xs:string">
            <xsl:next-match/>
        </xsl:variable>
        <xsl:value-of select="(1 to @amount) ! $next-match => string-join()"/>
    </xsl:template>

    <xsl:template match="nl" mode="mlml:doc">
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="attribute/value//nl" mode="mlml:doc">
        <xsl:text>&#x20;</xsl:text>
    </xsl:template>

    <xsl:template match="comment" mode="mlml:doc">
        <xsl:comment>
            <xsl:apply-templates mode="#current"/>
        </xsl:comment>
    </xsl:template>

    <xsl:template match="entity[@codepoint]" mode="mlml:doc">
        <xsl:variable name="charRef" select="replace(@codepoint, '^x', '')"/>
        <xsl:variable name="isHexRef" select="matches(@codepoint, '^x')"/>
        <xsl:variable name="code-point" select="
                if ($isHexRef) then
                    mlml:hex-to-int($charRef)
                else
                    xs:integer($charRef)
                "/>

        <xsl:value-of select="codepoints-to-string($code-point)"/>

    </xsl:template>

    <xsl:template match="entity[@name]" mode="mlml:doc">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:function name="mlml:namespace" as="xs:string">
        <xsl:param name="name" as="element(name)"/>
        <xsl:sequence select="mlml:namespace($name, '')"/>
    </xsl:function>

    <xsl:function name="mlml:namespace" as="xs:string">
        <xsl:param name="name" as="element(name)"/>
        <xsl:param name="default-namespace" as="xs:string"/>
        <xsl:variable name="prefix" select="replace($name, '^(([^:]+):)?.+', '$2')"/>

        <xsl:variable name="namespace" select="namespace-uri-for-prefix($prefix, $name)"/>

        <xsl:sequence select="
                if ($prefix = '')
                then
                    $default-namespace
                else
                    $namespace
                "/>
    </xsl:function>

    <xsl:function name="mlml:get-dtd-declarations" as="element()*">
        <xsl:param name="document" as="element(document)"/>
        <xsl:sequence select="$document/doc-type-decl/inline/*"/>
    </xsl:function>

    <xsl:function name="mlml:hex-to-int" as="xs:integer">
        <xsl:param name="in" as="xs:string"/>
        <xsl:variable name="in" select="lower-case($in)"/>
        <xsl:variable name="digits" select="string-length($in)"/>

        <xsl:variable name="hex-figures" select="((0 to 9) ! string(.), 'a', 'b', 'c', 'd', 'e', 'f')"/>

        <xsl:variable name="digit-values" select="
                for $d in 1 to $digits
                return
                    (index-of($hex-figures, substring($in, $d, 1)) - 1)
                    * (math:pow(16, $digits - $d))
                "/>

        <xsl:sequence select="$digit-values => sum() => xs:integer()"/>
    </xsl:function>

    <xsl:function name="mlml:int-to-hex" as="xs:string">
        <xsl:param name="in" as="xs:integer"/>
        <xsl:sequence select="
                if ($in eq 0)
                then
                    '0'
                else
                    concat(if ($in ge 16)
                    then
                        mlml:int-to-hex($in idiv 16)
                    else
                        '',
                    substring('0123456789ABCDEF',
                    ($in mod 16) + 1, 1))"/>
    </xsl:function>


</xsl:stylesheet>
