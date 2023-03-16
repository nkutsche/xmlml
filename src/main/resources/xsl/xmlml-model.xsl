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
        <xsl:apply-templates select="mlml:clean-up($xmlml-documuent)" mode="mlml:doc"/>
    </xsl:function>

    <xsl:template match="document" mode="mlml:doc">
        <xsl:document>
            <xsl:apply-templates select="pi | comment | element" mode="#current"/>
        </xsl:document>
    </xsl:template>

    <xsl:template match="ws" mode="mlml:doc"/>



    <xsl:template match="element" mode="mlml:doc">
        <xsl:param name="inherit-default-namespace" select="''" as="xs:string" tunnel="yes"/>

        <xsl:variable name="default-namespace" select="
                (@element-default-namespace/string(), $inherit-default-namespace)[1]
                "/>
        <xsl:variable name="elname" select="name"/>


        <xsl:element name="{$elname}" namespace="{mlml:namespace($elname, $default-namespace)}">
            <xsl:variable name="content" select="content/(text | pi | comment | element)"/>
            <xsl:apply-templates select="attribute, $content" mode="#current">
                <xsl:with-param name="inherit-default-namespace" select="$default-namespace" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>


    <xsl:template match="attribute" mode="mlml:doc">
        <xsl:attribute name="{name}" namespace="{mlml:namespace(name)}">
            <xsl:apply-templates select="value" mode="#current"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="attribute/value" mode="mlml:doc" priority="10">
        <xsl:variable name="type" select="../@type"/>
        <xsl:variable name="raw-value">
            <xsl:next-match/>
        </xsl:variable> 
        <xsl:value-of select="mlml:type-convert($raw-value, $type)"/>
    </xsl:template>
    
    <xsl:template match="attribute[@namespace = 'true']" mode="mlml:doc">
        <xsl:if test="not(value = '')">
            <xsl:namespace name="{name}">
                <xsl:apply-templates select="value" mode="#current"/>
            </xsl:namespace>
        </xsl:if>
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

    <xsl:template match="attribute/value//data/text()" mode="mlml:doc">
        <xsl:value-of select="replace(., '\t', ' ')"/>
    </xsl:template>
    
    <xsl:template match="attribute/value/entity[@name]" mode="mlml:doc" priority="10">
        <xsl:variable name="next-match">
            <xsl:next-match/>
        </xsl:variable>
        <xsl:value-of select="replace($next-match, '\r|\n', ' ')"/>
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
        <xsl:apply-templates mode="#current"/>
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

    <xsl:function name="mlml:type-convert" as="xs:string">
        <xsl:param name="value" as="xs:string"/>
        <xsl:param name="type" as="xs:string?"/>
        
        <xsl:variable name="is-valid" select="mlml:type-validate($value, $type)"/>
        
        <xsl:variable name="type-def" select="if($type) then $Type-Defs($type) else ()"/>
        
        <xsl:variable name="value" select="
            
            if ($type = ('IDREFS', 'NMTOKENS', 'ENTITIES')) 
            then (
                (tokenize($value, ' ')[. != ''] ! mlml:type-convert(., mlml:single-type($type))) => string-join(' ')
            ) 
            else 
            if (not($is-valid)) 
            then ($value) 
            else 
            if (exists($type-def)) 
            then ($type-def?convert($value)) 
            else 
                $value
            "/>
        
        <xsl:sequence select="string($value)"/>
        
    </xsl:function>
    <xsl:function name="mlml:single-type" as="xs:string">
        <xsl:param name="type" as="xs:string"/>
        <xsl:sequence select="
            if ($type = 'ENTITIES') then 'ENTITY' else replace($type, 'S$', '')
            "/>
    </xsl:function>
    
    <xsl:function name="mlml:type-validate" as="xs:boolean">
        <xsl:param name="value" as="xs:string"/>
        <xsl:param name="type" as="xs:string?"/>
        
        <xsl:variable name="type-def" select="if($type) then $Type-Defs($type) else ()"/>
        
        <xsl:variable name="is-valid" select="
            if (exists($type-def)) 
            then (matches($value, $type-def?regex)) 
            else 
            if ($type = ('IDREFS', 'NMTOKENS', 'ENTITIES')) 
            then (
                (
                    every $t in tokenize($value, ' ')[. != ''] 
                    satisfies mlml:type-validate($t, mlml:single-type($type))
                )
            ) 
            else 
                false()
            "/>
        
        <xsl:sequence select="$is-valid"/>
        
    </xsl:function>
    
    <xsl:variable name="NCNameStartChar" select="'[A-Z]|_|[a-z]|[&#xC0;-&#xD6;]|[&#xD8;-&#xF6;]|[&#xF8;-&#x2FF;]|[&#x370;-&#x37D;]|[&#x37F;-&#x1FFF;]|[&#x200C;-&#x200D;]|[&#x2070;-&#x218F;]|[&#x2C00;-&#x2FEF;]|[&#x3001;-&#xD7FF;]|[&#xF900;-&#xFDCF;]|[&#xFDF0;-&#xFFFD;]|[&#x10000;-&#xEFFFF;]'"/>
    <xsl:variable name="NameStartChar" select="':|' || $NCNameStartChar"/>
    <xsl:variable name="NameChar" select="$NameStartChar || '|-|\.|[0-9]|&#xB7;|[&#x0300;-&#x036F;]|[&#x203F;-&#x2040;]'"/>
    <xsl:variable name="NCNameChar" select="$NCNameStartChar || '|-|\.|[0-9]|&#xB7;|[&#x0300;-&#x036F;]|[&#x203F;-&#x2040;]'"/>
    
    <xsl:variable name="Name" select="'^[&#x20;]*(' || $NameStartChar || ')' || '(' || $NameChar || ')*[&#x20;]*$'"/>
    <xsl:variable name="NCName" select="'^[&#x20;]*(' || $NCNameStartChar || ')' || '(' || $NCNameChar || ')*[&#x20;]*$'"/>
    <xsl:variable name="Type-Defs" select="map{
            'NMTOKEN' : map{
                'regex' : '^[&#x20;]*(' || $NameChar || ')+[&#x20;]*$',
                'convert' : function($raw){xs:NMTOKEN($raw)}
            },
            'ENTITY' : map{
                'regex' : $Name,
                'convert' : function($raw){xs:NCName($raw)}
            },
            'ID' : map{
                'regex' : $NCName,
                'convert' : function($raw){xs:ID($raw)}
            },
            'IDREF' : map{
                'regex' : $NCName,
                'convert' : function($raw){xs:IDREF($raw) => normalize-space()}
            },
            'ENUM' : map{
                'regex' : '.*',
                'convert' : function($raw){normalize-space($raw)}
            }
        }">
        
    </xsl:variable>
    


</xsl:stylesheet>
