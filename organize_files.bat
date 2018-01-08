::this script will quickly organize all of your files, creating
:: a directory for each extension it finds and 
:: moving the necessary files into each directory
@echo off
rem For each file in your folder
for %%a in (".\*") do (
rem Check if the file has an extension and if it is not our script
if "%%~xa" NEQ ""  if "%%~dpxa" NEQ "%~dpx0" (
rem Create a directory if needed
if not exist "%%~xa" mkdir "%%~xa"
rem Move the file to directory
move "%%a" "%%~dpa%%~xa\"
))

