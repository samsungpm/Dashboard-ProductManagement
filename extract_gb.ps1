$base = 'C:\Users\baptiste.a\Documents\20. Product Management Website\Dashboard-ProductManagement\'
$index = [System.IO.File]::ReadAllText($base + 'index.html')

$frameMarker = 'id="frame-galaxybook"'
$frameIdx = $index.IndexOf($frameMarker)
if ($frameIdx -lt 0) { throw "frame-galaxybook introuvable" }

$srcdocMarker = 'srcdoc="'
$srcdocIdx = $index.IndexOf($srcdocMarker, $frameIdx)
$contentStart = $srcdocIdx + $srcdocMarker.Length

$endMarker = '"></iframe>'
$contentEnd = $index.IndexOf($endMarker, $contentStart)

$raw = $index.Substring($contentStart, $contentEnd - $contentStart)
$decoded = $raw.Replace('&quot;', '"').Replace('&amp;', '&')

[System.IO.File]::WriteAllText($base + '_tmp_gb.html', $decoded, (New-Object System.Text.UTF8Encoding($false)))
Write-Output "Extrait: longueur=$($decoded.Length)"
