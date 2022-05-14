# VitaGameListComparisonTool
Compares NoPlayStation's PS Vita TSV file to a Vita memory card's /app directory   and outputs the corresponding TitleID to the human-readable game title

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
