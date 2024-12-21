
$sourceUrl = "https://raw.githubusercontent.com/NeverSinkDev/NeverSink-PoE2litefilter/main/NeverSinks%20Litefilter.filter"
$destinationFolder = Join-Path $env:USERPROFILE "Documents\My Games\Path of Exile 2"
$destinationFile   = Join-Path $destinationFolder "NeverSinks Litefilter.filter"
$shaFile = "$destinationFile.sha"

# Ensure the destination folder exists
if (!(Test-Path $destinationFolder)) {
    New-Item -Path $destinationFolder -ItemType Directory | Out-Null
}

try {
    $rawContent = (Invoke-WebRequest -Uri $sourceUrl -UseBasicParsing).Content
    
    # Compute a SHA-256 hash of the remote content
    $sha256 = New-Object System.Security.Cryptography.SHA256Managed
    $remoteBytes = [System.Text.Encoding]::UTF8.GetBytes($rawContent)
    $remoteHashBytes = $sha256.ComputeHash($remoteBytes)
    $remoteHash = [BitConverter]::ToString($remoteHashBytes) -replace "-", ""

    # Read the local SHA if it exists
    $localHash = if(Test-Path $shaFile) { Get-Content $shaFile } else { "" }

    if ($remoteHash -ne $localHash) {
        # The file has changed on GitHub; update locally
        $rawContent | Out-File $destinationFile -Encoding UTF8

        # Save the new hash
        $remoteHash | Out-File $shaFile
        Write-Host "Filter updated: $destinationFile"
    }
    else {
        Write-Host "No changes detected."
    }
}
catch {
    Write-Host "Error during update check: $($_.Exception.Message)"
}
