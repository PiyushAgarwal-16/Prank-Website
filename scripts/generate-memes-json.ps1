Param(
  [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$memesDir = Join-Path $Root "memes"
$outputFile = Join-Path $Root "memes.json"
$allowedExt = @(".jpg", ".jpeg", ".png", ".webp", ".gif")

if (-not (Test-Path $memesDir)) {
  throw "Memes folder not found: $memesDir"
}

$files = Get-ChildItem -Path $memesDir -File |
  Where-Object { $allowedExt -contains $_.Extension.ToLowerInvariant() } |
  Sort-Object Name |
  ForEach-Object {
    "memes/$($_.Name)"
  }

# Use compact, valid JSON array that index.html can fetch directly.
$files | ConvertTo-Json | Set-Content -Path $outputFile -Encoding UTF8

Write-Host "Updated memes.json with $($files.Count) image(s)."
