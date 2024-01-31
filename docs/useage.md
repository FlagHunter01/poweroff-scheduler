---
title: Installation and useage
description: Guide on how to install and use the software. 
---

!!! warning "Admin privileges"
    Admin privileges are required for both the installation and execution of this script.

## Installation

1. First, open PowerShell with admin privileges and past this command:
```ps
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```
Then press the letter corresponding to "Yes". You have to press ++enter++ after each command you write.

2. Download the latest version of the script and unpack it. The destination folder can be anywhere but you should not make it accessible by the target users. 

## Useage

1. Take note of the exact name of the target user, as it can be seen in C:\Users\. This will be referred to as the **username**. 
2. Open the unpacked folder and launch the launcher. A blue window should appear with the main menu of the script. 
3. Depending of your use case, follow one of these three procedures.

=== "Create or update a schedule for a user"
    
    Enter `1`.

=== "Disable the poweroffs for a user"

    Enter `2`.

=== "Delete the script from a user's profile"

    Enter `3`.

When the script prompts you for a username, enter the one from step 1. <br>
If the script was already used, it will give ask you if you want to proceed with the last used username. `Yes` is the default answer, you can decline by entering `n`.

!!! danger "Locking yourself out"
    If you run the script with your own account or the admin account as a target, you will effectively lock yourself out if you are outside of the working hours you specified as the computer will shut down uppon login.

=== "Create or update a schedule for a user"

    For each day of the week, you will be prompted for a morning limit and an afternoon limit.
    Keep in mind that the computer will shut down *before* the morning limit and *after* the afternoon limit. 
    For example, if you set the morning limit at 6 AM and the afternoon limit at 10 PM, the computer will be useable *between* 6 AM and 10 PM. 

    To enter the time, please use the `hhmm` format. For example, 6 AM is `0600` and 10PM is `2200`. 0:1 AM is `0001` and 11:59 PM is `2359`. 

=== "Disable the poweroffs for a user"

    The script will still be present in the user's profile, but it will have no effect on the computer (the working hours will be set from 0 AM to 12 PM). 

    !!! note "Previously unmonitored user"
        Please note that if this action is carried out for a user that was previously unaffected by the script, the script will be written to their profile.

=== "Delete the script from a user's profile"

    All files related to the script will be removed from the target profile.

If you weren't asked to reboot or declined to do so, the script returns to the main menu so you can do another action, or exit by entering any letter. 

If any error messages appeared (in red), it probably means that the username was wrong or the script didn't have admin privileges.
