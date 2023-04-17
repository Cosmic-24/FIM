Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to calculate file hash
Function Cal_File_Hash($Filepath){
    $filehash = Get-FileHash -Path $Filepath -Algorithm SHA512
    return $filehash
}

# Function to start monitoring
Function Start-Monitoring($folder){
    # Dictionary to store hash from baseline while monitoring
    $hashbase = @{}

    # Getting Baseline
    Clear-Content -Path $baseline
    $files = Get-ChildItem -Path $folder -Recurse

    foreach($i in $files){
        try {
            $hash = Cal_File_Hash($i.FullName)
            "$($hash.Path)|$($hash.Hash)"| Out-File -FilePath $baseline -Append
        }
        catch {
            Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    Write-Host "Baseline saved at $baseline"

    # Monitoring Files
    $temphash = Get-Content -Path $baseline
    foreach($i in $temphash){
        $hashbase.Add($i.Split("|")[0],$i.Split("|")[1])
    }

    while($true){
        $mfiles = Get-ChildItem -Path $folder -Recurse
        foreach($i in $mfiles){
            try {
                $mhash = Cal_File_Hash($i.FullName)
                # If files are not altered
                if($hashbase[$mhash.Path] -eq $mhash.Hash){
                    # Do nothing
                }
                # If new file was created
                elseif($hashbase[$mhash.Path] -eq $null){
                    Write-Host $mhash.Path "File was created!!" -ForegroundColor Yellow
                }
                # If files are altered
                else{
                    Write-Host $mhash.Path "File was altered!!!" -ForegroundColor Red
                }
            }
            catch {
                Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
            }
        }

        # Check for deleted files
        foreach($i in $hashbase.Keys){
            $fileexist = Test-Path -Path $i
            if($fileexist -eq $false){
                Write-Host $i "File was deleted!!" -ForegroundColor Yellow
            }
        }
        Start-Sleep -Seconds 1
    }
}