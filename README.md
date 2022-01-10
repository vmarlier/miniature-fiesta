# miniature fiesta

The idea behind miniature fiesta is to managed a k8s in a production like environment with different tools and methodologies.

This repository can:
    - create a K8S managed cluster and create some basic resources (NS..)
    - setup Fluxv2.
    - setup SealedSecret.
    - setup Gloo

## How to use

```sh
# Before init - Setup access keys for Remote Backend
export AWS_ACCESS_KEY_ID=<access-key>
export AWS_SECRET_ACCESS_KEY=<secret-key>

# Init
make tf_init

# Before Plan
export TF_VAR_github_owner=<owner>
export TF_VAR_github_token=<token>

# Also make sure to setup scaleway-cli or to export the variables
# export SCW_ACCESS_KEY=<access-key>
# export SCW_SECRET_KEY=<secret-key>

# Plan
make tf_plan

# Apply
make tf_appy
```
