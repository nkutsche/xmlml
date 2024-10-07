<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xpmt="http://www.nkutsche.com/xpath-model/test-helper"  
    xpath-default-namespace="http://www.w3.org/2010/09/qt-fots-catalog"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:variable name="dependency-settings" as="element(xpmt:dependency)*"
        select="doc('QT3TS-Exclusions.xml')/*/*"/>
    
    <xsl:function name="xpmt:merge-dependencies" as="element(dependency)*">
        <xsl:param name="test-dependencies" as="element(dependency)*"/>
        <xsl:for-each-group select="$test-dependencies" group-by=" 
            if (@type = 'spec') 
            then ('spec') 
            else (@type || ';' || @value) ">
            <xsl:sequence select="current-group()[last()]"/>
        </xsl:for-each-group> 
    </xsl:function>
    
    <xsl:function name="xpmt:get-ignore-reasons" as="element(xpmt:dependency)*">
        <xsl:param name="test-dependencies" as="element(dependency)*"/>
        <xsl:sequence select="xpmt:get-ignore-reasons($test-dependencies, $dependency-settings[not(xpmt:ignore)])"/>
    </xsl:function>
    
    
    <xsl:function name="xpmt:get-ignore-reasons" as="element()*">
        <xsl:param name="test-dependencies" as="element(dependency)*"/>
        <xsl:param name="dependency-settings" as="element(xpmt:dependency)*"/>
        
        <xsl:variable name="only-dependency-settings" select="$dependency-settings[@only = 'true']"/>
        <xsl:choose>
            <xsl:when test="$only-dependency-settings">
                <xsl:sequence select="
                    $only-dependency-settings[
                        not(
                            some $td in $test-dependencies
                            satisfies
                                xpmt:verify-test-dependency($td, ., true())
                        )
                    ]
                    "/>
                    <xsl:sequence select="xpmt:get-ignore-reasons($test-dependencies, $dependency-settings except $only-dependency-settings)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="
                    $dependency-settings[
                        some $td in $test-dependencies
                        satisfies 
                            not(xpmt:verify-test-dependency($td, .))
                    ]
                    "/>
            </xsl:otherwise>
        </xsl:choose>
        
        <!--<xsl:variable name="satisfied" select="every $td in $test-dependencies
            satisfies xpmt:verify-test-dependency($td, $dependency-settings)"/>
        <xsl:choose>
            <xsl:when test="$dependency-settings[@only = 'true']">
                <xsl:sequence select="
                    $satisfied and (
                    every $odps in $dependency-settings[@only = 'true'] 
                    satisfies exists($test-dependencies[xpmt:verify-test-dependency(., $odps, true())])
                    )
                    "/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$satisfied"/>
            </xsl:otherwise>
        </xsl:choose>-->
        
    </xsl:function>
    
    
    <xsl:function name="xpmt:verify-test-dependencies" as="xs:boolean">
        <xsl:param name="test-dependencies" as="element(dependency)*"/>
        <xsl:sequence select="xpmt:verify-test-dependencies($test-dependencies, $dependency-settings)"/>
    </xsl:function>
    
    
    <xsl:function name="xpmt:verify-test-dependencies" as="xs:boolean">
        <xsl:param name="test-dependencies" as="element(dependency)*"/>
        <xsl:param name="dependency-settings" as="element(xpmt:dependency)*"/>
        <xsl:variable name="satisfied" select="every $td in $test-dependencies
            satisfies xpmt:verify-test-dependency($td, $dependency-settings)"/>
        <xsl:choose>
            <xsl:when test="$dependency-settings[@only = 'true']">
                <xsl:sequence select="
                    $satisfied and (
                    every $odps in $dependency-settings[@only = 'true'] 
                    satisfies exists($test-dependencies[xpmt:verify-test-dependency(., $odps, true())])
                    )
                    "/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$satisfied"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    
    <xsl:function name="xpmt:verify-test-dependency" as="xs:boolean">
        <xsl:param name="test-dependency" as="element(dependency)"/>
        <xsl:param name="dependency-settings" as="element(xpmt:dependency)*"/>
        <xsl:sequence select="xpmt:verify-test-dependency($test-dependency, $dependency-settings, false())"/>
    </xsl:function>
    <xsl:function name="xpmt:verify-test-dependency" as="xs:boolean">
        <xsl:param name="test-dependency" as="element(dependency)"/>
        <xsl:param name="dependency-settings" as="element(xpmt:dependency)*"/>
        <xsl:param name="false-if-no-match" as="xs:boolean"/>
        <xsl:variable name="type" select="$test-dependency/@type"/>
        <xsl:variable name="dependency-settings" select="$dependency-settings[@type = $type]"/>
        <xsl:variable name="values" select="
            if ($test-dependency/@type = 'spec') 
            then tokenize($test-dependency/@value, '\s+') 
            else $test-dependency/@value
            "/>
        <xsl:variable name="dependency-settings" select="$dependency-settings[
            if (@match) 
            then some $v in $values
            satisfies matches($v, @match) 
            else ($values = @value)
            ]"/>
        
        <xsl:variable name="test-dep-satisfied" select="($test-dependency/@satisfied, 'true')[1]"/>
        <xsl:variable name="test-dep-satisfied" select="
            if ($test-dep-satisfied = 'true') then ('true', 'partial') else $test-dep-satisfied
            "/>
        <xsl:variable name="dep-settings-satisfied" select="($dependency-settings/@satisfied, 'true')[1]"/>
        
        <xsl:choose>
            <xsl:when test="not($dependency-settings) and $false-if-no-match">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:when test="not($dependency-settings)">
                <xsl:sequence select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$dep-settings-satisfied = $test-dep-satisfied"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>