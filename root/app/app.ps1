function AppGetStatus() {
   try {
      winget source add --name "winget" --arg "https://cdn.winget.microsoft.com/cache" --type "Microsoft.PreIndexed.Package" | Out-Null
      winget source add --name "msstore" --arg "https://storeedgefd.dsx.mp.microsoft.com/v9.0" --type "Microsoft.Rest" | Out-Null
      winget source update | Out-Null
      $MaxChars = 80
      $Output = winget list --upgrade-available --include-unknown --accept-source-agreements 4>&1
      $Output = $Output -replace 'Verf├╝gbar','verfügbar' -replace 'ÔÇ…','…' -replace '├ñ','ä' -replace '├Ñ','Ä' -replace '├╝','ü' -replace '├┐','Ö' -replace '├╢','ß' -replace 'ÔÇª','…' -replace '├ü','ü' -replace '├Ä','ä' -replace '├Ö','ö' -replace '├Ü','Ü'
      $StringBuilder = New-Object System.Text.StringBuilder
      $OutputStart = $false
      foreach ($Line in $Output) {
         if (-not $OutputStart -and $Line -like 'Name*') { $OutputStart = $true }
         if ($OutputStart) {
            $TrimmedLine = if ($Line.Length -gt $MaxChars) { $Line.Substring(0, $MaxChars) } else { $Line }
            $StringBuilder.AppendLine($TrimmedLine) | Out-Null
         }
      }
      return $StringBuilder.ToString().Trim()
   } catch {
      <#SOON#>
   }
}
function AppGetApplist() {
   try {
      winget source add --name "winget" --arg "https://cdn.winget.microsoft.com/cache" --type "Microsoft.PreIndexed.Package" | Out-Null
      winget source add --name "msstore" --arg "https://storeedgefd.dsx.mp.microsoft.com/v9.0" --type "Microsoft.Rest" | Out-Null
      winget source update | Out-Null
      $Output = winget list --upgrade-available --include-unknown --accept-source-agreements
      $Output = $Output -replace 'Verf├╝gbar','verfügbar' -replace 'ÔÇ…','…' -replace '├ñ','ä' -replace '├Ñ','Ä' -replace '├╝','ü' -replace '├┐','Ö' -replace '├╢','ß' -replace 'ÔÇª','…' -replace '├ü','ü' -replace '├Ä','ä' -replace '├Ö','ö' -replace '├Ü','Ü'
      $AppList = @()
      foreach ($Line in $Output) {
         if ($Line -match '^(.+?)\s+([A-Za-z0-9][\w.-]+\.[A-Za-z0-9][\w.-]+)\s+[\d]') {
            $AppList += @{
            name = $matches[1].Trim()
            id   = $matches[2].Trim()
            }
         }
      }
      return $AppList
   } catch {
      <#Do this if a terminating exception happens#>
   }
}
function AppUpdateRun($AppList) {
    try {
        winget source add --name "winget" --arg "https://cdn.winget.microsoft.com/cache" --type "Microsoft.PreIndexed.Package" | Out-Null
        winget source add --name "msstore" --arg "https://storeedgefd.dsx.mp.microsoft.com/v9.0" --type "Microsoft.Rest" | Out-Null
        winget source update | Out-Null
        $StringBuilder = New-Object System.Text.StringBuilder
        if ($AppList.Count -eq 0) {
            $StringBuilder.AppendLine("No Updates for Apps available") | Out-Null
        }
        foreach ($App in $AppList) {
            $AppID = $App.id
            $AppName = $App.name
            $Output = winget upgrade --id $AppID --silent --accept-package-agreements --accept-source-agreements 4>&1
            if ($LASTEXITCODE -ne 0) {
                $Output = winget install --id $AppID --silent --uninstall-previous --accept-package-agreements --accept-source-agreements 4>&1
            }
            if ($LASTEXITCODE -eq 0) {
                foreach ($Line in $Output) {
                    $LineString = $Line.ToString().Trim()
                    if ($LineString -match '^[-\\|/]$') { continue }
                    if ($LineString -match 'ÔûÆ|Ôûê|Ôûæ|^\s*[\d.]+ [KMGT]?B') { continue }
                    $LineString = $LineString -replace 'Verf├╝gbar','verfügbar' -replace 'ÔÇ…','…' -replace '├ñ','ä' -replace '├Ñ','Ä' -replace '├╝','ü' -replace '├┐','Ö' -replace '├╢','ß' -replace 'ÔÇª','…' -replace '├ü','ü' -replace '├Ä','ä' -replace '├Ö','ö' -replace '├Ü','Ü'
                    if ($LineString -ne '') {
                        $StringBuilder.AppendLine($LineString) | Out-Null
                    }
                }
            } else {
                $StringBuilder.AppendLine("No Source for $AppName found. Unable to update.") | Out-Null
            }    
        }
        return $StringBuilder.ToString().Trim()
    } catch {
        <#SOON#>
    }
}