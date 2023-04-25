function Get-Confirm {
    $caption = "Please Confirm To Delete Directory $folderFullName"
    $message = "Are you Sure You Want To Proceed? $folderFullName"
    [int]$defaultChoice = 0
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Delete the directory"
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Do not delete the directory"
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

    return $host.ui.PromptForChoice($caption, $message, $options, $defaultChoice)
}


do {
    $dir = Read-Host "Enter directory to delete from"
    if (-not (Test-Path $dir -PathType Container)) {
        Write-Host -ForegroundColor Red "[!] '$dir' is not a valid directory path. Please try again."
    }
} while (-not (Test-Path $dir -PathType Container))

$nodeModulesFolders = Get-ChildItem -Path "${dir}" -Filter node_modules -Recurse -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    if ($_.FullName -notmatch "\\node_modules\\") {
        $_
    }
}
$totalMB = 0
if ($nodeModulesFolders) {
    foreach ($nodeModulesFolder in $nodeModulesFolders) {
        $folderFullName = $nodeModulesFolder.FullName
        $choice = Get-Confirm
        
        if ( $choice -ne 1 ) {
            $folderSize = Get-ChildItem -Path $nodeModulesFolder.FullName -Recurse | Measure-Object -Property Length -Sum
            $folderSizeMB = [Math]::Round($folderSize.Sum / 1MB)
            $totalMB += $folderSizeMB
            Remove-Item -Path $folderFullName -Recurse -Force
        }

    }

    if ($totalMB -eq 0) {
        Write-Host -ForegroundColor Yellow "[?] You didn't delete any node_modules :("
    } else {
        Write-Host -ForegroundColor DarkGreen "[v] Successfully deleted ${totalMB}MB of node_modules!"
    }

} else {
    Write-Host -ForegroundColor Yellow "[!] Can't find any node_modules inside the directory you provided"
}
