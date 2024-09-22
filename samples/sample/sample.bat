
java -cp %~dp0lib/* net.sf.saxon.Transform -init:com.nkutsche.xslt.pkg.handler.PackageManager -it -xsl:%~dp0sample.xsl -o:%~dp0results/xmlml-sample.xml