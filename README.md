# Poweroff Scheduler
 
## Goal
 
Little bro has a Windows PC and stays up too late, so you want to help him disconnect. The goal is to shut down the computer without relying on parenting control tools as they are easily worked around. I could -and should- have gone for a service or something launched by the scheduler, but where is the fun in that?
 
## How it works
 
This script is designed for a scenario where you have access to the admin account but not to the target user's account.
 
The script shall be launched from the admin account with admin privileges. Upon startup, the script will ask for the target account name and target shutdown time.
 
With the help of the account name, the script will create two files in the folder containing everything to be launched upon the target's login.
One of those files is an infinite loop that kills the computer upon reaching the target time, and the other file contains the said target time.
 
The target time can be modified by running the script again, as it will overwrite the time in the time file.
 
## Known issues
 
 - Not tested yet
 - A window pops up for a second (should be fixed by now)
 

