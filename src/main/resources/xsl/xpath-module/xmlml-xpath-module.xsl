<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    xmlns:xpm="http://www.nkutsche.com/xpath-model"
    xmlns:xpf="http://www.nkutsche.com/xmlml/xpath-engine/functions"
    xmlns:xpe="http://www.nkutsche.com/xpath-model/engine"
    xmlns:mlmlp="http://www.nkutsche.com/xmlml/xpath"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns:err="http://www.w3.org/2005/xqt-errors"
    xmlns:xpt="http://www.nkutsche.com/xmlml/xpath-engine/types"
    exclude-result-prefixes="math"
    version="3.0">
    <xsl:import href="../xmlml-lib.xsl"/>
    
    <xsl:function name="mlmlp:resolve-QName" as="xs:QName?">
        <xsl:param name="qname" as="xs:string?"/>
        <xsl:param name="element" as="element()"/>
        <xsl:if test="$qname">
            <xsl:variable name="namespaces" select="
                mlmlp:tree-walk($element, 'namespace') ! mlml:as-node(.)
                " as="namespace-node()*"/>
            <xsl:variable name="prefix" select="
                if (contains($qname, ':')) then substring-before($qname, ':') else ''
                "/>
            <xsl:sequence select="QName($namespaces[name() = $prefix], $qname)"/>
        </xsl:if>
    </xsl:function>
    
    <xsl:function name="mlmlp:node-name" as="xs:QName?">
        <xsl:param name="node" as="node()?"/>
        <xsl:choose>
            <xsl:when test="$node/self::mlml:attribute[@nsref]">
                <xsl:sequence select="mlml:attr-name($node)"/>
            </xsl:when>
            <xsl:when test="$node/mlml:name[. != '']">
                <xsl:variable name="name" select="$node/mlml:name"/>
                <xsl:variable name="default-namespace" select="
                    if ($node/self::mlml:element) 
                    then ($node/ancestor-or-self::*[@element-default-namespace][1]/@element-default-namespace, '')[1] 
                    else ''
                    "/>
                <xsl:variable name="namespace" select="mlml:namespace($name, $default-namespace)"/>
                <xsl:sequence select="QName($namespace, $name)"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="mlmlp:name" as="xs:string">
        <xsl:param name="node" as="node()?"/>
        <xsl:sequence select="
            if (empty($node)) 
            then '' 
            else if ($node/self::mlml:entity) 
            then string($node/(@name|@codepoint)) 
            else if ($node/self::mlml:attribute/@nsref) 
            then string($node/@nsref) 
            else string($node/mlml:name)
            "/>
    </xsl:function>

    <xsl:function name="mlmlp:local-name" as="xs:string">
        <xsl:param name="node" as="node()?"/>
        <xsl:variable name="node-name" select="mlmlp:node-name($node)"/>
        <xsl:sequence select="
            if (empty($node-name)) 
            then '' 
            else if ($node/self::mlml:entity) 
            then string($node/(@name|@codepoint))  
            else if ($node/self::mlml:attribute/@nsref) 
            then string($node/@nsref) 
            else local-name-from-QName($node-name)"/>
    </xsl:function>

    <xsl:function name="mlmlp:namespace-uri" as="xs:anyURI">
        <xsl:param name="node" as="node()?"/>
        <xsl:variable name="node-name" select="mlmlp:node-name($node)"/>
        <xsl:sequence select="
            if (empty($node-name)) 
            then xs:anyURI('') 
            else namespace-uri-from-QName($node-name)
            "/>
    </xsl:function>
    
    <xsl:function name="mlmlp:generate-id" as="xs:string">
        <xsl:param name="arg" as="node()?"/>
        <xsl:variable name="arg" select="$arg/mlml:redirect-appendings(.)"/>
        <xsl:variable name="root" select="mlmlp:root($arg)"/>
        <xsl:variable name="doc-id" select="$root/@id"/>
        <xsl:variable name="underline-id" select="$arg/generate-id(.)"/>
        <xsl:sequence select="
            if ($arg is $root) 
            then ($doc-id) 
            else if ($arg) 
            then replace($underline-id, '^d\d+', $doc-id) 
            else ''
            "/>
    </xsl:function>
    
    <xsl:function name="mlmlp:in-scope-prefixes" as="xs:string*">
        <xsl:param name="element" as="element()"/>
        <xsl:variable name="namespace-nodes" select="mlmlp:tree-walk($element, 'namespace', ())"/>
        <xsl:sequence select="$namespace-nodes/mlmlp:name(.)"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:path" as="xs:string?">
        <xsl:param name="arg" as="node()?"/>
        <xsl:variable name="arg" select="$arg/mlml:redirect-appendings(.)"/>
        <xsl:variable name="parent" select="$arg ! mlmlp:tree-walk(., 'parent', ())"/>
        <xsl:choose>
            <xsl:when test="empty($arg)"/>
            <xsl:when test="$arg/self::mlml:document">
                <xsl:sequence select="'/'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="parent-path" select="
                    if (empty($parent)) 
                    then 'Q{http://www.w3.org/2005/xpath-functions}root()' 
                    else mlmlp:path($parent)
                    "/>
                <xsl:variable name="node-name" select="mlmlp:node-name($arg)"/>
                <xsl:variable name="eqname" select="$node-name ! mlml:eqname(.)"/>
                <xsl:variable name="local-part" as="xs:string">
                    <xsl:choose>
                        <xsl:when test="$arg/self::mlml:element">
                            <xsl:variable name="nodeTest" as="element(nodeTest)">
                                <nodeTest kind="element" name="{$eqname}"/>
                            </xsl:variable>
                            <xsl:variable name="position" select="
                                mlmlp:tree-walk($arg, 'preceding-sibling', $nodeTest)
                                => count()
                                "/>
                            <xsl:sequence select="$eqname || '[' || $position + 1 || ']'"/>
                        </xsl:when>
                        <xsl:when test="$arg/self::mlml:attribute[@namespace = 'true' or @nsref]">
                            <xsl:variable name="localname" select="$node-name ! local-name-from-QName(.)"/>
                            <xsl:variable name="name" select="
                                if (empty($node-name)) 
                                then '*[Q{http://www.w3.org/2005/xpath-functions}local-name()=&quot;&quot;]'
                                else $localname
                                "/>
                            <xsl:sequence select="'namespace::' || $name"/>
                        </xsl:when>
                        <xsl:when test="$arg/self::mlml:attribute">
                            <xsl:variable name="name" select="
                                if (namespace-uri-from-QName($node-name) = '') 
                                then local-name-from-QName($node-name) 
                                else $eqname
                                "/>
                            <xsl:sequence select="'@' || $name"/>
                        </xsl:when>
                        <xsl:when test="$arg/self::mlml:pi">
                            <xsl:variable name="target" select="local-name-from-QName($node-name)"/>
                            <xsl:variable name="nodeTest" as="element(nodeTest)">
                                <nodeTest kind="processing-instruction" name="{$target}"/>
                            </xsl:variable>
                            <xsl:variable name="position" select="
                                mlmlp:tree-walk($arg, 'preceding-sibling', $nodeTest)
                                => count()
                                "/>
                            <xsl:sequence select="'processing-instruction(' || $target || ')[' || $position + 1 || ']'"/>
                        </xsl:when>
                        <xsl:when test="$arg/self::mlml:text | $arg/self::mlml:comment">
                            <xsl:variable name="kind" select="$arg/local-name(.)"/>
                            <xsl:variable name="nodeTest" as="element(nodeTest)">
                                <nodeTest kind="{$kind}"/>
                            </xsl:variable>
                            <xsl:variable name="position" select="
                                mlmlp:tree-walk($arg, 'preceding-sibling', $nodeTest)
                                => count()
                                "/>
                            <xsl:sequence select="$kind || '()[' || $position + 1 || ']'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:sequence select="error(xs:QName('mlmlp:internal-error'), 'This should never happen!')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:sequence select="$parent-path[. != '/'] || '/' || $local-part"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="mlmlp:string" as="xs:string">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="arg" as="item()?"/>
        <xsl:sequence select="
            if ($arg instance of element()) 
            then string(mlml:as-node($arg)) 
            else xpf:string($exec-context, $arg)
            "/>
    </xsl:function>
    
    <xsl:function name="mlmlp:nilled" as="xs:boolean?">
        <xsl:param name="arg" as="node()?"/>
        <xsl:variable name="has-nilled-property" select="
            $arg instance of element(mlml:element)
            "/>
        <xsl:sequence select="
            if ($has-nilled-property)
            (: TODO: impl of @xml:nil attribute? :)
            then false() 
            else ()
            "/>
    </xsl:function>
    
    <xsl:function name="mlmlp:data" as="item()*">
        <xsl:param name="arg" as="item()*"/>
        
        <xsl:variable name="arg" select="
            for $a in $arg 
            return 
            if ($a instance of node() and $a/self::mlml:*) 
            then mlml:as-node($a) 
            else $a
            
            "/>
        <xsl:sequence select="$arg ! data(.)"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:doc" as="element(mlml:document)?" mlmlp:as="document-node()?">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="uri" as="xs:string?"/>
        <xsl:variable name="baseUri" select="xpe:fn-apply($exec-context, 'static-base-uri', [])"/>
        <xsl:try>
            <xsl:choose>
                <xsl:when test="empty($uri)"/>
                <xsl:when test="empty($exec-context?uri-resolver)">
                    <xsl:sequence select="
                        mlmlp:uri-resolver($exec-context, $uri, $baseUri)
                        "/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:sequence select="$exec-context?uri-resolver($uri, $baseUri)"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:catch errors="err:FORG0002">
                <xsl:sequence select="error(xpe:error-code('FODC0005'), 'Malformed URI ' || $uri)"/>
            </xsl:catch>
        </xsl:try>
    </xsl:function>
    
    <xsl:function name="mlmlp:root" as="node()?">
        <xsl:param name="arg" as="node()?"/>
        <xsl:sequence select="$arg/ancestor-or-self::mlml:document"/>
    </xsl:function>
    
    
    <xsl:function name="mlmlp:deep-equal" as="xs:boolean">
        <xsl:param name="parameter1" as="item()*"/>
        <xsl:param name="parameter2" as="item()*"/>
        <xsl:param name="collation" as="xs:string"/>
        
        <xsl:variable name="parameter1" as="item()*">
            <xsl:apply-templates select="$parameter1" mode="mlmlp:item-to-xdm"/>
        </xsl:variable>
        <xsl:variable name="parameter2" as="item()*">
            <xsl:apply-templates select="$parameter2" mode="mlmlp:item-to-xdm"/>
        </xsl:variable>
        <xsl:sequence select="deep-equal($parameter1, $parameter2, $collation)"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:has-children" as="xs:boolean">
        <xsl:param name="arg" as="node()?"/>
        <xsl:variable name="children" select="$arg ! mlmlp:tree-walk(., 'child', ())"/>
        <xsl:sequence select="boolean($children)"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:lang" as="xs:boolean">
        <xsl:param name="testlang" as="xs:string?"/>
        <xsl:param name="arg" as="node()?"/>
        <xsl:variable name="parent" select="$arg ! mlmlp:tree-walk(., 'parent', ())"/>
        <xsl:variable name="xml-lang-test" as="element(nodeTest)">
            <nodeTest kind="attribute" name="xml:lang"/>
        </xsl:variable>
        <xsl:variable name="xml-lang" select="
            $arg 
            ! mlmlp:tree-walk(., 'attribute', $xml-lang-test) 
            ! mlml:as-node(.)
            "/>
        <xsl:variable name="testlang" select="($testlang, '')[1]"/>
        <xsl:sequence select="
            if (empty($arg)) 
            then false() 
            else if (empty($xml-lang)) 
            then mlmlp:lang($testlang, $parent) 
            else matches($xml-lang, '^' || $testlang || '(-.*|$)', 'i')
            "/>
    </xsl:function>
    
    
    <xsl:function name="mlmlp:document-uri" as="xs:anyURI?">
        <xsl:param name="arg" as="node()?"/>
        <xsl:sequence select="$arg/@document-uri[. != '']/xs:anyURI(.)"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:uri-resolver" as="element(mlml:document)?">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="relative" as="xs:string?"/>
        <xsl:param name="baseUri" as="xs:string"/>
        <xsl:variable name="resolved" as="xs:anyURI?">
            <xsl:sequence select="xpe:default-uri-mapper($exec-context, $relative, $baseUri)"/>
        </xsl:variable>
        <xsl:try>
            <xsl:sequence select="$resolved ! mlml:parse(., map{})"/>
            <xsl:catch>
                <xsl:sequence select="error(xpe:error-code('FODC0002'), $err:description)"/>
            </xsl:catch>
        </xsl:try>
    </xsl:function>
    
    <xsl:key name="mlml-id" match="mlml:attribute[@type = 'ID' or mlml:attr-name(.) = xs:QName('xml:id')]"
     use="mlmlp:data(.)"
    />
    <xsl:key name="mlml-genid" match="mlml:*"
     use="mlmlp:generate-id(.)"
    />
    
    <xsl:function name="mlmlp:id" as="element()*">
        <xsl:param name="arg" as="xs:string*"/>
        <xsl:param name="node" as="node()"/>
        <xsl:variable name="idrefs" select="$arg ! tokenize(., '\s+')"/>
        <xsl:sequence select="key('mlml-id', $idrefs, root($node))/parent::mlml:element"/>
    </xsl:function>
    
    
    <xsl:function name="mlmlp:analyze-string" as="element()">
        <xsl:param name="input" as="xs:string?"/>
        <xsl:param name="pattern" as="xs:string"/>
        <xsl:variable name="as" select="analyze-string($input, $pattern) => mlml:mlml-from-xdm()"/>
        <xsl:sequence select="$as"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:analyze-string" as="element()">
        <xsl:param name="input" as="xs:string?"/>
        <xsl:param name="pattern" as="xs:string"/>
        <xsl:param name="flags" as="xs:string"/>
        <xsl:sequence select="analyze-string($input, $pattern, $flags) => mlml:mlml-from-xdm()"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:parse-xml" as="element(mlml:document)?" mlmlp:as="document-node(element(*))?">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:variable name="static-base-uri" select="xpe:fn-apply($exec-context, 'static-base-uri', [])"/>
        <xsl:try>
            <xsl:sequence select="$arg ! mlml:parse-from-string(., $static-base-uri)"/>
            <xsl:catch errors="mlml:xml-syntax-error mlml:code-XML-Names.5.12.1 mlml:code-XML-Names.5.16.1">
                <xsl:sequence select="error(xpe:error-code('FODC0006'), $err:description)"/>
            </xsl:catch>
        </xsl:try>
    </xsl:function>

    <xsl:function name="mlmlp:parse-xml-fragment" as="element(mlml:document)?" mlmlp:as="document-node()?">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:variable name="static-base-uri" select="xpe:fn-apply($exec-context, 'static-base-uri', [])"/>
        <xsl:try>
            <xsl:sequence select="$arg ! mlml:parse-xml-fragment(., $static-base-uri)"/>
            <xsl:catch errors="mlml:xml-syntax-error mlml:code-XML-Names.5.12.1 mlml:code-XML-Names.5.16.1">
                <xsl:sequence select="error(xpe:error-code('FODC0006'), $err:description)"/>
            </xsl:catch>
        </xsl:try>
    </xsl:function>

    <xsl:function name="mlmlp:transform" as="map(*)">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="options" as="map(*)"/>
        <!--        
            Replace $options?stylesheet-location by $options?stylesheet-node and use URI resolver
        -->
        <xsl:variable name="stylesheet-location" select="$options?stylesheet-location"/>
        <xsl:variable name="replace-style-loc" select="exists($stylesheet-location)"/>
        <xsl:variable name="options" select="
            if ($replace-style-loc) 
            then 
            mlmlp:doc($exec-context, $stylesheet-location) 
            ! map:put($options, 'stylesheet-node', .)
            => map:remove('stylesheet-location')
            else $options
            "/>
        
        <!--
            In case of stylesheet location replacement, set the static-base-uri 
        -->
        <xsl:variable name="options" select="
            if ($replace-style-loc and empty($options?stylesheet-base-uri)) 
            then map:put($options, 'stylesheet-base-uri', $stylesheet-location) 
            else $options
            "/>
        
        <xsl:variable name="options" select="
            if (exists($options?package-location))
            then 
            mlmlp:doc($exec-context, $options?package-location)
            ! map:put($options, 'package-node', .) 
            => map:remove('package-location')
            else $options
            "/>
        
        <xsl:variable name="options" as="map(*)">
            <xsl:apply-templates select="$options" mode="mlmlp:item-to-xdm"/>
        </xsl:variable>
        
        <xsl:variable name="has-post-process" select="exists($options?post-process)"/>
        <xsl:variable name="options" select="
            if ($has-post-process) 
            then map:put($options, 'post-process', mlmlp:transform-post-process-wrapper(?, ?, xpe:raw-function($options?post-process))) 
            else $options
            "/>
        
<!--    
        global-context-item as item()
        function-params as array(item()*)
        initial-match-selection as item()*
        package-node as node()
        source-node as node()
        static-params as map(xs:QName, item()*)
        stylesheet-node as node()
        stylesheet-params as map(xs:QName, item()*)
        template-params as map(xs:QName, item()*)
        tunnel-params as map(xs:QName, item()*)
        vendor-options as map(xs:QName, item()*)
        -->
        
        <xsl:variable name="result" select="xpf:transform($exec-context, $options)"/>
        
        <xsl:choose>
            <xsl:when test="$has-post-process">
                <xsl:sequence select="$result"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="$result" mode="mlmlp:item-to-xmlml"/>
            </xsl:otherwise>
        </xsl:choose>
        
        
    </xsl:function>
    
    <xsl:mode name="mlmlp:item-to-xdm"/>
    <xsl:mode name="mlmlp:item-to-xmlml"/>
    
    <xsl:function name="mlmlp:transform-post-process-wrapper" as="item()*">
        <xsl:param name="key" as="xs:string"/>
        <xsl:param name="result" as="item()*"/>
        <xsl:param name="post-process" as="function(xs:string, item()*) as item()*"/>
        
        <xsl:variable name="result" select="$result"/>
        <xsl:variable name="xmlml-result" as="item()*">
            <xsl:apply-templates select="$result" mode="mlmlp:item-to-xmlml"/>
        </xsl:variable>
        <xsl:variable name="xmlml-result" select="$xmlml-result"/>
        <xsl:sequence select="$post-process($key, $xmlml-result)"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:item-to-xdm" as="item()*">
        <xsl:param name="items" as="item()*"/>
        <xsl:apply-templates select="$items" mode="mlmlp:item-to-xdm"/>
    </xsl:function>
    
    <xsl:template match=".[. instance of map(*)]" mode="mlmlp:item-to-xdm mlmlp:item-to-xmlml">
        <xsl:variable name="map" select="."/>
        <xsl:map>
            <xsl:for-each select="map:keys($map)">
                <xsl:map-entry key=".">
                    <xsl:variable name="value" select="$map(.)"/>
                    <xsl:choose>
                        <xsl:when test="$value instance of element()">
                            <xsl:sequence select="mlmlp:subnode-in-xdm-tree($value)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="$value" mode="#current"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:map-entry>
            </xsl:for-each>
        </xsl:map>
    </xsl:template>
    
    <xsl:template match=".[. instance of array(*)]" mode="mlmlp:item-to-xdm mlmlp:item-to-xmlml">
        <xsl:variable name="array" select="."/>
        <xsl:variable name="size" select="array:size($array)"/>
        <xsl:variable name="members" as="array(*)*">
            <xsl:for-each select="1 to $size">
                <xsl:variable name="value" select="$array(.)"/>
                <xsl:variable name="value" as="item()*">
                    <xsl:choose>
                        <xsl:when test="$value instance of element()">
                            <xsl:sequence select="mlmlp:subnode-in-xdm-tree($value)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="$value" mode="#current"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:sequence select="[$value]"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="array:join($members)"/>
    </xsl:template>
    
    <xsl:function name="mlmlp:subnode-in-xdm-tree" as="node()">
        <xsl:param name="mlml-node" as="element()"/>
        <xsl:variable name="parent" select="mlmlp:tree-walk($mlml-node, 'parent')"/>
        <xsl:choose>
            <xsl:when test="not($parent)">
                <xsl:apply-templates select="$mlml-node" mode="mlmlp:item-to-xdm"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="root" select="mlmlp:root($mlml-node)"/>
                <xsl:variable name="path" select="mlmlp:path($mlml-node)"/>
                <xsl:variable name="root" as="node()">
                    <xsl:apply-templates select="$root" mode="mlmlp:item-to-xdm"/>
                </xsl:variable>
                <xsl:evaluate context-item="$root" xpath="$path"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:template match="mlml:*" mode="mlmlp:item-to-xdm" priority="10">
        <xsl:sequence select="mlml:as-node(.)"/>
    </xsl:template>
    
    <xsl:template match="node() | /" mode="mlmlp:item-to-xmlml" priority="10">
        <xsl:sequence select="mlml:mlml-from-xdm(.)"/>
    </xsl:template>
    
    <xsl:template match=".[. instance of item()]" mode="mlmlp:item-to-xdm mlmlp:item-to-xmlml" priority="-10">
        <xsl:sequence select="."/>
    </xsl:template>
    
    
    <xsl:function name="mlmlp:serialize" as="xs:string" xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization">
        <xsl:param name="arg" as="item()*"/>
        <xsl:sequence select="mlmlp:serialize($arg, ())"/>
    </xsl:function>
    <xsl:function name="mlmlp:serialize" as="xs:string" xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization">
        <xsl:param name="arg" as="item()*"/>
        <xsl:param name="params" as="item()?"/>
        
        <xsl:variable name="params" select="
            if ($params instance of node()) 
            then mlml:as-node($params) 
            else $params
            "/>
        
        <xsl:variable name="method" select="
            if ($params instance of map(*)) 
            then $params?method 
            else $params ! output:method/resolve-QName(@value, .)
            "/>
        
        <xsl:variable name="method" select="
            if ($method instance of xs:string) 
            then QName('', $method)
            else $method 
            
            "/>
        <xsl:choose>
            <xsl:when test="not($method = xs:QName('mlml:xmlml'))">
                <xsl:variable name="arg" select="mlmlp:item-to-xdm($arg)"/>
                <xsl:sequence select="serialize($arg, $params)"/>
            </xsl:when>
            <xsl:when test="not($arg instance of element()+)">
                <xsl:sequence select="error(xs:QName('mlml:serialization-type-error'), 
                    'Only nodes can be serialize with method mlml:xmlml'
                    )"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="mlml:serialize-node($arg)"/>
            </xsl:otherwise>
        </xsl:choose>
        
        
    </xsl:function>

    <xsl:function name="mlmlp:json-to-xml" as="element(mlml:document)?" mlmlp:as="document-node()?">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="json-text" as="xs:string?"/>
        <xsl:sequence select="mlmlp:json-to-xml($exec-context, $json-text, map{})"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:json-to-xml" as="element(mlml:document)?" mlmlp:as="document-node()?">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="json-text" as="xs:string?"/>
        <xsl:param name="options" as="map(*)"/>
        <xsl:sequence select="xpf:json-to-xml($exec-context, $json-text, $options) => mlml:mlml-from-xdm()"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:xml-to-json" as="xs:string?">
        <xsl:param name="input" as="node()?"/>
        <xsl:sequence select="mlmlp:xml-to-json($input, map{})"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:xml-to-json" as="xs:string?">
        <xsl:param name="input" as="node()?"/>
        <xsl:param name="options" as="map(*)"/>
        <xsl:sequence select="$input ! xml-to-json(mlml:as-node(.), $options)"/>
    </xsl:function>
    
    <!--    <xsl:expose component="function" names="xpe:xpath-evaluate#3" visibility="final"/>-->
    
    <xsl:function name="mlmlp:xpath-evaluate" visibility="final">
        <xsl:param name="context" as="item()?"/>
        <xsl:param name="xpath" as="xs:string"/>
        <xsl:sequence select="mlmlp:xpath-evaluate($context, $xpath, map{})"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:xpath-evaluate" visibility="final">
        <xsl:param name="context" as="item()?"/>
        <xsl:param name="xpath" as="xs:string"/>
        <xsl:param name="static-context" as="map(*)"/>
        
        
        <xsl:variable name="extension-functions" select="
                mlmlp:create-fn-wrap('mlmlp:data', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:string', 2, true()),
                mlmlp:create-fn-wrap('mlmlp:name', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:local-name', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:namespace-uri', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:generate-id', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:in-scope-prefixes', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:path', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:node-name', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:resolve-QName', 2, false()),
                mlmlp:create-fn-wrap('mlmlp:nilled', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:analyze-string', 2 to 3, false()),
                mlmlp:create-fn-wrap('mlmlp:doc', 2, true()),
                mlmlp:create-fn-wrap('mlmlp:parse-xml', 2, true()),
                mlmlp:create-fn-wrap('mlmlp:parse-xml-fragment', 2, true()),
                mlmlp:create-fn-wrap('mlmlp:transform', 2, true()),
                mlmlp:create-fn-wrap('mlmlp:serialize', 1 to 2, false()),
                mlmlp:create-fn-wrap('mlmlp:json-to-xml', 2 to 3, true()),
                mlmlp:create-fn-wrap('mlmlp:xml-to-json', 1 to 2, false()),
                mlmlp:create-fn-wrap('mlmlp:document-uri', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:id', 2, false()),
                mlmlp:create-fn-wrap('mlmlp:has-children', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:lang', 2, false()),
                mlmlp:create-fn-wrap('mlmlp:root', 1, false()),
                mlmlp:create-fn-wrap('mlmlp:deep-equal', 3, false()),
                (: EXTENSION FUNCTIONS:)
                mlmlp:create-fn-wrap('mlmlp:entity', 1 to 3, true()),
                mlmlp:create-fn-wrap('mlmlp:cdata-section', 1 to 2, true()),
                mlmlp:create-fn-wrap('mlmlp:is-default-attribute', 1 to 2, true()),
                mlmlp:create-fn-wrap('mlmlp:no-defaults', 1, false())
            "/>
        <xsl:variable name="extension-functions" select="
                $extension-functions 
                => map:merge(map{'duplicates' : 'combine'})
            "/>
        
        <xsl:variable name="extension-operators" as="map(*)"
            select="map{
                'node-compare#eq' : mlmlp:op-node-eq#3,
                'union' : mlmlp:op-union#3,
                'except' : mlmlp:op-except#3,
                'intersect' : mlmlp:op-intersect#3,
                'instance-of' : mlmlp:instance-of#3
            }"
        />
        
        <xsl:variable name="static-context" select="map:put($static-context, 'extension-functions', $extension-functions)"/>
        <xsl:variable name="static-context" select="map:put($static-context, 'extension-operators', $extension-operators)"/>
        
        
        <xsl:sequence select="xpe:xpath-evaluate($context, $xpath, $static-context)"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:create-fn-wrap" as="map(xs:QName, map(*))+">
        <xsl:param name="function-name" as="xs:string"/>
        <xsl:param name="arities" as="xs:integer+"/>
        <xsl:param name="context-dependent" as="xs:boolean"/>
        <xsl:for-each select="$arities">
            <xsl:variable name="arity" select="."/>
            
            <xsl:variable name="fn-def" select="doc('')/*/xsl:function
                [@name = $function-name]
                [count(xsl:param) = $arity]"/>
            <xsl:sequence select="mlmlp:create-fn-wrap($fn-def, $context-dependent)"/>
        </xsl:for-each>
    </xsl:function>
    <xsl:function name="mlmlp:create-fn-wrap" as="map(xs:QName, map(*))">
        <xsl:param name="function-def" as="element(xsl:function)"/>
        <xsl:param name="context-dependent" as="xs:boolean"/>
        
        <xsl:variable name="params" select="$function-def/xsl:param[not($context-dependent) or position() > 1]"/>
        <xsl:variable name="arg-types" as="element(itemType)*">
            <xsl:for-each select="$params">
                <xsl:variable name="as" select="(@mlmlp:as, @as)[1]"/>
                <xsl:sequence select="xpm:xpath-type-model($as, mlmlp:ns-to-config(.))"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="return-type" select="$function-def/xpm:xpath-type-model((@mlmlp:as, @as)[1], mlmlp:ns-to-config(.))"
            as="element(itemType)"/>
        <xsl:variable name="funct-name" select="resolve-QName($function-def/@name, $function-def)"/>
        <xsl:variable name="fn-name" select="xs:QName('fn:' || local-name-from-QName($funct-name))"/>
        <xsl:variable name="function" select="function-lookup($funct-name, count($function-def/xsl:param))"/>
        
        
        <xsl:variable name="function-item" select="xpe:create-function-item($function, $fn-name, $arg-types, $return-type)"/>
        <xsl:variable name="function-item" select="map:put($function-item, 'context-dependent', $context-dependent)"/>
        <xsl:sequence select="map{
            $fn-name : $function-item
            }"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:ns-to-config" as="map(*)">
        <xsl:param name="el" as="element()"/>
        <xsl:map>
            <xsl:map-entry key="'namespaces'">
                <xsl:map>
                    <xsl:for-each select="$el/namespace::*">
                        <xsl:map-entry key="name()" select="string(.)"/>
                    </xsl:for-each>
                </xsl:map>
            </xsl:map-entry>
        </xsl:map>
    </xsl:function>
    
    <xsl:mode name="mlmlp:tree-step-down"/>
    <xsl:mode name="mlmlp:tree-side-sibl"/>
    <xsl:mode name="mlmlp:tree-step-up"/>
    
    <xsl:function name="mlmlp:tree-walk" as="node()*">
        <xsl:param name="context" as="element()"/>
        <xsl:param name="axis" as="xs:string"/>
        <xsl:sequence select="mlmlp:tree-walk($context, $axis, ())"/>
    </xsl:function>
    <xsl:function name="mlmlp:tree-walk" as="node()*">
        <xsl:param name="context" as="element()"/>
        <xsl:param name="axis" as="xs:string"/>
        <xsl:param name="node-test" as="element()?"/>
        <xsl:choose>
            <xsl:when test="$axis = 'child'">
                <xsl:variable name="children" select="
                    if ($context/self::mlml:element or $context/self::mlml:document[@fragment = 'true']) 
                    then ($context/mlml:content/mlml:*) 
                    else if ($context/self::mlml:document) 
                    then $context/mlml:* 
                    else ()
                    "/>
                <xsl:apply-templates select="$children" mode="mlmlp:tree-step-down">
                    <xsl:with-param name="node-test" select="$node-test" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$axis = 'self'">
                <xsl:sequence select="$context[mlmlp:node-test(., $node-test)]"/>
            </xsl:when>
            <xsl:when test="$axis = 'attribute'">
                <xsl:apply-templates select="$context/self::mlml:element/mlml:attribute[not(@namespace = 'true' or @nsref)]" mode="mlmlp:tree-step-down">
                    <xsl:with-param name="node-test" select="$node-test" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$axis = 'namespace' and $context/self::mlml:element">
                <xsl:variable name="this-ns" as="element(mlml:attribute)*">
                    <xsl:apply-templates select="$context/self::mlml:element/mlml:attribute[@namespace = 'true' or @nsref]" mode="mlmlp:tree-step-down">
                        <xsl:with-param name="node-test" select="$node-test" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:variable>
                <xsl:sequence select="
                    $this-ns[mlml:attr-name(.) != QName('', 'xmlns') or string(mlml:as-node(.)) != '']
                    "/>
            </xsl:when>
            <xsl:when test="$axis = 'namespace'"/>
            <xsl:when test="$axis = 'parent'">
                <xsl:apply-templates select="
                    $context/parent::*
                    " mode="mlmlp:tree-step-up">
                    <xsl:with-param name="node-test" select="$node-test" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$axis = 'descendant'">
                <xsl:variable name="descendant-parents" select="$context//mlml:element | $context/(self::mlml:document | self::mlml:element)"/>
                <xsl:sequence select="$descendant-parents/mlmlp:tree-walk(., 'child', $node-test)"/>
            </xsl:when>
            <xsl:when test="$axis = 'descendant-or-self'">
                <xsl:sequence select="
                    mlmlp:tree-walk($context, 'descendant', $node-test) 
                    | mlmlp:tree-walk($context, 'self', $node-test)"/>
            </xsl:when>
            <xsl:when test="$axis = 'ancestor'">
                <xsl:variable name="ancestors" select="$context/ancestor::mlml:element | $context/ancestor::mlml:document"/>
                <xsl:sequence select="$ancestors[mlmlp:node-test(., $node-test)]"/>
            </xsl:when>
            <xsl:when test="$axis = 'ancestor-or-self'">
                <xsl:sequence select="
                    mlmlp:tree-walk($context, 'self', $node-test),
                    mlmlp:tree-walk($context, 'ancestor', $node-test) 
                    "/>
            </xsl:when>
            <xsl:when test="$axis = 'following-sibling'">
                <xsl:apply-templates select="
                    mlmlp:next-sibl($context, 'following')
                    " mode="mlmlp:tree-side-sibl">
                    <xsl:with-param name="node-test" select="$node-test" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$axis = 'preceding-sibling'">
                <xsl:variable name="siblings" as="element()*">
                    <xsl:apply-templates select="
                        mlmlp:next-sibl($context, 'preceding')
                        " mode="mlmlp:tree-side-sibl">
                        <xsl:with-param name="node-test" select="$node-test" tunnel="yes"/>
                        <xsl:with-param name="direction" select="'preceding'" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:variable>
                <xsl:sequence select="$siblings/."/>
            </xsl:when>
            <xsl:when test="$axis = ('following', 'preceding')">
                <xsl:variable name="anc-or-self" select="mlmlp:tree-walk($context, 'ancestor-or-self', ())"/>
                <xsl:variable name="anc-siblings" select="$anc-or-self/mlmlp:tree-walk(., $axis || '-sibling', ())"/>
                <xsl:variable name="targets" select="$anc-siblings/mlmlp:tree-walk(., 'descendant-or-self', $node-test)"/>
                <xsl:sequence select="$targets"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="error(QName('', 'TODO'), 'Axis ' || $axis || ' not supported yet.')"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    
    <xsl:function name="mlmlp:next-sibl" as="element()?">
        <xsl:param name="context" as="node()"/>
        <xsl:param name="direction" as="xs:string"/>

        <xsl:variable name="context" select="
            if ($context/self::mlml:text[@append-id] and $direction = 'following') 
            then mlml:collect-appendings($context)[last()]
            else $context
            "/>
        
        
        <xsl:variable name="uncle" select="
            if ($direction = 'preceding') 
            then $context/parent::mlml:entity[@complex = 'true']/preceding-sibling::*[1] 
            else $context/parent::mlml:entity[@complex = 'true']/following-sibling::*[1] 
            "/>
        <xsl:variable name="sibling" select="
            if ($direction = 'preceding') 
            then $context/preceding-sibling::*[1] 
            else $context/following-sibling::*[1] 
            
            "/>
        
        <xsl:sequence select="($sibling, $uncle)[1]"/>
    </xsl:function>
    
    
    <xsl:template match="mlml:ws" mode="mlmlp:tree-side-sibl">
        <xsl:param name="direction" select="'following'" as="xs:string" tunnel="yes"/>
        <xsl:apply-templates select="mlmlp:next-sibl(., $direction)" mode="#current"/>
    </xsl:template>
    
    <xsl:template match="mlml:element | mlml:text | mlml:pi | mlml:comment" mode="mlmlp:tree-side-sibl">
        <xsl:param name="node-test" as="element(nodeTest)?" tunnel="yes"/>
        <xsl:param name="direction" select="'following'" as="xs:string" tunnel="yes"/>
        <xsl:sequence select=".[mlmlp:node-test(., $node-test)]"/>
        <xsl:apply-templates select="mlmlp:next-sibl(., $direction)" mode="#current"/>
    </xsl:template>
    
    <xsl:template match="mlml:entity[@complex = 'true']" mode="mlmlp:tree-side-sibl">
        <xsl:param name="direction" select="'following'" as="xs:string" tunnel="yes"/>
        <xsl:apply-templates select="*[if ($direction = 'preceding') then last() else 1]" mode="#current"/>
    </xsl:template>
    
    <xsl:template match="mlml:text[@appending]" mode="mlmlp:tree-side-sibl" priority="10">
        <xsl:param name="direction" select="'following'" as="xs:string" tunnel="yes"/>
        <xsl:choose>
            <xsl:when test="$direction = 'preceding'">
                <xsl:apply-templates select="mlml:redirect-appendings(.)" mode="#current"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="mlml:entity | mlml:content" mode="mlmlp:tree-step-up">
        <xsl:apply-templates select="parent::*" mode="#current"/>
    </xsl:template>
    
    <xsl:template match="mlml:entity" mode="mlmlp:tree-step-down">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="*" mode="mlmlp:tree-step-down mlmlp:tree-step-up mlmlp:tree-side-sibl" priority="-10"/>
    
    
    <xsl:template match="mlml:element | mlml:document | mlml:text" mode="mlmlp:tree-step-up">
        <xsl:param name="node-test" as="element(nodeTest)?" tunnel="yes"/>
        <xsl:sequence select=".[mlmlp:node-test(., $node-test)]"/>
    </xsl:template>
    
    <xsl:template match="mlml:element | mlml:text | mlml:pi | mlml:comment | mlml:attribute" mode="mlmlp:tree-step-down">
        <xsl:param name="node-test" as="element(nodeTest)?" tunnel="yes"/>
        <xsl:sequence select=".[mlmlp:node-test(., $node-test)]"/>
    </xsl:template>
    
    <xsl:template match="mlml:text[@appending]" mode="mlmlp:tree-step-down" priority="10"/>
    
    <xsl:function name="mlmlp:node-test" as="xs:boolean">
        <xsl:param name="node" as="element()"/>
        <xsl:param name="node-test" as="element(nodeTest)?"/>
        <xsl:variable name="node-kind" select="
            if ($node/self::mlml:pi) 
            then 'processing-instruction' 
            else if ($node/self::mlml:attribute[@namespace = 'true' or @nsref]) 
            then 'namespace-node' 
            else if ($node/self::mlml:document) 
            then 'document-node' 
            else $node/local-name()
            "/>
        <xsl:variable name="kind-test" select="($node-test/@kind, 'node')[1]"/>
        
        <xsl:sequence select="
            if (not(($node-kind, 'node') = $kind-test))
            then false()
            else 
            if ($node-kind = 'document-node' and $node-test/nodeTest) 
            then (mlmlp:node-test($node/mlml:element, $node-test/nodeTest))  
            else mlmlp:node-test-name($node, $node-test/@name)
            "/>
    </xsl:function>
    
    <xsl:function name="mlmlp:node-test-name" as="xs:boolean">
        <xsl:param name="node" as="element()"/>
        <xsl:param name="name-test" as="attribute()?"/>
        <xsl:variable name="name-matcher" select="xpm:name-matcher($name-test)"/>
        <xsl:choose>
            <xsl:when test="$name-matcher?namespace = 'http://www.w3.org/2000/xmlns/'">
                <xsl:sequence select="error(xpe:error-code('XQST0070'), 
                    'The string ''http://www.w3.org/2000/xmlns/'' cannot be used as a namespace URI.'
                    )"/>
            </xsl:when>
            <xsl:when test="not($name-test)">
                <xsl:sequence select="true()"/>
            </xsl:when>
            <xsl:when test="$node/self::mlml:attribute[@nsref]">
                <xsl:sequence select="($node/@nsref, '*') = $name-matcher?local and $name-matcher?namespace = ''"/>
            </xsl:when>
            <xsl:when test="$node/self::mlml:attribute[@namespace = 'true']">
                <xsl:sequence select="($node/mlml:name, '*') = $name-matcher?local and $name-matcher?namespace = ''"/>
            </xsl:when>
            <xsl:when test="$node/self::mlml:element | $node/self::mlml:attribute">
                <xsl:variable name="qname" select="
                    if ($node/self::mlml:attribute) 
                    then mlml:attr-name($node) 
                    else mlml:el-name($node)
                    "/>
                <xsl:variable name="node-ns" select="('*', namespace-uri-from-QName($qname))"/>
                <xsl:variable name="node-local" select="('*', local-name-from-QName($qname))"/>
                
                <xsl:sequence select="$node-local = $name-matcher?local and $node-ns = $name-matcher?namespace"/>
            </xsl:when>
            <xsl:when test="$node/self::mlml:pi">
                <xsl:variable name="target" select="$node/mlml:name"/>
                <xsl:sequence select="$target = $name-matcher?local and $name-matcher?namespace = ('*', '')"/>
            </xsl:when>
            <xsl:when test="
                $node/self::mlml:document | $node/self::mlml:comment | $node/self::mlml:text
                ">
                <xsl:sequence select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="error(QName('', 'TODO'), 'Internal error!') "/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    
<!--    
    XPath Operation Extensions
    -->
    
    <xsl:function name="mlmlp:op-node-eq" as="xs:boolean?">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="arg1" as="item()*"/>
        <xsl:param name="arg2" as="item()*"/>
        <xsl:variable name="nodeType" as="element(itemType)">
            <itemType>
                <nodeTest kind="node"/>
            </itemType>
        </xsl:variable>
        <xsl:sequence select="
            if (empty($arg1) or empty($arg2)) 
            then () 
            else if (not(mlmlp:instance-of($exec-context, $arg1, $nodeType))) 
            then error(error(xpe:error-code('XPTY0004'), 
            ' Required item type of first operand of ''is'' is node(); supplied value has type ' 
            || xpe:type-info($arg1) || '.'
            )) 
            else if (not(mlmlp:instance-of($exec-context, $arg2, $nodeType)))  
            then error(error(xpe:error-code('XPTY0004'), 
            ' Required item type of first operand of ''is'' is node(); supplied value has type ' 
            || xpe:type-info($arg1) || '.'
            )) 
            else mlmlp:generate-id($arg1) = mlmlp:generate-id($arg2)
            "/>
    </xsl:function>

    <xsl:function name="mlmlp:op-union" as="node()*">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="arg1" as="node()*"/>
        <xsl:param name="arg2" as="node()*"/>
        
        <xsl:variable name="nodes" select="$arg1 | $arg2"/>
        <xsl:variable name="roots" select="$nodes/mlmlp:root(.)"/>
        
        <xsl:variable name="result-nodes" as="node()*">
            <xsl:for-each-group select="$roots" group-by="mlmlp:generate-id(.)">
                <xsl:sort select="current-grouping-key()"/>
                <xsl:sequence select="key('mlml-genid', $nodes/mlmlp:generate-id(.))"/>
            </xsl:for-each-group> 
        </xsl:variable>
        
        <xsl:sequence select="$result-nodes"/>
        
    </xsl:function>

    <xsl:function name="mlmlp:op-except" as="node()*">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="arg1" as="node()*"/>
        <xsl:param name="arg2" as="node()*"/>
        <xsl:variable name="arg2-ids" select="$arg2/mlmlp:generate-id(.)"/>
        
        <xsl:variable name="nodes" select="$arg1[not(mlmlp:generate-id(.) = $arg2-ids)]"/>
        <xsl:variable name="roots" select="$nodes/mlmlp:root(.)"/>
        
        <xsl:variable name="result-nodes" as="node()*">
            <xsl:for-each-group select="$roots" group-by="mlmlp:generate-id(.)">
                <xsl:sort select="current-grouping-key()"/>
                <xsl:sequence select="key('mlml-genid', $nodes/mlmlp:generate-id(.))"/>
            </xsl:for-each-group> 
        </xsl:variable>
        
        <xsl:sequence select="$result-nodes"/>
        
    </xsl:function>

    <xsl:function name="mlmlp:op-intersect" as="node()*">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="arg1" as="node()*"/>
        <xsl:param name="arg2" as="node()*"/>
        <xsl:variable name="arg2-ids" select="$arg2/mlmlp:generate-id(.)"/>
        
        <xsl:variable name="nodes" select="$arg1[mlmlp:generate-id(.) = $arg2-ids]"/>
        <xsl:variable name="roots" select="$nodes/mlmlp:root(.)"/>
        
        <xsl:variable name="result-nodes" as="node()*">
            <xsl:for-each-group select="$roots" group-by="mlmlp:generate-id(.)">
                <xsl:sort select="current-grouping-key()"/>
                <xsl:sequence select="key('mlml-genid', $nodes/mlmlp:generate-id(.))"/>
            </xsl:for-each-group> 
        </xsl:variable>
        
        <xsl:sequence select="$result-nodes"/>
        
    </xsl:function>
    
    <!--    
        TODO
    -->
    
    <xsl:mode name="mlmlp:instance-of"/>
    
    <xsl:function name="mlmlp:instance-of" as="xs:boolean">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="arg" as="item()*"/>
        <xsl:param name="itemType" as="element(itemType)"/>
        
        <xsl:apply-templates select="$itemType" mode="mlmlp:instance-of">
            <xsl:with-param name="input" select="$arg" tunnel="yes"/>
            <xsl:with-param name="exec-context" select="$exec-context" tunnel="yes"/>
        </xsl:apply-templates>
        
    </xsl:function>
    
    <xsl:template match="itemType[nodeTest]" mode="mlmlp:instance-of" priority="20">
        <xsl:param name="exec-context" as="map(*)" tunnel="yes"/>
        <xsl:param name="input" tunnel="yes"/>
        <xsl:variable name="occur" select="(@occurrence, 'one')[1]"/>
        <xsl:choose>
            <xsl:when test="empty($input)">
                <xsl:sequence select="matches($occur, '^zero-')"/>
            </xsl:when>
            <xsl:when test="count($input) gt 1 and not(matches($occur, '-more$'))">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:when test="count($input) eq 1">
                <xsl:apply-templates select="nodeTest" mode="#current"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="
                    every $i in $input
                        satisfies mlmlp:instance-of($exec-context, $i, .)
                    "/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="itemType" mode="mlmlp:instance-of">
        <xsl:param name="exec-context" as="map(*)" tunnel="yes"/>
        <xsl:param name="input" tunnel="yes"/>
        <xsl:sequence select="xpt:instance-of($exec-context, $input, .)"/>
    </xsl:template>
    
    <xsl:template match="nodeTest" mode="mlmlp:instance-of" priority="20">
        <xsl:param name="input" tunnel="yes"/>
        <xsl:choose>
            <xsl:when test="not($input instance of element())">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:when test="not($input/self::mlml:*)">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="nodeTest[@kind != 'node']" mode="mlmlp:instance-of" priority="10">
        <xsl:param name="input" as="element()" tunnel="yes"/>
        <xsl:variable name="node-type" select="
            if ($input/self::mlml:document) 
            then 'document-node' 
            else $input/local-name()
            "/>
        <xsl:choose>
            <xsl:when test="$node-type = @kind">
                <xsl:next-match/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="nodeTest[@name]" mode="mlmlp:instance-of" priority="5">
        <xsl:param name="input" as="element()" tunnel="yes"/>
        <xsl:variable name="name" select="
            if (mlml:is-eqname(@name)) 
            then mlml:parse-eqname(@name) 
            else resolve-QName(@name, .)
            " as="xs:QName"/>
        <xsl:variable name="node-name" select="mlmlp:node-name($input)"/>
        <xsl:choose>
            <xsl:when test="$node-name = $name">
                <xsl:next-match/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="nodeTest" mode="mlmlp:instance-of" priority="-10">
        <xsl:sequence select="true()"/>
    </xsl:template>
    
    <!--  
        XPath extension functions
    -->
    
    <xsl:mode name="mlmlp:cdata-section" on-no-match="shallow-skip"/>
    
    
    <xsl:function name="mlmlp:cdata-section" as="node()*">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:variable name="context" select="$exec-context?context"/>
        <xsl:sequence select="
            if (empty($context)) 
            then error(xpe:error-code('XPDY0002'), 'Context item is absent for function call cdata-section()') 
            else mlmlp:cdata-section($exec-context, $context)
            "/>
        
    </xsl:function>
    
    <xsl:function name="mlmlp:cdata-section" as="node()*">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="context" as="element()?"/>
        <xsl:variable name="content" select="
            $context/(
            if (self::mlml:element) 
            then mlml:content 
            else .
            )"/>
        <xsl:variable name="cdatas" as="element(mlml:cdata-section)*">
            <xsl:apply-templates select="$content" mode="mlmlp:cdata-section"/>
        </xsl:variable>
        <xsl:sequence select="$cdatas"/>
    </xsl:function>
    
    <xsl:template match="mlml:element" mode="mlmlp:cdata-section"/>
    
    <xsl:template match="mlml:cdata-section" mode="mlmlp:cdata-section">
        <xsl:sequence select="."/>
    </xsl:template>
    
    <xsl:template match="text()" mode="mlmlp:cdata-section"/>
    
    <xsl:mode name="mlmlp:entity" on-no-match="shallow-skip"/>
    
    <xsl:function name="mlmlp:entity" as="node()*">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:sequence select="mlmlp:entity($exec-context, '*')"/>
    </xsl:function>
    
    <xsl:function name="mlmlp:entity" as="node()*">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="lookup" as="xs:string"/>
        <xsl:variable name="context" select="$exec-context?context"/>
        <xsl:sequence select="
            if (empty($context)) 
            then error(xpe:error-code('XPDY0002'), 'Context item is absent for function call entity()') 
            else mlmlp:entity($exec-context, $lookup, $context)
            "/>
        
    </xsl:function>

    <xsl:function name="mlmlp:entity" as="node()*">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="lookup" as="xs:string"/>
        <xsl:param name="context" as="element()"/>
        <xsl:variable name="content" select="
            $context/(
                if (self::mlml:element) 
                then mlml:content 
                else .
            )"/>
        <xsl:variable name="entities" as="element(mlml:entity)*">
            <xsl:apply-templates select="$content" mode="mlmlp:entity">
                <xsl:with-param name="lookup" select="$lookup" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:sequence select="$entities"/>
    </xsl:function>
    
    <xsl:template match="mlml:element" mode="mlmlp:entity"/>

    <xsl:template match="mlml:entity[@name]" mode="mlmlp:entity">
        <xsl:param name="lookup" as="xs:string" tunnel="yes"/>
        <xsl:if test="(@name , '*') = $lookup">
            <xsl:sequence select="."/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="mlml:entity[@codepoint]" mode="mlmlp:entity">
        <xsl:param name="lookup" as="xs:string" tunnel="yes"/>
        
        <xsl:choose>
            <xsl:when test="$lookup = '*'">
                <xsl:sequence select="."/>
            </xsl:when>
            <xsl:when test="starts-with($lookup, '#')">
                <xsl:variable name="codepoint" select="mlml:codepoint-by-charref(@codepoint)"/>
                <xsl:variable name="lookup-cp" select="
                    mlml:codepoint-by-charref(substring($lookup, 2)) 
                    " as="xs:integer"/>
                <xsl:if test="$codepoint = $lookup-cp">
                    <xsl:sequence select="."/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="text()" mode="mlmlp:entity"/>
    
    <xsl:function name="mlmlp:is-default-attribute" as="xs:boolean">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:variable name="context" select="$exec-context?context"/>
        <xsl:sequence select="
            if (empty($context)) 
            then error(xpe:error-code('XPDY0002'), 'Context item is absent for function call is-default-attribute()') 
            else mlmlp:is-default-attribute($exec-context, $context)
            "/>
    </xsl:function>
        
    <xsl:function name="mlmlp:is-default-attribute" as="xs:boolean?">
        <xsl:param name="exec-context" as="map(*)"/>
        <xsl:param name="attribute" as="element(mlml:attribute)?" mlmlp:as="attribute()?"/>
        <xsl:sequence select="
            if ($attribute) 
            then $attribute/@default = 'true' 
            else ()
            "/>
    </xsl:function>

    <xsl:function name="mlmlp:no-defaults" as="node()*">
        <xsl:param name="nodes" as="element()*" mlmlp:as="node()*"/>
        <xsl:sequence select="
            for $n in $nodes return
            if ($n instance of element(mlml:attribute)) 
            then $n[not(@default = 'true')] 
            else $n
            "/>
    </xsl:function>
    
    
    
    
</xsl:stylesheet>