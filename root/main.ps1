param(
   [switch]$EXELaunch
)

Import-Module "$PSScriptRoot\app\app.psm1"

Import-Module "$PSScriptRoot\update\update.psm1"
$CurrentVersion = Update $MyInvocation

Import-Module "$PSScriptRoot\flag\flag.psm1"
if ($EXELaunch -eq $false) {
   $FlagValue = ChecklastautomatedrunFlag $PSScriptRoot
   if ($FlagValue -eq 1) {
      exit
   }
}

Import-Module "$PSScriptRoot\automation\automation.psm1"
Import-Module "$PSScriptRoot\gpu\gpu.psm1"
Import-Module "$PSScriptRoot\network\network.psm1"
Import-Module "$PSScriptRoot\richtextbox\richtextbox.psm1"
Import-Module "$PSScriptRoot\system\system.psm1"
Import-Module "$PSScriptRoot\thread\thread.psm1" 
Import-Module "$PSScriptRoot\window\window.psm1"
Import-Module "$PSScriptRoot\windowsupdate\windowsupdate.psm1"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore


$SystemWindowsWindow, $LoadingBar, $LoadingBarFrames = SystemLogo
SystemLogoContinueOneFrame $SystemWindowsWindow $LoadingBar $LoadingBarFrames 0

$ThreadPool = ThreadPool
SystemLogoContinueOneFrame $SystemWindowsWindow $LoadingBar $LoadingBarFrames 1

$UserName = [System.Environment]::GetEnvironmentVariable("USERNAME")
SystemLogoContinueOneFrame $SystemWindowsWindow $LoadingBar $LoadingBarFrames 2

$ThreadList = New-Object System.Collections.Generic.List[object]
SystemLogoContinueOneFrame $SystemWindowsWindow $LoadingBar $LoadingBarFrames 3

$ThreadWrapper = { param($Function, $Parameter); $FunctionBlock = [scriptblock]::Create($Function); & $FunctionBlock $Parameter }
SystemLogoContinueOneFrame $SystemWindowsWindow $LoadingBar $LoadingBarFrames 4

$ThreadList.Add((Thread $ThreadWrapper -ThreadPool $ThreadPool -Function ${Function:Network}))
$ThreadList.Add((Thread $ThreadWrapper -ThreadPool $ThreadPool -Function ${Function:WindowsUpdateGetStatus}))
$ThreadList.Add((Thread $ThreadWrapper -ThreadPool $ThreadPool -Function ${Function:AppGetStatus}))
$ThreadList.Add((Thread $ThreadWrapper -ThreadPool $ThreadPool -Function ${Function:AppGetApplist}))
$ThreadList.Add((Thread $ThreadWrapper -ThreadPool $ThreadPool -Function ${Function:GPUInstalledVersion}))
$ThreadList.Add((Thread $ThreadWrapper -ThreadPool $ThreadPool -Function ${Function:GPULatestVersion}))
SystemLogoContinueOneFrame $SystemWindowsWindow $LoadingBar $LoadingBarFrames 5

SystemLogoContinueOneFrame $SystemWindowsWindow $LoadingBar $LoadingBarFrames 6
SystemLogoContinueOneFrame $SystemWindowsWindow $LoadingBar $LoadingBarFrames 7

$SystemWindowsWindow, $SystemWindowsControlsCanvas, $AutomationButton, $UpdateNowButton, $InfoButton, $SystemWindowsControlsRichTextBox0, $SystemWindowsControlsRichTextBox1, $SystemWindowsControlsRichTextBox2, $SystemWindowsControlsRichTextBox3, $AutomationCheck = System $MyInvocation

if (-not $AutomationCheck -and $EXELaunch -ne $true) {
   $SystemWindowsWindow.Close()
   $ThreadPool.Close()
   $ThreadPool.Dispose()
   exit
}

$AutomationButton.Active = $true
$UpdateNowButton.Active = $true

RichTextBoxClear $SystemWindowsControlsRichTextBox0
RichTextBox $SystemWindowsControlsRichTextBox0 "SYSTEM v$CurrentVersion" | Out-Null
RichTextBox $SystemWindowsControlsRichTextBox0 "" | Out-Null
RichTextBox $SystemWindowsControlsRichTextBox0 "Welcome $UserName" | Out-Null
RichTextBox $SystemWindowsControlsRichTextBox0 "____________________________________________________________________________________________________________________________________________________________" | Out-Null
RichTextBox $SystemWindowsControlsRichTextBox0 "" | Out-Null
RichTextBox $SystemWindowsControlsRichTextBox0 "" | Out-Null
Window  | Out-Null

$Frames = @("⣷","⣯","⣟","⡿","⢿","⣻","⣽","⣾")
$FrameIndex = 0
$LinestoDelete = 0
while ($ThreadList | Where-Object { -not $_.Handle.IsCompleted }) {
   $Frame = $Frames[$FrameIndex % $Frames.Count]
   if ($FrameIndex -gt 0 -and $LinestoDelete -gt 0) {
      for ($d = 0; $d -lt $LinestoDelete; $d++) {
         RichTextBoxDeleteLine $SystemWindowsControlsRichTextBox0 | Out-Null
      }
   }
   $LinestoDelete = 0
   $TaskName = @("Network", "Windows Update Status", "Application Update Status", "Application Update List", "GPU Latest Version Scan", "GPU Latest Version Scan")
   for ($i = 0; $i -lt $ThreadList.Count; $i++) {
      if (-not $ThreadList[$i].Handle.IsCompleted) {
         RichTextBox $SystemWindowsControlsRichTextBox0 "$Frame SYSTEM START | $($TaskName[$i])" | Out-Null
         $LinestoDelete++
      }
   }
   Window | Out-Null
   $FrameIndex++
   Start-Sleep -Seconds 0.04
}

$Results = [System.Collections.Generic.List[object]]::new()
foreach ($Thread in $ThreadList) {
   $Result = $Thread.Instance.EndInvoke($Thread.Handle)
   if ($Thread.Instance.HadErrors) {
      $Thread.Instance.Streams.Error | ForEach-Object { Write-Warning "Thread error: $_" }
   }
   $Thread.Instance.Dispose()
   $Results.Add($Result)
}
$ThreadList.Clear()

$Network = $Results[0]
$WindowsUpdateStatus = $Results[1]
$WingetStatus = $Results[2]
$WingetAppList = $Results[3]
$GPUInsalledVersion = $Results[4]
$GPULatestVersion = $Results[5]
$WindowsUpdateNeeded = $false
$AppUpdateNeeded = $false
$GPUUpdateNeeded = $false

if (-not $Network) {
   $NetworkCancel = [System.Windows.MessageBox]::Show(
   "No Network could be found",
   "No Network",
   "OK",
   "Error"
   )
   if ($NetworkCancel -eq "OK") {
      $SystemWindowsWindow.Close()
      exit
   }
}

if ($WindowsUpdateStatus[0] -eq 0) {
   RichTextBoxClear $SystemWindowsControlsRichTextBox1
   RichTextBox $SystemWindowsControlsRichTextBox1 "No Windows Updates available" -Color ([System.Windows.Media.Brushes]::LightGreen) | Out-Null
   Window | Out-Null
} elseif ($WindowsUpdateStatus[0] -eq 1) {
   $RebootFlag = $true
   RichTextBoxClear $SystemWindowsControlsRichTextBox1
   RichTextBox $SystemWindowsControlsRichTextBox1 "No Windows Updates available - Reboot Required" -Color ([System.Windows.Media.Brushes]::LightGreen) | Out-Null
   Window | Out-Null
} else {
   $WindowsUpdateNeeded = $true
   RichTextBoxClear $SystemWindowsControlsRichTextBox1
   RichTextBox $SystemWindowsControlsRichTextBox1 $WindowsUpdateStatus | Out-Null
   Window | Out-Null
}

if ($null -eq $WingetAppList -or $WingetAppList.Count -eq 0) {
   RichTextBoxClear $SystemWindowsControlsRichTextBox2
   RichTextBox $SystemWindowsControlsRichTextBox2 "No Updates for Apps available" -Color ([System.Windows.Media.Brushes]::LightGreen) | Out-Null
   Window | Out-Null
} else {
   $AppUpdateNeeded = $true
   RichTextBoxClear $SystemWindowsControlsRichTextBox2
   RichTextBox $SystemWindowsControlsRichTextBox2 $WingetStatus | Out-Null
   Window | Out-Null
}

if (-not $GPULatestVersion -eq 0) {
   if ($GPUInsalledVersion -eq $GPULatestVersion) {
      RichTextBoxClear $SystemWindowsControlsRichTextBox3
      RichTextBox $SystemWindowsControlsRichTextBox3 "No Updates for GPU available" -Color ([System.Windows.Media.Brushes]::LightGreen) | Out-Null
      Window | Out-Null
   } else {
      $GPUUpdateNeeded = $true
      RichTextBoxClear $SystemWindowsControlsRichTextBox3
      RichTextBox $SystemWindowsControlsRichTextBox3 "Update to v$GPULatestVersion available" | Out-Null
      Window | Out-Null
   }
} else {
   RichTextBoxClear $SystemWindowsControlsRichTextBox3
   RichTextBox $SystemWindowsControlsRichTextBox3 "No Database Match for GPU" -Color ([System.Windows.Media.Brushes]::Yellow) | Out-Null
   Window | Out-Null
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

if ($EXELaunch -eq $true) {
   RichTextBoxClear $SystemWindowsControlsRichTextBox0
   RichTextBox $SystemWindowsControlsRichTextBox0 "SYSTEM v$CurrentVersion" | Out-Null
   RichTextBox $SystemWindowsControlsRichTextBox0 "" | Out-Null
   RichTextBox $SystemWindowsControlsRichTextBox0 "Welcome $UserName" | Out-Null
   RichTextBox $SystemWindowsControlsRichTextBox0 "____________________________________________________________________________________________________________________________________________________________" | Out-Null
   Window | Out-Null
   $UpdateNowButton.Active = $false
   $AutomationButton.Active = $false
   $SystemWindowsWindow.Hide()
   $SystemWindowsWindow.ShowDialog()
   $ThreadPool.Close()
   $ThreadPool.Dispose()
   exit
}

if ($AutomationCheck) {
   RichTextBoxClear $SystemWindowsControlsRichTextBox0
   RichTextBox $SystemWindowsControlsRichTextBox0 "SYSTEM v$CurrentVersion" | Out-Null
   RichTextBox $SystemWindowsControlsRichTextBox0 "" | Out-Null
   RichTextBox $SystemWindowsControlsRichTextBox0 "Welcome $UserName" | Out-Null
   RichTextBox $SystemWindowsControlsRichTextBox0 "____________________________________________________________________________________________________________________________________________________________" | Out-Null
   Window | Out-Null
   SystemStartUpdateRun $WingetAppList $MyInvocation $WindowsUpdateNeeded $AppUpdateNeeded $GPUUpdateNeeded
   $SystemWindowsWindow.Hide()
   $SystemWindowsWindow.Show()
   $ThreadPool.Close()
   $ThreadPool.Dispose()
   exit
}