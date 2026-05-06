#retrieve the username
[Environment]::UserName
$Env:UserName
#paths
$DownloadsPath = "C:\Users\metro\Downloads"
$BBBPath = "C:\Users\metro\Documents\BBB"
$BBBPathResult = Get-ChildItem -Path $BBBPath | 
Where-Object {$_.Name -like "Modul*"} #Filter
$PicturePath = "C:\Users\metro\Pictures"
$DownloadsPathResult = Get-ChildItem -Path $DownloadsPath -Recurse 

#output Path Results
Write-Host "BBB Folder: $BBBPath"  
Write-Output $BBBPathResult 
Write-Host "Downloads Folder: $DownloadsPath"
Write-Output $DownloadsPathResult 

$ModulFilePrefixes = $BBBPathResult | ForEach-Object {
     $_.Name -match '(\d{3})' 
     $Matches[1]
}

$DownloadsPathResult | ForEach-Object {
    if ($_.Name -match '^(PR|LA)_M?(\d{3})') {
        $Number = $Matches[2]
        if ($ModulFilePrefixes -contains $Number) {
            if (!(Test-Path .Path $BBBPath)) {
                New-Item .Path "C:\Users\metro\Documents\BBB" -Force
            }
            Move-Item -Path $_.FullName -Destination "$BBBPath\Modul_$Number"
            Write-Host "Excersizes moved to BBB"
        } else {
            New-Item -Path "$BBBPath\Modul_$Number" -ItemType Directory
            Move-Item -Path $_.FullName -Destination "$BBBPath\Modul_$Number"
            Write-Host "Excersizes moved and made Folders"
        }
    }
    if ($_.Name -match '\.(.msi|.exe|.pkg)') {
        Remove-Item $_.FullName
        Write-Host "Extensions deleted"
    }
    if ($_.Name -match '(.png|.jpg|.webp|.gif|.avif)') {
        Move-Item -Path $_.FullName -Destination $PicturePath
        Write-Host "Moved Pictures"
    }
}