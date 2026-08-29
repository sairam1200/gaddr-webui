# Gaddr WebUI bundle

`webui.zip` is the production bundle built from source commit
`190e7826ee051625aa92d55d20f5b8cef518f836` with:

```sh
npm ci
npm test
npm run typecheck
npm run build
```

The archive contains the contents of `dist/` at its root. Verify it against
`webui.zip.sha256` before promotion.
