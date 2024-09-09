# GeneratePSK.ps1
$bytes = New-Object byte[] 32
[System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
$psk = [BitConverter]::ToString($bytes) -replace '-'
$psk.ToLower()
