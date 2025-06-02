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

`talosctl config gen --with-secrets` to maintain pki
`talosctl machineconfig patch ./worker.yaml -p @patch/common.yaml -p @patch/node-<X>.yaml` to view the changes generated
`talosctl apply-config -f ./worker.yaml -p @patch/common.yaml -p @patch/node-<X>.yaml` to apply said configtalosctl

# Updates/upgrades

see version release notes & https://www.talos.dev/v1.10/talos-guides/upgrading-talos/ but short
answer `talosctl -n <node> upgrade --image ghcr.io/siderolabs/installer:1.10.3`.

Do the controllers then the workers.
