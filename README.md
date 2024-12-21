# NeverSink-Updater

This quick and dirty POSH script will automatically download **NeverSinks Litefilter.filter** from the [NeverSinkDev/NeverSink-PoE2litefilter](https://github.com/NeverSinkDev/NeverSink-PoE2litefilter) GitHub repository. If the file has changed, it automatically downloads the latest version to your local Path of Exile 2 folder.


# Windows Scheduler

## Scheduling the Script (Windows Task Scheduler)

You can automate this script to run periodically (e.g., daily, weekly, or hourly).

1.  **Open Task Scheduler**  
    Press the Windows key and search for **Task Scheduler**.
    
2.  **Create a Basic Task**
    
    -   Click **Create Basic Task** on the right.
    -   Give it a name, e.g., **PoE2 Filter Updater**.
    -   Choose a schedule (Daily, Weekly, etc.).
3.  **Action**: **Start a program**
    
    -   In **Program/script**, type:
              
        `powershell.exe` 
        
    -   In **Add arguments**, enter:
        
        `-ExecutionPolicy Bypass -File "C:\Scripts\NeverSink-Updater.ps1"` 
        
        (Adjust the path if your script is elsewhere.)
4.  **Complete the Wizard**  
    Click **Finish** and confirm the task appears in the Task Scheduler Library.
