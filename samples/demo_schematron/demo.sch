<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:let name="xmlmlns" value="'http://www.nkutsche.com/xmlml'"/>
    <sch:let name="xmlmlpns" value="'http://www.nkutsche.com/xmlml/xpath'"/>
    <sch:let name="config" value="doc('saxon-config.xml')"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
    <sch:ns uri="http://www.w3.org/2005/xpath-functions/map" prefix="map"/>
    
    <sch:let name="xmlml-function" value="
        function($name as xs:string, $args as array(*)){
            transform(map{ 
                    'vendor-options': map {QName('http://saxon.sf.net/', 'configuration'): $config},
                    'package-name' : 'http://www.nkutsche.com/xmlml',
                    'initial-function' : QName($xmlmlns, $name),
                    'function-params' : $args,
                    'delivery-format' : 'raw',
                    'package-version' : '*'
                })?output
            }
        "/>
    <sch:let name="xmlmlp-function" value="
        function($name as xs:string, $args as array(*)){
            transform(map{ 
                    'vendor-options': map {QName('http://saxon.sf.net/', 'configuration'): $config},
                    'package-name' : 'http://www.nkutsche.com/xmlml/xpath',
                    'initial-function' : QName($xmlmlpns, $name),
                    'function-params' : $args,
                    'delivery-format' : 'raw',
                    'package-version' : '*'
                })?output
            }
        "/>
    <sch:let name="xmlml-doc" value="$xmlml-function('parse', [base-uri(/)])"/>
    
    <sch:pattern>
        <sch:rule context="character[@species = 'human']">
            <sch:let name="path" value="'no-defaults(' || path(@species) || ')'"/>
            <sch:let name="no-defaults" value="$xmlmlp-function('xpath-evaluate', [$xmlml-doc, $path, map{}])"/>
            <sch:report test="$no-defaults"
                >Don't use explicit human species as it is the default value.</sch:report>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="text()[contains(., '&#x2009;')]">
            <sch:let name="path" value="path() || '/entity(''x2009'')'"/>
            <sch:let name="entities" value="$xmlmlp-function('xpath-evaluate', [$xmlml-doc, $path, map{}])"/>
            <sch:let name="spaces" value="replace(., '[^&#x2009;]', '') => string-length()"/>
            <sch:assert test="$spaces = count($entities)"
                >Not every thin space was written as &amp;x2009;!</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
</sch:schema>