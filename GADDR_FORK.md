# Gaddr Stalwart WebUI fork

This branch applies a deliberately narrow Gaddr presentation layer to the
standalone Stalwart WebUI. It does not modify the Stalwart mail-server binary,
SMTP, IMAP, JMAP, storage, authentication, permissions, or schema-driven forms.

## Provenance

- Upstream repository: `https://github.com/stalwartlabs/webui.git`
- Upstream commit: `af11f5119c1aa299e2f56965b813a30136cd4009`
- Upstream application version: `1.0.9`
- License: `AGPL-3.0-only OR LicenseRef-SEL`, as declared per upstream file

The Gaddr deployment uses the AGPL-3.0-only option unless a valid Stalwart
Enterprise licence authorises the alternative licence. Preserve upstream
copyright and SPDX notices. Users of the network service must be offered the
complete corresponding source for the deployed modified version.

## Branding changes

- Use the existing Gaddr wordmark in the login page and top bar.
- Use the owner-supplied `gaddr-logo-xs(1).svg` byte-for-byte as the browser
  favicon. Its SHA-256 is
  `ecaf8ee43c3b2e47e9e8530792e28d39dd99af9dda869ab30842725850c2af8b`.
- Use `Gaddr` in document titles, logo alternative text, the version tooltip,
  setup messages, and new MFA authenticator entries.
- Keep upstream names out of user-facing product branding while preserving
  required source provenance and copyright notices.
- Preserve all functional Lucide icons and schema-provided navigation icons.

## Build

```sh
npm ci
npm test
npm run typecheck
npm run lint
npm run build
```

Package the contents of `dist/`, not the directory itself, as `webui.zip`.

## Live application contract

The current Stalwart Application record mounts one bundle at `/admin` and
`/account`. Before promotion, retain this exact rollback Resource URL:

```text
https://github.com/stalwartlabs/webui/releases/latest/download/webui.zip
```

Publish the branded bundle at an immutable HTTPS URL, record its SHA-256, and
keep the corresponding source available under the AGPL before changing the
Application Resource URL. Never point production at a mutable branch archive.
