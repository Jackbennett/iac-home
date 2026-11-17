# Talosctl configs

topology, 192.168.1.2xx range, bottom-up being control planes, top down being work nodes;

* 192.168.1.200 VIP
* 192.168.1.201 CP
* 192.168.1.209 worker
* 192.168.1.210 worker

## Creating config

use talosctl gen config files (controlplane.yaml/worker.yaml) as bases to apply node config to.
Include CP config on the CP nodes.
Node config per machine.

1. `talosctl config gen --with-secrets` to maintain pki
1. `talosctl machineconfig patch ./worker.yaml -p @patch/common.yaml -p @patch/node-<X>.yaml` to view the changes generated
1. app machineConfig documents works via -p too. see `talosctl machineconfig patch controlplane.yaml -p @patch/node-a-volumes.yaml`
1. `talosctl apply-config -f ./worker.yaml -p @patch/common.yaml -p @patch/node-<X>.yaml` to apply said configtalosctl

### Networking

Services to be exposed via BGP to my unify network. This avoids deploying ingress as we make service routes available directly.

# Updates/upgrades

Get the existing extensions factory via `talosctl get extensions` [Image Factory a3ea... v1.14.6](https://factory.talos.dev/?target=metal&version=1.14.6&arch=amd64&platform=metal&schematic-id=a3ea39fe448d8d4f3bdfbfc4e662b30fa37e91e609b160bd103377e8f11bbd5c) and update the version tags to upgrade.

See version release notes & https://www.talos.dev/v1.10/talos-guides/upgrading-talos/ but short
answer `talosctl -n <cp node> upgrade --image factory.talos.dev/metal-installer/a3ea39fe448d8d4f3bdfbfc4e662b30fa37e91e609b160bd103377e8f11bbd5c:v1.14.6`.

Do the controllers then the workers.
