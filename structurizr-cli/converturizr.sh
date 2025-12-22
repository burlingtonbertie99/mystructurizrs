# REM @echo off
# REM setlocal
#REM set SCRIPT_DIR=%~dp0
#REM java -cp "%SCRIPT_DIR%;%SCRIPT_DIR%\lib\*;" com.structurizr.cli.StructurizrCliApplication %*
cp ../workspace.dsl .
./structurizr.sh  export -workspace workspace.dsl  -format plantuml -output out/
