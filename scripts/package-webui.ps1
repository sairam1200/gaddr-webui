# SPDX-FileCopyrightText: 2026 Gaddr
# SPDX-License-Identifier: AGPL-3.0-only

[CmdletBinding()]
param(
  [string]$DistDirectory = (Join-Path $PSScriptRoot '..\dist'),
  [string]$OutputPath = (Join-Path $PSScriptRoot '..\release\webui.zip')
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

Add-Type -AssemblyName System.IO.Compression

$dist = (Resolve-Path -LiteralPath $DistDirectory).Path
$distPrefix = $dist.TrimEnd([char[]]'\/') + [System.IO.Path]::DirectorySeparatorChar
$output = [System.IO.Path]::GetFullPath($OutputPath)
$outputDirectory = Split-Path -Parent $output
[System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null

$stream = [System.IO.File]::Open($output, [System.IO.FileMode]::Create)
try {
  $archive = [System.IO.Compression.ZipArchive]::new(
    $stream,
    [System.IO.Compression.ZipArchiveMode]::Create,
    $false
  )
  try {
    foreach ($file in Get-ChildItem -LiteralPath $dist -File -Recurse | Sort-Object FullName) {
      if (-not $file.FullName.StartsWith($distPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to package a file outside the dist directory: $($file.FullName)"
      }
      $relativePath = $file.FullName.Substring($distPrefix.Length).Replace('\', '/')
      $entry = $archive.CreateEntry($relativePath, [System.IO.Compression.CompressionLevel]::Optimal)
      $input = $file.OpenRead()
      try {
        $entryStream = $entry.Open()
        try {
          $input.CopyTo($entryStream)
        } finally {
          $entryStream.Dispose()
        }
      } finally {
        $input.Dispose()
      }
    }
  } finally {
    $archive.Dispose()
  }
} finally {
  $stream.Dispose()
}

$hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $output).Hash.ToLowerInvariant()
Write-Output "$hash  $output"
