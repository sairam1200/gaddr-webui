# Gaddr WebUI bundle

`webui.zip` is the production bundle built from source commit
`cff9d6b0a8afd1e8b20898144896e9b46883c598` with:

```sh
npm ci
npm test
npm run typecheck
npm run build
pwsh -File scripts/package-webui.ps1
```

The archive contains the contents of `dist/` at its root and uses portable
forward-slash entry names. Verify it against `webui.zip.sha256` before
promotion.
