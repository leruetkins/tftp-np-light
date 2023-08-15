@echo off
del /f /a /q ..\..\soft\antivir\kaspersky\data\005-bases.srm
del /f /a /q ..\..\soft\antivir\kaspersky\data\005-bases.srm.sha512
wget.exe -c rescuedisk.kaspersky-labs.com/updatable/2018/bases/042-freshbases.srm -O ..\..\soft\antivir\kaspersky\data\005-bases.srm
wget.exe -c rescuedisk.kaspersky-labs.com/updatable/2018/bases/hashes.txt -O ..\..\soft\antivir\kaspersky\data\005-bases.srm.sha512
setlocal EnableDelayedExpansion
set "search=042-freshbases.srm"
set "replace=005-bases.srm"
set "file=..\..\soft\antivir\kaspersky\data\005-bases.srm.sha512"

(for /f "delims=" %%i in ('type "%file%"') do (
    set "line=%%i"
    set "line=!line:%search%=%replace%!"
    echo !line!
)) > "%file%.tmp"

move /y "%file%.tmp" "%file%"