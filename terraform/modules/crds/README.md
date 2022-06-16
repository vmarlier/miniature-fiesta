# CRDs

This module allow us to deploy CRDs that we don't want to deploy through HelmRelease, it is a Best Practice to make sure resources based on these CRDs will not be removed if we need to migrate/delete
the tool (e.g. Do not delete kustomizations from Fluxv2 cause all the files deployed by the kustomization resources will be removed too, total outage).

```hcl
module "crds" {
  source = "../../../../../modules/crds/"

  crds = {
    "flux" : {}
    "sealed-secrets" : {}
  }
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 1.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | ~> 1.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.crd](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_path_documents.crd](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/path_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_crds"></a> [crds](#input\_crds) | Custom Resource Definitions to create on the cluster | `map(object({}))` | `{}` | no |

## Outputs

No outputs.

## Author

[Talend SRE Team](github.com/Talend)
