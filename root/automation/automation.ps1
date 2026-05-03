function AutomationActivate() {
   try {
      RichTextBox $SystemWindowsControlsRichTextBox0 ""  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "Activate Automation"  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "______________________________________________________________________________"  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 ""  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "!!! IF you move the CoreForge Folder please reactivate Automation !!!"  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 ""  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "          This runs CoreForge at your first Login of the Day         "  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "        Updates will be downloaded and installed automatically       "  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "   You can still launch in non automated Mode through CoreForge.exe  "  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 ""  | Out-Null
      Window  | Out-Null
      $MainScriptPath = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\main.ps1"))
      $TaskName = "CoreForge_Automation";
      $TaskUser = "$env:USERDOMAIN\$env:USERNAME";
      $TaskTrigger = New-ScheduledTaskTrigger -AtLogOn;
      $TaskTrigger.UserId = $TaskUser;
      $TaskTrigger.Delay = "PT0M";
      $MainScriptPath = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\main.ps1"))
      $TaskAction = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument "-ExecutionPolicy Bypass -File `"$MainScriptPath`" -WindowStyle Hidden";
      $TaskPrincipal = New-ScheduledTaskPrincipal -UserId $TaskUser -LogonType Interactive -RunLevel Highest;
      $TaskSettings = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopOnIdleEnd;
      Register-ScheduledTask -TaskName $TaskName -Trigger $TaskTrigger -Action $TaskAction -Principal $TaskPrincipal -Settings $TaskSettings;
      RichTextBox $SystemWindowsControlsRichTextBox0 "Automation Activated" -Color ([System.Windows.Media.Brushes]::LightGreen) | Out-Null
      Window  | Out-Null
      
   } catch {
      <#SOON#>
   }
}
function AutomationDeactivate() {
   try {
      RichTextBox $SystemWindowsControlsRichTextBox0 ""  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "Deactivate Automation"  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 "______________________________________________________________________________"  | Out-Null
      RichTextBox $SystemWindowsControlsRichTextBox0 ""  | Out-Null
      Window  | Out-Null
      Unregister-ScheduledTask -TaskName "CoreForge_Automation" -Confirm:$false
      RichTextBox $SystemWindowsControlsRichTextBox0 "Automation Deactivated" -Color ([System.Windows.Media.Brushes]::LightGreen) | Out-Null
      Window  | Out-Null
   } catch {
      <#SOON#>
   }
}