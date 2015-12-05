function Invoke-IPRandomizer {
<#
.DESCRIPTION
Takes in a plaintext list of IPs and lists out a random selection based on how many the user requests.

.PARAMETER HostFile
Plaintext file containing newline character seperated IPs.

.PARAMETER IPCount
Number of IPs that will be randomly grabbed from the provided HostFile.
#>

        #Assigning Args
        [CmdletBinding()]
        Param(
        [Parameter(Mandatory = $true)]
        [string]$HostFile,
		[Parameter(Mandatory = $true)]
        [string]$IPCount
)

#Grab IPs
Get-Content -Path $HostFile | Get-Random -count $IPCount

}
