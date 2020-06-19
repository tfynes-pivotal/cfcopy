# cfcopy
copy files from PCF container to windows desktop using cf client a putty scp (pscp)

PreReq:
* putty scp (pscp) on windows path
* cf cli on windows path
* cf logged into the target PCF foudnation and targetting appropriate org and space

usage: 

cfcopy {app-name} {system-domain} {filename with path in app-container} {local-filename with path}

where {system-domain} is the domain on which the cf api is listening.. e.g. cf login -a api.{system-domain}

details:
cfcopy
  1. gets app-guid for PCF container hosting app with file
  2. gets ssh one-time login code
  3. forms the pscp command required to copy the file from the pcf container to local windows workstation
  
Note PCF hosted application files are hosted in /home/vcap/app
Use cf ssh {app-name} and locate file of interest to be copied down
Defaults to using index 0 (first AI) if there is more than one - change script if source file required from difference app instance.

known issue: after file transfer from PCF to local windows desktop completes, pscp sometimes hangs at 100%

