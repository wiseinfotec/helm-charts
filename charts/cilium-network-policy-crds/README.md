# Cilium Network Policy CRDs

Installs the `CiliumNetworkPolicy` and
`CiliumClusterwideNetworkPolicy` API definitions. Install this chart before
Cilium and before resources using either API. The clusterwide API includes host
policies. This chart installs no controller or agent. Cilium agents enforce
policies only after they start with the required policy and host-firewall
settings.

## Install

```bash
helm install cilium-network-policy-crds \
  ./charts/cilium-network-policy-crds
```

## Update

```bash
python3 -m pip install -r requirements.txt
python3 scripts/update-cilium-network-policy-crds.py \
  --cilium-version 1.20.0 \
  --chart-version 0.1.0
```

CRDs in `crds/` are installed before chart templates. [Helm does not upgrade or
delete them](https://helm.sh/docs/chart_best_practices/custom_resource_definitions/).
Existing clusters require explicit CRD updates when schemas change. Review the
generated diff, then apply each updated CRD with the cluster's normal
CRD-management process.
