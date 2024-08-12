@echo off

set THIS=%~dp0

set debug=false

if "-d"=="%1" set debug=true
shift

set xpath=%~1

if not "%xpath%"=="" set xpath=xpath='%xpath%'


mvn -q -P demo -f ../../pom.xml exec:exec -Dexec.executable="java" -Dexec.args="%J_OPTS% -cp %%classpath net.sf.saxon.Transform -init:com.nkutsche.xslt.pkg.handler.PackageManager -xsl:%THIS%\demo.xsl -it -s:%THIS%\xpaths.xml debug=%debug% %xpath%"

:: XPath:
:: mvn exec:java  -Dexec.mainClass=net.sf.saxon.Transform -Dexec.args="-init:com.nkutsche.xslt.pkg.handler.PackageManager -xsl:src/test/xspec/samples/sample-test-xpath.xsl -s:src/test/xspec/samples/dummy.xml -o:target/debug-out.xml"

