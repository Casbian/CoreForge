function ListWindowsUpdate() {
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
      
      $Updates = Get-WindowsUpdate -IgnoreReboot
      if ($Updates | Where-Object { $_.RebootRequired -eq $true }) {
         return 1
      }
      if ($Updates.Count -eq 0) {
         return 0
      } else {
         $StringBuilder = New-Object System.Text.StringBuilder
         while ($true) {
            $verbose = Get-WindowsUpdate -Verbose -IgnoreReboot 4>&1
            foreach ($line in $verbose) {
               $trimmedLine = $line.Message -replace 'Please wait\.\.\.', ''
               $StringBuilder.AppendLine($trimmedLine) | Out-Null
            }
            break
         }
      }
         return $StringBuilder.ToString()
   } catch {
      <#Do this if a terminating exception happens#>
   }
}
