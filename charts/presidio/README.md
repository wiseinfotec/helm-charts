# Presidio - Data Protection and De-identification SDK

**Context aware, pluggable and customizable PII de-identification service for text and images.**

Project: https://github.com/data-privacy-stack/presidio

## Gateway API

Gateway API exposure is disabled by default. Enable it and disable the existing Ingress to avoid exposing both paths:

```yaml
ingress:
  enabled: false

gateway:
  enabled: true
  gatewayClassName: example
```

`gateway.listeners` is passed directly to the generated `Gateway`. `gateway.route.rewritePath=true` strips each service prefix with an `HTTPRoute` `URLRewrite` filter. This requires Gateway controller support for `HTTPRoutePathRewrite`. Set `rewritePath=false` to leave prefixes unchanged.
