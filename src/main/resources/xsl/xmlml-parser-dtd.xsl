<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:mlml="http://www.nkutsche.com/xmlml" xmlns:dtdml="http://www.nkutsche.com/dtdml" xmlns="http://www.nkutsche.com/dtdml" xmlns:xmlp="http://www.nkutsche.com/xml-parser" xmlns:dtdp="http://www.nkutsche.com/dtd-parser" xmlns:dtdpe="http://www.nkutsche.com/dtd-pe-parser" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:array="http://www.w3.org/2005/xpath-functions/array" exclude-result-prefixes="#all" version="3.0">

    <xsl:mode name="mlml:dtd-pre-parse" on-no-match="shallow-copy"/>

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 11, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> Nico</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>


    <xsl:function name="mlml:parse-dtds-from-xml" as="element(dtdml:dtd)?">
        <xsl:param name="href" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:variable name="uri-resolver" select="$config($mlml:URI_RESOLVER)"/>
        <xsl:variable name="xml-resource" select="$uri-resolver($href, static-base-uri())"/>

        <xsl:variable name="xml-base-uri" select="$xml-resource?base-uri"/>

        <xsl:variable name="xml-preparsed" select="xmlp:parse-document($xml-resource?content)"/>
        
        <xsl:sequence select="mlml:parse-dtds-from-preparsed-xml($xml-preparsed, $xml-base-uri, $config)"/>
        
    </xsl:function>
    
    <xsl:function name="mlml:parse-dtds-from-preparsed-xml" as="element(dtdml:dtd)?">
        <xsl:param name="xml-preparsed" as="element(document)"/>
        <xsl:param name="base-uri" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        
        <xsl:variable name="uri-resolver" select="$config($mlml:URI_RESOLVER)"/>

        <xsl:variable name="dtd-decl" select="$xml-preparsed/prolog/doctypedecl"/>
        
        <xsl:variable name="inline" select="$dtd-decl/intSubset/string(.)"/>
        
        <xsl:variable name="dtd-external-path" select="$dtd-decl/ExternalID/SystemLiteral/(SystemLiteralDouble | SystemLiteralSingle)/string(.)"/>

        <xsl:variable name="dtd-ext-resource" select="
            if($dtd-external-path)
            then
                $uri-resolver($dtd-external-path, $base-uri)
            else 
                map{}
            "/>

        <xsl:variable name="contents" select="
                $inline, $dtd-ext-resource?content
                "/>
        <xsl:variable name="base-uris" select="
                $base-uri[$inline], $dtd-ext-resource?base-uri
                "/>

        <xsl:sequence select="mlml:parse-dtds-from-string($contents, $base-uris, $config)"/>

    </xsl:function>

    <xsl:function name="mlml:parse-dtds-from-string">
        <xsl:param name="content" as="xs:string*"/>
        <xsl:param name="base-uris" as="xs:string*"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:variable name="contentObjs" select="
            for $i in (1 to count($content))
            return map{
            'content' : string($content[$i]),
            'base-uri' : string($base-uris[$i])
            }
            " as="map(xs:string, xs:string)*"/>
        <xsl:sequence select="mlml:parse-dtds-from-string($contentObjs, $config)"/>
        
    </xsl:function>

    <xsl:function name="mlml:parse-dtds-from-string">
        <xsl:param name="contentObjs" as="map(xs:string, xs:string)*"/>
        <xsl:param name="config" as="map(*)"/>
        <!--        <xsl:param name="properties" as="map(xs:string, xs:string)"/>-->

        <xsl:variable name="preparsed" select="mlml:dtd-pre-parse($contentObjs, $config) => string-join()"/>

        <xsl:variable name="parsed" select="dtdp:parse-document($preparsed)"/>

        <dtd>
            <xsl:apply-templates select="$parsed" mode="mlml:dtd-parse">
                <xsl:with-param name="config" select="$config" tunnel="yes"/>
            </xsl:apply-templates>
        </dtd>
    </xsl:function>


    <xsl:function name="mlml:dtd-pre-parse" as="node()*">
        <xsl:param name="contents" as="map(xs:string, xs:string)*"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:sequence select="mlml:dtd-pre-parse($contents, $config, ())"/>
    </xsl:function>

    <xsl:function name="mlml:dtd-pre-parse" as="node()*">
        <xsl:param name="contents" as="map(xs:string, xs:string)*"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:param name="entities" as="map(xs:string, item()?)*"/>
        
        <xsl:variable name="head" select="head($contents)"/>
        <xsl:variable name="tail" select="tail($contents)"/>
        
        <xsl:variable name="head-ebnf-parsed" as="element()*">
            <xsl:for-each select="$head">
                <xsl:variable name="ebnf-parsed" select="dtdpe:parse-document(?content)"/>
                <xsl:variable name="base-uri" select="?base-uri"/>
                
                <xsl:copy select="$ebnf-parsed">
                    <xsl:attribute name="xml:base" select="$base-uri"/>
                    <xsl:sequence select="node()"/>
                </xsl:copy>
                
            </xsl:for-each>
        </xsl:variable>
        <xsl:apply-templates select="$head-ebnf-parsed" mode="mlml:dtd-pre-parse">
            <xsl:with-param name="config" select="$config" tunnel="yes"/>
            <xsl:with-param name="entities" select="$entities" tunnel="yes"/>
        </xsl:apply-templates>
        
        <xsl:if test="exists($tail)">
            <xsl:variable name="entities" select="$head-ebnf-parsed//EntityDecl/mlml:parse-entity(., base-uri(.), $config)"/>

            <xsl:sequence select="mlml:dtd-pre-parse($tail, $config, $entities)"/>
            
        </xsl:if>
        
        

    </xsl:function>

    <xsl:template match="extSubsetDecl" mode="mlml:dtd-pre-parse">
        <xsl:param name="config" as="map(*)" tunnel="yes"/>
        <xsl:param name="entities" select="()" as="map(xs:string, item()?)*" tunnel="yes"/>

        <xsl:variable name="iterations" as="array(element()*)*">
            <xsl:for-each-group select="*" group-starting-with="*[.//PEReference | .//PercentInEntityDecl[Name]]">
                <xsl:sequence select="[current-group()]"/>
            </xsl:for-each-group>
        </xsl:variable>
        <xsl:sequence select="mlml:dtd-resolve-parameter-entities(array:join($iterations), $entities, $config)"/>

    </xsl:template>

    <xsl:function name="mlml:dtd-resolve-parameter-entities" as="element()*">
        <xsl:param name="resolve-iterations" as="array(element()*)"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:sequence select="mlml:dtd-resolve-parameter-entities($resolve-iterations, (), $config)"/>
    </xsl:function>

    <xsl:function name="mlml:dtd-resolve-parameter-entities" as="element()*">
        <xsl:param name="resolve-iterations" as="array(element()*)"/>
        <xsl:param name="entities" as="map(xs:string, item()?)*"/>
        <xsl:param name="config" as="map(*)"/>

        <xsl:variable name="head" select="array:head($resolve-iterations)"/>
        <xsl:variable name="tail" select="array:tail($resolve-iterations)"/>


        <xsl:choose>
            <xsl:when test="array:size($resolve-iterations) = 0">
                <xsl:sequence select="()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="resolved" as="element()*">
                    <xsl:apply-templates select="$head" mode="mlml:dtd-pre-parse">
                        <xsl:with-param name="config" select="$config" tunnel="yes"/>
                        <xsl:with-param name="entities" select="$entities" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:variable>
                <xsl:variable name="new-entities" as="map(xs:string, item()?)*" select="
                        $resolved/EntityDecl/mlml:parse-entity(., base-uri(.), $config)
                        "/>

                <xsl:sequence select="$resolved"/>
                <ITERATE/>
                <xsl:sequence select="mlml:dtd-resolve-parameter-entities($tail, ($entities, $new-entities), $config)"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>

    <!--  regex for quoted values  -->
    <xsl:variable name="quot_value_regex">('([^']*)'|"([^"]*)")</xsl:variable>

    <xsl:template match="EntityDecl" mode="mlml:dtd-pre-parse" priority="10">
        <xsl:variable name="next-match" as="element(EntityDecl)">
            <xsl:next-match/>
        </xsl:variable>
        <xsl:variable name="base-uri" select="base-uri(.)"/>
        <xsl:copy select="$next-match">
            <xsl:sequence select="@*"/>
            <xsl:analyze-string select="." regex="^(&lt;!ENTITY\s+(%\s+)?[^\s'&quot;]+\s+SYSTEM\s+){$quot_value_regex}(\s*&gt;$)">
                <xsl:matching-substring>
                    <xsl:variable name="value" select="regex-group(3)"/>
                    <xsl:variable name="q" select="substring($value, 1, 1)"/>
                    <xsl:variable name="value" select="substring($value, 2, string-length($value) - 2)"/>
                    <xsl:value-of select="
                            regex-group(1),
                            $q,
                            resolve-uri($value, $base-uri),
                            $q,
                            regex-group(6)
                            " separator=""/>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:analyze-string select="." regex="^(&lt;!ENTITY\s+(%\s+)?[^\s'&quot;]+\s+PUBLIC\s+{$quot_value_regex}\s+){$quot_value_regex}(\s*&gt;$)">
                        <xsl:matching-substring>
                            <xsl:variable name="value" select="regex-group(6)"/>
                            <xsl:variable name="q" select="substring($value, 1, 1)"/>
                            <xsl:variable name="value" select="substring($value, 2, string-length($value) - 2)"/>
                            <xsl:value-of select="
                                    regex-group(1),
                                    $q,
                                    resolve-uri($value, $base-uri),
                                    $q,
                                    regex-group(9)
                                    " separator=""/>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:copy>

    </xsl:template>


    <xsl:function name="mlml:parse-entity" as="map(xs:string, item()?)">
        <xsl:param name="enitydecl" as="xs:string"/>
        <xsl:param name="base-uri" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>

        <xsl:map>


            <xsl:variable name="regex_local">^&lt;!ENTITY\s+(%\s+)?([^\s'"]+)\s+('([^']*)'|"([^"]*)")\s*&gt;$</xsl:variable>

            <xsl:variable name="regex_external">
                <xsl:text>^&lt;!ENTITY\s+</xsl:text>
                <xsl:text>(%\s+)?</xsl:text>
                <xsl:text>([^\s'"]+)\s+</xsl:text>
                <xsl:text>(</xsl:text>
                <xsl:text>SYSTEM\s+</xsl:text>
                <xsl:sequence select="$quot_value_regex"/>
                <xsl:text>(</xsl:text>
                <xsl:text>\s+NDATA\s+</xsl:text>
                <xsl:text>(.*?)</xsl:text>
                <xsl:text>\s*)?</xsl:text>
                <xsl:text>|</xsl:text>
                <xsl:text>PUBLIC\s+</xsl:text>
                <xsl:sequence select="$quot_value_regex"/>
                <xsl:text>\s+</xsl:text>
                <xsl:sequence select="$quot_value_regex"/>
                <xsl:text>)</xsl:text>
                <xsl:text>\s*&gt;$</xsl:text>
            </xsl:variable>

            <xsl:analyze-string select="$enitydecl" regex="{$regex_local}">
                <xsl:matching-substring>
                    <xsl:message expand-text="yes">Parsed Entity: {.}</xsl:message>
                    <xsl:variable name="value" select="(regex-group(4), regex-group(5), '')[. != ''][1]"/>

                    <xsl:sequence select="
                            map {
                                'is-param': normalize-space(regex-group(1)) = '%',
                                'name': regex-group(2),
                                'resolve' : function(){
                                    map{'content' : $value}
                                }
                            }"/>

                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:analyze-string select="." regex="{$regex_external}">
                        <xsl:matching-substring>
                            <xsl:variable name="ext-type" select="substring-before(regex-group(3), ' ')"/>
                            <xsl:variable name="systemId" select="
                                    if ($ext-type = 'SYSTEM')
                                    then
                                        (regex-group(5), regex-group(6))[. != ''][1]
                                    else
                                        (regex-group(13), regex-group(14))[. != ''][1]
                                    "/>
                            <xsl:variable name="pubId" select="
                                    if ($ext-type = 'PUBLIC')
                                    then
                                        (regex-group(10), regex-group(11))[. != ''][1]
                                    else
                                        ()"/>
                            <xsl:variable name="ndata" select="
                                    if (normalize-space(regex-group(7)) != '')
                                    then
                                        (regex-group(8))
                                    else
                                        ()"/>
                            <xsl:variable name="ext-type" 
                                select="
                                if ($ndata) then $ext-type || '-NDATA' else $ext-type
                                "/>

                            <xsl:variable name="uri-resolver" select="$config($mlml:URI_RESOLVER)"/>

                            <xsl:message expand-text="yes">Resolve external entity {regex-group(2)} to "{$systemId}".</xsl:message>

                            <xsl:variable name="name" select="regex-group(2)"/>
                            <xsl:sequence select="
                                map {
                                        'is-param': normalize-space(regex-group(1)) = '%',
                                        'name': $name,
                                        'external': $ext-type,
                                        'resolve' : function(){
                                            if ($ndata) 
                                            then mlml:error(413, 'Unparsed entity ' || $name || 'must not be referenced.') 
                                            else $uri-resolver($systemId, $base-uri)
                                        }
                                    }"/>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:message expand-text="yes" terminate="yes">Could not parse Entity {.}</xsl:message>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:map>
    </xsl:function>

    <xsl:template match="PEReference | PercentInEntityDecl[Name]" mode="mlml:dtd-pre-parse">
        <xsl:param name="entities" as="map(xs:string, item()?)*" tunnel="yes"/>
        <xsl:variable name="name" select="replace(., '^%|;$', '')"/>
        <xsl:variable name="entity" select="$entities[?is-param][?name = $name]"/>
        
        <xsl:if test="empty($entity)">
            <xsl:sequence select="
                error(
                    xs:QName('mlml:undeclared-parameter-entity'), 
                    'Undeclared parameter entity ' || $name
                )
                "/>
        </xsl:if>
        
        <xsl:variable name="resolved" select="$entity?resolve()"/>
        <xsl:variable name="value" select="$resolved?content"/>
        <xsl:variable name="with-spaces" select="not(ancestor::quotedDeclContent)"/>
        
        <xsl:copy>

            <xsl:if test="exists($resolved?base-uri)">
                <xsl:attribute name="xml:base" select="$resolved?base-uri"/>
            </xsl:if>

            <xsl:sequence select="' '[$with-spaces]"/>
            <xsl:value-of select="$value"/>
            <xsl:sequence select="' '[$with-spaces]"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="DeclSep[PEReference]" mode="mlml:dtd-pre-parse">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>

    <xsl:template match="DeclSep/PEReference" mode="mlml:dtd-pre-parse" priority="10">
        <xsl:param name="entities" as="map(xs:string, item()?)*" tunnel="yes"/>
        <xsl:param name="config" as="map(*)" tunnel="yes"/>

        <xsl:variable name="name" select="replace(., '^%|;$', '')"/>

        <xsl:variable name="entity" select="$entities[?is-param][?name = $name]"/>
        
        <xsl:if test="empty($entity)">
            <xsl:sequence select="
                error(
                xs:QName('mlml:undeclared-parameter-entity'), 
                'Undeclared parameter entity ' || $name
                )
                "/>
        </xsl:if>
        
        <xsl:variable name="resolved" select="$entity?resolve()"/>
        <xsl:variable name="value" select="$resolved?content"/>
        
        <xsl:variable name="base-uri" select="($entity?base-uri, base-uri(.))[1]"/>

        <xsl:variable name="contentObj" select="
            map{
                'content' : $resolved?content, 
                'base-uri' : string($base-uri)
            }
            "/>

        <xsl:sequence select="mlml:dtd-pre-parse($contentObj, $config, $entities)/document/(* except prolog)"/>

    </xsl:template>
    
    <xsl:template match="
        quotedDeclContent[TOKEN = '&quot;']/Reference 
        | quotedDeclContent[TOKEN = '&quot;']/PEReference
        " mode="mlml:dtd-pre-parse" priority="10">
        <xsl:variable name="content">
            <xsl:next-match/>
        </xsl:variable>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:value-of select="replace($content, '&quot;', '&amp;#34;')"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="
        quotedDeclContent[TOKEN = '''']/Reference
        | quotedDeclContent[TOKEN = '''']/PEReference
        " mode="mlml:dtd-pre-parse" priority="10">
        <xsl:variable name="content">
            <xsl:next-match/>
        </xsl:variable>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:value-of select="replace($content, '''', '&amp;#39;')"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="CharRef[CharRefHex]" mode="mlml:dtd-pre-parse">
        <xsl:value-of select="codepoints-to-string(mlml:hex-to-int(CharRefHex))"/>
    </xsl:template>

    <xsl:template match="CharRef[CharRefDec]" mode="mlml:dtd-pre-parse">
        <xsl:value-of select="codepoints-to-string(xs:integer(CharRefDec))"/>
    </xsl:template>

    <xsl:template match="markupdecl" mode="mlml:dtd-pre-parse">
        <xsl:copy>
            <xsl:attribute name="xml:base" select="base-uri(.)"/>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>


    <!--    
    Main DTD Parsing
    -->

    <xsl:template match="
            prolog | Comment | PI | TOKEN | S | elementdecl/Name | EntityDecl[PEDecl]
            | PubidLiteral | EOF | ignoreSect
            " mode="mlml:dtd-parse"/>

    <xsl:template match="
            document | extSubsetDecl | markupdecl | DeclSep
            | contentspec/Mixed | GEDecl | EntityDef | ExternalID | EntityValueDouble | EntityValueSingle
            | EntityStaticValueDouble | EntityStaticValueSingle | conditionalSect | includeSect | extSubsetDecl
            " mode="mlml:dtd-parse">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>

    <xsl:template match="elementdecl" mode="mlml:dtd-parse">
        <element-decl name="{Name}">
            <xsl:apply-templates mode="#current"/>
        </element-decl>
    </xsl:template>

    <xsl:template match="contentspec[Mixed]" mode="mlml:dtd-parse">
        <content mixed="true" repeating="true">
            <choice>
                <xsl:apply-templates mode="#current"/>
            </choice>
        </content>
    </xsl:template>

    <xsl:template match="contentspec" mode="mlml:dtd-parse">
        <content>
            <xsl:apply-templates mode="#current"/>
        </content>
    </xsl:template>

    <xsl:template match="choiceOrSeq" mode="mlml:dtd-parse">
        <sequence>
            <xsl:apply-templates mode="#current"/>
        </sequence>
    </xsl:template>

    <xsl:template match="choiceOrSeq[TOKEN = '|']" mode="mlml:dtd-parse" priority="10">
        <choice>
            <xsl:apply-templates mode="#current"/>
        </choice>
    </xsl:template>

    <xsl:template match="contentspec//Name" mode="mlml:dtd-parse">
        <element ref="{.}"/>
    </xsl:template>

    <xsl:template match="cp | children" mode="mlml:dtd-parse">
        <xsl:variable name="content" as="element()">
            <xsl:apply-templates mode="#current"/>
        </xsl:variable>
        <xsl:variable name="token" select="TOKEN"/>
        <xsl:copy select="$content">
            <xsl:sequence select="@*"/>
            <xsl:if test="$token = ('+', '*')">
                <xsl:attribute name="repeating" select="'true'"/>
            </xsl:if>
            <xsl:if test="$token = ('?', '*')">
                <xsl:attribute name="optional" select="'true'"/>
            </xsl:if>
            <xsl:sequence select="node()"/>
        </xsl:copy>

    </xsl:template>


    <!--    
    Attributes
    -->

    <xsl:template match="AttlistDecl" mode="mlml:dtd-parse">
        <attribute-list ref="{Name}">
            <xsl:apply-templates select="AttDef" mode="#current"/>
        </attribute-list>
    </xsl:template>

    <xsl:template match="AttlistDecl/AttDef" mode="mlml:dtd-parse">
        <attribute name="{Name}">

            <xsl:if test="DefaultDecl/TOKEN = '#IMPLIED'">
                <xsl:attribute name="optional" select="true()"/>
            </xsl:if>

            <xsl:if test="DefaultDecl/TOKEN = '#FIXED'">
                <xsl:attribute name="fixed" select="true()"/>
            </xsl:if>

            <xsl:variable name="defValue" select="DefaultDecl/AttValue/(AttValueDouble | AttValueSingle)"/>

            <xsl:if test="$defValue">
                <xsl:attribute name="default" select="$defValue"/>
            </xsl:if>

            <xsl:variable name="simpleType" select="AttType/(StringType | TokenizedType)"/>
            <xsl:choose>
                <xsl:when test="$simpleType">
                    <xsl:attribute name="type" select="$simpleType"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="AttType" mode="#current"/>
                </xsl:otherwise>
            </xsl:choose>

        </attribute>
    </xsl:template>

    <xsl:template match="AttDef/AttType[EnumeratedType/NotationType]" mode="mlml:dtd-parse">
        <type notation="true">
            <xsl:for-each select="EnumeratedType/NotationType/Name">
                <enum>
                    <xsl:value-of select="."/>
                </enum>
            </xsl:for-each>
        </type>
    </xsl:template>

    <xsl:template match="AttDef/AttType[EnumeratedType/Enumeration]" mode="mlml:dtd-parse">
        <type>
            <xsl:for-each select="EnumeratedType/Enumeration/Nmtoken">
                <enum>
                    <xsl:value-of select="."/>
                </enum>
            </xsl:for-each>
        </type>
    </xsl:template>


    <!--    
    Entities
    -->

    <xsl:template match="EntityDecl[GEDecl]" mode="mlml:dtd-parse">
        <entity-decl name="{GEDecl/Name}">
            <xsl:apply-templates select="GEDecl/EntityDef" mode="#current"/>
        </entity-decl>
    </xsl:template>

    <xsl:template match="EntityDecl//EntityValue" mode="mlml:dtd-parse">
        <value>
            <xsl:apply-templates mode="#current"/>
        </value>
    </xsl:template>

    <xsl:template match="Reference" mode="mlml:dtd-parse">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="EntityDef[ExternalID/SystemLiteral]" mode="mlml:dtd-parse">
        <xsl:param name="config" as="map(*)" tunnel="yes"/>

        <xsl:variable name="uri-resolver" select="$config($mlml:URI_RESOLVER)"/>
        <xsl:variable name="systemId" select="ExternalID/SystemLiteral/string(SystemLiteralDouble | SystemLiteralSingle)"/>
        <xsl:variable name="base-uri" select="base-uri(.) => string()"/>
        <xsl:variable name="external_resolved" select="$uri-resolver($systemId, $base-uri)"/>
        <external systemId="{$systemId}">
            <xsl:attribute name="xml:base" select="$base-uri"/>
        </external>
    </xsl:template>

    <xsl:template match="EntityDef[ExternalID/SystemLiteral][NDataDecl]" mode="mlml:dtd-parse" priority="10">
        <xsl:param name="config" as="map(*)" tunnel="yes"/>
        <xsl:variable name="systemId" select="ExternalID/SystemLiteral/string(SystemLiteralDouble | SystemLiteralSingle)"/>

        <value ndata-ref="{NDataDecl/Name}">
            <xsl:value-of select="$systemId"/>
        </value>
    </xsl:template>

    <!--    
    Notations
    -->
    <xsl:template match="NotationDecl" mode="mlml:dtd-parse">
        <xsl:variable name="systemId" select="ExternalOrPublicID/SystemLiteral/(SystemLiteralDouble | SystemLiteralSingle)/string()"/>
        <xsl:variable name="publicId" select="ExternalOrPublicID/PubidLiteral/(PubidLiteralDouble | PubidLiteralSingle)/string()"/>
        <notation name="{Name}">
            <xsl:if test="exists($systemId)">
                <xsl:attribute name="systemId" select="$systemId"/>
            </xsl:if>
            <xsl:if test="exists($publicId)">
                <xsl:attribute name="publicId" select="$publicId"/>
            </xsl:if>
            <xsl:apply-templates select="GEDecl/EntityDef" mode="#current"/>
        </notation>
    </xsl:template>

    <xsl:template match="*" mode="mlml:dtd-parse" priority="-100">
        <NOT_SUPPORTED>
            <xsl:copy>
                <xsl:apply-templates select="@*" mode="#current"/>
                <xsl:apply-templates mode="#current"/>
            </xsl:copy>
        </NOT_SUPPORTED>
    </xsl:template>




</xsl:stylesheet>
