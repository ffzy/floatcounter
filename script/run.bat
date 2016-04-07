@echo off

set FILE=%1

if {%FILE%} == {} (
    echo Usage: run.bat ^<input file^>
    goto END
)

set MVN_HOME=C:\Program Files\apache-maven-3.2.3
set MVN=%MVN_HOME%\bin\mvn
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_74
set JAVA=%JAVA_HOME%\bin\java

REM set JAR_FILE=target\floatcounter-*-with-dependencies.jar
REM REM Wildcard is evil in Windows.
set JAR_FILE=target\floatcounter-1.0-SNAPSHOT-jar-with-dependencies.jar

set LOG=logs\run.log
if not exist logs (
    mkdir logs
)
echo See %LOG% for detail.

echo Building...
call "%MVN%" package > %LOG%

echo Running...
call "%JAVA%" -jar -DfileName=%FILE% %JAR_FILE% >> %LOG%

echo Done

:END