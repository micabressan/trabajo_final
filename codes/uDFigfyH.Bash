docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; disabled)
   Active: failed (Result: timeout) since Ср 2015-08-19 13:35:57 NOVT; 1min 52s ago
     Docs: https://docs.docker.com
 Main PID: 2245

авг 19 13:34:27 cap.nachislim docker[2245]: time="2015-08-19T13:34:27.193943782+06:00" level=warning msg="You are running linux kernel version 3.8.13-68.3.5.el7uek.x86_64, which might be unstable running docker. Please upgrade your kernel to 3.10.0."
авг 19 13:34:27 cap.nachislim docker[2245]: time="2015-08-19T13:34:27.234809137+06:00" level=info msg="[graphdriver] using prior storage driver \"devicemapper\""
авг 19 13:34:27 cap.nachislim docker[2245]: time="2015-08-19T13:34:27.235372781+06:00" level=info msg="Option DefaultDriver: bridge"
авг 19 13:34:27 cap.nachislim docker[2245]: time="2015-08-19T13:34:27.235392114+06:00" level=info msg="Option DefaultNetwork: bridge"
авг 19 13:34:27 cap.nachislim docker[2245]: time="2015-08-19T13:34:27.237634824+06:00" level=warning msg="Running modprobe bridge nf_nat br_netfilter failed with message: modprobe: WARNING: Module br_netfilter not found.\n, error: exit status 1"
авг 19 13:35:57 cap.nachislim systemd[1]: docker.service operation timed out. Terminating.
авг 19 13:35:57 cap.nachislim systemd[1]: Failed to start Docker Application Container Engine.
авг 19 13:35:57 cap.nachislim systemd[1]: Unit docker.service entered failed state.