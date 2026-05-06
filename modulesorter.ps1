#retrieve the username
[Environment]::UserName
$userpath = [Environment]::GetFolderPath("UserProfile")

#paths
$docpaths = [Environment]::GetFolderPath("MyDocuments")
$PicturePath = Join-Path $userpath "Pictures"
$DownloadsPath = Join-Path $userpath "Downloads"
$BBBPath = "$docpaths\Documents\BBB"
$BBBPathResult = Get-ChildItem -Path $BBBPath | 
Where-Object {$_.Name -like "Modul*"} #Filter
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
        } else {
            New-Item -Path "$BBBPath\Modul_$Number" -ItemType Directory
            Move-Item -Path $_.FullName -Destination "$BBBPath\Modul_$Number"
        }
    }
    if ($_.Name -match '\.(.msi|.exe|.pkg)') {
        Remove-Item $_.FullName
    }
    if ($_.Name -match '(.png|.jpg|.webp|.gif|.avif)') {
        Move-Item -Path $_.FullName -Destination $PicturePath
    }
}