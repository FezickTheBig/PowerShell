<#
.Synopsis
   Verify a data set against the Havel-Hakimi Algorithm
.DESCRIPTION
   Challenge laid out here:
   https://www.reddit.com/r/dailyprogrammer/comments/bqy1cf/20190520_challenge_378_easy_the_havelhakimi/
.EXAMPLE
   VerifyHavelHakimi 2,1,1,0
#>
function VerifyHavelHakimi
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Data set
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [Array]
        $DataSet
                
    )

    Begin
    {
        $Complete = $null
    }
    Process
    {
        while ($null -eq $Complete) {    
            $Step1 = @()
            $Step2 = @()
            $Step3 = @()

            #Drop the zeros
            $Step1 = $DataSet | Where-Object {$_ -ne 0}
    
            #Check to see if no values left: True condition
            if ($Step1.Length -eq 0) { $Complete = "True"; BREAK;}

            #Sort the list
            $Step1 = $Step1 | Sort-Object -Descending

            #Pop off N
            $N = $Step1[0]
            $Step2 = $Step1[1..($Step1.Length)]

            #Check to see if N is larger the the current number of values left: False condition
            if ($N -gt $Step2.Length) {
                $Complete = "False"
                BREAK; }
            else {
                #Front Elimination
                for ( $i = 0; $i -le $Step2.Length; $i++) {
                    if ($i -lt $N) {
                        $Step3 += $Step2[$i] - 1}
                    else {
                        $Step3 += $Step2[$i]}
                }
            }

            If ($Complete -ne "False" -and $null -ne $Complete ) { $Complete = "True" }
            $DataSet = $Step3

        }

            }
    End
    {        
return $Complete
    }
}