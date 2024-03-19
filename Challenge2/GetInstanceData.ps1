param (
    [string]$key = ""
)

param (
    [string]$instance_ip = ""
)

if (-not $key) {
    Write-Error "Please provide a data key parameter"
    exit 1
}

if (-not $instance_ip) {
    Write-Error "Please provide a ip of instance"
    exit 1
}


$metadataUrl = "http://$instance_ip/metadata/instance?api-version=2021-02-01"
$metadataHeaders = @{"Metadata"="true"}


$instanceMetadata = Invoke-RestMethod -Uri $metadataUrl -Headers $metadataHeaders


if ($instanceMetadata.PSObject.Properties.Match($key)) {
    $value = $instanceMetadata.$key
    $jsonOutput = @{
        $key = $value
    } | ConvertTo-Json
    Write-Output $jsonOutput
} else {
    Write-Error "Key '$key' not found in the instance metadata."
    exit 1
}