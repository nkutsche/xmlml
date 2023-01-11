<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:x="http://www.jenitennison.com/xslt/xspec" xmlns:mlml="http://www.nkutsche.com/xmlml"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    
    <xsl:param name="focus" as="xs:string?"/>
    
    <xsl:variable name="focus-map" select="
        if(exists($focus)) then
        let $tk := tokenize($focus, '=')
        return
        map{$tk[1] : $tk[2] => tokenize(',')}
        
        else ()
        "/>
    
    <xsl:template match="/">
        <x:description xmlns:x="http://www.jenitennison.com/xslt/xspec" xmlns:mlml="http://www.nkutsche.com/xmlml" stylesheet="{resolve-uri('test-runner.xsl', static-base-uri())}">
            <xsl:call-template name="test-caller"/>
            <xsl:apply-templates/>
        </x:description>
    </xsl:template>
    
    <xsl:template match="TESTCASES[@PROFILE]">
        <x:scenario label="{@PROFILE}" catch="true">
            <xsl:apply-templates/>
        </x:scenario>
    </xsl:template>


    <xsl:template match="TEST">
        <xsl:variable name="is-focus" select="$focus-map?id = @ID or $focus-map?type = @TYPE"/>
        <x:scenario label="{@ID}" catch="true">
            <xsl:if test="$is-focus">
                <xsl:attribute name="focus" select="''"/>
            </xsl:if>
            <x:variable name="src" select="'{resolve-uri(@URI, base-uri(.))}'"/>
            <x:like label="{@TYPE}"/>
        </x:scenario>
    </xsl:template>
    
    <xsl:template name="test-caller">
        
        <x:scenario label="not-wf" shared="true" catch="true">
            <x:call function="mlml:parse">
                <x:param select="$src"/>
            </x:call>
            <x:expect label="Expected an error message" select="map{{}}"/>
        </x:scenario>
        <x:scenario label="error" shared="true" catch="true">
            <x:call function="mlml:parse">
                <x:param select="$src"/>
            </x:call>
            <x:expect label="Expected an error message" select="map{{}}"/>
        </x:scenario>

        <x:scenario label="invalid" shared="true" catch="true">
            <x:scenario label="mlml:parse-and-serialize">
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
            <x:scenario label="mlml:parse-dtd-and-validate">
                <x:call function="mlml:parse-dtd-and-validate">
                    <x:param select="$src"/>
                </x:call>
                <x:expect label="Parsed DTD is valid" select="true()"/>
            </x:scenario>
        </x:scenario>

        <x:scenario label="valid" shared="true" catch="true">
            <x:scenario label="mlml:parse-and-serialize">
                <x:call function="mlml:parse-and-serialize">
                    <x:param select="$src"/>
                    <x:param select="true()"/>
                </x:call>
                <x:expect label="No change after parsed and serialized" select="unparsed-text($src)"/>
            </x:scenario>
            <x:scenario label="mlml:parse-dtd-and-validate">
                <x:call function="mlml:parse-dtd-and-validate">
                    <x:param select="$src"/>
                <x:variable name="dtdml" select="
                    mlml:try-catch(
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
        </x:scenario>
    </xsl:template>
    
</xsl:stylesheet>