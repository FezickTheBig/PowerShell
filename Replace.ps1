$count = 0
$InputFiles = Get-Item "*.ini"
$OldString  = 'Service=wdm disable=yes'
$NewString  = ''
$InputFiles | ForEach-Object {

    if ((Get-Content -Path $_.FullName).Contains($OldString)) {
        (Get-Content -Path $_.FullName).Replace($OldString,$NewString) | Set-Content -Path $_.FullName
        $count++
    }

}

Write-Host "Replace: $count"