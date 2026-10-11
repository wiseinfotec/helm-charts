# Gateway API Standard CRDs

Installs the complete Gateway API Standard channel bundle as Helm-managed
templates. CRDs stay in the cluster after chart deletion; admission policy
resources are deleted normally.

Kubernetes 1.31 or newer is required by Gateway API 1.6 TLSRoute validation.

## Install

```bash
helm install gateway-api-standard-crds \
  ./charts/gateway-api-standard-crds
```

## Upgrade

Update the generated bundle and chart versions, review the diff, then upgrade:

```bash
python3 -m pip install -r requirements.txt
python3 scripts/update-gateway-api-standard-crds.py \
  --gateway-version 1.6.0 \
  --chart-version 0.1.0
helm upgrade gateway-api-standard-crds \
  ./charts/gateway-api-standard-crds
```

Because CRDs live under `templates/`, `helm upgrade` applies schema changes.

## Uninstall and cleanup

```bash
helm uninstall gateway-api-standard-crds
```

Helm removes `ValidatingAdmissionPolicy` and
`ValidatingAdmissionPolicyBinding`. The `helm.sh/resource-policy: keep`
annotation retains all CRDs and their custom resources.

Delete retained CRDs manually only after confirming their custom resources are
no longer needed:

```bash
kubectl delete crd \
  backendtlspolicies.gateway.networking.k8s.io \
  gatewayclasses.gateway.networking.k8s.io \
  gateways.gateway.networking.k8s.io \
  grpcroutes.gateway.networking.k8s.io \
  httproutes.gateway.networking.k8s.io \
  listenersets.gateway.networking.k8s.io \
  referencegrants.gateway.networking.k8s.io \
  tcproutes.gateway.networking.k8s.io \
  tlsroutes.gateway.networking.k8s.io \
  udproutes.gateway.networking.k8s.io
```

Deleting a CRD also deletes every custom resource of that kind.

