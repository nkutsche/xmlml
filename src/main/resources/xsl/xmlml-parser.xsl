<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:mlml="http://www.nkutsche.com/xmlml" xmlns="http://www.nkutsche.com/xmlml" xmlns:xmlp="http://www.nkutsche.com/xml-parser" xmlns:dtdp="http://www.nkutsche.com/dtd-parser" 
    xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:dtdml="http://www.nkutsche.com/dtdml"
    xmlns:xmlfp="http://www.nkutsche.com/xml-fragment-parser" exclude-result-prefixes="#all" version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 11, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> Nico</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>

    <xsl:variable name="feature_ns" select="'http://www.nkutsche.com/xmlml/parser/features/'"/>

    <xsl:variable name="mlml:STRIP-WHITESPACE" select="QName($feature_ns, 'STRIP-WHITESPACE')" visibility="final"/>
    <xsl:variable name="mlml:RESOLVE-DTD-URIS" select="QName($feature_ns, 'RESOLVE-DTD-URIS')" visibility="final"/>
    <xsl:variable name="mlml:EXPAND-DEFAULT-ATTRIBUTES" select="QName($feature_ns, 'EXPAND-DEFAULT-ATTRIBUTES')" visibility="final"/>
    <xsl:variable name="mlml:URI_RESOLVER" select="QName($feature_ns, 'URI_RESOLVER')" visibility="final"/>

    <xsl:variable name="default-config" select="
        mlml:detect-default-config()
        " as="map(*)"/>


    <xsl:function name="mlml:detect-default-config" as="map(*)?">

        <xsl:variable name="get-detection-file" select="
                function ($name) {
                    ('../cfg/cfg-detection/' || $name || '.xml')
                    => resolve-uri(static-base-uri())
                    => doc()
                }"/>

        <xsl:variable name="strip-whitespace-all.doc" select="
                $get-detection-file('strip-whitespace-all')
                "/>
        <xsl:variable name="strip-whitespace-ignorable.doc" select="
                $get-detection-file('strip-whitespace-ignorable')
                "/>

        <xsl:variable name="strip-whitespace" select="
                if (not($strip-whitespace-all.doc/*/text()))
                then
                    ('all')
                else
                    if (not($strip-whitespace-ignorable.doc/*/text()))
                    then
                        'ignorable'
                    else
                        'none'
                "/>

        <xsl:variable name="expand-default-attributes.doc" select="
                $get-detection-file('expand-default-attributes')
                "/>
        <xsl:variable name="expand-default-attributes" select="
                exists($expand-default-attributes.doc/*/@*)
                "/>

        <xsl:variable name="resolve-dtd-uris.doc" select="
                $get-detection-file('resolve-dtd-uris')
                "/>

        <xsl:variable name="resolve-dtd-uris" select="
                $resolve-dtd-uris.doc/*/base-uri(.) != $resolve-dtd-uris.doc/*/*/base-uri(.)
                "/>

        <xsl:sequence select="map{
            $mlml:STRIP-WHITESPACE : $strip-whitespace,
            $mlml:RESOLVE-DTD-URIS : $resolve-dtd-uris,
            $mlml:EXPAND-DEFAULT-ATTRIBUTES : $expand-default-attributes,
            $mlml:URI_RESOLVER : mlml:default-uri-resolver#2
            }"/>

    </xsl:function>

    <xsl:function name="mlml:default-uri-resolver" as="map(xs:string, xs:string)?">
        <xsl:param name="href" as="xs:string"/>
        <xsl:param name="base-uri" as="xs:string?"/>
        <xsl:variable name="base-uri" select="
                if ($base-uri) then
                    resolve-uri($href, $base-uri)
                else
                    $href
                "/>
        <xsl:choose>
            <xsl:when test="unparsed-text-available($base-uri)">
                <xsl:variable name="content" select="unparsed-text($base-uri)"/>
                <xsl:sequence select="map{
                    'base-uri' : string($base-uri),
                    'content' : $content
                    }"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message expand-text="yes">Could not resolve URI "{$base-uri}"</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="mlml:parse" as="node()">
        <xsl:param name="href" as="xs:string"/>
        <xsl:sequence select="mlml:parse($href, map{})"/>
    </xsl:function>

    <xsl:function name="mlml:parse" as="node()">
        <xsl:param name="href" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        
        <xsl:variable name="config" select="map:merge(($config, $default-config))"/>
        
        <xsl:variable name="contentObj" select="$config($mlml:URI_RESOLVER)($href, ())"/>

        <xsl:variable name="text" select="$contentObj?content"/>

        <xsl:variable name="linefeed" select="
                if ($contentObj?linefeed) then
                    $contentObj?linefeed
                else
                    if (matches($text, '\r\n')) then
                        'rn'
                    else
                        if (matches($text, '\r')) then
                            'r'
                        else
                            if (matches($text, '\n')) then
                                'n'
                            else
                                '#default'
                "/>
        <xsl:variable name="base-uri" select="($contentObj?base-uri, $href)[1]"/>
        <xsl:sequence select="
                mlml:parse-from-string($text, $config, map {
                    'line-feed-format': $linefeed,
                    'base-uri': $base-uri
                })"/>
    </xsl:function>

    <xsl:function name="mlml:parse-from-string" as="node()">
        <xsl:param name="unparsed-xml" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:param name="properties" as="map(xs:string, xs:string)"/>
        <xsl:variable name="pre-parsed" select="xmlp:parse-document($unparsed-xml)"/>

        <xsl:apply-templates select="$pre-parsed" mode="mlml:parse">
            <xsl:with-param name="config" select="$config" tunnel="yes"/>
            <xsl:with-param name="properties" select="$properties" tunnel="yes"/>
        </xsl:apply-templates>

    </xsl:function>

    <xsl:template match="document" mode="mlml:parse">
        <xsl:param name="properties" tunnel="yes" as="map(*)?"/>
        <document>
            <xsl:if test="$properties?line-feed-format != '#default'">
                <xsl:attribute name="line-feed-format" select="$properties?line-feed-format"/>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
        </document>
    </xsl:template>

    <xsl:template match="element" mode="mlml:parse">
        <xsl:variable name="content" as="element()*">
            <xsl:apply-templates mode="#current"/>
        </xsl:variable>
        <element>
            <xsl:if test="not(ETag)">
                <xsl:attribute name="collapsed" select="'true'"/>
            </xsl:if>
            <xsl:for-each select="$content/self::mlml:namespace">
                <xsl:choose>
                    <xsl:when test="mlml:name = ''">
                        <xsl:attribute name="element-default-namespace" select="mlml:value"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:namespace name="{mlml:name}" select="mlml:value"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            <xsl:sequence select="$content"/>
        </element>
    </xsl:template>

    <xsl:template match="content" mode="mlml:parse">
        <xsl:variable name="content" as="element()*">
            <xsl:apply-templates mode="#current"/>
        </xsl:variable>
        <xsl:where-populated>
            <content>
                <xsl:for-each-group select="$content" group-adjacent="exists(self::mlml:text)">
                    <xsl:choose>
                        <xsl:when test="current-grouping-key()">
                            <xsl:copy>
                                <xsl:sequence select="current-group()/node()"/>
                            </xsl:copy>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:sequence select="current-group()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each-group>
            </content>
        </xsl:where-populated>
    </xsl:template>

    <xsl:template match="Attribute[matches(Name, '^xmlns(:|$)')]" mode="mlml:parse">
        <namespace>
            <xsl:apply-templates mode="#current"/>
        </namespace>
    </xsl:template>

    <xsl:template match="Attribute/Name[matches(., '^xmlns(:|$)')]" mode="mlml:parse">
        <name>
            <xsl:value-of select="replace(., '^xmlns(:|$)', '')"/>
        </name>
    </xsl:template>

    <xsl:template match="Attribute" mode="mlml:parse">
        <attribute>
            <xsl:apply-templates mode="#current"/>
        </attribute>
    </xsl:template>

    <xsl:template match="Attribute/Eq/TOKEN" mode="mlml:parse">
        <eq/>
    </xsl:template>

    <xsl:template match="Attribute/AttValue | DefaultDecl/AttValue" mode="mlml:parse">
        <value>
            <xsl:if test="AttValueSingle">
                <xsl:attribute name="quotes" select="'single'"/>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
        </value>
    </xsl:template>

    <xsl:template match="Comment" mode="mlml:parse">
        <comment>
            <xsl:apply-templates mode="#current"/>
        </comment>
    </xsl:template>

    <xsl:template match="PI" mode="mlml:parse">
        <pi>
            <xsl:apply-templates mode="#current"/>
        </pi>
    </xsl:template>

    <xsl:template match="PITarget" mode="mlml:parse">
        <name>
            <xsl:apply-templates mode="#current"/>
        </name>
    </xsl:template>

    <xsl:template match="PIContentEnd" mode="mlml:parse">
        <xsl:analyze-string select="." regex="^([\s\r\n]*)(.*?)(\?>)$" flags="s">
            <xsl:matching-substring>
                <xsl:sequence select="mlml:white-space(regex-group(1))"/>
                <xsl:if test="regex-group(2) != ''">
                    <value>
                        <xsl:sequence select="regex-group(2) => mlml:line-breaks()"/>
                    </value>
                </xsl:if>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:message terminate="yes">Failed to parse PI value "<xsl:value-of select="."/>"</xsl:message>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template match="CharData" mode="mlml:parse">
        <text>
            <xsl:apply-templates mode="#current"/>
        </text>
    </xsl:template>

    <xsl:template match="CDSect" mode="mlml:parse">
        <text>
            <cdata>
                <xsl:apply-templates mode="#current"/>
            </cdata>
        </text>
    </xsl:template>

    <xsl:template match="CDSect/TOKEN[. = ']'][following-sibling::TOKEN[. = ']']]" mode="mlml:parse">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>

    <xsl:template match="AttValue//Reference | EntityValue//Reference" mode="mlml:parse" priority="10">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>

    <xsl:template match="Reference" mode="mlml:parse">
        <text>
            <xsl:apply-templates mode="#current"/>
        </text>
    </xsl:template>


    <xsl:template match="Reference/CharRef[CharRefDec | CharRefHex]" mode="mlml:parse">
        <xsl:variable name="charRef" select="CharRefDec | CharRefHex"/>
        <xsl:variable name="isHexRef" select="exists($charRef/self::CharRefHex)" as="xs:boolean"/>

        <entity>
            <xsl:attribute name="codepoint" select="'x'[$isHexRef], $charRef" separator=""/>
        </entity>

    </xsl:template>

    <xsl:variable name="pre-def-entities" select="
        map{
        'amp' : '&amp;',
        'lt' : '&lt;',
        'gt' : '&gt;',
        'quot' : '&quot;',
        'apos' : '&apos;&apos;'
        }
        "/>

    <xsl:template match="Reference/EntityRef[$pre-def-entities(Name)]" mode="mlml:parse" priority="10">
        <entity>
            <xsl:attribute name="name" select="Name"/>
            <text>
                <xsl:value-of select="$pre-def-entities(Name)"/>
            </text>
        </entity>
    </xsl:template>
    
    <xsl:template match="Reference/EntityRef[Name]" mode="mlml:parse">
        <xsl:param name="dtd" tunnel="yes"/>
        <xsl:variable name="nameRef" select="Name"/>
        
        <xsl:variable name="value" select="
            $dtd/dtdml:entity-decl[@name = $nameRef]/dtdml:value
            "/>
        
        <xsl:variable name="fragment-parsed" select="xmlfp:parse-document-fragment(string($value))"/>
        
        <xsl:if test="$fragment-parsed/self::ERROR">
            <xsl:sequence select="error(xs:QName('mlml:fail'), serialize($fragment-parsed))"/>
        </xsl:if>
        
        <xsl:variable name="fragment-parsed" select="$fragment-parsed/content/node()"/>
        
        
        <entity>
            <xsl:attribute name="name" select="Name"/>
            <xsl:apply-templates select="$fragment-parsed" mode="#current"/>
        </entity>
    </xsl:template>



    <xsl:template match="Name" mode="mlml:parse">
        <name>
            <xsl:apply-templates mode="#current"/>
        </name>
    </xsl:template>
    <xsl:template match="ETag[S]" mode="mlml:parse">
        <close-tag-space>
            <xsl:apply-templates select="S" mode="#current"/>
        </close-tag-space>
    </xsl:template>

    <xsl:template match="S" mode="mlml:parse">
        <xsl:sequence select="mlml:white-space(.)"/>
    </xsl:template>

    <xsl:function name="mlml:white-space" as="element(mlml:ws)?">
        <xsl:param name="space" as="xs:string"/>

        <xsl:variable name="tokenized" as="element()*">
            <xsl:analyze-string select="$space" regex="&#x20;+|\t+|(\r\n)+|\r+|\n+">
                <xsl:matching-substring>
                    <xsl:variable name="el-name" select="
                            if (matches(., '&#x20;')) then
                                'space'
                            else
                                if (matches(., '\t')) then
                                    ('tab')
                                else
                                    if (matches(., '\r|\n')) then
                                        'nl'
                                    else
                                        error(xs:QName('fatal-error'), 'This should never happen!')
                            "/>
                    <xsl:element name="{$el-name}">
                        <xsl:attribute name="amount" select="string-length(replace(., '\r\n', '&#xA;'))"/>
                    </xsl:element>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:sequence select="error(xs:QName('fatal-error'), 'This should never happen!')"/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="count($tokenized) = 0"/>
            <xsl:when test="count($tokenized) = 1">
                <ws>
                    <xsl:attribute name="{$tokenized/local-name()}" select="$tokenized/@amount"/>
                </ws>
            </xsl:when>
            <xsl:otherwise>
                <ws>
                    <xsl:for-each-group select="$tokenized" group-adjacent="name()">
                        <xsl:choose>
                            <xsl:when test="current-grouping-key() = 'nospace'">
                                <xsl:value-of select="current-group()" separator=""/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy>
                                    <xsl:variable name="amount" select="sum(current-group()/@amount)"/>
                                    <xsl:if test="$amount gt 1">
                                        <xsl:attribute name="amount" select="$amount"/>
                                    </xsl:if>
                                </xsl:copy>
                            </xsl:otherwise>
                        </xsl:choose>

                    </xsl:for-each-group>
                </ws>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>

    <xsl:function name="mlml:line-breaks" as="node()*">
        <xsl:param name="text" as="xs:string?"/>
        <xsl:analyze-string select="$text" regex="(\r\n|\r|\n)+">
            <xsl:matching-substring>
                <xsl:variable name="amount" select="replace(., '\r\n', '&#xA;') => string-length()"/>
                <nl>
                    <xsl:if test="$amount gt 1">
                        <xsl:attribute name="amount" select="$amount"/>
                    </xsl:if>
                </nl>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:function>

    <xsl:template match="text()" mode="mlml:parse">
        <xsl:sequence select="mlml:line-breaks(.)"/>
    </xsl:template>

    <xsl:template match="
            prolog | content | Misc
            | Attribute/Eq
            | AttValueDouble
            | AttValueDoubleVal
            | AttValueSingle
            | AttValueSingleVal
            | CDSectContent
            | CommentContent
            | Reference/CharRef
            " mode="mlml:parse" priority="-5">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>

    <xsl:template match="TOKEN | ETag | EOF" mode="mlml:parse" priority="-5"/>

    <!--    
    Prolog (XmlDecl, DocType, etc)
    -->



    <xsl:template match="XMLDecl" mode="mlml:parse">
        <xml-decl>
            <xsl:apply-templates mode="#current"/>
        </xml-decl>
    </xsl:template>

    <xsl:template match="VersionInfo" mode="mlml:parse">
        <version>
            <xsl:apply-templates mode="#current"/>
        </version>
    </xsl:template>

    <xsl:template match="EncodingDecl" mode="mlml:parse">
        <encoding>
            <xsl:apply-templates mode="#current"/>
        </encoding>
    </xsl:template>

    <xsl:template match="SDDecl" mode="mlml:parse">
        <standalone>
            <xsl:apply-templates mode="#current"/>
        </standalone>
    </xsl:template>

    <xsl:template match="
            VersionInfo/TOKEN[. = 'version']
            | EncodingDecl/TOKEN[. = 'encoding']
            | SDDecl/TOKEN[. = 'standalone']
            " mode="mlml:parse">
        <name/>
    </xsl:template>

    <xsl:template match="
            VersionInfo/Eq
            | EncodingDecl/Eq
            | SDDecl/Eq
            " mode="mlml:parse">
        <eq/>
    </xsl:template>

    <xsl:template match="
            VersionInfo/VersionNum
            | EncodingDecl/EncName
            | SDDecl/TOKEN[. = ('yes', 'no')]
            " mode="mlml:parse">
        <value>
            <xsl:if test="preceding-sibling::TOKEN[. = '''']">
                <xsl:attribute name="quotes" select="'single'"/>
            </xsl:if>
            <xsl:value-of select="."/>
        </value>
    </xsl:template>

    <xsl:template match="doctypedecl" mode="mlml:parse">
        <doc-type-decl>
            <xsl:apply-templates mode="#current"/>
        </doc-type-decl>
    </xsl:template>

    <xsl:template match="doctypedecl/TOKEN" mode="mlml:parse" priority="10"/>

    <xsl:template match="doctypedecl/Name" mode="mlml:parse">
        <name>
            <xsl:apply-templates mode="#current"/>
        </name>
    </xsl:template>

    <xsl:template match="doctypedecl/ExternalID[TOKEN = 'SYSTEM']" mode="mlml:parse">
        <system>
            <xsl:apply-templates mode="#current"/>
        </system>
    </xsl:template>

    <xsl:template match="doctypedecl/ExternalID/SystemLiteral" mode="mlml:parse">
        <value>
            <xsl:apply-templates mode="#current"/>
        </value>
    </xsl:template>


    <xsl:template match="doctypedecl/intSubset" mode="mlml:parse">
        <inline>
            <xsl:apply-templates mode="#current"/>
        </inline>
    </xsl:template>

    <xsl:template match="elementdecl" mode="mlml:parse">
        <element-decl>
            <xsl:apply-templates mode="#current"/>
        </element-decl>
    </xsl:template>

    <xsl:template match="elementdecl/contentspec" mode="mlml:parse">
        <content-spec>
            <xsl:sequence select="mlml:line-breaks(.)"/>
        </content-spec>
    </xsl:template>

    <xsl:template match="AttlistDecl" mode="mlml:parse">
        <attlist-decl>
            <xsl:apply-templates mode="#current"/>
        </attlist-decl>
    </xsl:template>

    <xsl:template match="AttlistDecl/AttDef" mode="mlml:parse">
        <attribute-decl>
            <xsl:apply-templates mode="#current"/>
        </attribute-decl>
    </xsl:template>

    <xsl:template match="AttDef/AttType" mode="mlml:parse">
        <type>
            <xsl:value-of select="."/>
        </type>
    </xsl:template>

    <xsl:template match="DefaultDecl[TOKEN = '#IMPLIED']" mode="mlml:parse">
        <implied/>
    </xsl:template>

    <xsl:template match="DefaultDecl[TOKEN = '#REQUIRED']" mode="mlml:parse">
        <required/>
    </xsl:template>

    <xsl:template match="DefaultDecl[TOKEN = '#FIXED']" mode="mlml:parse">
        <fixed>
            <xsl:apply-templates mode="#current"/>
        </fixed>
    </xsl:template>

    <xsl:template match="EntityDecl" mode="mlml:parse">
        <entity-decl>
            <xsl:apply-templates mode="#current"/>
        </entity-decl>
    </xsl:template>

    <xsl:template match="EntityDecl//EntityValue" mode="mlml:parse">
        <value>
            <xsl:if test="substring(., 1, 1) = ''''">
                <xsl:attribute name="quotes" select="'single'"/>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
        </value>
    </xsl:template>


    <xsl:template match="doctypedecl//*" mode="mlml:parse" priority="-10">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>


    <xsl:template match="*" mode="mlml:parse" priority="-100">
        <NOT_SUPPORTED>
            <xsl:copy>
                <xsl:apply-templates select="@*" mode="#current"/>
                <xsl:apply-templates mode="#current"/>
            </xsl:copy>
        </NOT_SUPPORTED>
    </xsl:template>



</xsl:stylesheet>
