function New-vRAExternalNetworkProfile {
<#
    .SYNOPSIS
    Create a vRA external network profile
    
    .DESCRIPTION
    Create a vRA external network profiles
    
    .PARAMETER Name
    The network profile Name
    
    .PARAMETER Description
    The network profile Description

    .PARAMETER SubnetMask
    The subnet mask of the network profile

    .PARAMETER GatewayAddress
    The gateway address of the network profile

    .PARAMETER PrimaryDNSAddress
    The address of the primary DNS server

    .PARAMETER SecondaryDNSAddress
    The address of the secondary DNS server

    .PARAMETER DNSSuffix
    The DNS suffix

    .PARAMETER DNSSearchSuffix
    The DNS search suffix

    .PARAMETER IPRanges
    An array of ip address ranges

    .PARAMETER PrimaryWinsAddress
    The address of the primary wins server

    .PARAMETER SecondaryWinsAddress
    The address of the secondary wins server

    .INPUTS
    System.String
    PSCustomObject

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    $DefinedRange1 = New-vRANetworkProfileIPRange -Name "External-Range-01" -Description "Example 1" -StatIPv4Address "10.60.1.2" -EndIPv4Address "10.60.1.5"
    $DefinedRange2 = New-vRANetworkProfileIPRange -Name "External-Range-02" -Description "Example 2" -StatIPv4Address "10.60.1.10" -EndIPv4Address "10.60.1.20"

    New-vRAExternalNetworkProfile -Name Network-External -Description "External" -SubnetMask "255.255.255.0" -GatewayAddress "10.60.1.1" -PrimaryDNSAddress "10.60.1.100" -SecondaryDNSAddress "10.60.1.101" -DNSSuffix "corp.local" -DNSSearchSuffix "corp.local" -IPRanges $DefinedRange1,$DefinedRange2

#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="Low")][OutputType('System.Management.Automation.PSObject')]

    Param (

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,
    
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$Description, 

        [Parameter(Mandatory=$true)]
        [ValidateScript({$_ -match [IPAddress]$_ })]  
        [String]$SubnetMask,

        [Parameter(Mandatory=$false)]
        [ValidateScript({$_ -match [IPAddress]$_ })]  
        [String]$GatewayAddress,

        [Parameter(Mandatory=$false)]
        [ValidateScript({$_ -match [IPAddress]$_ })]  
        [String]$PrimaryDNSAddress,

        [Parameter(Mandatory=$false)]
        [ValidateScript({$_ -match [IPAddress]$_ })]  
        [String]$SecondaryDNSAddress,

        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$DNSSuffix,

        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$DNSSearchSuffix,

        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject[]]$IPRanges,

        [Parameter(Mandatory=$false)]
        [ValidateScript({$_ -match [IPAddress]$_ })] 
        [String]$PrimaryWinsAddress,

        [Parameter(Mandatory=$false)]
        [ValidateScript({$_ -match [IPAddress]$_ })]  
        [String]$SecondaryWinsAddress

    )    

    begin {
    
    }
    
    process {     
           
        try {

            # --- Define the network profile template
            $Template = @"

                {
                    "@type": "ExternalNetworkProfile",
                    "name": "$($Name)",
                    "description": "$($Description)",
                    "createdDate": null,
                    "lastModifiedDate": null,
                    "isHidden": false,
                    "definedRanges": [],
                    "profileType": "EXTERNAL",
                    "subnetMask": "$($SubnetMask)",
                    "gatewayAddress": "$($GatewayAddress)",
                    "primaryDnsAddress": "$($PrimaryDNSAddress)",
                    "secondaryDnsAddress": "$($SecondaryDNSAddress)",
                    "dnsSuffix": "$($DNSSuffix)",
                    "dnsSearchSuffix": "$($DNSSearchSuffix)",
                    "primaryWinsAddress": "$($PrimaryWinsAddress)",
                    "secondaryWinsAddress": "$($SecondaryWinsAddress)"
                }

"@

            if ($PSBoundParameters.ContainsKey("IPRanges")) {

                $Object = $Template | ConvertFrom-Json

                foreach ($IPRange in $IPRanges) {

                    $Object.definedRanges += $IPRange

                }

                $Template = $Object | ConvertTo-Json

            }

            Write-Verbose -Message $Template

            if ($PSCmdlet.ShouldProcess($Name)){

                $URI = "/iaas-proxy-provider/api/network/profiles"
                  
                # --- Run vRA REST Request
                $Response = Invoke-vRARestMethod -Method POST -URI $URI -Body $Template -Verbose:$VerbosePreference

                # --- Output the Successful Result
                Get-vRAExternalNetworkProfile -Name $Name

            }

        }
        catch [Exception]{

            throw
        }

    }
    end {
        
    }

}