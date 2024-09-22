set XSPEC=xmlml-testsuite.xspec

if not "%1"=="" set XSPEC=%1

if "%1"=="#all" set XSPEC=

mvn compile com.nkutsche:xspec-maven-plugin:run-xspec@run-xspec -Drun.xspecs=%XSPEC%
