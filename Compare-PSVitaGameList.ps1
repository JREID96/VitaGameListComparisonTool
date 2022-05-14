<#
.SYNOPSIS
    Compares NoPlayStation's PS Vita TSV file to a Vita memory card's /app directory
    and outputs the corresponding TitleID to the human-readable game title
.EXAMPLE
    $gameDir = D:\app\
    $tsv = C:\Temp\PSV_GAMES.tsv

    .\Compare-PSVitaGameList -AppFolderPath $gameDir -TSVFilePath $tsv

    It will return the matching games and their TitleID

.EXAMPLE
    $gameDir = D:\app\
    $tsv = C:\Temp\PSV_GAMES.tsv

    .\Compare-PSVitaGameList -AppFolderPath $gameDir -TSVFilePath $tsv

    It will return the match games and all other related information
.EXAMPLE
    $gameDir = D:\app\
    $tsv = C:\Temp\PSV_GAMES.tsv

    .\Compare-PSVitaGameList -AppFolderPath $gameDir -TSVFilePath $tsv -FilePath C:\Temp\nsp_matches.csv

    It will return the match games and all other related information
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    # The full path to the /app directory on your PSVita memory card
    [string]
    $AppFolderPath,

    # The full path the the NSP Vita games TSV file
    [string]
    $TSVFilePath = "$PSScriptRoot\PSV_GAMES.tsv",

    # Toggle to return all matchinginfo. Leave off to only return the name and TitleID
    [switch]
    $AllInfo,

    # Save the matches to a CSV
    [string]
    $FilePath
)

$tsv = Import-Csv $TSVFilePath -Delimiter "`t"
$apps = Get-ChildItem $AppFolderPath | select -expand Name

Write-Host "Found $($tsv.count) games in Vita database"
Write-Host "Found $($apps.count) games in $AppFolderPath"

$success  = @()
$failures = @()

foreach ($app in $apps) {
    $game = $tsv | where {$_.'Title ID' -match $app}

    if (-not $game) {
        Write-Host "No match found for TitleID: $app" -ForegroundColor 'Red'
        $failures += $app
    }
    else {
        Write-Host -Verbose "Match found for $($app): $($game.Name)" -ForegroundColor 'Green'
        $success += $game
    }
}

$output = {
    Write-Host "Successfully matched $($success.count) TitleID(s)!" -ForegroundColor 'Green'
    if ($failures -gt 0) {
        Write-Host "Failed to match $($failures.count) TitleID(s) " -ForegroundColor 'Red'
    }
}

if ($AllInfo) {
    $gameMatches | sort Name
    & $output
}
else {
    $gameMatches | select Name, 'Title ID' | sort Name
    & $output
}

if ($FilePath) {
    $success | sort Name | Export-Csv -Path $FilePath
    Write-Host "Exported matches to $FilePath"
}
