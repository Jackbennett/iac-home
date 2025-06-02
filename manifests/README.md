# Setup via Install fluxcd via operator;

[Fluxcd CD Operator](https://fluxcd.control-plane.io/operator/flux-config/) Docs.

Install the operator;
```bash
kubectl apply -f https://github.com/controlplaneio-fluxcd/flux-operator/releases/latest/download/install.yaml
```

Then start the flux controllers via instance CRD [from the repo yaml.](./fluxcd/FluxInstance.yaml)

## Structure

1. Node access & kubectl from [lab talos](../lab/)
1. Bootstrap & config management starts from [fluxcd](./fluxcd/)
1. ...directories here per job, possibly not 1:1 to namespace.
