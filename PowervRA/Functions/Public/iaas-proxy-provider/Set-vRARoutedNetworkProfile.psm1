function Set-vRAExternalNetworkProfile {
<#
    .SYNOPSIS
    Set a vRA network profile
    
    .DESCRIPTION
    Set a vRA network profiles
    
    .PARAMTER Id
    The network profile id
    
    .PARAMETER Name
    The network profile name
    
    .PARAMETER Description
    The network profile description

    .PARAMETER Hidden
    Creates a hidden network profile

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

    .PARAMETER NatType
    The nat type. This can be One-to-One or One-to-Many

    .PARAMETER ExternalNetworkProfile
    The external network profile that will be linked to that Routed or NAT network profile

    .PARAMETER DHCPEnabled
    Enable DHCP for a NAT network profile. Nat type must be One-to-Many

    .PARAMETER DHCPStartAddress
    The start address of the dhcp range

    .PARAMETER DHCPEndAddress
    The end address of the dhcp range

    .PARAMETER RangeSubnetMask
    The subnet mask for the routed range

    .PARAMETER BaseIPAddress
    The base ip address for the routed range

    .INPUTS
    System.String.
    System.Int.
    System.Switch

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-vRANetworkProfile -Name "Network-External" | Set-vRANetworkProfile -Name "Network-External-Updated" -Description "Updated Description" -SubnetMask "255.255.0.0" -GatewayAddress "10.70.2.1" -PrimaryDNSAddress "10.70.1.100" -SecondaryDNSAddress "10.70.1.101" -DNSSuffix "corp1.local" -DNSSearchSuffix "corp1.local" -DHCPStartAddress "10.70.1.21" -DHCPEndAddress "10.70.1.31"

    .EXAMPLE
    $DefinedRange1 = New-vRANetworkProfileIPRange -Name "NAT-Range-01" -Description "Disable DHCP Test" -StatIPv4Address "10.70.2.2" -EndIPv4Address "10.70.2.20"
    $DefinedRange2 = New-vRANetworkProfileIPRange -Name "NAT-Range-02" -Description "Disable DHCP Test" -StatIPv4Address "10.70.2.21" -EndIPv4Address "10.70.2.30"

    Get-vRANetworkProfile -Name "Network-NAT" | Set-vRANetworkProfile -DHCPEnabled:$false -IPRanges $DefinedRange1,$DefinedRange1

#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")][OutputType('System.Management.Automation.PSObject')]

    Param (

        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName)]
        [String]$Id,

        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,
    
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$Description,

        [Parameter(Mandatory=$false)]
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
        [String]$SecondaryWinsAddress,

        [Parameter(Mandatory=$false)]
        [Parameter(Mandatory=$false, ParameterSetName="ExternalNetworkProfile")]
        [ValidateNotNullOrEmpty()]
        [String]$ExternalNetworkProfile,

        [parameter(Mandatory=$false, ParameterSetName="ExternalNetworkProfile")]
        [ValidateNotNullOrEmpty()]
        [Switch]$UseExternalNetworkProfileSettings

    )    

    begin {
    
    }
    
    process {     
           
        try {

            # --- Get the network profile     
            $URI = "/iaas-proxy-provider/api/network/profiles/$($Id)"

            $NetworkProfile = Invoke-vRARestMethod -Method GET -URI $URI

            if ($NetworkProfile.profileType -ne "ROUTED") {

                throw "Network Profile $($NetworkProfile.id) is not of type ROUTED"

            }

            # --- Set Properties
            if ($PSBoundParameters.ContainsKey("Name")) {

                Write-Verbose -Message "Updating Name: $($NetworkProfile.name) >> $($Name)"

                $NetworkProfile.name = $Name

            }

            if ($PSBoundParameters.ContainsKey("Description")) {

                Write-Verbose -Message "Updating Description: $($NetworkProfile.description) >> $($Description)"

                $NetworkProfile.description = $Description

            }

            if ($PSBoundParameters.ContainsKey("PrimaryDNSAddress")) {

                Write-Verbose -Message "Updating Primary DNS Address: $($NetworkProfile.primaryDNSAddress) >> $($PrimaryDNSAddress)"

                $NetworkProfile.primaryDNSAddress = $PrimaryDNSAddress

            }

            if ($PSBoundParameters.ContainsKey("SecondaryDNSAddress")) {

                Write-Verbose -Message "Updating Secondary DNS Address: $($NetworkProfile.secondaryDNSAddress) >> $($SecondaryDNSAddress)"

                $NetworkProfile.secondaryDNSAddress = $SecondaryDNSAddress

            }

            if ($PSBoundParameters.ContainsKey("DNSSuffix")) {

                Write-Verbose -Message "Updating DNS Suffix: $($NetworkProfile.dnsSuffix) >> $($DNSSuffix)"

                $NetworkProfile.dnsSuffix = $DNSSuffix

            }

            if ($PSBoundParameters.ContainsKey("DNSSearchSuffix")) {

                Write-Verbose -Message "Updating DNS Search Address: $($NetworkProfile.dnsSearchSuffix) >> $($DNSSearchSuffix)"

                $NetworkProfile.dnsSearchSuffix = $DNSSearchSuffix

            }

            if ($PSBoundParameters.ContainsKey("PrimaryWinsAddress")) {

                Write-Verbose -Message "Updating Primary WINS Address: $($NetworkProfile.primaryWinsAddress) >> $($PrimaryWinsAddress)"

                $NetworkProfile.primaryWinsAddress = $PrimaryWinsAddress

            }

            if ($PSBoundParameters.ContainsKey("SecondaryWinsAddress")) {

                Write-Verbose -Message "Updating Secondary WINS Address: $($NetworkProfile.secondaryWinsAddress) >> $($SecondaryWinsAddress)"

                $NetworkProfile.secondaryWinsAddress = $SecondaryWinsAddress

            }

            if ($PSBoundParameters.ContainsKey("GatewayAddress")) {

                Write-Verbose -Message "Updating Gateway Address: $($NetworkProfile.gatewayAddress) >> $GatewayAddress"

                $NetworkProfile.gatewayAddress = $GatewayAddress

            }

            if ($PSBoundParameters.ContainsKey("IPRanges")) {

                foreach ($IPRange in $IPRanges) {

                    Write-Verbose -Message "Adding IP Address Range $($IPRange.name) To Network Profile $($NetworkProfile.Name)"

                    $NetworkProfile.definedRanges += $IPRange

                }

            }

            $NetworkProfileTemplate = $NetworkProfile | ConvertTo-Json -Depth 100

            if ($PSCmdlet.ShouldProcess($Id)){

                $URI = "/iaas-proxy-provider/api/network/profiles/$($Id)"
                  
                # --- Run vRA REST Request
                $Response = Invoke-vRARestMethod -Method PUT -URI $URI -Body $NetworkProfileTemplate -Verbose:$VerbosePreference

                # --- Output the Successful Result
                Get-vRAExternalNetworkProfile -Id $Id

            }

        }
        catch [Exception]{

            throw

        }

    }
    
    end {
        
    }

}