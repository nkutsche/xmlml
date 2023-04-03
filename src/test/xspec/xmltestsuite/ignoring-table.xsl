<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mlmlt="http://www.nkutsche.com/xmlml/test-helper"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Apr 3, 2023</xd:p>
            <xd:p><xd:b>Author:</xd:b> Nico</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output method="text"/>
    
    <xsl:variable name="testsuite" select="doc('xmlconf/xmlconf.xml')"/>
    <xsl:key name="Test-id" match="TEST" use="@ID"/>
    <xsl:key name="Test-edition" match="TEST[@EDITION]" use="@EDITION/tokenize(., '\s')"/>
    <xsl:key name="Test-version" match="TEST[@VERSION]" use="@VERSION"/>
    
    <xsl:template match="/*">
        
        <xsl:text># Ignoring Tests from the XML Conformance Testsuite</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>This page describes the test cases which are marked as pending and the reasons for. This page is generated and be maintained by this [XML document](src/test/xspec/xmltestsuite/XMLConf-Testsuite-Exclusions.xml).</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        
        <xsl:text>## Ignore Reasons</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>

        <xsl:text>The following table lists all reasons to exclude a test case of the XML Conformance Testsuite from being executed. The reasons are referanced in the Ignored Test Cases table by there *Reason Code*.</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        
        <xsl:text>| Reason Code | Description | Number of Ignored Tests |</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>|--|--|--|</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:for-each select="reason">
            <xsl:variable name="descr" as="xs:string*">
                <xsl:apply-templates select="description/node()"/>
            </xsl:variable>
            <xsl:variable name="cells" select="
                    mlmlt:code(@id), 
                    string-join($descr),
                    string(count(ignore/mlmlt:get-tests-by-ignore(.)))
                "/>
            <xsl:sequence select="
                ($cells) => mlmlt:create-table-line()
                "/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:for-each>
        
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>## Ignored Test Cases</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>The following table lists all test case of the XML Conformance TestSuite which are marked as pending. The reason are referenced by a reason code which can be looked up in the table above.</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>| Test-ID | Source File | Type | Description | Ignore Reason Code |</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>|--|--|--|--|--|</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:apply-templates select="reason/ignore"/>
        
    </xsl:template>
    
    <xsl:template match="description//code">
        <xsl:sequence select="mlmlt:code(.)"/>
    </xsl:template>
    <xsl:template match="description//a">
        <xsl:sequence select="'[' || . || '](' || @href || ')'"/>
    </xsl:template>
    
    <xsl:template match="ignore[@id|@edition |@version]">
        <xsl:variable name="test" select="mlmlt:get-tests-by-ignore(.)"/>
        <xsl:variable name="reason" select="parent::reason/@id"/>
        <xsl:for-each select="$test">
            <xsl:value-of select="mlmlt:create-ignore-test-line(., $reason)"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="ignore" priority="-10"/>
    
    <xsl:function name="mlmlt:get-tests-by-ignore" as="element(TEST)*">
        <xsl:param name="ignore" as="element(ignore)"/>
        <xsl:sequence select="mlmlt:get-tests-by-ignore($ignore, $testsuite)"/>
    </xsl:function>
    
    <xsl:function name="mlmlt:get-tests-by-ignore" as="element(TEST)*">
        <xsl:param name="ignore" as="element(ignore)"/>
        <xsl:param name="testsuite" as="document-node()"/>
        <xsl:variable name="key-attr" select="
            $ignore/(@id, @edition, @version)[1]
            " as="attribute()"/>
        <xsl:variable name="key-name" select="'Test-' || $key-attr/name()"/>
        <xsl:variable name="tests" select="key($key-name, $key-attr, $testsuite)"/>
        <xsl:sequence select="$tests"/>
    </xsl:function>
    
    <xsl:function name="mlmlt:code" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:sequence select="'`'  || $input || '`'"/>
    </xsl:function>
    
    <xsl:function name="mlmlt:create-ignore-test-line" as="xs:string">
        <xsl:param name="test" as="element(TEST)"/>
        <xsl:param name="reason" as="xs:string"/>
        <xsl:variable name="cells" select="
            mlmlt:code($test/@ID),
            $test/@URI,
            $test/@TYPE/mlmlt:code(.),
            $test/replace(normalize-space(.), '&quot;', ''),
            mlmlt:code($reason)"/>
        <xsl:sequence select="
            $cells => mlmlt:create-table-line()
            "/>
    </xsl:function>

    <xsl:function name="mlmlt:create-table-line" as="xs:string">
        <xsl:param name="cells" as="xs:string*"/>
        <xsl:sequence select="
            '| ' || string-join($cells, ' | ') || ' |'
            "/>
    </xsl:function>
    
</xsl:stylesheet>