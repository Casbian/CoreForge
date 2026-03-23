if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
   try {
      Start-Process pwsh -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
      exit
   }
   catch {
      if ($_.Exception.Message -match 'cancel') {
            exit
      }
      Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
      exit
   }
   exit
}
if ($PSVersionTable.PSVersion.Major -lt 7) {
   winget install --id Microsoft.PowerShell --uninstall-previous --accept-package-agreements --accept-source-agreements --silent --force
   Start-Process pwsh -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
   exit
}


Import-Module "$PSScriptRoot\file\file.psm1"
Import-Module "$PSScriptRoot\main\main.psm1"
Import-Module "$PSScriptRoot\richtextbox\richtextbox.psm1"
Import-Module "$PSScriptRoot\thread\thread.psm1" 
Import-Module "$PSScriptRoot\update\update.psm1"
Import-Module "$PSScriptRoot\window\window.psm1"


Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore


function UpdateRun($AppList) {
   try {
      if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
         Remove-Module PSWindowsUpdate -Force -ErrorAction SilentlyContinue
         Install-Module PSWindowsUpdate -Force -Scope AllUsers -ErrorAction SilentlyContinue
      }
      Import-Module PSWindowsUpdate;
      $services = @('wuauserv', 'bits', 'cryptsvc')
      foreach ($serviceName in $services) {
         $serviceRunning = $false;
         while ($serviceRunning -eq $false) {
            $service = Get-Service -Name $serviceName;
            if ($null -eq $service) {
                  break;
            }
            if ($service.Status -ne 'Running') {
                  Start-Service $serviceName;
            } else {
                  $serviceRunning = $true;
                  break;
            }
         }
      }
      Get-WindowsUpdate -AcceptAll -Install -Verbose -IgnoreReboot 4>&1 | ForEach-Object {
      $line = if ($_.Message) { 
         $_.Message 
      } elseif ($_ -is [System.Management.Automation.VerboseRecord]) {
         $_.Message
      } elseif ($_.GetType().Name -eq '__ComObject') {
         $null
      } else { 
         "$_" 
      }
      if ($line) {
         $trimmedLine = $line -replace 'Please wait\.\.\.', ''
         RichTextBox $SystemWindowsControlsRichTextBox0 "> $trimmedLine" -RemoveLast -Color ([System.Windows.Media.Brushes]::Cyan)
         Window
      } 
      }
      RichTextBox $SystemWindowsControlsRichTextBox0 ""
      Window
      foreach ($App in $AppList) {
         $AppName = $App.name
         $AppID = $App.id
         winget install --id $AppID --uninstall-previous --accept-package-agreements --accept-source-agreements --force | ForEach-Object {
            RichTextBox $SystemWindowsControlsRichTextBox0 "> $_" -RemoveLast -Color ([System.Windows.Media.Brushes]::Cyan)
            Window
         }
         RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE Winget        | Installation   | v/ - $AppName" -Color ([System.Windows.Media.Brushes]::Cyan)  
         Window
      }
   }
   catch {
      <#Do this if a terminating exception happens#>
   }
}
function StartUpdateRun($AppList) {
   RichTextBox $SystemWindowsControlsRichTextBox0 ""
   RichTextBox $SystemWindowsControlsRichTextBox0 ""
   RichTextBox $SystemWindowsControlsRichTextBox0 "‎  Update Run"
   RichTextBox $SystemWindowsControlsRichTextBox0 "_________________________________________________________________"
   RichTextBox $SystemWindowsControlsRichTextBox0 ""
   RichTextBox $SystemWindowsControlsRichTextBox0 ""
   Window
   UpdateRun $AppList
   RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE WindowsUpdate | ReScan         | -" -Color ([System.Windows.Media.Brushes]::Cyan)
   Window
   try {
      $WindowsUpdateOutput = WindowsUpdate-Get
      if ($WindowsUpdateOutput -eq 0) {
         RichTextBox $SystemWindowsControlsRichTextBox1 "No Windows Updates available" -Clear -Color ([System.Windows.Media.Brushes]::LightGreen)
         Window
      } elseif ($WindowsUpdateOutput -eq 1) {
         $RebootFlag = $true
         RichTextBox $SystemWindowsControlsRichTextBox1 "No Windows Updates available - Reboot Required" -Clear -Color ([System.Windows.Media.Brushes]::LightGreen)
         Window
      } else {
         RichTextBox $SystemWindowsControlsRichTextBox1 $WindowsUpdateOutput -Clear
         Window
      }
      RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE WindowsUpdate | ReScan         | v/" -RemoveLast -Color ([System.Windows.Media.Brushes]::LightGreen)
      Window
   } catch {
      RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE WindowsUpdate | ReScan         | ERROR" -RemoveLast -Color ([System.Windows.Media.Brushes]::Red)
      Window
   }
   RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE Winget        | ReScan         | -" -Color ([System.Windows.Media.Brushes]::Cyan)
   Window
   try {
      $WingetOutput, $AppList = Winget-Get
      if ($null -eq $AppList -or $AppList.Count -eq 0) {
         RichTextBox $SystemWindowsControlsRichTextBox2 "No Updates for Apps available" -Clear -Color ([System.Windows.Media.Brushes]::LightGreen)
         Window
      } else {
         RichTextBox $SystemWindowsControlsRichTextBox2 $WingetOutput -Clear
         Window
      }
      RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE Winget        | ReScan         | v/" -RemoveLast -Color ([System.Windows.Media.Brushes]::LightGreen)
      Window
   } catch {
      RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE Winget        | ReScan         | ERROR" -RemoveLast -Color ([System.Windows.Media.Brushes]::Red)
      Window
   }
   if ($RebootFlag -eq $true) {
      $ResultQuestion = [System.Windows.MessageBox]::Show(
      "It was detected that a Reboot is needed`n`nDo you want to reboot now ?",
      "Reboot ?",
      "YesNo",
      "Question"
      )
      if ($ResultQuestion -eq "Yes") {
         Restart-Computer -Force
         exit
      }
   }
}


#======================================#
# MAIN
#======================================#


$CurrentVersion = Update $MyInvocation

Logo

$ThreadPool = ThreadPool

$SystemWindowsWindow, $SystemWindowsControlsRichTextBox0, $SystemWindowsControlsRichTextBox1, $SystemWindowsControlsRichTextBox2 = Home


RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM $CurrentVersion         | StartUp" -Clear -Color ([System.Windows.Media.Brushes]::Cyan)                                                | Out-Null
RichTextBox $SystemWindowsControlsRichTextBox0 ""                                                                                                                                               | Out-Null
RichTextBox $SystemWindowsControlsRichTextBox0 "‎  MODULE               | TASK           | RESULT"                                                                                       | Out-Null
RichTextBox $SystemWindowsControlsRichTextBox0 "_______________________________________________________________________________________________________________________________________"        | Out-Null
RichTextBox $SystemWindowsControlsRichTextBox0 ""                                                                                                                                               | Out-Null
RichTextBox $SystemWindowsControlsRichTextBox0 ""                                                                                                                                               | Out-Null
Window                                                                                                                                                                                        | Out-Null


try {
   $Result = Thread {
      param($Function, $Parameter)
      $FunctionBlock = [scriptblock]::Create($Function)
      & $FunctionBlock $Parameter
   } -ThreadPool $ThreadPool -Function ${function:FileCheckSettings} -Parameter $PSScriptRoot -TaskName "SettingsFile"
   if ($Result -eq 1) {
      RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM               | SettingsFile   | v/" -RemoveLast -Color ([System.Windows.Media.Brushes]::LightGreen)                             | Out-Null
      Window                                                                                                                                                                                  | Out-Null
   } else {
      RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM               | SettingsFile   | X" -RemoveLast -Color ([System.Windows.Media.Brushes]::Red)                                     | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM could not find SettingsFile at $Result" -Color ([System.Windows.Media.Brushes]::Red)                                             | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM created a new EMPTY SettingsFile" -Color ([System.Windows.Media.Brushes]::LightGreen)                                            | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 ""                                                                                                                                         | Out-Null
      Window                                                                                                                                                                                  | Out-Null
   } 
}
catch {
   RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM               | SettingsFile   | ERROR" -RemoveLast -Color ([System.Windows.Media.Brushes]::Red)                                    | Out-Null
   Window                                                                                                                                                                                     | Out-Null
}


RichTextBox $SystemWindowsControlsRichTextBox0 ""                                                                                                                                               | Out-Null
Window                                                                                                                                                                                        | Out-Null
try {
   $Result = Thread {
      param($Function, $Parameter)
      $FunctionBlock = [scriptblock]::Create($Function)
      & $FunctionBlock $Parameter
   } -ThreadPool $ThreadPool -Function ${function:FileCheckAutologon} -Parameter $PSScriptRoot -TaskName "AutologonExe"
   if ($Result -eq 1) {
      RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM               | AutologonExe   | v/" -RemoveLast -Color ([System.Windows.Media.Brushes]::LightGreen)                             | Out-Null
      Window                                                                                                                                                                                  | Out-Null
   } else {
      RichTextBox $SystemWindowsControlsRichTextBox0 "" -RemoveLast                                                                                                                             | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 ""                                                                                                                                         | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM               | AutologonExe   | X" -RemoveLast -Color ([System.Windows.Media.Brushes]::Red) | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM could not find AutologonExe at $Result" -Color ([System.Windows.Media.Brushes]::Red) | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM Download at - https://learn.microsoft.com/en-us/sysinternals/downloads/autologon" -Color ([System.Windows.Media.Brushes]::Red)   | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 ""                                                                                                                                         | Out-Null
      Window                                                                                                                                                                                  | Out-Null
   }
}
catch {
   RichTextBox $SystemWindowsControlsRichTextBox0 "> SYSTEM               | AutologonExe   | ERROR" -RemoveLast -Color ([System.Windows.Media.Brushes]::Red)                                    | Out-Null
   Window                                                                                                                                                                                     | Out-Null
}
   

RichTextBox $SystemWindowsControlsRichTextBox0 ""                                                                                                                                               | Out-Null
Window                                                                                                                                                                                        | Out-Null
try {
   $Result = Thread {
      param($Function, $Parameter)
      $FunctionBlock = [scriptblock]::Create($Function)
      & $FunctionBlock $Parameter
   } -ThreadPool $ThreadPool -Function ${function:ListWindowsUpdate} -TaskName "preScan"
   if ($Result -eq 0) {
      RichTextBox $SystemWindowsControlsRichTextBox1 "No Windows Updates available" -Clear -Color ([System.Windows.Media.Brushes]::LightGreen)                                                  | Out-Null
      Window                                                                                                                                                                                  | Out-Null
   } elseif ($Result -eq 1) {
      $RebootFlag = $true
      RichTextBox $SystemWindowsControlsRichTextBox1 "No Windows Updates available - Reboot Required" -Clear -Color ([System.Windows.Media.Brushes]::LightGreen)                                | Out-Null
      Window                                                                                                                                                                                  | Out-Null
   } else {
      RichTextBox $SystemWindowsControlsRichTextBox1 $Result -Clear                                                                                                                             | Out-Null
      Window                                                                                                                                                                                  | Out-Null
   }
   RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE WindowsUpdate | preScan        | v/" -RemoveLast -Color ([System.Windows.Media.Brushes]::LightGreen)                                | Out-Null
   Window                                                                                                                                                                                     | Out-Null
}
catch {
   RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE WindowsUpdate | preScan        | ERROR" -RemoveLast -Color ([System.Windows.Media.Brushes]::Red)                                    | Out-Null
   Window                                                                                                                                                                                     | Out-Null
}


RichTextBox $SystemWindowsControlsRichTextBox0 ""                                                                                                                                               | Out-Null
Window                                                                                                                                                                                        | Out-Null
try {
   $Result = Thread {
      param($Function, $Parameter)
      $FunctionBlock = [scriptblock]::Create($Function)
      & $FunctionBlock $Parameter
   } -ThreadPool $ThreadPool -Function ${function:ListWinget} -TaskName "preScan"
   $Result2 = Thread {
      param($Function, $Parameter)
      $FunctionBlock = [scriptblock]::Create($Function)
      & $FunctionBlock $Parameter
   } -ThreadPool $ThreadPool -Function ${function:ListWingetApps} -TaskName "preScan"
   if ($null -eq $Result2 -or $Result2.Count -eq 0) {
      RichTextBox $SystemWindowsControlsRichTextBox2 "No Updates for Apps available" -Clear -Color ([System.Windows.Media.Brushes]::LightGreen)                                                 | Out-Null
      Window                                                                                                                                                                                  | Out-Null
   } else {
      RichTextBox $SystemWindowsControlsRichTextBox2 $Result -Clear                                                                                                                             | Out-Null
      Window                                                                                                                                                                                  | Out-Null
   }
   RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE Winget        | preScan        | v/" -RemoveLast -Color ([System.Windows.Media.Brushes]::LightGreen)                                | Out-Null
   Window                                                                                                                                                                                     | Out-Null
}
catch {
   RichTextBox $SystemWindowsControlsRichTextBox0 "> MODULE Winget        | preScan        | ERROR" -RemoveLast -Color ([System.Windows.Media.Brushes]::Red)                                    | Out-Null
   Window                                                                                                                                                                                     | Out-Null
}
if ($RebootFlag -eq $true) {
   $ResultQuestion = [System.Windows.MessageBox]::Show(
   "It was detected that a Reboot is needed`n`nDo you want to reboot now ?",
   "Reboot ?",
   "YesNo",
   "Question"
   )
   if ($ResultQuestion -eq "Yes") {
      Restart-Computer -Force
      exit
   }
}


$SystemWindowsWindow.Hide()
$SystemWindowsWindow.ShowDialog()
$ThreadPool.Close()
$ThreadPool.Dispose()