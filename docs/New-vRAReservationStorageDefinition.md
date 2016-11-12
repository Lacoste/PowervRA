# New-vRAReservationStorageDefinition

## SYNOPSIS
Creates a new storage definition for a reservation

## SYNTAX

```
New-vRAReservationStorageDefinition -Type <String> -ComputeResourceId <String> -Path <String>
 -ReservedSizeGB <Int32> [-Priority <Int32>]
```

## DESCRIPTION
Creates a new storage definition for a reservation.
This cmdlet is used to create a custom
complex storage object.
One or more of these can be added to an array and passed to New-vRAReservation.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$StorageDefinitionArray = @()
```

$Storage1 = New-vRAReservationStorageDefinition -Type vSphere -ComputeResourceId 75ae3400-beb5-4b0b-895a-0484413c93b1 -Path "Datastore01" -ReservedSizeGB 10 -Priority 0 
$StorageDefinitionArray += $Storage1

## PARAMETERS

### -Type
{{Fill Type Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputeResourceId
{{Fill ComputeResourceId Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The storage path

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReservedSizeGB
{{Fill ReservedSizeGB Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Priority
The priority of storage

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String.
System.Int.

## OUTPUTS

### System.Management.Automation.PSObject

## NOTES

## RELATED LINKS

