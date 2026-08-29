# Gaddr WebUI bundle

`webui.zip` is the production bundle built from source commit
`2a137c87c7eaed8811480e5e38b25a5ff6f6bb1f` with:

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
