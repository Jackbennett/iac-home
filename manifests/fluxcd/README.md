# FluxCD self-management.

1. FluxInstance deploys the operator which keeps fluxcd itself deployed.
1. FluxResourceSet keeps the operator updated.
1. apply-* generally per source sync config of kustomizations or helmcharts.

apply-* pattern of kustomizations to stagger rollouts or work on multiple broken projects without
blocking know-good sources from deploying i.e. getting hotfixes deployed.
