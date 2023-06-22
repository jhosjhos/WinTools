::-------------MENU---------------------------
@echo off
::--Interfaz----
::COLOR 0A
::mode con cols=96 lines=35
::--------Menu Principal------------
:menu
    cls                          
echo.   
echo.     '##:::::'##'####'##::: ##'########:'#######::'#######:'##:::::::'######::
echo.      ##:'##: ##. ##::###:: ##... ##..:'##.... ##'##.... ##:##::::::'##... ##:
echo.      ##: ##: ##: ##::####: ##::: ##::::##:::: ##:##:::: ##:##:::::::##:::..::
echo.      ##: ##: ##: ##::## ## ##::: ##::::##:::: ##:##:::: ##:##::::::. ######::
echo.      ##: ##: ##: ##::##. ####::: ##::::##:::: ##:##:::: ##:##:::::::..... ##:
echo.      ##: ##: ##: ##::##:. ###::: ##::::##:::: ##:##:::: ##:##::::::'##::: ##:
echo.     . ###. ###:'####:##::. ##::: ##:::. #######:. #######::########. ######::
echo.     :...::...::....:..::::..::::..:::::.......:::.......::........::......::: By YHXS
echo.        
echo.
echo.                                               1.- Checker Windows Update Status                                    
echo.                                               2.- Disable Windows Update
echo.                                               3.- Restore Windows Update
echo.                                       
echo.
echo.                                                7.- readme
echo.                                                8.- changelog                             
echo.                                                9.- salir            
echo.
echo.
echo.
echo.
echo.
echo.
echo.

echo.:...::...:: Recuerda ejecutar este Script como ADMINISTRADOR o NO funcionara :...::...::
    set /P Opc=
 
    IF "%Opc%"    ==  "9"  goto :EOF
    IF "%Opc%"    ==  "8"  goto change
    IF "%Opc%"    ==  "7"  goto readme
    IF "%Opc%"    ==  "4"  goto 
    IF "%Opc%"    ==  "3"  goto rest
    IF "%Opc%"    ==  "2"  goto desc
    IF "%Opc%"    ==  "1"  goto check
                           goto:menu

::-----------Checker_WindowsUpdate-----------------
:check
    cls

@echo off
echo Este script verifica si los servicios de los cuales depende Windows Update estan corriendo.
echo.
echo.
TIMEOUT /T 1 > NUL
echo. Estado:
TIMEOUT /T 1 > NUL
echo.
echo Servicio de transferencia inteligente en segundo plano (BITS):
sc query BITS | findstr ESTADO
TIMEOUT /T 1 > NUL
echo.
echo Update ORCHESTRATOR service
sc query UsoSvc | findstr ESTADO
TIMEOUT /T 1 > NUL
echo.
echo Windows update
sc query wuauserv | findstr ESTADO
TIMEOUT /T 1 > NUL
echo.
echo Windows Update Medic Service
sc query WaasMedicSvc | findstr ESTADO
echo.
TIMEOUT /T 1 > NUL

pause
goto:menu

::------------Desactivador_WindowsUpdate--------------
:desc
   cls
@echo off
TIMEOUT /T 1 > NUL
echo Este script desactiva todos los servicios relacionados con las actualizaciones.
::                   ¡¡Este solamente es compatible con WINDOWS 10!!
::----------Backend-----------
TIMEOUT /T 2 > NUL
echo.
echo -----------------------------------------
echo       Haciendo cambios en el Regedit 
echo -----------------------------------------
TIMEOUT /T 3 > NUL
set X=UsoSvc
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "Start" /T REG_DWORD /D "4" /F
TIMEOUT /T 2 > NUL
set X=WaasMedicSvc
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "Start" /T REG_DWORD /D "4" /F
TIMEOUT /T 2 > NUL
set X=BITS
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "Start" /T REG_DWORD /D "4" /F
TIMEOUT /T 2 > NUL
set X=wuauserv
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "Start" /T REG_DWORD /D "4" /F
TIMEOUT /T 1 > NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "ObjectName" /T REG_SZ /D "Guest" /F
TIMEOUT /T 2 > NUL
::--------------------------------------------------------------------------------------------------------------------
   cls
echo -----------------------------------------
echo           Deteniendo servicios
echo -----------------------------------------
echo.
echo Servicios:
TIMEOUT /T 2 > NUL
echo Servicio de transferencia inteligente...
sc stop BITS
echo.
TIMEOUT /T 2 > NUL
echo ORCHESTRATOR...
sc stop UsoSvc
echo.
TIMEOUT /T 2 > NUL
echo Windows Update...
sc stop wuauserv
echo.
TIMEOUT /T 2 > NUL
echo Windows Update Medic Service...
sc stop WaasMedicSvc
echo.
TIMEOUT /T 2 > NUL
::----------------------------------------------------------------------------------------------------------------------
  cls
echo -----------------------------
echo        Check de Exito
echo -----------------------------
echo.
TIMEOUT /T 2 > NUL
echo Servicio de transferencia inteligente..
sc query BITS | findstr ESTADO
echo.
TIMEOUT /T 1 > NUL
echo Update ORCHESTRATOR 
sc query UsoSvc | findstr ESTADO
echo.
TIMEOUT /T 1 > NUL
echo Windows Update
sc query wuauserv | findstr ESTADO
echo.
TIMEOUT /T 1 > NUL
echo Windows Update Medic Service
sc query WaasMedicSvc | findstr ESTADO
echo.
TIMEOUT /T 1 > NUL
echo.
echo -------------------------------------------------------
echo          Todos los servicios deben estar STOPPED 
echo             para que las actualizaciones esten
echo                       desabilitadas  
echo -------------------------------------------------------
echo.
::Referencia-Codigo basado en David Lightman

pause
goto:menu

::------------Restablecer WindowsUpdate---------------------
:rest
   cls
@echo off
echo Este script Restablece la configuracion de Disable Windows Update.
::                           Solo funciona con windows 10
echo. 
TIMEOUT /T 3 >NUL
echo  ----------------------------------------------------------
echo  Restaurando los permisos de ejecucion de Windows Update...
echo  ----------------------------------------------------------
echo.

TIMEOUT /T 2 >NUL
set X=wuauserv
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "ObjectName" /T REG_SZ /D "LocalSystem" /F
echo.

TIMEOUT /T 1 >NUL
set X=UsoSvc
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "ObjectName" /T REG_SZ /D "LocalSystem" /F
echo.

TIMEOUT /T 2 > NUL
echo Restaurando ORCHESTRATOR service...
set X=UsoSvc
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "Start" /T REG_DWORD /D "3" /F
echo.

TIMEOUT /T 2 > NUL
echo Restaurando Windows Update Medic Service...
set X=WaasMedicSvc
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "Start" /T REG_DWORD /D "3" /F
echo.

TIMEOUT /T 2 > NUL
echo Restaurando Servicio de transferencia inteligente...
set X=BITS
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "Start" /T REG_DWORD /D "3" /F
echo.

TIMEOUT /T 2 > NUL
echo Restaurando Windows Update...
set X=wuauserv
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%X%" /V "Start" /T REG_DWORD /D "3" /F
echo.

TIMEOUT /T 3 > NUL
echo ------------------------------------------------------------------------------------------
echo.                                    RESTAURACION COMPLETADA
echo                 Es necesario reiniciar para que los permisos se puedan arrancar.
echo ------------------------------------------------------------------------------------------
echo.
::Referencia-Codigo basado en David Lightman

pause
goto:menu

::----------README----------------------------
:readme
@echo off
start https://github.com/jhosjhos/WinTools/tree/main#readme
goto :menu

::----------CHANGELOG-------------------------
:change
@echo off
start https://github.com/jhosjhos/WinTools/blob/main/CHANGELOG.md
goto :menu
