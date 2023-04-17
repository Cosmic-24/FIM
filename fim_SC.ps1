
#To Calculate File Hash Of Files

Function Cal_File_Hash($Filepath){
 $filehash = Get-FileHash -Path $Filepath -Algorithm MD5
 return $filehash
}

#folder in which files are to be monitored

$folder = "D:\OM\Cosmic\Project files\FIM\TEST"

#Baseline File Location

$baseline = "D:\OM\Cosmic\Project files\FIM\Baseline\Baseline.txt"

#Dictionary to store hash from baseline while monitoring

$hashbase = @{}

#Display  

Write-Host "`n`n__________FILE INTEGRITY MONITOR__________"
Write-Host "`n1]Get Baseline"
Write-Host "2]Monitor Files"
$response = Read-Host -Prompt "--->" 

#Logic Getting Baseline

if($response -eq 1){
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

}


#Logic Monitoring

elseif($response -eq 2){

#getting baseline start

$temphash = Get-Content -Path $baseline
Start-Sleep -Seconds 1
Write-Host "`nGetting Baseline....."

foreach($i in $temphash){

$hashbase.Add($i.Split("|")[0],$i.Split("|")[1])

}

#getting baseline end

#monitoring start
Start-Sleep -Seconds 1
Write-Host "`nMonitoring Files....."
Start-Sleep -Seconds 1
while($true){

$mfiles = Get-ChildItem -Path $folder

 foreach($i in $mfiles){

 $mhash = Cal_File_Hash($i.FullName)

 #exception

 #if files are not altered
 if($hashbase[$mhash.Path] -eq $mhash.Hash){
 Start-Sleep -Seconds 1
 }
 
 #if new file was created
 elseif($hashbase[$mhash.Path] -eq $null){

 Write-Host $mhash.Path "File was Created!!"
 Start-Sleep -Seconds 1
 }
 #if files are altered
 else{

 Write-Host $mhash.Path "File was Altered!!!`n"
 Start-Sleep -Seconds 1
 }
 #exception


 }
 foreach($i in $hashbase.Keys){
 $fileexist = Test-Path -Path $i
 if($fileexist -eq $false){
 Write-Host $i "File was deleted!!"
 
 }

 }
}

#monitoring end



}
