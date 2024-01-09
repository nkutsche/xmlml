<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:mlml="http://www.nkutsche.com/xmlml" xmlns:dtdml="http://www.nkutsche.com/dtdml" xmlns="http://www.nkutsche.com/dtdml" xmlns:xmlp="http://www.nkutsche.com/xml-parser" xmlns:dtdp="http://www.nkutsche.com/dtd-parser" xmlns:dtdpe="http://www.nkutsche.com/dtd-pe-parser" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="#all" version="3.0">

    <xsl:mode name="mlml:dtd-pre-parse" on-no-match="shallow-copy"/>
    <xsl:mode name="mlml:dtd-pre-parse-quoted" on-no-match="shallow-copy"/>

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 11, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> Nico</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    
    <xsl:function name="mlml:parse-external-dtd" as="element(dtdml:dtd)?" visibility="final">
        <xsl:param name="href" as="xs:string"/>
        <xsl:param name="pubId" as="xs:string?"/>
        <xsl:sequence select="mlml:parse-external-dtd($href, $pubId, $default-config)"/>
    </xsl:function>
    
    <xsl:function name="mlml:parse-external-dtd" as="element(dtdml:dtd)?" visibility="final">
        <xsl:param name="href" as="xs:string"/>
        <xsl:param name="pubId" as="xs:string?"/>
        <xsl:param name="config" as="map(*)"/>
        
        <xsl:variable name="dtd-resource" select="
            mlml:load-external-resource($href, static-base-uri(), $pubId, 'entity', $config)
            "/>
        
        <xsl:sequence select="mlml:parse-dtds-from-string((), $dtd-resource, $config)"/>
        
    </xsl:function>


    <xsl:function name="mlml:parse-dtds-from-xml" as="element(dtdml:dtd)?">
        <xsl:param name="href" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:variable name="xml-resource" select="
            mlml:load-external-resource($href, static-base-uri(), (), 'regular', $config)
            "/>

        <xsl:variable name="xml-base-uri" select="$xml-resource?base-uri"/>

        <xsl:variable name="xml-preparsed" select="xmlp:parse-document($xml-resource?content)"/>
        
        <xsl:sequence select="mlml:parse-dtds-from-preparsed-xml($xml-preparsed, $xml-base-uri, $config)"/>
        
    </xsl:function>
    
    <xsl:function name="mlml:parse-dtds-from-preparsed-xml" as="element(dtdml:dtd)?">
        <xsl:param name="xml-preparsed" as="element(document)"/>
        <xsl:param name="base-uri" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        
        <xsl:variable name="dtd-decl" select="$xml-preparsed/prolog/doctypedecl"/>
        
        <xsl:variable name="inline" select="
            if($config($mlml:IGNORE-INLINE-DTD))
            then ()
            else $dtd-decl/intSubset/string(.)
            "/>
        
        <xsl:variable name="dtd-external-path" select="
            if($config($mlml:IGNORE-EXTERNAL-DTD))
            then ()
            else $dtd-decl/ExternalID/SystemLiteral/(SystemLiteralDouble | SystemLiteralSingle)/string(.)
            "/>
        <xsl:variable name="dtd-pub-id" select="
            $dtd-decl/ExternalID/PubidLiteral/(PubidLiteralDouble | PubidLiteralSingle)/string(.)
            "/>

        <xsl:variable name="dtd-ext-resource" select="
            if($dtd-external-path)
            then
                mlml:load-external-resource($dtd-external-path, $base-uri, $dtd-pub-id, 'entity', $config)
            else 
                ()
            "/>
        
        <xsl:variable name="internalSubset" select="
            if (exists($inline[. != ''])) 
                then map{
                    'content' : $inline,
                    'base-uri' : $base-uri
                } 
                else ()
            "/>

        <xsl:sequence select="mlml:parse-dtds-from-string($internalSubset, $dtd-ext-resource, $config)"/>

    </xsl:function>

    <xsl:function name="mlml:parse-dtds-from-string">
        <xsl:param name="internalSubset" as="map(xs:string, item())?"/>
        <xsl:param name="externalSubset" as="map(xs:string, item())?"/>
        <xsl:param name="config" as="map(*)"/>
        
        <xsl:variable name="inlineSubset" select="$internalSubset ! map:put(., 'internal-subset', true())"/>
        
        <xsl:variable name="external-is-dtdml" select="
            ($externalSubset ! matches(.?mediatype, 'xml$'), false())[1]
            " as="xs:boolean"/>

        <xsl:variable name="preparsed" select="mlml:dtd-pre-parse(($inlineSubset, $externalSubset[not($external-is-dtdml)]), $config) ! string(.)"/>

        <xsl:variable name="parsed" select="$preparsed ! dtdp:parse-document(.)"/>
        
        <xsl:if test="$parsed[self::ERROR]">
            <xsl:sequence select="mlml:error('unknown', string($parsed[self::ERROR][1]))"/>
        </xsl:if>
        
        <xsl:variable name="parsed" select="$parsed ! mlml:check-preparsed-dtd-constrains(.)"/>
        
        <xsl:variable name="parsed" as="document-node()">
            <xsl:document>
                <xsl:sequence select="$parsed"/>
            </xsl:document>
        </xsl:variable>
        <dtd>
            <xsl:apply-templates select="$parsed" mode="mlml:dtd-parse">
                <xsl:with-param name="config" select="$config" tunnel="yes"/>
            </xsl:apply-templates>
            <xsl:if test="$external-is-dtdml">
                <xsl:sequence select="mlml:debug('Detected DTDML as external subset', $config)"/>
                <xsl:variable name="linefeed" select="
                    if ($externalSubset?linefeed) then
                        $externalSubset?linefeed
                    else
                        mlml:lf-type($externalSubset?content)
                    "/>
                <xsl:variable name="base-uri" select="$externalSubset?base-uri"/>
                <xsl:sequence select="mlml:debug('Parses DTDML from ' || $base-uri , $config)"/>
                <xsl:variable name="dtdml" select="parse-xml($externalSubset?content)"/>
                <xsl:sequence select="$dtdml/*/node()"/>
                <xsl:sequence select="mlml:debug('Finished parsing DTDML', $config)"/>
            </xsl:if>
        </dtd>
    </xsl:function>
    
    <xsl:function name="mlml:check-preparsed-dtd-constrains" as="node()">
        <xsl:param name="parsed" as="node()"/>
        
        <xsl:if test="$parsed//(EntityStaticValueDouble | EntityStaticValueSingle)[contains(string(.), '%')]">
            <xsl:sequence select="mlml:error('4.1.69.0', 'The character ''%'' must be part of a parameter entity reference')"/>
        </xsl:if>
        
        <xsl:if test="$parsed//PITarget[matches(., '^xml$', 'i')]">
            <xsl:sequence select="mlml:error('2.6.17.0', 'The target name ''xml'' is reserved for the XML declaration at the very beginning of the document.')"/>
        </xsl:if>
        
        <xsl:sequence select="$parsed"/>
        
    </xsl:function>
    


    <xsl:function name="mlml:dtd-pre-parse" as="node()*">
        <xsl:param name="contents" as="map(xs:string, item())*"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:sequence select="mlml:dtd-pre-parse($contents, $config, ())"/>
    </xsl:function>

    <xsl:function name="mlml:dtd-pre-parse" as="node()*">
        <xsl:param name="contents" as="map(xs:string, item())*"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:param name="entities" as="map(xs:string, item()?)*"/>
        
        <xsl:variable name="head" select="head($contents)"/>
        <xsl:variable name="tail" select="tail($contents)"/>
        
        <xsl:variable name="head-ebnf-parsed" as="element()*">
            <xsl:for-each select="$head">
                <xsl:variable name="ebnf-parsed" select="dtdpe:parse-document(?content)"/>
                <xsl:variable name="base-uri" select="?base-uri"/>
                
                <xsl:if test="$ebnf-parsed/self::ERROR">
                    <xsl:sequence select="mlml:error('unknown', string($ebnf-parsed))"/>
                </xsl:if>
                
                <xsl:variable name="internal-subset" select="($head?internal-subset, false())[1]"/>
                <xsl:variable name="pe-refs" select="$ebnf-parsed//PEReference"/>
                <xsl:variable name="allowed-pe-refs" select="
                    $ebnf-parsed//DeclSep/PEReference
                    | $ebnf-parsed//AttlistDecl//quotedDeclContent//PEReference
                    "/>
                <xsl:if test="$internal-subset and ($pe-refs except $allowed-pe-refs)">
                    <xsl:sequence select="mlml:error('2.8.29.2', 'Parameter entities are not allowed in markup declarations of internal DTD subsets.')"/>
                </xsl:if>
                
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

    <xsl:template match="extSubsetDecl[conditionalSect/ignoreSectPE]" mode="mlml:dtd-pre-parse" priority="10">
        <xsl:param name="config" as="map(*)" tunnel="yes"/>
        <xsl:param name="entities" select="()" as="map(xs:string, item()?)*" tunnel="yes"/>
        <xsl:variable name="first-cond-pe-sect" select="conditionalSect[ignoreSectPE][1]"/>
        <xsl:variable name="head" select="*[. &lt;&lt; $first-cond-pe-sect]"/>
        <xsl:variable name="rest" select="* except ($head, $first-cond-pe-sect)"/>
        
        <xsl:variable name="head-resolved">
            <xsl:call-template name="mlml:dtd-pre-parse-extSubsetDecl">
                <xsl:with-param name="focus" select="$head"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="new-entities" as="map(xs:string, item()?)*" select="
            $head-resolved//EntityDecl/mlml:parse-entity(., base-uri(.), $config)
            "/>
        
        <xsl:variable name="entities" select="($entities, $new-entities)"/>
        
        <xsl:variable name="PERef" select="$first-cond-pe-sect/ignoreSectPE/PEReference"/>
        <xsl:variable name="IGNORE-OR-INCLUDE" select="
            mlml:dtd-resolve-parameter-entities([$PERef], $entities, $config)
            "/>
        <xsl:variable name="IGNORE-OR-INCLUDE" select="$IGNORE-OR-INCLUDE => string-join() => normalize-space()"/>
        
        <xsl:variable name="rest">
            <xsl:copy>
                <xsl:attribute name="xml:base" select="base-uri(.)"/>
                <xsl:choose>
                    <xsl:when test="$IGNORE-OR-INCLUDE = 'IGNORE'">
                        <conditionalSect>
                            <TOKEN>&lt;![</TOKEN>
                            <TOKEN>IGNORE</TOKEN>
                            <TOKEN>[</TOKEN>
                            <xsl:sequence select="$first-cond-pe-sect/ignoreSectPE/ignoreSectContents"/>
                            <TOKEN>]]&gt;</TOKEN>
                        </conditionalSect>
                    </xsl:when>
                    <xsl:when test="$IGNORE-OR-INCLUDE = 'INCLUDE'">
                        <conditionalSect>
                            <includeSect>
                                <TOKEN>&lt;![</TOKEN>
                                <TOKEN>INCLUDE</TOKEN>
                                <TOKEN>[</TOKEN>
                                <extSubsetDecl>
                                    <xsl:sequence select="dtdpe:parse-document(string($first-cond-pe-sect/ignoreSectPE/ignoreSectContents))"/>
                                </extSubsetDecl>
                                <TOKEN>]]&gt;</TOKEN>
                            </includeSect>
                        </conditionalSect>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes" expand-text="yes"
                            >Conditional section must have keyword "IGNORE" or "INCLUDE" but has "{$IGNORE-OR-INCLUDE}"!</xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:sequence select="$rest"/>
            </xsl:copy>
        </xsl:variable>
        
        <xsl:sequence select="$head-resolved"/>
        <xsl:apply-templates select="$rest/*" mode="#current">
            <xsl:with-param name="entities" select="$entities" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>
    
    
    <xsl:template match="extSubsetDecl" mode="mlml:dtd-pre-parse" name="mlml:dtd-pre-parse-extSubsetDecl">
        <xsl:param name="config" as="map(*)" tunnel="yes"/>
        <xsl:param name="entities" select="()" as="map(xs:string, item()?)*" tunnel="yes"/>
        <xsl:param name="focus" select="*" as="element()*"/>

        <xsl:variable name="iterations" as="array(element()*)*">
            <xsl:for-each-group select="$focus" group-starting-with="*[.//PEReference | .//PercentInEntityDecl[NCName]]">
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
                        $resolved//EntityDecl/mlml:parse-entity(., base-uri(.), $config)
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
                <xsl:text>(</xsl:text>
                <xsl:text>\s+NDATA\s+</xsl:text>
                <xsl:text>(.*?)</xsl:text>
                <xsl:text>\s*)?</xsl:text>
                <xsl:text>)</xsl:text>
                <xsl:text>\s*&gt;$</xsl:text>
            </xsl:variable>

            <xsl:analyze-string select="$enitydecl" regex="{$regex_local}">
                <xsl:matching-substring>
                    <xsl:sequence select="mlml:debug('Parsed Entity: ' || ., $config)"/>
                    <xsl:variable name="value" select="((regex-group(4), regex-group(5))[. != ''], '')[1]"/>

                    <xsl:sequence select="
                            map {
                                'is-param': normalize-space(regex-group(1)) = '%',
                                'name': regex-group(2),
                                'resolve' : function(){
                                    map{'content' : mlml:unescape-character-entities($value)}
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
                                    if (normalize-space(regex-group(15)) != '')
                                    then
                                        (regex-group(16))
                                    else
                                        ()"/>
                            <xsl:variable name="ext-type" 
                                select="
                                if ($ndata) then $ext-type || '-NDATA' else $ext-type
                                "/>

                            <xsl:sequence select="mlml:debug('Resolve external entity ' || regex-group(2) || ' to &quot;' || $systemId || '&quot;.', $config)"/>

                            <xsl:variable name="name" select="regex-group(2)"/>
                            <xsl:sequence select="
                                map {
                                        'is-param': normalize-space(regex-group(1)) = '%',
                                        'name': $name,
                                        'external': $ext-type,
                                        'resolve' : function(){
                                            if ($ndata) 
                                            then 
                                                mlml:error('4.1.68.3', 'Unparsed entity ' || $name || ' must not be referenced.') 
                                            else 
                                                mlml:load-external-resource($systemId, $base-uri, $pubId, 'entity', $config)
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

    <!-- 
        Parameter entities in Attribute values are not recognized
        https://www.w3.org/TR/xml/#entproc
    -->
    <xsl:template match="AttlistDecl/declContentWQuotes/quotedDeclContent//PEReference" mode="mlml:dtd-pre-parse" priority="50">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="EntityDecl" mode="mlml:dtd-pre-parse">
        <xsl:variable name="next-match" as="element(EntityDecl)">
            <xsl:next-match/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="matches(string($next-match), '^(&lt;!ENTITY\s+(%\s+)?[^\s''&quot;]+\s+(SYSTEM|PUBLIC)\s+)')">
                <xsl:sequence select="$next-match"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="$next-match" mode="mlml:dtd-pre-parse-quoted"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <!--    
        Ignore Parameter Entity References in quoted values
        At first PEReferences are resolved outside of quoted values
        Parameter Entity References in quoted values are resolved in mode mlml:dtd-pre-parse-quoted
        (depending on the context - which can be determinated after resolving the PEs outside the quotes at first)
        Sample: <!ENTITY foo %xxx; "%pe;"> 
        - if %xxx; is resolved to SYSTEM the %pe; is not resolved
        - if %xxx; is resolved to whitespace only the %pe; is resolved
    -->
    <xsl:template match="EntityDecl//quotedDeclContent//PEReference" mode="mlml:dtd-pre-parse" priority="40">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
<!--    
    Avoids resolving PEReferences twice
    -->
    <xsl:template match="PEReference[@resolved = 'true'] | PercentInEntityDecl[NCName][@resolved = 'true']" mode="mlml:dtd-pre-parse mlml:dtd-pre-parse-quoted" priority="100">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="PEReference | PercentInEntityDecl[NCName]" mode="mlml:dtd-pre-parse mlml:dtd-pre-parse-quoted">
        <xsl:param name="entities" as="map(xs:string, item()?)*" tunnel="yes"/>
        <xsl:variable name="name" select="replace(., '^%|;$', '')"/>
        <xsl:variable name="entity" select="$entities[?is-param][?name = $name][1]"/>
        
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
            <xsl:attribute name="resolved" select="'true'"/>

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

        <xsl:variable name="entity" select="$entities[?is-param][?name = $name][1]"/>
        
        <xsl:if test="empty($entity)">
            <xsl:sequence select="
                error(
                xs:QName('mlml:undeclared-parameter-entity'), 
                'Undeclared parameter entity ' || $name
                )
                "/>
        </xsl:if>

        <xsl:sequence select="mlml:debug('Resolves parameter entity reference ' || $name, $config)"/>
        
        <xsl:variable name="resolved" select="$entity?resolve()"/>
        <xsl:variable name="value" select="$resolved?content"/>
        
        <xsl:if test="empty($resolved?content)">
            <xsl:sequence select="mlml:warn('Resolved parameter entity ' || $name || 'is empty!', $config)"/>
            <xsl:sequence select="mlml:debug('Base URI is: ' || $resolved?base-uri, $config)"/>
        </xsl:if>
        
        <xsl:variable name="base-uri" select="($resolved?base-uri, base-uri(.))[1]"/>
        
        <xsl:variable name="contentObj" select="
            map{
                'content' : $value, 
                'base-uri' : string($base-uri)
            }
            "/>

        <xsl:variable name="external-preparsed" select="mlml:dtd-pre-parse($contentObj, $config, $entities)"/>
        
        <xsl:sequence select="
            if ($entity?external = ('SYSTEM', 'PUBLIC')) 
            then $external-preparsed/(* except prolog) 
            else $external-preparsed
            "/>

    </xsl:template>
    
    <xsl:function name="mlml:unescape-character-entities">
        <xsl:param name="value" as="xs:string"/>
        <xsl:sequence select="
            mlml:replace(
                $value, 
                '&amp;#(([0-9]+)|x([0-9a-fA-F]+));', 
                function($match, $groups){
                    if ($groups[@nr = '3']) 
                    then codepoints-to-string(mlml:hex-to-int($groups[@nr = '3'])) 
                    else codepoints-to-string(xs:integer($groups[@nr = '2']))
                }
            )
            "/>
    </xsl:function>
    
    <xsl:function name="mlml:replace" as="xs:string">
        <xsl:param name="value" as="xs:string"/>
        <xsl:param name="regex" as="xs:string"/>
        <xsl:param name="match" as="function(xs:string, element()*) as xs:string?"/>
        <xsl:sequence select="mlml:replace($value, $regex, $match, '')"/>
    </xsl:function>
    
    <xsl:function name="mlml:replace" as="xs:string">
        <xsl:param name="value" as="xs:string"/>
        <xsl:param name="regex" as="xs:string"/>
        <xsl:param name="match" as="function(xs:string, element()*) as xs:string?"/>
        <xsl:param name="flags" as="xs:string"/>
        <xsl:sequence select="mlml:analyze-string($value, $regex, $match, function($no-match){$no-match}, $flags)"/>
    </xsl:function>
    
    <xsl:function name="mlml:analyze-string" as="xs:string">
        <xsl:param name="value" as="xs:string"/>
        <xsl:param name="regex" as="xs:string"/>
        <xsl:param name="match" as="function(xs:string, element()*) as xs:string?"/>
        <xsl:param name="no-match" as="function(xs:string) as xs:string?"/>
        <xsl:sequence select="mlml:analyze-string($value, $regex, $match, $no-match, '')"/>
    </xsl:function>
    <xsl:function name="mlml:analyze-string" as="xs:string">
        <xsl:param name="value" as="xs:string"/>
        <xsl:param name="regex" as="xs:string"/>
        <xsl:param name="match" as="function(xs:string, element()*) as xs:string?"/>
        <xsl:param name="no-match" as="function(xs:string) as xs:string?"/>
        <xsl:param name="flags" as="xs:string"/>
        
        <xsl:sequence select="
            analyze-string($value, $regex, $flags)/*/(
                if (local-name() = 'match') 
                then $match(serialize(.), .//fn:group) 
                else $no-match(string(.))
            ) => string-join()
            "/>
        
    </xsl:function>
    
    <xsl:template match="
        quotedDeclContent[TOKEN = '&quot;']/Reference 
        | quotedDeclContent[TOKEN = '&quot;']/PEReference
        " mode="mlml:dtd-pre-parse-quoted" priority="10">
        <xsl:variable name="content">
            <xsl:next-match/>
        </xsl:variable>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:value-of select="replace($content, '&quot;', '&amp;#34;') ! replace(., '%', '&amp;#37;')"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="
        quotedDeclContent[TOKEN = '''']/Reference
        | quotedDeclContent[TOKEN = '''']/PEReference
        " mode="mlml:dtd-pre-parse-quoted" priority="10">
        <xsl:variable name="content">
            <xsl:next-match/>
        </xsl:variable>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:value-of select="replace($content, '''', '&amp;#39;') ! replace(., '%', '&amp;#37;')"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="CharRef[CharRefHex] | CharRef[CharRefDec]" mode="mlml:dtd-pre-parse">
        <xsl:sequence select="dtdml:resolve-charref(.)"/>
    </xsl:template>

    <xsl:function name="dtdml:resolve-charref" as="xs:string">
        <xsl:param name="charref" as="element(CharRef)"/>
        
        <xsl:variable name="codepoint" select="
            $charref/(
                if (CharRefHex) 
                then mlml:hex-to-int(CharRefHex) 
                else xs:integer(CharRefDec)
            )
            "/>
        
        <xsl:variable name="is-linebreak" select="$codepoint = (10, 13)"/>
        
        <xsl:sequence select="
            if ($is-linebreak) 
            then 
                string($charref)
            else 
                codepoints-to-string($codepoint) 
            "/>
        
    </xsl:function>

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
            | contentspec/Mixed | GEDecl | EntityDef | ExternalID
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

    <xsl:template match="contentspec[TOKEN = 'ANY']" mode="mlml:dtd-parse">
        <content preset="ANY"/>
    </xsl:template>

    <xsl:template match="contentspec[TOKEN = 'EMPTY']" mode="mlml:dtd-parse">
        <content preset="EMPTY"/>
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

            <xsl:variable name="defValue">
                <xsl:apply-templates select="DefaultDecl/AttValue/(AttValueDouble | AttValueSingle)" mode="mlml:dtd-parse-w-ents"/>
            </xsl:variable>

            <xsl:if test="DefaultDecl/AttValue">
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
        <entity-decl name="{GEDecl/NCName}">
            <xsl:apply-templates select="GEDecl/EntityDef" mode="#current"/>
        </entity-decl>
    </xsl:template>

    <xsl:template match="EntityDecl//EntityValue" mode="mlml:dtd-parse">
        <value>
            <xsl:apply-templates mode="#current"/>
        </value>
    </xsl:template>
    
    <xsl:template match="EntityValueDouble" mode="mlml:dtd-parse">
        <xsl:variable name="content">
            <xsl:apply-templates mode="#current"/>
        </xsl:variable>
        <xsl:value-of select="replace($content, '&amp;#34;', '&quot;')"/>        
    </xsl:template>

    <xsl:template match="EntityValueSingle" mode="mlml:dtd-parse">
        <xsl:variable name="content">
            <xsl:apply-templates mode="#current"/>
        </xsl:variable>
        <xsl:value-of select="replace($content, '&amp;#39;', '''')"/>        
    </xsl:template>
    
    <xsl:key name="entity-name" match="EntityDecl/GEDecl" use="NCName"/>
    
    <xsl:template match="EntityRef[$pre-def-entities(NCName)]" mode="mlml:dtd-parse-w-ents" priority="10">
        <xsl:value-of select="$pre-def-entities(NCName)"/>
    </xsl:template>
    <xsl:template match="EntityRef[NCName]" mode="mlml:dtd-parse-w-ents">
        <xsl:variable name="name" select="NCName"/>
        <xsl:variable name="this" select="."/>

        <xsl:variable name="entitydecl" select="key('entity-name', $name)[. &lt;&lt; $this][1]"/>
        <xsl:if test="not($entitydecl)">
            <xsl:sequence select="mlml:error('4.1.68.1', 'No declaration for the named entity ' || $name || '.')"/>
        </xsl:if>
        
        <xsl:if test="$entitydecl/EntityDef/ExternalID">
            <xsl:sequence select="mlml:error('3.1.41.2', 'The external entity reference ' || $name || ' is not permitted in attribute values.')"/>
        </xsl:if>
        
        <xsl:apply-templates select="
            $entitydecl/EntityDef/EntityValue/
            (EntityValueDouble|EntityValueSingle)
            /node()
            " mode="#current"/>
    </xsl:template>
    
    <xsl:template match="Reference" mode="mlml:dtd-parse">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="EntityDef[ExternalID/SystemLiteral]" mode="mlml:dtd-parse">
        <xsl:param name="config" as="map(*)" tunnel="yes"/>

        <xsl:variable name="systemId" select="ExternalID/SystemLiteral/string(SystemLiteralDouble | SystemLiteralSingle)"/>
        <xsl:variable name="pubId" select="ExternalID/PubidLiteral/string(PubidLiteralDouble | PubidLiteralSingle)"/>
        <xsl:variable name="base-uri" select="base-uri(.) => string()"/>
        <xsl:variable name="external_resolved" select="
            mlml:load-external-resource($systemId, $base-uri, $pubId, 'entity', $config)
            "/>
        <external systemId="{$systemId}">
            <xsl:if test="$pubId">
                <xsl:attribute name="pubId" select="$pubId"/>
            </xsl:if>
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
        <notation name="{NCName}">
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
