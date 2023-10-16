<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    xpath-default-namespace="http://www.nkutsche.com/xmlml"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xsl:mode name="mlml:clean-up" on-no-match="shallow-copy"/>
    
    <xsl:function name="mlml:serialize" as="xs:string" visibility="final">
        <xsl:param name="document" as="element(document)"/>
        <xsl:variable name="document" select="mlml:clean-up($document)"/>
        <xsl:variable name="serialized" as="xs:string*">
            <xsl:apply-templates select="$document" mode="mlml:serialize"/>
        </xsl:variable>
        <xsl:sequence select="$serialized => string-join()"/>    
    </xsl:function>

    <xsl:function name="mlml:serialize-node" as="xs:string" visibility="final">
        <xsl:param name="nodes" as="element()*"/>
        <xsl:variable name="nodes" select="$nodes/mlml:clean-up(.)"/>
        <xsl:variable name="serialized" as="xs:string*">
            <xsl:apply-templates select="$nodes" mode="mlml:serialize"/>
        </xsl:variable>
        <xsl:sequence select="$serialized => string-join()"/>    
    </xsl:function>
    
    <xsl:function name="mlml:clean-up" as="element()">
        <xsl:param name="node" as="element()"/>
        <xsl:apply-templates select="$node" mode="mlml:clean-up"/>
    </xsl:function>
    
    
    <xsl:template match="element" mode="mlml:serialize">
        <xsl:text>&lt;</xsl:text>
        <xsl:variable name="startTag" select="name | attribute | ws"/>
        <xsl:variable name="endTag" select="name, close-tag-space"/>
        <xsl:apply-templates select="$startTag" mode="#current"/>
        <xsl:if test="@collapsed = 'true'">
            <xsl:text>/</xsl:text>
        </xsl:if>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates select="* except ($startTag | $endTag)" mode="#current"/>
        
        <xsl:if test="not(@collapsed = 'true')">
            <xsl:text>&lt;/</xsl:text>
            <xsl:apply-templates select="$endTag" mode="#current"/>
            <xsl:text>&gt;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="ws[@space|@tab] | ws/space | ws/tab" mode="mlml:serialize">
        <xsl:variable name="char" select=" if (@tab|self::tab) then ('&#x9;') else ' '"/>
        <xsl:variable name="amount" select="xs:integer(@space|@tab|@amount)"/>
        <xsl:variable name="amount" select="($amount, 1)[1]"/>
        <xsl:sequence select="(1 to $amount) ! $char"/>
    </xsl:template>

    <xsl:template match="ws[@nl] | nl" mode="mlml:serialize">
        <xsl:variable name="lf-format" select="(@line-feed-format, ancestor::document/@line-feed-format, '#default')[1]"/>
        <xsl:variable name="char" select="$line-separators($lf-format)"/>
        <xsl:variable name="amount" select="xs:integer((@nl|@amount, 1)[1])"/>
        <xsl:sequence select="(1 to $amount) ! $char"/>
    </xsl:template>

    
    <xsl:template match="eq" mode="mlml:serialize">
        <xsl:text>=</xsl:text>
    </xsl:template>
    
    <xsl:template match="attribute[@default = 'true']" mode="mlml:serialize"/>
    
    <xsl:template match="
        attribute/value[@quotes = 'single'] 
        | xml-decl/*/value[@quotes = 'single']
        | attribute-decl/value[@quotes = 'single']
        | doc-type-decl/system//value[@quotes = 'single']
        | doc-type-decl/public//value[@quotes = 'single']
        " mode="mlml:serialize" priority="10">
        <xsl:text>'</xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text>'</xsl:text>
    </xsl:template>
    
    <xsl:template match="
        attribute/value 
        | xml-decl/*/value 
        | attribute-decl/value
        | doc-type-decl/system//value
        | doc-type-decl/public//value
        " mode="mlml:serialize">
        <xsl:text>"</xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text>"</xsl:text>
    </xsl:template>
    
    <xsl:template match="attribute[@namespace='true']/name[. = '']" mode="mlml:serialize" priority="10">
        <xsl:text>xmlns</xsl:text>
    </xsl:template>

    <xsl:template match="attribute[@namespace='true']/name" mode="mlml:serialize">
        <xsl:text>xmlns:</xsl:text>
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="pi" mode="mlml:serialize">
        <xsl:text>&lt;?</xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text>?&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="comment" mode="mlml:serialize">
        <xsl:text>&lt;!--</xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text>--&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="xml-decl" mode="mlml:serialize">
        <xsl:text>&lt;?xml</xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text>?&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="xml-decl/*/name" mode="mlml:serialize">
        <xsl:value-of select="parent::*/local-name()"/>
    </xsl:template>
    
    <xsl:template match="doc-type-decl" mode="mlml:serialize">
        <xsl:text>&lt;!DOCTYPE</xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="doc-type-decl/system" mode="mlml:serialize">
        <xsl:text>SYSTEM</xsl:text>
        <xsl:apply-templates mode="#current"/>
    </xsl:template>

    <xsl:template match="doc-type-decl/public" mode="mlml:serialize">
        <xsl:text>PUBLIC</xsl:text>
        <xsl:apply-templates mode="#current"/>
    </xsl:template>

    <xsl:template match="doc-type-decl/inline" mode="mlml:serialize">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text>]</xsl:text>
    </xsl:template>

    <xsl:template match="cdata-section" mode="mlml:serialize">
        <xsl:text>&lt;![CDATA[</xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text>]]&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="entity[@name]" mode="mlml:serialize">
        <xsl:text>&amp;</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>;</xsl:text>
    </xsl:template>
    <xsl:template match="entity[@codepoint]" mode="mlml:serialize">
        <xsl:text>&amp;</xsl:text>
        <xsl:text>#</xsl:text>
        <xsl:value-of select="@codepoint"/>
        <xsl:text>;</xsl:text>
    </xsl:template>
    
    <xsl:template match="
        data/text() 
        | name/text()
        " mode="mlml:clean-up">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="text()" mode="mlml:clean-up"/>
        
    
    
    
</xsl:stylesheet>