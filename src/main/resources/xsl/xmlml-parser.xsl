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
    <xsl:variable name="xmlml_ns" select="'http://www.nkutsche.com/xmlml'"/>

    <xsl:variable name="mlml:STRIP-WHITESPACE" select="QName($feature_ns, 'STRIP-WHITESPACE')" visibility="final"/>
    <xsl:variable name="mlml:RESOLVE-DTD-URIS" select="QName($feature_ns, 'RESOLVE-DTD-URIS')" visibility="final"/>
    <xsl:variable name="mlml:EXPAND-DEFAULT-ATTRIBUTES" select="QName($feature_ns, 'EXPAND-DEFAULT-ATTRIBUTES')" visibility="final"/>
    <xsl:variable name="mlml:URI_RESOLVER" select="QName($feature_ns, 'URI_RESOLVER')" visibility="final"/>
    <xsl:variable name="mlml:ENTITY_RESOLVER" select="QName($feature_ns, 'ENTITY_RESOLVER')" visibility="final"/>

    <xsl:variable name="mlml:IGNORE-INLINE-DTD-PIS" select="QName($feature_ns, 'IGNORE-INLINE-DTD-PIS')" visibility="final"/>

    <xsl:variable name="mlml:CUSTOM-STRUCTUR-ELEMENTS" select="QName($feature_ns, 'CUSTOM-STRUCTUR-ELEMENTS')" visibility="final"/>
    
    <xsl:variable name="mlml:IGNORE-EXTERNAL-DTD" select="QName($feature_ns, 'IGNORE-EXTERNAL-DTD')" visibility="final"/>

    <xsl:variable name="mlml:IGNORE-INLINE-DTD" select="QName($feature_ns, 'IGNORE-INLINE-DTD')" visibility="final"/>
    
    <xsl:variable name="mlml:IGNORE-UNDECLARED-ENTITIES" select="QName($feature_ns, 'IGNORE-UNDECLARED-ENTITIES')" visibility="final"/>
    
    <xsl:variable name="mlml:PARSER-LOG-LEVEL" select="QName($feature_ns, 'PARSER-LOG-LEVEL')" visibility="final"/>

    <xsl:variable name="mlml:LOG-LEVEL-VERBOSE" select="'VERBOSE'" visibility="final"/>
    
    <xsl:variable name="mlml:LOG-LEVEL-DEBUG" select="'DEBUG'" visibility="final"/>

    <xsl:variable name="mlml:LOG-LEVEL-WARN" select="'WARNING'" visibility="final"/>

    <xsl:variable name="mlml:LOG-LEVEL-ERROR" select="'ERROR'" visibility="final"/>


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
        
        <xsl:variable name="ignore-inline-dtd-pis.doc" select="
                $get-detection-file('ignore-inline-dtd-pis')
                "/>
        
        <xsl:variable name="ignore-inline-dtd-pis" select="
                empty($ignore-inline-dtd-pis.doc/processing-instruction())
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
            $mlml:IGNORE-INLINE-DTD-PIS : $ignore-inline-dtd-pis,
            $mlml:URI_RESOLVER : mlml:default-uri-resolver#2,
            $mlml:PARSER-LOG-LEVEL : $mlml:LOG-LEVEL-WARN,
            $mlml:IGNORE-UNDECLARED-ENTITIES: false(),
            $mlml:IGNORE-EXTERNAL-DTD: false(),
            $mlml:IGNORE-INLINE-DTD: false()
            }"/>

    </xsl:function>

    <!--    
        This is a bit hacky, but works with Saxon 12.4 (maybe because of a bug?)
        Problem: 
        * you need to return for each document-uri a distinct ID
        * But if you call mlml:document-id twice with the same $document-uri 
          you need to return both the same ID.
        Reason why it works:
        * If you call fn:transform() with the a stylesheet-text and a specific stylesheet-base-uri 
          Saxon stores the stylesheet text and the base-uri into the cache.
        * If you use the exact same stylesheet-text with a different base-uri, it ignores this base-uri
          but reuses the base-uri from cache.
    -->
    <xsl:function name="mlml:document-id" as="xs:string">
        <xsl:param name="document-uri" as="xs:string"/>
        <xsl:variable name="dummy">
            <dummy/>
        </xsl:variable>
        <xsl:variable name="stylesheet" as="xs:string">
            <![CDATA[
                <xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                    <xsl:template name="main">
                        <result doc-uri="$document-uri">
                            <xsl:value-of select="substring-after(static-base-uri(), '=')"/>
                        </result>
                    </xsl:template>
                </xsl:stylesheet>
            ]]>
        </xsl:variable>
        <xsl:variable name="transform" select="
            transform(
            map{
            'stylesheet-text' : replace($stylesheet, '\$document-uri', $document-uri),
            'initial-template' : QName('','main'),
            'stylesheet-base-uri' : ($document-uri || '.xsl?=' || generate-id($dummy))
            })('output')
            "/>
        <xsl:sequence select="'xmlml_' || string($transform)"/>
        
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
                    'id' : mlml:document-id($base-uri),
                    'content' : $content
                    }"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes" expand-text="yes">Could not resolve URI "{$base-uri}"</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="mlml:load-external-resource" as="map(xs:string, xs:string)?">
        <xsl:param name="systemId" as="xs:string"/>
        <xsl:param name="base-uri" as="xs:string?"/>
        <xsl:param name="publicId" as="xs:string?"/>
        <xsl:param name="mode" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:variable name="entity-resolver" select="$config($mlml:ENTITY_RESOLVER)"/>
        <xsl:variable name="uri-resolver" select="$config($mlml:URI_RESOLVER)"/>
        
        <xsl:variable name="resource" as="map(xs:string, xs:string)?"
            select="
            if ($mode = 'entity' and exists($entity-resolver)) 
            then $entity-resolver($publicId, resolve-uri($systemId, $base-uri)) 
            else ()
            "
            />
        <xsl:variable name="resource" as="map(xs:string, xs:string)?"
            select="
            if (empty($resource) and exists($uri-resolver)) 
            then $uri-resolver($systemId, $base-uri) 
            else $resource
            "
            />
        
        <xsl:variable name="resource" select="
            if (empty($resource)) 
            then mlml:default-uri-resolver($systemId, $base-uri) 
            else $resource
            "/>
        
        <xsl:sequence select="$resource"/>
        
    </xsl:function>

    <xsl:function name="mlml:parse" as="element(mlml:document)" visibility="final">
        <xsl:param name="href" as="xs:string"/>
        <xsl:sequence select="mlml:parse($href, map{})"/>
    </xsl:function>

    <xsl:function name="mlml:parse" as="element(mlml:document)" visibility="final">
        <xsl:param name="href" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        
        <xsl:variable name="config" select="map:merge(($config, $default-config))"/>
        
        <xsl:variable name="contentObj" select="
            mlml:load-external-resource($href, (), (), 'regular', $config)
            "/>
        
        <xsl:variable name="document-uri" select="resolve-uri($href) => string()"/>

        <xsl:variable name="text" select="$contentObj?content"/>
        
        <xsl:variable name="document-id" 
            select="
            if (exists($contentObj?id)) 
            then ($contentObj?id) 
            else mlml:document-id($document-uri)
            "/>

        <xsl:variable name="linefeed" select="
                if ($contentObj?linefeed) then
                    $contentObj?linefeed
                else
                    mlml:lf-type($text)
                "/>
        <xsl:variable name="base-uri" select="($contentObj?base-uri, $document-uri)[1]"/>
        <xsl:sequence select="
                mlml:parse-from-string($text, $config, map {
                    'line-feed-format': $linefeed,
                    'base-uri': $base-uri,
                    'document-id' : $document-id,
                    'document-uri' : $document-uri
                })"/>
    </xsl:function>
    
    <xsl:function name="mlml:parse-xml-fragment" as="element(mlml:document)" visibility="final">
        <xsl:param name="unparsed-xml" as="xs:string"/>
        <xsl:param name="base-uri" as="xs:string"/>
        <xsl:sequence select="mlml:parse-xml-fragment($unparsed-xml, $default-config, map{
                'base-uri' : $base-uri
            })"/>
    </xsl:function>
    
    <xsl:function name="mlml:parse-xml-fragment" as="element(mlml:document)" visibility="final">
        <xsl:param name="unparsed-xml" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:param name="properties" as="map(xs:string, xs:string)"/>
        
        <xsl:variable name="pre-parsed" select="xmlfp:parse-document-fragment($unparsed-xml)"/>
        
        <xsl:variable name="properties" select="
            if (map:contains($properties, 'line-feed-format')) 
            then $properties 
            else map:put($properties, 'line-feed-format', mlml:lf-type($unparsed-xml))
            "/>
        
        <xsl:variable name="properties" select="
            if (map:contains($properties, 'document-id')) 
            then $properties 
            else map:put($properties, 'document-id', 'xmlml_' || generate-id(root($pre-parsed)))
            "/>
        
        <xsl:if test="$pre-parsed/self::ERROR">
            <xsl:sequence select="error(xs:QName('mlml:xml-syntax-error'), string($pre-parsed))"/>
        </xsl:if>
        
        <xsl:variable name="xml-version" select="
            ($pre-parsed/document/prolog/XMLDecl/VersionInfo/VersionNum/string(.), '1.0')[1]
            "/>
        
        <xsl:variable name="result" as="document-node(element(mlml:document))">
            <xsl:document>
                <xsl:apply-templates select="$pre-parsed" mode="mlml:parse">
                    <xsl:with-param name="config" select="$config" tunnel="yes"/>
                    <xsl:with-param name="properties" select="map:put($properties, 'xml-version', $xml-version)" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:document>
        </xsl:variable>
        <xsl:variable name="result" select="$result/mlml:document"  as="element(mlml:document)"/>
        
        <xsl:sequence select="
            if (map:contains($config, $mlml:CUSTOM-STRUCTUR-ELEMENTS)) 
            then mlml:custom-strip-spacing($result, $config($mlml:CUSTOM-STRUCTUR-ELEMENTS)($result)) 
            else $result
            "/>        

    </xsl:function>
    
    <xsl:function name="mlml:parse-from-string" as="element(mlml:document)" visibility="final">
        <xsl:param name="unparsed-xml" as="xs:string"/>
        <xsl:param name="base-uri" as="xs:string"/>
        <xsl:sequence select="mlml:parse-from-string($unparsed-xml, $default-config, map{
            'base-uri': $base-uri
            })"/>
    </xsl:function>
    
    <xsl:function name="mlml:parse-from-string" as="element(mlml:document)">
        <xsl:param name="unparsed-xml" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:param name="properties" as="map(xs:string, xs:string)"/>
        <xsl:variable name="pre-parsed" select="xmlp:parse-document($unparsed-xml)"/>
        
        
        <xsl:variable name="properties" select="
            if (map:contains($properties, 'document-id')) 
            then $properties 
            else map:put($properties, 'document-id', 'xmlml_' || generate-id(root($pre-parsed)))
            "/>
        
        <xsl:if test="$pre-parsed/self::ERROR">
            <xsl:sequence select="error(xs:QName('mlml:xml-syntax-error'), string($pre-parsed))"/>
        </xsl:if>
        
        <xsl:variable name="dtd" select="mlml:parse-dtds-from-preparsed-xml(
            $pre-parsed, 
            $properties?base-uri, 
            $config)"/>
        
        <xsl:variable name="xml-version" select="
            ($pre-parsed/document/prolog/XMLDecl/VersionInfo/VersionNum/string(.), '1.0')[1]
            "/>
        
        <xsl:variable name="result" as="document-node(element(mlml:document))">
            <xsl:document>
                <xsl:apply-templates select="$pre-parsed" mode="mlml:parse">
                    <xsl:with-param name="config" select="$config" tunnel="yes"/>
                    <xsl:with-param name="properties" select="map:put($properties, 'xml-version', $xml-version)" tunnel="yes"/>
                    <xsl:with-param name="dtd" select="$dtd" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:document>
        </xsl:variable>
        <xsl:variable name="result" select="$result/mlml:document"  as="element(mlml:document)"/>
        
        <xsl:sequence select="
            if (map:contains($config, $mlml:CUSTOM-STRUCTUR-ELEMENTS)) 
            then mlml:custom-strip-spacing($result, $config($mlml:CUSTOM-STRUCTUR-ELEMENTS)($result)) 
            else $result
            "/>        

    </xsl:function>
    
    <xsl:function name="mlml:custom-strip-spacing" as="element(mlml:document)">
        <xsl:param name="document" as="element(mlml:document)"/>
        <xsl:param name="struct-elements" as="element(mlml:element)*"/>
        
        
        <xsl:apply-templates select="$document" mode="mlml:custom-strip-spacing">
            <xsl:with-param name="struct-elements" select="$struct-elements" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:function>
    
    <xsl:mode name="mlml:custom-strip-spacing" on-no-match="shallow-copy"/>
    <xsl:mode name="mlml:custom-strip-spacing-active" on-no-match="shallow-copy"/>
    
    
    <xsl:template match="mlml:element" mode="mlml:custom-strip-spacing">
        <xsl:param name="struct-elements" as="node()*" tunnel="yes"/>
        <xsl:choose>
            <xsl:when test=". intersect $struct-elements">
                <xsl:next-match>
                    <xsl:with-param name="strip-spacing" select="true()" tunnel="yes"/>
                </xsl:next-match>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match>
                    <xsl:with-param name="strip-spacing" select="false()" tunnel="yes"/>
                </xsl:next-match>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="mlml:content[@space = 'preserve']" mode="mlml:custom-strip-spacing">
        <xsl:param name="strip-spacing" select="false()" as="xs:boolean" tunnel="yes"/>
        <xsl:choose>
            <xsl:when test="$strip-spacing">
                <xsl:copy>
                    <xsl:attribute name="space" select="'skip'"/>
                    <xsl:apply-templates mode="#current"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="mlml:text" mode="mlml:custom-strip-spacing">
        <xsl:param name="strip-spacing" select="false()" as="xs:boolean" tunnel="yes"/>
        <xsl:choose>
            <xsl:when test="$strip-spacing">
                <ws>
                    <xsl:apply-templates mode="#current"/>
                </ws>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="mlml:data[normalize-space(.) = '']" mode="mlml:custom-strip-spacing">
        <xsl:param name="strip-spacing" select="false()" as="xs:boolean" tunnel="yes"/>
        <xsl:choose>
            <xsl:when test="$strip-spacing">
                <xsl:variable name="lf" select="(ancestor-or-self::*[@line-feed-format]/@line-feed-format, '#default')[1]"/>
                <xsl:variable name="ws" select="mlml:white-space(string(.), $lf)"/>
                <xsl:variable name="a" select="($ws/@*)[1]"/>
                <xsl:choose>
                    <xsl:when test="$a">
                        <xsl:element name="{$a/local-name()}">
                            <xsl:attribute name="amount" select="$a"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:sequence select="$ws/*"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="document-fragment" mode="mlml:parse">
        <xsl:param name="properties" tunnel="yes" as="map(*)?"/>
        <xsl:variable name="document" as="element(mlml:document)">
            <document id="{$properties?document-id}" fragment="true">
                <xsl:if test="$properties?line-feed-format != '#default'">
                    <xsl:attribute name="line-feed-format" select="$properties?line-feed-format"/>
                </xsl:if>
                <xsl:apply-templates mode="#current">
                    <xsl:with-param name="space-preserve" select="true()" tunnel="yes"/>
                </xsl:apply-templates>
            </document>
        </xsl:variable>
        <xsl:sequence select="mlml:verify-constraints($document)"/>
    </xsl:template>
    
    <xsl:template match="document" mode="mlml:parse">
        <xsl:param name="properties" tunnel="yes" as="map(*)?"/>
        <xsl:variable name="document" as="element(mlml:document)">
            <document id="{$properties?document-id}" document-uri="{$properties?document-uri}">
                <xsl:attribute name="xml:base" select="$properties?base-uri"/>
                <xsl:if test="$properties?line-feed-format != '#default'">
                    <xsl:attribute name="line-feed-format" select="$properties?line-feed-format"/>
                </xsl:if>
                <xsl:apply-templates mode="#current"/>
            </document>
        </xsl:variable>
        <xsl:sequence select="mlml:verify-constraints($document)"/>
    </xsl:template>

    <xsl:template match="element" mode="mlml:parse">
        <xsl:param name="dtd" select="()" as="element(dtdml:dtd)?" tunnel="yes"/>
        <xsl:param name="config" tunnel="yes" as="map(*)"/>
        
        <xsl:variable name="el_name" as="element(mlml:name)">
            <xsl:apply-templates select="Name" mode="#current"/>
        </xsl:variable>
        <xsl:variable name="attribute-lists" select="$dtd//dtdml:attribute-list[@ref = $el_name]"/>
        <xsl:variable name="element-decl" select="$dtd//dtdml:element-decl[@name = $el_name]"/>
        
        <xsl:variable name="content-model" select="$element-decl/dtdml:content"/>
        <xsl:variable name="attributes" as="element()*">
            <xsl:apply-templates select="Attribute" mode="#current">
                <xsl:with-param name="attribute-lists" select="$attribute-lists" tunnel="yes"/>
                <xsl:with-param name="space-preserve" select="true()" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:variable>
        
        
        <xsl:variable name="default-attributes" as="element(mlml:attribute)*">
            <xsl:for-each-group select="$attribute-lists/dtdml:attribute" group-by="@name">
                <xsl:if test="@default">
                    <attribute default="true">
                        <xsl:choose>
                            <xsl:when test="matches(@name, '^xmlns(:|$)')">
                                <xsl:attribute name="namespace" select="'true'"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:sequence select="mlml:attribute-type(.)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <ws space="1" />
                        <name>
                            <xsl:value-of select="replace(@name, '^xmlns(:|$)', '')"/>
                        </name>
                        <eq />
                        <value>
                            <data>
                                <xsl:value-of select="@default"/>
                            </data>
                        </value>
                    </attribute>
                </xsl:if>
                
            </xsl:for-each-group>
        </xsl:variable>
        <xsl:variable name="default-attributes" select="
            $default-attributes[not(mlml:name = $attributes/mlml:name)]
            "/>
        <xsl:variable name="attributes" select="($default-attributes, $attributes)"/>
        
        <xsl:variable name="space-preserve" select="
            mlml:preserve-space($content-model, $attributes[mlml:name = 'xml:space'], $config)
            "/>
        
        <xsl:variable name="content" as="element()*">
            <xsl:apply-templates select="node() except Attribute" mode="#current">
                <xsl:with-param name="attribute-lists" select="$attribute-lists" tunnel="yes"/>
                <xsl:with-param name="space-preserve" select="$space-preserve" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:variable name="el_name" select="$content/self::mlml:name"/>
        
        <xsl:variable name="etag" select="ETag"/>
        
        <xsl:if test="Name != $etag/Name">
            <xsl:sequence select="mlml:error('3.0.39.1', 'The end tag ' || $etag/Name || ' does not match to the start tag ' || Name || '.')"/>
        </xsl:if>
        
        <element>
            <xsl:if test="not($etag)">
                <xsl:attribute name="collapsed" select="'true'"/>
            </xsl:if>
            <xsl:for-each select="$attributes[@namespace = 'true']">
                <xsl:variable name="value">
                    <xsl:apply-templates select="mlml:value" mode="mlml:doc"/>
                </xsl:variable>
                <xsl:variable name="value" select="string-join($value)"/>
                <xsl:variable name="name" select="mlml:name"/>
                <xsl:choose>
                    <xsl:when test="$name = 'xmlns'">
                        <xsl:sequence select="mlml:error('XML-Names.3.2.2', 'The prefix xmlns must not be used for namespace declarations')"/>
                    </xsl:when>
                    <xsl:when test="$value = 'http://www.w3.org/2000/xmlns/'">
                        <xsl:sequence select="mlml:error('XML-Names.3.2.2', 'The namespace URI http://www.w3.org/2000/xmlns/ is reserved and must not be used in namespace declarations')"/>
                    </xsl:when>
                    <xsl:when test="
                        $name = 'xml' and not($value = 'http://www.w3.org/XML/1998/namespace')
                        ">
                        <xsl:sequence select="mlml:error('XML-Names.3.2.1', 'The prefix xml is reserved and must be used only for the namespace URI http://www.w3.org/XML/1998/namespace.')"/>
                    </xsl:when>
                    <xsl:when test="
                        $value = 'http://www.w3.org/XML/1998/namespace' and not($name = 'xml') 
                        ">
                        <xsl:sequence select="mlml:error('XML-Names.3.2.1', 'The namespace URI http://www.w3.org/XML/1998/namespace is reserved and must be used only with the prefix xml.')"/>
                    </xsl:when>
                    <xsl:when test="$name = ''">
                        <xsl:attribute name="element-default-namespace" select="$value"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:namespace name="{$name}" select="$value"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            <xsl:variable name="el_start" select="$content[. &lt;&lt; $el_name] | $el_name"/>
            <xsl:sequence select="$el_start"/>
            <xsl:sequence select="$attributes"/>
            <xsl:sequence select="$content except $el_start"/>
        </element>
    </xsl:template>
    
    <xsl:function name="mlml:preserve-space" as="xs:boolean">
        <xsl:param name="content-model" as="element(dtdml:content)?"/>
        <xsl:param name="xml-space-attr" as="element(mlml:attribute)?"/>
        <xsl:param name="config" as="map(*)"/>
        
        <xsl:variable name="mixed-content" select="
            $content-model/@mixed = 'true'
            or $content-model/@preset = ('ANY', 'EMPTY')
            "/>
        <xsl:variable name="strip-space-cfg" select="($config($mlml:STRIP-WHITESPACE), 'ignorable')[1]"/>
        
        <xsl:sequence select="
            if ($xml-space-attr/mlml:value = 'preserve') 
            then true() 
            else if ($strip-space-cfg = 'all') 
            then false() 
            else if ($strip-space-cfg = 'none') 
            then true() 
            (:assume that $strip-space-cfg = 'ignorable':)
            else if ($mixed-content) 
            then true() 
            else if ($content-model) 
            then false() 
            else true()
            "/>
    </xsl:function>
    
    <xsl:template match="content" mode="mlml:parse">
        <xsl:param name="space-preserve" select="false()" as="xs:boolean" tunnel="yes"/>
        <xsl:variable name="content">
            <xsl:apply-templates mode="#current"/>
        </xsl:variable>
        <xsl:where-populated>
            <content>
                <xsl:attribute name="space" select="
                    if ($content/mlml:text or $space-preserve) 
                    then 'preserve' 
                    else 'skip'
                    "/>
                <xsl:for-each-group select="$content/*" group-adjacent="exists(self::mlml:text)">
                    <xsl:choose>
                        <xsl:when test="current-grouping-key()">
                            <xsl:copy>
                                <xsl:sequence select="current-group()/node()"/>
                            </xsl:copy>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each-group select="current-group()" group-adjacent="exists(self::mlml:ws)">
                                <xsl:sequence select=" 
                                    if (current-grouping-key()) 
                                    then mlml:merge-white-spaces(current-group()) 
                                    else current-group()
                                    "/>
                            </xsl:for-each-group> 
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each-group>
            </content>
        </xsl:where-populated>
    </xsl:template>

    <xsl:template match="Attribute[matches(Name, '^xmlns(:|$)')]" mode="mlml:parse">
        <attribute namespace="true">
            <xsl:apply-templates mode="#current"/>
        </attribute>
    </xsl:template>

    <xsl:template match="Attribute/Name[matches(., '^xmlns(:|$)')]" mode="mlml:parse">
        <name>
            <xsl:value-of select="
                if (. = 'xmlns') 
                then '' 
                else if (matches(., '^xmlns:[^:]+$')) 
                   then replace(., '^xmlns:', '') 
                   else mlml:error('XML-Names.4.8.0', 'Invalid prefix name ' || . ||  ' for a namespace declaration!')
                "/>
        </name>
    </xsl:template>

    <xsl:template match="Attribute" mode="mlml:parse">
        <xsl:param name="attribute-lists" select="()" tunnel="yes"/>
        <xsl:variable name="content" as="node()*">
            <xsl:apply-templates mode="#current"/>
        </xsl:variable>
        <xsl:variable name="name" select="$content/self::mlml:name"/>
        <attribute>
            <xsl:sequence select="mlml:attribute-type($attribute-lists/dtdml:attribute[@name = $name])"/>
            <xsl:sequence select="$content"/>
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
        <xsl:if test="matches(., '^xml$', 'i')">
            <xsl:sequence select="mlml:error('2.6.17.0', 'The target name ''xml'' is reserved for the XML declaration at the very beginning of the document.')"/>
        </xsl:if>
        <name>
            <xsl:apply-templates mode="#current"/>
        </name>
    </xsl:template>

    <xsl:template match="PIContentEnd" mode="mlml:parse">
        <xsl:param name="properties" as="map(xs:string, xs:string)" tunnel="yes"/>
        <xsl:analyze-string select="." regex="^([\s\r\n]*)(.*?)(\?>)$" flags="s">
            <xsl:matching-substring>
                <xsl:sequence select="mlml:white-space(regex-group(1), $properties?line-feed-format)"/>
                <xsl:if test="regex-group(2) != ''">
                    <value>
                        <xsl:sequence select="regex-group(2) => mlml:line-breaks($properties?line-feed-format)"/>
                    </value>
                </xsl:if>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:message terminate="yes">Failed to parse PI value "<xsl:value-of select="."/>"</xsl:message>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template match="CharData" mode="mlml:parse">
        <xsl:param name="properties" as="map(xs:string, xs:string)" tunnel="yes"/>
        <xsl:param name="space-preserve" select="false()" as="xs:boolean" tunnel="yes"/>
        <xsl:choose>
            <xsl:when test="$space-preserve or normalize-space(.) != ''">
                <text>
                    <xsl:apply-templates mode="#current"/>
                </text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="mlml:white-space(., $properties?line-feed-format)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="CDSect" mode="mlml:parse">
        <xsl:variable name="content">
            <xsl:apply-templates mode="#current"/>
        </xsl:variable>
        <text>
            <cdata-section>
                <!--
                    Handling exception of CDATA sections, to avoid to <data> elements in a row.
                -->
                <xsl:for-each-group select="$content/*" group-adjacent="name()">
                    <xsl:choose>
                        <xsl:when test="name() = 'data'">
                            <xsl:copy select=".">
                                <xsl:sequence select="current-group()/node()"/>
                            </xsl:copy>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:sequence select="current-group()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each-group> 
            </cdata-section>
        </text>
    </xsl:template>

    <xsl:template match="CDSect/TOKEN[. = ']'][following-sibling::TOKEN[. = ']']]" mode="mlml:parse">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>

    <xsl:template match="AttValue//Reference | EntityValue//Reference" mode="mlml:parse" priority="10">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    
    <xsl:template match="Reference" mode="mlml:parse">
        <xsl:param name="properties" as="map(xs:string, xs:string)" tunnel="yes"/>
        <xsl:param name="space-preserve" select="false()" as="xs:boolean" tunnel="yes"/>
        
        <xsl:variable name="entity" as="element(mlml:entity)">
            <xsl:apply-templates mode="#current"/>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$entity/@complex = 'true'">
                <xsl:sequence select="$entity"/>
            </xsl:when>
            <xsl:when test="$space-preserve or not(mlml:entity-is-whitespace($entity))">
                <text>
                    <xsl:sequence select="$entity"/>
                </text>
            </xsl:when>
            <xsl:otherwise>
                <ws>
                    <xsl:sequence select="$entity"/>
                </ws>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:function name="mlml:entity-is-whitespace" as="xs:boolean">
        <xsl:param name="entity" as="element(mlml:entity)"/>
        <xsl:variable name="ws-codepoints" select="
            'x9', 'xa', 'xd', 'x20', 
            '9', '10', '13', '32'
            "/>
        <xsl:sequence select="
            $entity[@name][*][not(* except mlml:ws)] 
            or 
            $entity/@codepoint/lower-case(.) = $ws-codepoints"/>
    </xsl:function>
    


    <xsl:template match="Reference/CharRef[CharRefDec | CharRefHex]" mode="mlml:parse">
        <xsl:variable name="charRef" select="CharRefDec | CharRefHex"/>
        <xsl:variable name="isHexRef" select="exists($charRef/self::CharRefHex)" as="xs:boolean"/>
        <xsl:variable name="charRef" select="
            if ($isHexRef) 
            then 'x' || $charRef 
            else $charRef
            "/>
        <xsl:variable name="codepoint" select="mlml:codepoint-by-charref($charRef)"/>
        <xsl:sequence select="mlml:check-valid-xml-char($codepoint)"/>
        <entity>
            <xsl:attribute name="codepoint" select="$charRef"/>
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
            <data>
                <xsl:value-of select="$pre-def-entities(Name)"/>
            </data>
        </entity>
    </xsl:template>
    
    <xsl:template match="Reference/EntityRef[Name]" mode="mlml:parse">
        <xsl:param name="config" tunnel="yes"/>
        <xsl:param name="dtd" select="()" as="element(dtdml:dtd)?" tunnel="yes"/>
        <xsl:param name="properties" as="map(xs:string, xs:string)" tunnel="yes"/>
        <xsl:variable name="nameRef" select="Name"/>
        
        <xsl:variable name="entity-decl" select="$dtd/dtdml:entity-decl[@name = $nameRef][1]"/>
        
        <xsl:variable name="is-attribute-value" select="ancestor::AttValue"/>
        
        <xsl:variable name="value" select="
            if (not($entity-decl) and $config($mlml:IGNORE-UNDECLARED-ENTITIES))
            then ()
            else if (not($entity-decl)) 
            then (mlml:error('4.1.68.1', 'No declaration for the named entity ' || $nameRef || '.')) 
            else if ($entity-decl/dtdml:external and $is-attribute-value) 
            then (mlml:error('3.1.41.2', 'The external entity reference ' || $nameRef || ' is not permitted in attribute values.')) 
            else if ($entity-decl/dtdml:external) 
            then 
                $entity-decl/dtdml:external/
                    mlml:load-external-resource(@systemId, @xml:base, @publicId, 'entity', $config)
                    ?content
            else if ($entity-decl/dtdml:value/@ndata-ref) 
                then mlml:error('4.1.68.3', 'Unparsed entity ' || $nameRef || ' must not be referenced.') 
            else 
                $entity-decl/dtdml:value
            "/>
        
        <xsl:variable name="fragment-parsed" select="xmlfp:parse-document-fragment(string($value))"/>
        
        <xsl:if test="$fragment-parsed/self::ERROR">
            <xsl:sequence select="error(xs:QName('mlml:fail'), serialize($fragment-parsed))"/>
        </xsl:if>
        
        <xsl:if test="$fragment-parsed/XMLDecl and not($entity-decl/dtdml:external)">
            <xsl:sequence select="mlml:error('4.3.2.78.0', 'An internal parsed entity must not start with a Text Declaration!')"/>
        </xsl:if>
        
        <xsl:variable name="doc-xml-version" select="$properties?xml-version"/>
        <xsl:variable name="ent-xml-version" select="($fragment-parsed/XMLDecl/VersionInfo/VersionNum/string(.), '1.0')[1]"/>
        
        <xsl:if test="$doc-xml-version != $ent-xml-version">
            <xsl:sequence select="mlml:error('E2e.38', 'An XML v' || $doc-xml-version || ' should not contain an external entity with XML v' || $ent-xml-version || '!')"/>
        </xsl:if>

        <xsl:variable name="fragment-parsed" select="$fragment-parsed/content/node()"/>
        
        <xsl:variable name="content">
            <xsl:apply-templates select="$fragment-parsed" mode="#current"/>
        </xsl:variable>
        <xsl:variable name="simple-content" select="
            $content/(
                mlml:text | mlml:ws | mlml:entity[not(@complex = 'true')]
            )
            "/>
        
        <entity>
            <xsl:attribute name="name" select="Name"/>
            <xsl:choose>
                <xsl:when test="$content/* except $simple-content">
                    <xsl:attribute name="complex" select="'true'"/>
                    <xsl:sequence select="$content/*"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="ws" select="$simple-content/self::mlml:ws"/>
                    <xsl:sequence select="($simple-content except $ws)/* | $ws"/>
                </xsl:otherwise>
            </xsl:choose>
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
        <xsl:param name="properties" as="map(xs:string, xs:string)" tunnel="yes"/>
        <xsl:sequence select="mlml:white-space(., $properties?line-feed-format)"/>
    </xsl:template>

    <xsl:function name="mlml:white-space" as="element(mlml:ws)?">
        <xsl:param name="space" as="xs:string"/>
        <xsl:param name="document-lf-format" as="xs:string"/>

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
                    <xsl:choose>
                        <xsl:when test="$el-name = 'nl'">
                            <xsl:sequence select="mlml:line-breaks(., $document-lf-format)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="{$el-name}">
                                <xsl:attribute name="amount" select="string-length(replace(., '\r\n', '&#xA;'))"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:sequence select="error(xs:QName('fatal-error'), 'This should never happen! mlml:white-space function must not be called with ''' || $space || ''' as input.')"/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="count($tokenized) = 0"/>
            <xsl:when test="count($tokenized) = 1 and $tokenized/@line-feed-format">
                <ws>
                    <xsl:sequence select="$tokenized"/>
                </ws>
            </xsl:when>
            <xsl:when test="count($tokenized) = 1">
                <ws>
                    <xsl:attribute name="{$tokenized/local-name()}" select="$tokenized/(@amount, 1)[1]"/>
                </ws>
            </xsl:when>
            <xsl:otherwise>
                <ws>
                    <xsl:for-each-group select="$tokenized" group-adjacent="name() || @line-feed-format">
                        <xsl:choose>
                            <xsl:when test="current-grouping-key() = 'nospace'">
                                <xsl:value-of select="current-group()" separator=""/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy>
                                    <xsl:variable name="amount" select="current-group()/(@amount, 1)[1] => sum()"/>
                                    <xsl:if test="$amount gt 1">
                                        <xsl:attribute name="amount" select="$amount"/>
                                    </xsl:if>
                                    <xsl:sequence select="current-group()/@line-feed-format"/>
                                </xsl:copy>
                            </xsl:otherwise>
                        </xsl:choose>

                    </xsl:for-each-group>
                </ws>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>
    
    <xsl:function name="mlml:merge-white-spaces" as="element(mlml:ws)*">
        <xsl:param name="ws" as="element(mlml:ws)*"/>
        <xsl:for-each-group select="$ws" group-adjacent="
            if (@space | @tab | @nl) then (@space, @tab, @nl)[1]/name() else 'complex'
            ">
            <xsl:choose>
                <xsl:when test="current-grouping-key() = 'complex'">
                    <ws>
                       <xsl:sequence select="current-group()/*"/> 
                    </ws>
                </xsl:when>
                <xsl:otherwise>
                    <ws>
                        <xsl:attribute name="{current-grouping-key()}" select="current-group()/@*[name() = current-grouping-key()] => sum()"/>
                    </ws>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each-group> 
    </xsl:function>

    <xsl:function name="mlml:line-breaks" as="node()*">
        <xsl:param name="text" as="xs:string?"/>
        <xsl:param name="document-format" as="xs:string"/>
        <xsl:variable name="nodes" as="node()*">
            <xsl:analyze-string select="$text" regex="(\r\n|\r|\n)">
                <xsl:matching-substring>
                    <xsl:variable name="amount" select="replace(., '\r\n', '&#xA;') => string-length()"/>
                    <nl>
                        <xsl:attribute name="amount" select="$amount"/>
                        <xsl:variable name="lf-type" select="mlml:lf-type(.)"/>
                        <xsl:attribute name="line-feed-format" select="
                            if ($lf-type = $document-format) 
                            then '#default' 
                            else $lf-type
                            "/>
                    </nl>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <data>
                        <xsl:value-of select="."/>
                    </data>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        
        <xsl:for-each-group select="$nodes" group-adjacent="(@line-feed-format, '#text')[1]">
            <xsl:choose>
                <xsl:when test="self::mlml:nl">
                    <xsl:variable name="amount" select="sum(current-group()/@amount)"/>
                    <nl>
                        <xsl:if test="$amount gt 1">
                            <xsl:attribute name="amount" select="$amount"/>
                        </xsl:if>
                        <xsl:if test="current-grouping-key() != '#default'">
                            <xsl:sequence select="@line-feed-format"/>
                        </xsl:if>
                    </nl>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:sequence select="current-group()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each-group> 
        
    </xsl:function>
    
    <xsl:function name="mlml:lf-type" as="xs:string">
        <xsl:param name="text" as="xs:string"/>
        <xsl:variable name="text" select="replace($text, '^[^\r\n]+', '')"/>
        <xsl:variable name="linefeed-format" select="
            if (matches($text, '^\r\n')) then
                'rn'
            else
                if (matches($text, '^\r')) then
                    'r'
                else
                    if (matches($text, '^\n')) then
                        'n'
                    else
                        '#default'
            "/>
        <xsl:sequence select="$linefeed-format"/>
    </xsl:function>
    
    

    <xsl:template match="text()" mode="mlml:parse">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="
        AttValue//text()
        | CommentContent//text()
        | CharData//text()
        | CDSect//text()
        
        " mode="mlml:parse">
        <xsl:param name="properties" as="map(xs:string, xs:string)" tunnel="yes"/>
        <xsl:sequence select="mlml:line-breaks(., $properties?line-feed-format)"/>
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
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="
            VersionInfo/Eq/TOKEN[. = '=']
            | EncodingDecl/Eq/TOKEN[. = '=']
            | SDDecl/Eq/TOKEN[. = '=']
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
            <data>
                <xsl:value-of select="."/>
            </data>
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

    <xsl:template match="doctypedecl/ExternalID[TOKEN = 'PUBLIC']" mode="mlml:parse">
        <public>
            <xsl:apply-templates mode="#current"/>
        </public>
    </xsl:template>

    <xsl:template match="
        doctypedecl/ExternalID/SystemLiteral
        | doctypedecl/ExternalID/PubidLiteral
        " mode="mlml:parse">
        <value>
            <xsl:if test="SystemLiteralSingle | PubidLiteralSingle">
                <xsl:attribute name="quotes" select="'single'"/>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
        </value>
    </xsl:template>
    <xsl:template match="
        doctypedecl/ExternalID/SystemLiteral/SystemLiteralDouble
        | doctypedecl/ExternalID/SystemLiteral/SystemLiteralSingle
        | doctypedecl/ExternalID/PubidLiteral/PubidLiteralDouble
        | doctypedecl/ExternalID/PubidLiteral/PubidLiteralSingle
        " mode="mlml:parse">
        <data>
            <xsl:value-of select="."/>
        </data>
    </xsl:template>


    <xsl:template match="doctypedecl/intSubset" mode="mlml:parse">
        <xsl:param name="config" as="map(*)" tunnel="yes"/>
        <xsl:param name="properties" as="map(xs:string, xs:string)" tunnel="yes"/>
        <inline>
            
            <xsl:for-each-group select="node()" group-adjacent="exists(self::markupdecl[PI]) and not($config($mlml:IGNORE-INLINE-DTD-PIS))">
                <xsl:choose>
                    <xsl:when test="current-grouping-key()">
                        <xsl:apply-templates select="current-group()/PI" mode="#current"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:sequence select="mlml:line-breaks(string-join(current-group()), $properties?line-feed-format)"/>
                    </xsl:otherwise>
                </xsl:choose>
                
            </xsl:for-each-group> 
        </inline>
    </xsl:template>
    
    <xsl:function name="mlml:attribute-type" as="attribute(type)?">
        <xsl:param name="attribute-decl" as="element(dtdml:attribute)*"/>
        <xsl:variable name="attribute-decl" select="$attribute-decl[1]"/>
        <xsl:choose>
            <xsl:when test="$attribute-decl/@type">
                <xsl:sequence select="$attribute-decl/@type"/>
            </xsl:when>
            <xsl:when test="$attribute-decl/dtdml:type">
                <xsl:attribute name="type" select="'ENUM'"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>

    <xsl:template match="*" mode="mlml:parse" priority="-100">
        <NOT_SUPPORTED>
            <xsl:copy>
                <xsl:apply-templates select="@*" mode="#current"/>
                <xsl:apply-templates mode="#current"/>
            </xsl:copy>
        </NOT_SUPPORTED>
    </xsl:template>



</xsl:stylesheet>
