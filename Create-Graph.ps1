<#
    .SYNOPSIS
    This script creates a graph from 0-100

    .DESCRIPTION
    This script takes in numbers specified from 0-100 and creates a graph.  You can specify the number of columns to show and display the maximum and minimum values
    from over the course of running it.

    .EXAMPLE
    Create-Graph -NewValue 10

    .EXAMPLE
    Create-Graph -NewValue 10 -ResetArray $true

    .EXAMPLE
    Create-Graph -NewValue 10 -NumCols 5
#>
Function Create-Graph()
{
    [CmdletBinding()]
    param (
        [int]$NewValue,
        [bool]$ResetArray,
        [int]$NumCols = 10
        )

    $ListExist = Test-Path variable:global:vallist

    if (($ListExist -eq $false) -or ($ResetArray -eq $true))
    {
        $global:ValList = [System.Collections.ArrayList]@()
    }

    #if ([string]::IsNullOrWhiteSpace($NewValue)){}
    if (!([string]::IsNullOrWhiteSpace($NewValue)))
    {
        [void]$global:ValList.Add($NewValue)

        #Setup values, some of which will become random
        $CurrCol = 0
        $MaxValue = 0
        $MinValue = 100

        #Retrieve the last 10 results
        $NumRecords = $ValList.Count

        If ($NumCols -gt $NumRecords)
        {
            $NumCols = $NumRecords
            $CurrRecord = -1
        }
        else
        {
            $CurrRecord = $NumRecords-$NumCols-1
        }

        $LastRecord = $NumRecords-1
        $HeaderFooter = "     -"
        $Output100 = "100 | "
        $Output90 = "90  | "
        $Output80 = "80  | "
        $Output70 = "70  | "
        $Output60 = "60  | "
        $Output50 = "50  | "
        $Output40 = "40  | "
        $Output30 = "30  | "
        $Output20 = "20  | "
        $Output10 = "10  | "
        $Output0 = "0   | "

        Do{
            $CurrRecord++
            $CurrCol++
            $HeaderFooter += " -"
            If ($global:ValList[$CurrRecord] -eq 100)
            {
                $Output100 +="* "
            }
            Else
            {
                $Output100 +="  "
            }

            If ($global:ValList[$CurrRecord] -in 90..99)
            {
                $Output90 +="* "
            }
            Else
            {
                $Output90 +="  "
            }

            If ($global:ValList[$CurrRecord] -in 80..89)
            {
                $Output80 +="* "
            }
            Else
            {
                $Output80 +="  "
            }

            If ($global:ValList[$CurrRecord] -in 70..79)
            {
                $Output70 +="* "
            }
            Else
            {
                $Output70 +="  "
            }

            If ($global:ValList[$CurrRecord] -in 60..69)
            {
                $Output60 +="* "
            }
            Else
            {
                $Output60 +="  "
            }

            If ($global:ValList[$CurrRecord] -in 50..59)
            {
                $Output50 +="* "
            }
            Else
            {
                $Output50 +="  "
            }

            If ($global:ValList[$CurrRecord] -in 40..49)
            {
                $Output40 +="* "
            }
            Else
            {
                $Output40 +="  "
            }

            If ($global:ValList[$CurrRecord] -in 30..39)
            {
                $Output30 +="* "
            }
            Else
            {
                $Output30 +="  "
            }

            If ($global:ValList[$CurrRecord] -in 20..29)
            {
                $Output20 +="* "
            }
            Else
            {
                $Output20 +="  "
            }

            If ($global:ValList[$CurrRecord] -in 10..19)
            {
                $Output10 +="* "
            }
            Else
            {
                $Output10 +="  "
            }

            If ($global:ValList[$CurrRecord] -in 0..9)
            {
                $Output0 +="* "
            }
            Else
            {
                $Output0 +="  "
            }
        } While ($CurrCol -lt $NumCols)
        $Output100 += "| 100"
        $Output90 += "| 90"
        $Output80 += "| 80"
        $Output70 += "| 70"
        $Output60 += "| 60"
        $Output50 += "| 50"
        $Output40 += "| 40"
        $Output30 += "| 30"
        $Output20 += "| 20"
        $Output10 += "| 10"
        $Output0 += "| 0"

        $CurrValue = $global:ValList | Select -Last 1
        $MaxValue = ($global:ValList | Measure-Object -Maximum).Maximum
        $MinValue = ($global:ValList | Measure-Object -Minimum).Minimum

        Write-Output "Max:$MaxValue% | Min:$MinValue% | Curr:$CurrValue%"
        $HeaderFooter
        $Output100
        $Output90
        $Output80
        $Output70
        $Output60
        $Output50
        $Output40
        $Output30
        $Output20
        $Output10
        $Output0
        $HeaderFooter
    }
}
