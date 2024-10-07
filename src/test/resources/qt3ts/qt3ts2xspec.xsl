<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:x="http://www.jenitennison.com/xslt/xspec"
    xmlns:xpe="http://www.nkutsche.com/xpath-model/engine"
    xmlns:xpmt="http://www.nkutsche.com/xpath-model/test-helper"  
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:qt="http://www.w3.org/2010/09/qt-fots-catalog"
    xmlns:mlmlp="http://www.nkutsche.com/xmlml/xpath"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    xpath-default-namespace="http://www.w3.org/2010/09/qt-fots-catalog"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 23, 2023</xd:p>
            <xd:p><xd:b>Author:</xd:b> Nico</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:include href="dependency-handling.xsl"/>
    
    <xsl:param name="focus-surefire-report" as="xs:string"/>
    <xsl:param name="focus" as="xs:string">.*</xsl:param>
    <xsl:param name="group-focus" as="xs:string">*</xsl:param>
    <xsl:param name="output-dir" as="xs:string" required="yes"/>
    
    <xsl:variable name="focus-eff" select="
        if ($focus-surefire-report != '' and doc-available($focus-surefire-report)) 
        then xpmt:focus-surefire-report($focus-surefire-report) 
        else ($focus => tokenize(','))
        "/>
    
    <xsl:function name="xpmt:focus-surefire-report" as="xs:string*">
        <xsl:param name="surefire-report" as="xs:string"/>
        <xsl:variable name="doc" select="doc($surefire-report)"/>
        <xsl:variable name="failures" select="$doc/testsuites/testsuite[@failures > 0]" xpath-default-namespace=""/>
        <xsl:sequence select="$failures/@name/substring-before(., ':')"/>
    </xsl:function>
    
    
    
    <xsl:template match="/catalog">
        <xsl:variable name="scenarios" as="element(x:scenario)*">
            <xsl:apply-templates>
                <xsl:with-param name="envs" select="environment" tunnel="yes"/>
                <xsl:with-param name="test-dependencies" tunnel="yes" as="element(dependency)">
                    <qt:dependency type="spec" value="XP3.0+"/>
                </xsl:with-param>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:for-each-group select="$scenarios[not(@shared = 'true')][(@xpmt:group, '*') = $group-focus]" group-by="@xpmt:group">
            <xsl:variable name="group-name" select="current-grouping-key()"/>
            <xsl:for-each-group select="current-group()" group-adjacent="(position() - 1) idiv 1000">
                <xsl:result-document href="{$output-dir}qt3ts-runner-{$group-name}-{current-grouping-key()}.xspec">
                    <x:description stylesheet="{resolve-uri('qt3ts-helper.xsl')}">
                        <x:helper package-name="http://maxtoroq.github.io/rng-xsl" package-version="*"/>
                        
                        <x:helper stylesheet="{resolve-uri('../../../main/resources/xsl/xmlml-main.xsl')}"/>
                        <x:helper package-name="http://www.nkutsche.com/xmlml/xpath" package-version="*"/>
                        
                        <x:variable name="fn-transform-workaround" select="false()"/>
                        <xsl:sequence select="$scenarios[@label = current-group()//x:like/@label]"/>
                        <xsl:for-each select="current-group()">
                            <xsl:copy select=".">
                                <xsl:sequence select="@* except @xpmt:group"/>
                                <xsl:sequence select="node()"/>
                            </xsl:copy>
                        </xsl:for-each>
                    </x:description>
                </xsl:result-document>
            </xsl:for-each-group>
        </xsl:for-each-group> 
        
    </xsl:template>
    
    <xsl:template match="environment">
        <x:scenario label="{generate-id(.)}" shared="true">
            <x:variable name="sources">
                <xsl:attribute name="select">
                    <xsl:text>(</xsl:text>
                    <xsl:if test="source[@role = '.']">
                        <xsl:text>'</xsl:text>
                        <xsl:value-of select="source[@role = '.']/resolve-uri(@file, base-uri(.))"/>
                        <xsl:text>'</xsl:text>
                    </xsl:if>
                    <xsl:text>)</xsl:text>
                </xsl:attribute>
            </x:variable>
            <x:variable name="context" select="
                $sources 
                ! mlml:parse(., map{{'expand-namespace-nodes' : true()}})
                "/>
            <x:variable name="execution-context" select="xpmt:execution-context(*, $base-uri, $fn-transform-workaround)">
                <xsl:copy-of select="xpmt:copy-for-xspec(.)"/>
            </x:variable>
            <x:call function="mlmlp:xpath-evaluate">
                <x:param select="$context"/>
                <x:param select="$xpath"/>
                <x:param select="$execution-context"/>
            </x:call>
            <x:expect label="expected compare" test="xpmt:result-compare($result, $x:result)"/>
        </x:scenario>
    </xsl:template>
    
    <xsl:template match="test-set[@file]">
        <xsl:apply-templates select="doc(resolve-uri(@file, base-uri(.)))/*">
            <xsl:with-param name="group" select="(tokenize(@name, '-'), 'default')[1]" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="test-set[environment]" priority="50">
        <xsl:param name="envs" as="element(qt:environment)*" tunnel="yes"/>
        <xsl:next-match>
            <xsl:with-param name="envs" select="$envs, environment" tunnel="yes"/>
        </xsl:next-match>
    </xsl:template>

    <xsl:template match="test-set[dependency] | test-case[dependency]" priority="60">
        <xsl:param name="test-dependencies" tunnel="yes" as="element(dependency)*"/>
        <xsl:next-match>
            <xsl:with-param name="test-dependencies" select="$test-dependencies, dependency" tunnel="yes"/>
        </xsl:next-match>
    </xsl:template>
    
    <xsl:template match="test-case" priority="50">
        <xsl:param name="test-dependencies" tunnel="yes" as="element(dependency)*"/>
        <xsl:variable name="focus" select="$focus-eff"/>
        <xsl:variable name="focus" select="$focus[. != ''] ! ('^' || . || '$')"/>
        <xsl:variable name="test-dependencies" select="$test-dependencies => xpmt:merge-dependencies()"/>
        <xsl:choose>
            <xsl:when test="exists($focus) and (every $f in $focus satisfies not(matches(@name, $f)))"/>
            <xsl:when test="not($test-dependencies)">
                <xsl:next-match/>
            </xsl:when>
            <xsl:when test="
                $test-dependencies => xpmt:verify-test-dependencies()">
                <xsl:next-match/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="reason" select="xpmt:get-ignore-reasons($test-dependencies)"/>
                <xsl:variable name="reason-code" select="$reason/xpmt:reason/@code => string-join(';')"/>
                <xsl:variable name="reason-code" select="($reason-code, 'UNKNOWN')[1]"/>
                <xsl:variable name="pending" select="
                    'Reason-code: [[' || $reason-code || ']]'
                    "/>
                <xsl:next-match>
                    <xsl:with-param name="pending" select="$pending" tunnel="yes"/>
                </xsl:next-match>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    
    
    
    <xsl:template match="test-case">
        <xsl:param name="envs" as="element(qt:environment)*" tunnel="yes"/>
        <xsl:param name="group" as="xs:string" tunnel="yes" select="'default'"/>
        <xsl:param name="pending" as="xs:string?" tunnel="yes" select="()"/>
        <xsl:variable name="custom-env" select="environment[not(@ref)]"/>
        
        <xsl:apply-templates select="$custom-env"/>
        
        <xsl:variable name="env-ref" select="(environment/@ref, 'empty')[1]"/>
        <xsl:variable name="env" select="
            if ($custom-env) 
            then $custom-env 
            else $envs[@name = $env-ref]
            "/>
        <xsl:if test="exists($focus-eff[. = @name]) or (some $f in $focus-eff satisfies matches(@name, $f))">
            
            <x:scenario label="&lt;{@name}>: {description}" catch="true" xpmt:group="{$group}">
                <xsl:if test="$env/source/@validation = 'strict'">
                    <xsl:attribute name="pending">Ignored as test case seems to be schema-aware.</xsl:attribute>
                </xsl:if>
                <xsl:variable name="test-name" select="@name"/>
                <xsl:variable name="ignore" select="$dependency-settings//xpmt:ignore[@test = $test-name]"/>
                <xsl:if test="$ignore">
                    <xsl:attribute name="pending" expand-text="yes"
                        >Reason-code: [[{$ignore/../xpmt:reason}]]</xsl:attribute>
                </xsl:if>
                <xsl:if test="$pending">
                    <xsl:attribute name="pending" select="$pending"/>
                </xsl:if>
                <x:variable name="base-uri" select="'{base-uri(.)}'"/>
                <x:variable name="xpath" select="string(.)">
                    <xsl:copy-of select="test"/>
                </x:variable>
                <x:variable name="result" select="*">
                    <xsl:copy-of select="xpmt:copy-for-xspec(result)"/>
                </x:variable>
                <xsl:if test="
                    dependency[@type = 'feature'][(@satisfied, 'true')[1]= 'true']/@value = 'fn-transform-XSLT'
                    ">
                    <x:variable name="fn-transform-workaround" select="true()"/>
                </xsl:if>
                <xsl:if test="$env">
                    <x:like label="{$env[last()]/generate-id(.)}"/>
                </xsl:if>
            </x:scenario>
            
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="text()[normalize-space() = '']"/>
        
    
    
    <xsl:template match="description"/>
    
    <xsl:mode name="xpmt:copy-for-xspec" on-no-match="shallow-copy"/>
    
    <xsl:function name="xpmt:copy-for-xspec" as="node()*">
        <xsl:param name="node" as="node()*"/>
        <xsl:apply-templates select="$node" mode="xpmt:copy-for-xspec"/>
    </xsl:function>
    
    <xsl:template match="environment | result" mode="xpmt:copy-for-xspec">
        <xsl:copy>
            <xsl:attribute name="xml:base" select="base-uri(.)"/>
            <xsl:attribute name="xml:space" select="'preserve'"/>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*" mode="xpmt:copy-for-xspec">
        <xsl:attribute name="{name()}" select="replace(., '(\{|\})', '$1$1')"/>
    </xsl:template>
    
    
</xsl:stylesheet>