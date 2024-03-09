<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    xmlns:r="http://maxtoroq.github.io/rng.xsl"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Dec 5, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> Nico</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:variable name="line-separators" select="
        map{
        'r' : '&#xD;',
        'n' : '&#xA;',
        'rn' : '&#xD;&#xA;',
        '#default' : system-property('line.separator') 
        }
        "/>
    
    <xsl:function name="mlml:validate-xmlml" as="node()">
        <xsl:param name="instance" as="node()"/>
        <xsl:sequence select="mlml:validate($instance, doc(resolve-uri('../rnc/xmlml.rng', static-base-uri())))"/>
    </xsl:function>
    
    <xsl:function name="mlml:validate-dtd" as="node()">
        <xsl:param name="instance" as="node()"/>
        <xsl:sequence select="mlml:validate($instance, doc(resolve-uri('../rnc/dtdml.rng', static-base-uri())))"/>
    </xsl:function>
    
    <xsl:function name="mlml:validate" as="node()">
        <xsl:param name="instance" as="node()"/>
        <xsl:param name="schema" as="document-node()"/>
        <xsl:try>
            <xsl:variable name="rng-validate" as="xs:boolean">
                <xsl:sequence select="r:is-valid($instance, $schema)"/>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="$rng-validate">
                    <xsl:sequence select="$instance"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:sequence select="error(xs:QName('Invalid-Result'))"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:catch>
                <ERROR message="Invalid result:">
                    <xsl:sequence select="$instance"/>
                </ERROR>
            </xsl:catch>
        </xsl:try>
    </xsl:function>
    
    <xsl:function name="mlml:error" as="empty-sequence()">
        <xsl:param name="code" as="xs:string"/>
        <xsl:param name="description" as="xs:string"/>
        <xsl:variable name="name" select="xs:QName('mlml:code-' || $code)"/>
        <xsl:sequence select="error($name, $description)"/>
    </xsl:function>
    
    <xsl:function name="mlml:log-output" as="xs:boolean">
        <xsl:param name="level" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:variable name="log-level-cfg" select="($config($mlml:PARSER-LOG-LEVEL), $mlml:LOG-LEVEL-WARN)[1]"/>
        <xsl:variable name="hierarchy" select="
            $mlml:LOG-LEVEL-VERBOSE,
            $mlml:LOG-LEVEL-DEBUG,
            $mlml:LOG-LEVEL-WARN,
            $mlml:LOG-LEVEL-ERROR
            "/>
        <xsl:sequence select="
            index-of($hierarchy, $level) ge index-of($hierarchy, $log-level-cfg)
            "/>
    </xsl:function>
    
    <xsl:function name="mlml:warn" as="empty-sequence()">
        <xsl:param name="message" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:sequence select="mlml:log($message, $mlml:LOG-LEVEL-WARN, $config)"/>
    </xsl:function>

    <xsl:function name="mlml:debug" as="empty-sequence()">
        <xsl:param name="message" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:sequence select="mlml:log($message, $mlml:LOG-LEVEL-DEBUG, $config)"/>
    </xsl:function>

    <xsl:function name="mlml:verbose" as="empty-sequence()">
        <xsl:param name="message" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        <xsl:sequence select="mlml:log($message, $mlml:LOG-LEVEL-VERBOSE, $config)"/>
    </xsl:function>
    
    <xsl:function name="mlml:log" as="empty-sequence()">
        <xsl:param name="message" as="xs:string"/>
        <xsl:param name="level" as="xs:string"/>
        <xsl:param name="config" as="map(*)"/>
        
        <xsl:if test="mlml:log-output($level, $config)">
            <xsl:message select="$message"/>
        </xsl:if>
        
    </xsl:function>
    
<!--    
    XML Constraint Check
    -->
    
    
    
    <xsl:function name="mlml:verify-constraints" as="element()">
        <xsl:param name="document" as="element()"/>
        <xsl:variable name="elements" select="$document//mlml:element"/>
        <xsl:for-each select="$elements">
            <xsl:sequence select="mlml:verify-name(mlml:name)"/>
            <xsl:for-each select="mlml:attribute">
                <xsl:sequence select="mlml:verify-name(mlml:name, 'attribute')"/>
            </xsl:for-each>
            <xsl:sequence select="mlml:check-unique-attribute-constr(mlml:attribute)"/>
        </xsl:for-each>
        
        <xsl:sequence select="$document"/>
    </xsl:function>
    
    
    <xsl:function name="mlml:verify-name" as="empty-sequence()">
        <xsl:param name="name" as="element(mlml:name)"/>
        <xsl:sequence select="mlml:verify-name($name, 'element')"/>
    </xsl:function>
    <xsl:function name="mlml:verify-name" as="empty-sequence()">
        <xsl:param name="name" as="element(mlml:name)"/>
        <xsl:param name="context" as="xs:string"/>
        <xsl:variable name="prefix" select="substring-before($name, ':')"/>
        <xsl:sequence select="
            if (not(contains($name, ':'))) 
            then ()
            else if (in-scope-prefixes($name) = $prefix) 
            then ()
            else 
            if ($context = 'attribute') 
            then 
            mlml:error('XML-Names.5.16.1', 
            'Undeclared prefix ' || $prefix || ' in attribute name ' || $name || '.')
            else 
            mlml:error('XML-Names.5.12.1', 
            'Undeclared prefix ' || $prefix || ' in element name ' || $name || '.')
            "/>
    </xsl:function>
    
    <xsl:function name="mlml:check-unique-attribute-constr" as="empty-sequence()">
        <xsl:param name="attributes" as="element(mlml:attribute)*"/>
        <xsl:for-each-group select="$attributes" group-by="mlml:attr-name(.)">
            <xsl:if test="count(current-group()) gt 1">
                <xsl:sequence select="mlml:error('3.1.40.1', 'Duplicate attribute with name ' || current-grouping-key() || '.') "/>
            </xsl:if>
        </xsl:for-each-group> 
    </xsl:function>
    
    <xsl:function name="mlml:attr-raw-name" as="xs:Name">
        <xsl:param name="attr" as="element(mlml:attribute)"/>
        <xsl:variable name="name" select="$attr/mlml:name"/>
        <xsl:sequence select="
            if ($name = '' and $attr/@namespace = 'true') 
            then xs:Name('xmlns') 
            else if ($attr/@namespace = 'true') 
            then xs:Name('xmlns:' || $name) 
            else xs:Name($name)
            "/>
    </xsl:function>
    <xsl:function name="mlml:attr-name" as="xs:QName">
        <xsl:param name="attr" as="element(mlml:attribute)"/>
        <xsl:variable name="name" select="$attr/mlml:name"/>
        <xsl:sequence select="
            if ($name = '' and $attr/@namespace = 'true') 
            then QName('', 'xmlns') 
            else 
            QName(
            if ($attr/@namespace = 'true') 
            then ('http://www.w3.org/2000/xmlns/') 
            else (mlml:namespace($name)),
            $name
            )
            "/>
    </xsl:function>
    
    <xsl:function name="mlml:el-name" as="xs:QName">
        <xsl:param name="element" as="element(mlml:element)"/>
        <xsl:variable name="name" select="$element/mlml:name"/>
        <xsl:variable name="def-ns" select="
            $element/ancestor-or-self::mlml:element[@element-default-namespace][1]
            /@element-default-namespace
            "/>
        <xsl:sequence select="
            QName(
            mlml:namespace($name, ($def-ns, '')[1]),
            $name
            )
            "/>
    </xsl:function>
    
    <xsl:function name="mlml:is-eqname" as="xs:boolean">
        <xsl:param name="eqname" as="xs:string"/>
        <xsl:variable name="comp" select="mlml:parse-eqname-compontents($eqname)"/>
        <xsl:sequence select="
            if (empty($comp))
            then false() 
            else 
            ($comp?local-name castable as xs:NCName and $comp?namespace-uri castable as xs:anyURI) 
            "/>
    </xsl:function>
    <xsl:function name="mlml:parse-eqname" as="xs:QName">
        <xsl:param name="eqname" as="xs:string"/>
        <xsl:variable name="comp" select="mlml:parse-eqname-compontents($eqname)"/>
        <xsl:sequence select="QName($comp?namespace-uri, $comp?local-name)"/>
    </xsl:function>
    <xsl:function name="mlml:parse-eqname-compontents" as="map(xs:string, xs:string)?">
        <xsl:param name="eqname" as="xs:string"/>
        <xsl:variable name="eqname" select="normalize-space($eqname)"/>
        <xsl:analyze-string select="$eqname" regex="^Q\{{([^}}]*)\}}(.*)">
            <xsl:matching-substring>
                <xsl:sequence select="map{
                    'local-name' : normalize-space(regex-group(2)),
                    'namespace-uri' : normalize-space(regex-group(1))
                    }"/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    
    <xsl:function name="mlml:eqname" as="xs:string">
        <xsl:param name="qname" as="xs:QName"/>
        <xsl:sequence select="'Q{' || namespace-uri-from-QName($qname) || '}' || local-name-from-QName($qname)"/>
    </xsl:function>
    
    <xsl:function name="mlml:namespace" as="xs:string">
        <xsl:param name="name" as="element(mlml:name)"/>
        <xsl:sequence select="mlml:namespace($name, '')"/>
    </xsl:function>
    
    <xsl:function name="mlml:namespace" as="xs:string">
        <xsl:param name="name" as="element(mlml:name)"/>
        <xsl:param name="default-namespace" as="xs:string"/>
        <xsl:variable name="prefix" select="replace($name, '^(([^:]+):)?.+', '$2')"/>
        
        <xsl:variable name="namespace" select="namespace-uri-for-prefix($prefix, $name)"/>
        
        <xsl:sequence select="
            if ($prefix = '')
            then
            $default-namespace
            else
            $namespace
            "/>
    </xsl:function>
    
    
    <xsl:function name="mlml:check-valid-xml-char" as="empty-sequence()">
        <xsl:param name="codepoint" as="xs:integer"/>
        
        <!--
        #x0009
        | #x000A
        | #x000D
        | [#x0020-#xD7FF]
        | [#xE000-#xFFFD]
        | [#x10000-#x10FFFF]
        -->
        <xsl:choose>
            <!-- #x0009 | #x000A | #x000D -->
            <xsl:when test="$codepoint = (9, 10, 13)">
            </xsl:when>
            <!-- [#x0020-#xD7FF] -->
            <xsl:when test="$codepoint ge 32 and $codepoint le 55295"/>
            <!-- [#xE000-#xFFFD] -->
            <xsl:when test="$codepoint ge 57344 and $codepoint le 65533"/>
            <!-- [#x10000-#x10FFFF] -->
            <xsl:when test="$codepoint ge 65536 and $codepoint le 1114111"/>
            <xsl:otherwise>
                <xsl:sequence select="mlml:error('2.2.2.0', 'Invalid character with codepoint ' || $codepoint || '.') "/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    
<!--    
    Hex
    -->
    <xsl:function name="mlml:codepoint-by-charref" as="xs:integer">
        <xsl:param name="charref" as="xs:string"/>
        <xsl:sequence select="
            if (starts-with($charref, 'x')) 
            then (mlml:hex-to-int(replace($charref, '^x', ''))) 
            else xs:integer($charref)
            "/>
    </xsl:function>
    
    
    <xsl:function name="mlml:hex-to-int" as="xs:integer">
        <xsl:param name="in" as="xs:string"/>
        <xsl:variable name="in" select="lower-case($in)"/>
        <xsl:variable name="digits" select="string-length($in)"/>
        
        <xsl:variable name="hex-figures" select="((0 to 9) ! string(.), 'a', 'b', 'c', 'd', 'e', 'f')"/>
        
        <xsl:variable name="digit-values" select="
            for $d in 1 to $digits
            return
            (index-of($hex-figures, substring($in, $d, 1)) - 1)
            * (math:pow(16, $digits - $d))
            "/>
        
        <xsl:sequence select="$digit-values => sum() => xs:integer()"/>
    </xsl:function>
    
    <xsl:function name="mlml:int-to-hex" as="xs:string">
        <xsl:param name="in" as="xs:integer"/>
        <xsl:sequence select="
            if ($in eq 0)
            then
            '0'
            else
            concat(if ($in ge 16)
            then
            mlml:int-to-hex($in idiv 16)
            else
            '',
            substring('0123456789ABCDEF',
            ($in mod 16) + 1, 1))"/>
    </xsl:function>
</xsl:stylesheet>