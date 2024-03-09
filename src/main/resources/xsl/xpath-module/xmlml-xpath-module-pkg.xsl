<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:package [<!ENTITY % versions SYSTEM "../../version.ent">%versions;]>
<xsl:package xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:mlml="http://www.nkutsche.com/xmlml"
    xmlns:xpm="http://www.nkutsche.com/xpath-model"
    xmlns:xpf="http://www.nkutsche.com/xmlml/xpath-engine/functions"
    xmlns:xpe="http://www.nkutsche.com/xpath-model/engine"
    xmlns:mlmlp="http://www.nkutsche.com/xmlml/xpath"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    package-version="&project.version;"
    name="http://www.nkutsche.com/xmlml/xpath"
    exclude-result-prefixes="math"
    version="3.0">
    <xsl:import href="xmlml-xpath-module.xsl"/>
    
    <xsl:use-package name="http://maxtoroq.github.io/rng-xsl" package-version="*"/>
    <xsl:use-package name="http://www.nkutsche.com/xmlml" package-version="*"/>
    
    <xsl:use-package name="http://www.nkutsche.com/xpath-model" package-version="*">
        
        <xsl:override>
            <xsl:function name="xpe:tree-walk" as="node()*" visibility="public">
                <xsl:param name="context" as="node()"/>
                <xsl:param name="axis" as="xs:string"/>
                <xsl:param name="node-test" as="element()?"/>
                <xsl:sequence select="mlmlp:tree-walk($context, $axis, $node-test)"/>
            </xsl:function>
        </xsl:override>
    </xsl:use-package>
    
    
</xsl:package>