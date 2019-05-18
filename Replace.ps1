$count = 0
$InputFiles = Get-Item "*.ini"
$OldString  = 'Service=wdm disable=yes'
$NewString  = ' '
$InputFiles | ForEach {
#    (Get-Content -Path $_.FullName).Replace($OldString,$NewString) | Set-Content -Path $_.FullName
    if ((Get-Content -Path $_.FullName).Contains($OldString)) {
#        Write-Host "Found IT!"
#        $_
#        $_.Replace($OldString,$NewString)
#        Set-Content -Path $_.FullName
        (Get-Content -Path $_.FullName).Replace($OldString,$NewString) | Set-Content -Path $_.FullName
        $count++
    }

<#
  if ((Get-Content -Path $_.FullName).Contains($OldString)) {
    $_.Replace($OldString,$NewString)
    $count++
  }
#>

}

Write-Host "Replace: $count"