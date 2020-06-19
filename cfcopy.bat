@echo off

rem set appname to first argument
if "%1"=="" goto continue
set appname=%1

rem default app-instance 0 is used
set appinstance=0

rem set system domain to second argument
if "%2"=="" goto continue
set systemdomain=%2

rem set containerfilepath to third argument
if "%3"=="" goto continue
set containerfilepath=%3

rem set localfilepath to fourth argument
if "%4"=="" goto continue
set localfilepath=%4


rem GET APP GUID
cf app %appname% --guid > appguid.tmp
set /p appguid=<appguid.tmp
del appguid.tmp

rem GET SSH LOGIN CODE
cf ssh-code > sshcode.tmp
set /p sshcode=<sshcode.tmp
del sshcode.tmp


echo executing pscp -P 2222 -pw %sshcode% -l cf:%appguid%/%appinstance% ssh.%systemdomain%:%containerfilepath% %localfilepath%
pscp -P 2222 -pw %sshcode% -l cf:%appguid%/%appinstance% ssh.%systemdomain%:%containerfilepath% %localfilepath%

goto done

:continue
echo Usage: 
echo PreReq: Log into PCF and target the org/space containing your application
echo cfcopy {app-name} {system-domain} {filename with path in app-container} {local-filename}
rem pscp -P 2222 -pw IqQxdlFx4y -l cf:4eebfbf8-aaf7-42b2-8250-0b7c1125c9bc/0 ssh.system.homelab.fynesy.com:/home/vcap/app/env ./env

:done
echo done
