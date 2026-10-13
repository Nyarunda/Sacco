param(
    [Parameter(Mandatory = $true)]
    [string]$ReportPath,

    [Parameter(Mandatory = $true)]
    [string]$LayoutPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $ReportPath)) {
    throw "Report file not found: $ReportPath"
}

if (-not (Test-Path -LiteralPath $LayoutPath)) {
    throw "Layout file not found: $LayoutPath"
}

$reportText = Get-Content -LiteralPath $ReportPath -Raw
$layoutText = Get-Content -LiteralPath $LayoutPath -Raw
$layoutLines = Get-Content -LiteralPath $LayoutPath

$reportColumns = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
[regex]::Matches($reportText, 'column\(([^;\s,]+)\s*;') | ForEach-Object {
    [void]$reportColumns.Add($_.Groups[1].Value)
}

$layoutFields = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
[regex]::Matches($layoutText, '<Field Name="([^"]+)"') | ForEach-Object {
    [void]$layoutFields.Add($_.Groups[1].Value)
}

$expressionFields = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
[regex]::Matches($layoutText, 'Fields!([A-Za-z0-9_]+)\.Value') | ForEach-Object {
    [void]$expressionFields.Add($_.Groups[1].Value)
}

$missingInReport = @($expressionFields | Sort-Object | Where-Object { -not $reportColumns.Contains($_) })
$missingInLayout = @($expressionFields | Sort-Object | Where-Object { -not $layoutFields.Contains($_) })

$suspiciousExpressions = @(for ($i = 0; $i -lt $layoutLines.Length; $i++) {
    $line = $layoutLines[$i]
    if ($line -match '\b(?:Sum|Avg|Count|Max|Min)\(Fields![^)]+\)\s*[+\-*/]\s*Fields![A-Za-z0-9_]+\.Value' -or
        $line -match 'Fields![A-Za-z0-9_]+\.Value\s*[+\-*/]\s*\b(?:Sum|Avg|Count|Max|Min)\(Fields![^)]+\)') {
        [pscustomobject]@{
            Line       = $i + 1
            Expression = $line.Trim()
        }
    }
})

Write-Host "Report: $ReportPath"
Write-Host "Layout: $LayoutPath"
Write-Host ''

if ($missingInReport.Count -eq 0) {
    Write-Host 'OK: all RDLC field references exist in the AL dataset.'
} else {
    Write-Host 'Missing in AL dataset:'
    $missingInReport | ForEach-Object { Write-Host "  $_" }
}

Write-Host ''

if ($missingInLayout.Count -eq 0) {
    Write-Host 'OK: all referenced fields exist in the RDLC field list.'
} else {
    Write-Host 'Missing in RDLC field definitions:'
    $missingInLayout | ForEach-Object { Write-Host "  $_" }
}

Write-Host ''

if ($suspiciousExpressions.Count -eq 0) {
    Write-Host 'OK: no aggregate-plus-bare-field expressions detected.'
} else {
    Write-Host 'Suspicious expressions mixing aggregates and bare fields:'
    $suspiciousExpressions | ForEach-Object {
        Write-Host "  Line $($_.Line): $($_.Expression)"
    }
}
