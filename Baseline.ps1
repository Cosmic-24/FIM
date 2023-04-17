#To Calculate File Hash Of Files

Function Cal_File_Hash($Filepath){
 $filehash = Get-FileHash -Path $Filepath -Algorithm SHA512
 return $filehash
}

#folder in which files are to be monitored

$folder = "D:\OM\Cosmic\Project files\FIM\TEST"

#Baseline File Location

$baseline = "D:\OM\Cosmic\Project files\FIM\Baseline\Baseline.txt"

#Dictionary to store hash from baseline while monitoring

$hashbase = @{}




Start-Sleep -Seconds 1
Write-Host "Getting Baseline....."
Clear-Content -Path $baseline
$files = Get-ChildItem -Path $folder

 foreach($i in $files){

 $hash = Cal_File_Hash($i.FullName)
 "$($hash.Path)|$($hash.Hash)"| Out-File -FilePath $baseline -Append
 Start-Sleep -Seconds 1
 Write-Host "."


}
Start-Sleep -Seconds 1
Write-Host "Baseline Saved!!"

