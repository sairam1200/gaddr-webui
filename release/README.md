# Gaddr WebUI bundle

`webui.zip` is the production bundle built from source commit
`98738b4d5c94949f13a39976668eb41d30bcecd0` with:

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
