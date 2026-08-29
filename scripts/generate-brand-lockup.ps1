# SPDX-FileCopyrightText: 2026 Gaddr
# SPDX-License-Identifier: AGPL-3.0-only

[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$repositoryDirectory = Split-Path -Parent $scriptDirectory
$iconPath = Join-Path $repositoryDirectory 'public\gaddr-logo-xs.svg'
$wordmarkPath = Join-Path $repositoryDirectory 'src\assets\gaddr-logo.svg'
$sourceOutputPath = Join-Path $repositoryDirectory 'src\assets\gaddr-brand.svg'
$publicOutputPath = Join-Path $repositoryDirectory 'public\gaddr-brand.svg'

function Get-SvgInnerContent([string]$path) {
  $source = [IO.File]::ReadAllText($path)
  $match = [Text.RegularExpressions.Regex]::Match(
    $source,
    '<svg\b[^>]*>(?<content>[\s\S]*)</svg>\s*$',
    [Text.RegularExpressions.RegexOptions]::IgnoreCase
  )
  if (-not $match.Success) {
    throw "Could not extract SVG content from $path"
  }
  return $match.Groups['content'].Value.Trim()
}

$iconContent = Get-SvgInnerContent $iconPath
$wordmarkContent = Get-SvgInnerContent $wordmarkPath
$svg = @"
<?xml version="1.0" encoding="UTF-8"?>
<!-- SPDX-FileCopyrightText: 2026 Gaddr -->
<!-- SPDX-License-Identifier: AGPL-3.0-only -->
<svg xmlns="http://www.w3.org/2000/svg" width="680" height="202" viewBox="0 0 680 202" role="img" aria-label="Gaddr">
  <svg x="0" y="51" width="154" height="100" viewBox="0 0 43 28" preserveAspectRatio="xMidYMid meet">
$iconContent
  </svg>
  <svg x="184" y="0" width="496" height="202" viewBox="0 0 496 202" preserveAspectRatio="xMidYMid meet">
$wordmarkContent
  </svg>
</svg>
"@

$utf8WithoutBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($sourceOutputPath, $svg, $utf8WithoutBom)
[IO.File]::WriteAllText($publicOutputPath, $svg, $utf8WithoutBom)
