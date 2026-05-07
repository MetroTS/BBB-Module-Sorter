# Module sorter for all the BBB students out there

Automatically sorts your Downloads folder nightly using a Windows Scheduled Task.

**!!! WARNING STILL HEAVILY WORK IN PROGESS !!! use at your own risk**

---

| File | Role |
|---|---|
| `init.ps1` | One-time setup script. Registers Scheduled-Task |
| `modulesorter.ps1` | Actual sorting logic |

`init.ps1` is run **once** by the user. It registers `modulesorter.ps1` as a Scheduled-Task in Windows to repeat every day at 2 AM. If the machine was off at that time it will fire it at the next boot.

## Stuff needed

-Windows 10/11
-Powershell 5.1 or newer
-Admin rights

---

## Setup

**1. Clone or download the repo**

Place both `init.ps1` and `modulesorter.ps1` in the same folder --> I recommend a specific folder in documents.
If you wish to edit the time when the automation runs you can edit Line 15 in the init.ps1 file at the `-Daily -At "xx:xx"` flag.

**2. Run the `init.ps1` as admin**

double click `init.ps` 

or

``` powershell
# Start Powershell as admin
cd "C:\Users\yourfolderpathere" 
\.init.ps1
```

**3. Verify the install

```powershell
Get-ScheduledTask -TaskName "FileSort"
```

You should see `State: Ready` if the install was a success, like this:
``` powershell

TaskPath                                       TaskName                          State
--------                                       --------                          -----
\                                              FileSort                          Ready

```

## Uninstall

to remove:

``` powershell
Unregister-TaskScheduler -TaskName "FileSort" -Confirm:$false
```
