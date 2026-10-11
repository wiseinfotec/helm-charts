# Changelog

## [2.1.0] - 2026-10-11

- Moved project links and container images to the Data Privacy Stack organization and GHCR.
- Pinned analyzer and anonymizer images to `2.2.364`, and image redactor to `0.0.60`.
- Added optional Gateway API `Gateway` and `HTTPRoute` resources with configurable listeners and path rewriting.
- Set `ingress.enabled` to `false` by default.

## [2.0.1] - 2025-07-25

- Introduced Helm values to configure common and resource-specific annotations and labels.
- Added support for specifying additional volumes and corresponding mounts in deployments via Helm values.
- Enabled configuration of environment variables for deployments through Helm values.

## [2.0.0] - 2025-07-27

- Initial chart release.
