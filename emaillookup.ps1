$File=$args[0]
If ($null-eq $File) {
    Write-Host "Missing file name."
    Break
}
#$Import = Import-Csv -Path .\Profile.csv
$Import = Import-Csv -Path $File
#$Import.Count
$Count = 0
$Updated = 0
$Skipped = 0

ForEach ($Line in $Import) {

    If ($Line.'Last Login User' -ne "" -and $Line.'Last Login Domain' -ne "" -and $Line.'Last Login Domain' -ne $Line.'PC Name' ){
        try {
            $User = Get-ADUser -Server $Line.'Last Login Domain' -Identity $Line.'Last Login User' -Properties mail
            Add-Member -InputObject $Line -MemberType NoteProperty Email $User.mail
            $Updated++
        } catch {
            $Skipped++
        }
        
    } else { $Skipped++ }

    $Count = $Updated + $Skipped
    $PercentCompleted = [Math]::Round((($Count/$Import.Count)*100),2)
    Export-Csv -InputObject $Line -Append -Force .\updated.csv -NoTypeInformation
    Clear-Host
    Write-Progress -Activity "Search in Progress" -Status "$PercentCompleted% Complete:" -PercentComplete $PercentCompleted
    Write-Host "`n`n`n`n`n`n`n`n"
    Write-Host "Total Objects: " $Import.Count " " $PercentCompleted "% Completed"
    Write-Host "Email address found: " $Updated
    Write-Host "Skipped: " $Skipped
    #If ($Count -eq 5) {break}
    }

Write-Host "`nJob Completed!`n"