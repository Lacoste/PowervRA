﻿function Remove-vRAExternalNetworkProfile {
<#
    .SYNOPSIS
    Remove an external network profile
    
    .DESCRIPTION
    Remove an external network profile
    
    .PARAMETER Id
    The id of the external network profile

    .PARAMETER Name
    The name of the external network profile

    .INPUTS
    System.String

    .EXAMPLE
    Get-vRAExternalNetworkProfile -Name NetworkProfile01 | Remove-vRAExternalNetworkProfile

    .EXAMPLE
    Remove-vRAExternalNetworkProfile -Name NetworkProfile01

    .EXAMPLE
    Remove-vRExternalANetworkProfile -Id 597ff2c1-a35f-4a81-bfd3-ca014

#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="High",DefaultParameterSetName="ById")]

    Param (

        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName, ParameterSetName="ById")]
        [ValidateNotNullOrEmpty()]
        [String[]]$Id,

        [Parameter(Mandatory=$true, ParameterSetName="ByName")]
        [ValidateNotNullOrEmpty()]
        [String[]]$Name   
       
    )
    
    begin {}
    
    process {    

        try {

            switch ($PSCmdlet.ParameterSetName) {

                'ById' {

                    foreach ($NetworkProfileId in $Id) {

                        if ($PSCmdlet.ShouldProcess($NetworkProfileId)){

                            $URI = "/iaas-proxy-provider/api/network/profiles/$($NetworkProfileId)"
            
                            Write-Verbose -Message "Preparing DELETE to $($URI)"

                            $Response = Invoke-vRARestMethod -Method DELETE -URI "$($URI)"

                            Write-Verbose -Message "SUCCESS"

                        }

                    }

                    break

                }

                'ByName' {

                    foreach ($NetworkProfileName in $Name) {

                        if ($PSCmdlet.ShouldProcess($NetworkProfileName)){

                            $Id = (Get-vRANetworkProfile -Name $NetworkProfileName).id

                            $URI = "/iaas-proxy-provider/api/network/profiles/$($Id)"
            
                            Write-Verbose -Message "Preparing DELETE to $($URI)"

                            $Response = Invoke-vRARestMethod -Method DELETE -URI "$($URI)"

                            Write-Verbose -Message "SUCCESS"

                        }

                    }

                    break

                }
  
            }
    
        }
        catch [Exception]{
        
            throw

        }
        
    }   
     
}