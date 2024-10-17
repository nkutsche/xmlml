<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:x="http://www.jenitennison.com/xslt/xspec" xmlns:mlml="http://www.nkutsche.com/xmlml"
    xmlns:mlmlt="http://www.nkutsche.com/xmlml/test-helper"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    
    <xsl:param name="focus" as="xs:string?"/>
    
    <xsl:variable name="focus-map" select="
        if(exists($focus) and normalize-space($focus) != '') then
        let $tk := tokenize($focus, '=')
        return
        map{$tk[1] : $tk[2] => tokenize(',')}
        else ()
        "/>

    
    <xsl:template match="/">
        <x:description xmlns:x="http://www.jenitennison.com/xslt/xspec" xmlns:mlml="http://www.nkutsche.com/xmlml" stylesheet="{resolve-uri('test-runner.xsl', static-base-uri())}">
            <x:helper package-name="http://maxtoroq.github.io/rng-xsl" package-version="*"/>
            <xsl:call-template name="test-caller"/>
            <xsl:apply-templates/>
        </x:description>
    </xsl:template>
    
    <xsl:template match="TESTCASES[@PROFILE]">
        <x:scenario label="{@PROFILE}" catch="true">
            <xsl:apply-templates/>
        </x:scenario>
    </xsl:template>
    
    <xsl:template match="TEST[@NAMESPACE = 'no']" priority="15"/>
    
    
    <xsl:variable name="ignorings" select="doc('XMLConf-Testsuite-Exclusions.xml')"/>
    
    <xsl:key name="ignore-id" match="ignore[@id]" use="@id"/>
    <xsl:key name="ignore-edition" match="ignore[@edition]" use="@edition"/>
    <xsl:key name="ignore-version" match="ignore[@version]" use="@version"/>
    
    <xsl:template match="TEST">
        <xsl:variable name="with-out-def" select="@OUTPUT"/>
        <xsl:variable name="type" select="@TYPE"/>
        
        <xsl:variable name="src" select="resolve-uri(@URI, base-uri(.))"/>
        <xsl:variable name="out" select=" if ($with-out-def) then resolve-uri(@OUTPUT, base-uri(.)) else $src "/>
        <xsl:variable name="ignore" select="
            (key('ignore-id', @ID, $ignorings)
            | key('ignore-edition', @EDITION/tokenize(.,'\s'), $ignorings)
            | key('ignore-version', @VERSION, $ignorings))
            "/>
        <x:scenario label="&lt;&lt;{@ID}>>: {normalize-space(.)}" catch="true">
            <xsl:choose>
                <xsl:when test="$ignore">
                    <xsl:variable name="ignore-ids" select="@ID, @EDITION, @VERSION"/>
                    <xsl:variable name="ignore-attr" select="$ignore-ids[tokenize(., '\s') = $ignore/@*]"/>
                    <xsl:attribute name="pending" select="'Reason-code: [[' || $ignore/parent::reason/@id || ']]'"/>
                </xsl:when>
                <xsl:when test="$focus-map?id = @ID">
                    <xsl:attribute name="focus" select="'Focused by ID'"/>
                </xsl:when>
                <xsl:when test="$focus-map?type = $type">
                    <xsl:attribute name="focus" select="'Focused by type ''' || $type || ''''"/>
                </xsl:when>
            </xsl:choose>
            
            <x:variable name="src" select="'{$src}'"/>
            <xsl:if test="$with-out-def">
                <x:variable name="out" select="'{$out}'"/>
            </xsl:if>
            <xsl:variable name="like" select="
                if (not($type = ('valid', 'invalid'))) 
                then $type
                else 
                    if (not(doc-available($out))) 
                    then $type || '-no-xerces' 
                    else if ($with-out-def) 
                    then $type || '-w-outdef'
                    else $type
                "/>
            <x:like label="{$like}"/>
        </x:scenario>
    </xsl:template>
    
    <xsl:template name="test-caller">
        
        <x:scenario label="not-wf" shared="true" catch="true">
            <x:call function="mlml:parse-and-validate">
                <x:param select="$src"/>
                <x:param select="$cfg-w-outdef"/>
            </x:call>
            <x:expect label="Expected an error message" test="$x:result instance of map(*)"/>
        </x:scenario>
        
        <!--        
            NOTE: the test type "error" means:
            Conforming XML 1.0 Processors are permitted to ignore certain errors, or to report them at user option. 
            See https://www.w3.org/XML/Test/xmlconf-20080827.html#error
            That's why the test case just checks that result is an error or the result is a valid mlml:document
        -->
        <x:scenario label="error" shared="true" catch="true">
            <x:call function="mlml:parse">
                <x:param select="$src"/>
            </x:call>
            <x:expect label="Parser returns anything" test="
                if ($x:result instance of element()) 
                then exists(mlml:validate-xmlml($x:result)/self::mlml:document) 
                else $x:result instance of map(*)
                "/>
        </x:scenario>

        <x:scenario label="mlml:parse-and-serialize" shared="true" catch="true">
            <x:call function="mlml:parse-and-serialize">
                <x:param select="$src"/>
                <x:param select="true()"/>
            </x:call>
            <x:expect label="No change after parsed and serialized" test=" 
                if ($x:result instance of map(*)) 
                then $x:result?err?description 
                else $x:result
                " select="unparsed-text($src)"/>
        </x:scenario>
        
        <x:scenario label="mlml:doc" shared="true" catch="true">
            <x:variable name="xmlml" select="
                mlmlt:try-catch(
                function(){{
                    mlml:parse($src, $default-config)
                }}
                )
                "/>
            <x:call function="mlml:doc">
                <x:param select="$xmlml"/>
            </x:call>
            
            <x:expect label="XMLML as XDM" test="$x:result" 
                select="
                    mlmlt:try-catch(
                        function(){{
                            doc($src)
                        }}
                    )
                    "/>
        </x:scenario>

        <x:scenario label="mlml:doc-w-outdef" shared="true" catch="true">
            <x:variable name="xmlml" select="
                mlmlt:try-catch(
                function(){{
                    mlml:parse($src, $cfg-w-outdef)
                }}
                )
                "/>
            <x:call function="mlml:doc">
                <x:param select="$xmlml"/>
            </x:call>
            
            <x:expect label="XMLML as XDM" test="mlml:ignore-comments($x:result)" 
                select="
                    mlmlt:try-catch(
                        function(){{
                            doc($out)
                        }}
                    )
                    "/>
        </x:scenario>

        <x:scenario label="mlml:parse-dtd-and-validate" shared="true" catch="true">
            
            <x:variable name="dtdml" select="
                mlmlt:try-catch(
                    function(){{
                        mlml:parse-dtds-from-xml($src, $default-config)
                    }}
                )
                "/>
            
            <x:call function="mlml:validate-dtd">
                <x:param select="$dtdml"/>
            </x:call>
            <x:expect label="Parsed DTD is valid" select="$dtdml"/>
        </x:scenario>

        <x:scenario label="invalid" shared="true" catch="true">

            <x:scenario label="parsing and serialize">
                <x:like label="mlml:parse-and-serialize"/>
            </x:scenario>

            <x:scenario label="DOM comparision">
                <x:like label="mlml:doc"/>
            </x:scenario>
            
            
        </x:scenario>

        <x:scenario label="valid" shared="true" catch="true">
            
            <x:scenario label="parsing and serialize">
                <x:like label="mlml:parse-and-serialize"/>
            </x:scenario>

            <x:scenario label="parsing the DTD and validate it">
                <x:like label="mlml:parse-dtd-and-validate"/>
            </x:scenario>
            
            <x:scenario label="DOM comparision">
                <x:like label="mlml:doc"/>
            </x:scenario>
            
        </x:scenario>

        <x:scenario label="invalid-no-xerces" shared="true" catch="true">

            <x:scenario label="parsing and serialize">
                <x:like label="mlml:parse-and-serialize"/>
            </x:scenario>

        </x:scenario>

        <x:scenario label="valid-no-xerces" shared="true" catch="true">
            
            <x:scenario label="parsing and serialize">
                <x:like label="mlml:parse-and-serialize"/>
            </x:scenario>

            <x:scenario label="parsing the DTD and validate it">
                <x:like label="mlml:parse-dtd-and-validate"/>
            </x:scenario>
            
        </x:scenario>

        <x:scenario label="invalid-w-outdef" shared="true" catch="true">

            <x:scenario label="parsing and serialize">
                <x:like label="mlml:parse-and-serialize"/>
            </x:scenario>

            <x:scenario label="DOM comparision">
                <x:like label="mlml:doc-w-outdef"/>
            </x:scenario>
            
            
        </x:scenario>
        
        <x:scenario label="valid-w-outdef" shared="true" catch="true">
            
            <x:scenario label="parsing and serialize">
                <x:like label="mlml:parse-and-serialize"/>
            </x:scenario>

            <x:scenario label="parsing the DTD and validate it">
                <x:like label="mlml:parse-dtd-and-validate"/>
            </x:scenario>
            
            <x:scenario label="DOM comparision">
                <x:like label="mlml:doc-w-outdef"/>
            </x:scenario>
            
        </x:scenario>
    </xsl:template>
    
</xsl:stylesheet>