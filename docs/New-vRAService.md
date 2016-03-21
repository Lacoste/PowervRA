# New-vRAService

## SYNOPSIS
    
Create a vRA Service for the current tenant

## SYNTAX


## DESCRIPTION

Create a vRA Service for the current tenant

Currently unsupported interactive actions:

* HoursStartTime
* HoursEndTime
* ChangeWindowDayOfWeek
* ChangeWindowStartTime
* ChangeWindowEndTime

## PARAMETERS


### Name

The name of the service

* Required: true
* Position: named
* Default value: 
* Accept pipeline input: false

### Description

A description of the service

* Required: false
* Position: named
* Default value: 
* Accept pipeline input: false

### Owner

The owner of the service

* Required: false
* Position: named
* Default value: 
* Accept pipeline input: false

### SupportTeam

The support team of the service

* Required: false
* Position: named
* Default value: 
* Accept pipeline input: false

### JSON

A json string of type service (catalog-service/api/docs/el_ns0_service.html)

* Required: true
* Position: named
* Default value: 
* Accept pipeline input: true (ByValue)

### WhatIf


* Required: false
* Position: named
* Default value: 
* Accept pipeline input: false

### Confirm


* Required: false
* Position: named
* Default value: 
* Accept pipeline input: false

## INPUTS

System.String

## OUTPUTS

System.Management.Automation.PSObject

## EXAMPLES
```
-------------------------- EXAMPLE 1 --------------------------

C:\PS>New-vRAService -Name "New Service"







-------------------------- EXAMPLE 2 --------------------------

C:\PS>New-vRAService -Name "New Service" -Description "A new service" -Owner user@vsphere.local -SupportTeam customgroup@vsphere.local







-------------------------- EXAMPLE 3 --------------------------

C:\PS>$JSON = @"


{
      "name": "New Service",
      "description": "A new Service",
      "status": "ACTIVE",
      "statusName": "Active",
      "version": 1,
      "organization": {
        "tenantRef": "Tenant01",
        "tenantLabel": "Tenant01",
        "subtenantRef": null,
        "subtenantLabel": null
      },
      "newDuration": null,
      "iconId": "cafe_default_icon_genericService"
    }
"@

$JSON | New-vRAService
```
