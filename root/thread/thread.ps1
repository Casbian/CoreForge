function ThreadPool {
    $ThreadCount = [System.Environment]::ProcessorCount
    $ThreadPool  = [runspacefactory]::CreateRunspacePool(1, $ThreadCount)
    $ThreadPool.Open()
    return $ThreadPool
}
function Thread([scriptblock]$Task,[System.Management.Automation.Runspaces.RunspacePool]$ThreadPool,[scriptblock]$Function,[object]$Parameter) {
    $PowershellRunspace = [powershell]::Create()
    $PowershellRunspace.RunspacePool = $ThreadPool
    $PowershellRunspace.AddScript($Task)                        | Out-Null
    $PowershellRunspace.AddParameter('Function',  $Function)    | Out-Null
    $PowershellRunspace.AddParameter('Parameter', $Parameter)   | Out-Null
    return [PSCustomObject]@{
        Instance = $PowershellRunspace
        Handle   = $PowershellRunspace.BeginInvoke()
    }
}