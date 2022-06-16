# Namespaces

This module allow us to deploy a list of namespaces on a Kubernetes cluster.

```hcl
module "namespaces" {
  source = "../../../../../modules/namespaces/"

  namespaces = {
    "admin" : {
      labels : {
        "toto" = "test"
      }
    }
    "app" : {}
    "logging" : {}
    "monitoring" : {}
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | Namespaces to manage on a Kubernetes cluster | <pre>map(object({<br>    labels : optional(map(string)),<br>    annotations : optional(map(string))<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.


## Author

[Talend SRE Team](github.com/Talend)
