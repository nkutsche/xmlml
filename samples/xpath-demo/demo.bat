@echo off

set xpath=%~1

if not "%xpath%"=="" set xpath=xpath='%xpath%'


mvn -q -f ../../pom.xml exec:exec -Dexec.executable="java" -Dexec.args="%J_OPTS% -cp %%classpath net.sf.saxon.Transform -init:com.nkutsche.xslt.pkg.handler.PackageManager -xsl:%~dp0\demo.xsl -it -s:%~dp0\xpaths.xml %xpath%"

:: XPath:
:: mvn exec:java  -Dexec.mainClass=net.sf.saxon.Transform -Dexec.args="-init:com.nkutsche.xslt.pkg.handler.PackageManager -xsl:src/test/xspec/samples/sample-test-xpath.xsl -s:src/test/xspec/samples/dummy.xml -o:target/debug-out.xml"

