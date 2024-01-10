# X(ML)²

The X(ML)² structure enables to work on an XML document nodes (XDM tree) but also enables to reconstruct each character of the origin XML syntax. The project provides an XML parser, serializer and XDM tree converter as XSLT function library.

See more details on the [Wiki](https://github.com/nkutsche/xmlml/wiki).

## XML Conformance

The XmlML parser supports the [XML 1.0 edition 5 recommendation](https://www.w3.org/TR/2008/REC-xml-20081126/). XML 1.1 or earlier edditions are not supported.

If the Maven test phase is invoked with the profile `xml-conformance` active (`mvn test -P xml-conformance`), a test harness based on the [W3C XML conformance testsuite](https://www.w3.org/XML/Test/) is invoked.

The test harness generates XSpec tests for each test cases of the XML testsuite. The XSpec test checks that:

* for wellformed test cases (valid or invalid)
    * the input can be parsed to a valid XmlML document (`exists(mlml:validate-xmlml(mlml:parse($path))/self::mlml:document)`). 
    * the input can be parsed and re-serialized without any change (`mlml:serialize(mlml:parse($path)) = fn:unparsed-text($path)`)
    * the function calls `$path => mlml:parse() => mlml:doc()` returns an XDM document which is equal to the result of the `fn:doc($path)`
* parsing the input for non-wellformed test cases   
    * causes an XmlML parser error
* parsing the input of test cases with optional errors 
    * causes an XmlML parser error or
    * has a valid XmlML document as result

### Testsuite Result Summary

There are only a view failing test cases which are not related to the basic restrictions of the XmlML parser (1.0 edition 5). Some of them may be fixed in future, a few are related to the concept using an underlying XSLT process for the parser. 

An overview of all failed test cases is generated and can be found [here](XMLConf-Testsuite-Exclusions.md).

## Contribution

As most of my latest projects also this is based on the two following very usefull projects:

* [REx Parser Generator](https://www.bottlecaps.de/rex/) - which was used as basic generator to parse the XML syntax.
* [rng.xsl](https://github.com/maxtoroq/rng.xsl) - an XSLT based implementation of Relax NG
