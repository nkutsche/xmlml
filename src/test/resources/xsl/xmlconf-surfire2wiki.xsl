<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:mlmlt="http://www.nkutsche.com/xmlml/test-helper"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns:xpmt="http://www.nkutsche.com/xpath-model/test-helper"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:param name="surefire-report-dir" as="xs:string" required="yes"/>
    <xsl:param name="result-dir" as="xs:string" required="yes"/>
    <xsl:param name="pattern" as="xs:string" select="'*.xml'"/>
    
    <xsl:output method="text"/>
    
    <xsl:key name="reason-code" match="reason" use="@id"/>
    
    <xsl:template match="/">
        
        <xsl:variable name="this" select="."/>
        
        <xsl:variable name="surefire-reports" select="collection($surefire-report-dir || '?select=' || $pattern)"/>
        
        <xsl:variable name="summary" as="map(xs:string, element()*)">
            <xsl:map>
                <xsl:for-each-group select="$surefire-reports/testsuites/testsuite/testcase" group-by="'tests', string(@status)">
                    <xsl:map-entry key="current-grouping-key()" select="current-group()"/>
                </xsl:for-each-group> 
            </xsl:map>
        </xsl:variable>
        
        
        <xsl:result-document href="{$result-dir}/XML_Conformance.md">
            <xsl:text>## XML Conformance Summary</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>This page provides an overview of the XML conformance test harness results. The [XML conformance testsuite](https://www.w3.org/XML/Test/) contains a huge number of XML test cases. Some of them are relevant for the X(ml)² XPath engine, some not (e.g. XQuery tests) and some are skipped for other reasons. This page(s) lists all XML conformance test cases and the exclude reasons for those that are skipped.</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            
            
            <xsl:sequence select="mlmlt:create-table(
                ('Test Group', 'Tests', 'Passed', 'Skipped'),
                [
                    ['All groups', count($summary('tests')), count($summary('passed')), count($summary('skipped'))]
                ]
                )"/>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            
            
            <xsl:text>## Ignore Reasons</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>The following table gives an overview of all reasons to exclude a test case of the XML Conformance testsuite from being executed. The reasons are referanced in the detail section by there *Reason Code*.</xsl:text>
            
            <xsl:call-template name="create-reson-code-section">
                <xsl:with-param name="test-case-by-status" select="$summary"/>
            </xsl:call-template>

            <xsl:text>## Ignored Test Cases</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            
            <xsl:text>The following table lists all test case that are marked as pending. The reason are referenced by a reason code which can be looked up in the table above.</xsl:text>
            
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            
            <xsl:variable name="body" select="
                array{
                    $summary('skipped')/array{mlmlt:get-test-details(.)}
                }
                "/>
            
            <xsl:sequence select="mlmlt:create-table(
                ('Test-ID', 'Description', 'Ignore Reason Code'),
                $body
                )"/>
            
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            
        </xsl:result-document>
        
        
    </xsl:template>
    
    <xsl:variable name="this" select="/"/>
    
    <xsl:template name="create-reson-code-section">
        <xsl:param name="test-case-by-status"/>
        <xsl:variable name="reason-codes" as="map(xs:string, element()*)">
            <xsl:map>
                <xsl:for-each-group select="$test-case-by-status('skipped')" group-by="mlmlt:get-reason-code(skipped)">
                    <xsl:map-entry key="current-grouping-key()" select="current-group()"/>
                </xsl:for-each-group>
            </xsl:map>
        </xsl:variable>
        
        
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        
        <xsl:variable name="body" select="
            array {
            map:keys($reason-codes) ! 
            [
            mlmlt:code(.), 
            string(key('reason-code', ., $this)[1]/description), 
            count($reason-codes(.))
            ]
            }
            
            "/>
        <xsl:sequence select="mlmlt:create-table(
            ('Reason Code', 'Description', 'Number of Ignored Tests'),
            $body
            )"/>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        
    </xsl:template>
    
    <xsl:function name="mlmlt:get-test-details" as="xs:string*">
        <xsl:param name="surefire-test" as="element(testcase)"/>
        
        <xsl:variable name="id-descr" as="xs:string+">
            <xsl:analyze-string select="$surefire-test/@name" regex="^.*&lt;&lt;([^>]*)>>:\s((.|\n)*)$">
               <xsl:matching-substring>
                   <xsl:sequence select="mlmlt:code(normalize-space(regex-group(1))), replace(normalize-space(regex-group(2)), '\|', '\\|')"/>
               </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:sequence select="'???', '???'"/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <xsl:variable name="reason-codes" select="string-join(mlmlt:get-reason-code($surefire-test/skipped) ! mlmlt:code(.), ', ')"/>
        <xsl:sequence select="$id-descr, $reason-codes"/>
    </xsl:function>
    
    <xsl:function name="mlmlt:get-reason-code" as="xs:string*">
        <xsl:param name="skipped-descr" as="xs:string?"/>
        <xsl:choose>
            <xsl:when test="$skipped-descr">
                <xsl:analyze-string select="$skipped-descr" regex="^Reason-code: \[\[([^\]]*)\]\]$">
                    <xsl:matching-substring>
                        <xsl:sequence select="regex-group(1) => tokenize(';')"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:text>UNKNOWN</xsl:text>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>UNKNOWN</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    <xsl:function name="mlmlt:create-table" as="xs:string">
        <xsl:param name="headings" as="xs:string*"/>
        <xsl:param name="rows" as="array(*)"/>
        <xsl:variable name="lines" select="
            mlmlt:create-table-line($headings),
            (1 to count($headings)) ! '---' => mlmlt:create-table-line(),
            (1 to array:size($rows)) ! $rows(.) ! mlmlt:create-table-line(.)
            "/>
        <xsl:sequence select="
            $lines => string-join('&#xA;')
            "/>
    </xsl:function>
    
    
    <xsl:function name="mlmlt:code" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:sequence select="'`'  || $input || '`'"/>
    </xsl:function>
    
    
    <xsl:function name="mlmlt:create-table-line" as="xs:string">
        <xsl:param name="cells" as="item()*"/>
        <xsl:variable name="cells" select="
            if($cells instance of array(*))
            then $cells?*
            else $cells
            "/>
        
        <xsl:sequence select="
            '| ' || string-join($cells, ' | ') || ' |'
            "/>
    </xsl:function>
    
</xsl:stylesheet>