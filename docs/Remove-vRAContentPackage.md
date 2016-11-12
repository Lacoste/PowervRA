# Remove-vRAContentPackage

## SYNOPSIS
Remove a vRA Content Package

## SYNTAX

### Id (Default)
```
Remove-vRAContentPackage -Id <String[]> [-WhatIf] [-Confirm]
```

### Name
```
Remove-vRAContentPackage -Name <String[]> [-WhatIf] [-Confirm]
```

## DESCRIPTION
Remove a vRA Content Package

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Remove-vRAContentPackage -Id "f8e0d99e-c567-4031-99cb-d8410c841ed7"
```

### -------------------------- EXAMPLE 2 --------------------------
```
Remove-vRAContentPackage -Name "ContentPackage01","ContentPackage02"
```

### -------------------------- EXAMPLE 3 --------------------------
```
Get-vRAContentPackage -Name "ContentPackage01","ContentPackage02" | Remove-vRAContentPackage -Confirm:$false
```

## PARAMETERS

### -Id
Content Package Id

```yaml
Type: String[]
Parameter Sets: Id
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Content Package Name

```yaml
Type: String[]
Parameter Sets: Name
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String.

## OUTPUTS

### None

## NOTES

## RELATED LINKS

