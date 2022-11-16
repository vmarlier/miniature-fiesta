# Miniature Fiesta

The idea behind miniature fiesta is to managed a k8s cluster in a production like environment with different tools and methodologies.

* [Terraform topologies](./terraform/): This topology is in charge of creating the Kubernetes cluster (on Scaleway Cloud) and to setup the basic tools (GitOps + SealedSecret).
* [GitOps](./config/): This directory is the one used with Fluxv2 for the GitOps part of the project.

## TODO

- [X] Kapsule Cluster
- [X] Cluster Configuration
  - [X] CRDs
  - [X] Namespaces
  - [X] GitOps: Fluxv2 Stack
  - [X] Secret Handling: SealedSecret
- [ ] Observability Stack
  - [X] Prometheus
  - [ ] Thanos
  - [X] Grafana (+ on call plug-in)
  - [ ] Loki
  - [ ] Tempo
- [ ] Dumb applications
  - [ ] Dumb 1
  - [ ] Dumb 2
- [ ] Service Mesh
  - [ ] Test Ambient
  - [ ] Test Cilium
- [ ] Proxy, Ingress
  - [ ] Traefik2
  - [ ] Gloo ?
  - [ ] Istio
- [ ] Cluster Hardening and Security Improvment
  - [ ] Admission Controller: Kyverno
  - [ ] Network Policies
- [ ] Others
  - [ ] OpenFaaS ?
  - [ ] Keda ?
  - [ ] Karma ?

## How to use the GitOps stack

## How to use the Terraform stack

```sh
# Before init - Setup access keys for Remote Backend, and scaleway provider authentication
export AWS_ACCESS_KEY_ID=<access-key>
export AWS_SECRET_ACCESS_KEY=<secret-key>
export SCW_ACCESS_KEY=<access-key>
export SCW_SECRET_KEY=<secret-key>

# Also, export the vault variable
export TF_VAR_vault_pass=<vault_pass>

# Use the Makefile
make plan topology=cluster
make apply topology=cluster

make plan topology=config
make apply topology=config

make destroy topology=config
make destroy topology=cluster
```
