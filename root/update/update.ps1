function Update($MyInvocation) {
   $CurrentVersion = "1.0.0"
   $InstallDir = Split-Path -Parent $MyInvocation.MyCommand.Path
   $ScriptPath = $MyInvocation.MyCommand.Path
   Write-Host "Checking for updates..." -ForegroundColor Cyan
   try {
      $Release = Invoke-RestMethod "https://api.github.com/repos/Casbian/CoreForge/releases/latest"
      $LatestVersion = $Release.tag_name.TrimStart("v")
      if ([version]$LatestVersion -gt [version]$CurrentVersion) {
         Write-Host "Update available: $LatestVersion (current: $CurrentVersion)" -ForegroundColor Yellow
         $ZipUrl = $Release.zipball_url
            if ($ZipUrl) {
               $TempZip = "$env:TEMP\CoreForge_update.zip"
               $TempExtract = "$env:TEMP\CoreForge_update"
               Write-Host "Downloading update..." -ForegroundColor Cyan
               Invoke-WebRequest -Uri $ZipUrl -OutFile $TempZip
               Write-Host "Extracting..." -ForegroundColor Cyan
               if (Test-Path $TempExtract) {
                  Remove-Item $TempExtract -Recurse -Force
               }
               Expand-Archive -Path $TempZip -DestinationPath $TempExtract
               Write-Host "Applying update..." -ForegroundColor Green
               $UpdateScript = @"
`$ScriptPath = $ScriptPath
Get-ChildItem -Path "$InstallDir" -Recurse | Remove-Item -Recurse -Force
`$Source = Get-ChildItem "$TempExtract" | Where-Object { `$_.PSIsContainer } | Select-Object -First 1
if (`$Source) {
    Copy-Item "`$(`$Source.FullName)\*" "$InstallDir" -Recurse -Force
} else {
    Copy-Item "$TempExtract\*" "$InstallDir" -Recurse -Force
}
Remove-Item "$TempZip" -Force -ErrorAction SilentlyContinue
Remove-Item "$TempExtract" -Recurse -Force -ErrorAction SilentlyContinue
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`""
"@
               $UpdateScriptPath = "$env:TEMP\CoreForge_apply_update.ps1"
               $UpdateScript | Out-File -FilePath $UpdateScriptPath -Encoding utf8BOM
               Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$UpdateScriptPath`"" 
               exit
            } else {
               Write-Warning "No .zip asset found in latest release."
               return $CurrentVersion
            }
         } else {
            Write-Host "CoreForge is up to date ($CurrentVersion)" -ForegroundColor Green
            return $CurrentVersion
         }
   } catch {
      Write-Warning "Update check failed: $_"
      return $CurrentVersion
   }
}
