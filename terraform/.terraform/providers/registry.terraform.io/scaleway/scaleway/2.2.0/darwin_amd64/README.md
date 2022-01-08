# Scaleway Terraform Provider

- [Provider Documentation Website](https://www.terraform.io/docs/providers/scaleway/index.html)
- [![Gitter chat](https://badges.gitter.im/hashicorp-terraform/Lobby.png)](https://gitter.im/hashicorp-terraform/Lobby)
- Mailing list: [Google Groups](http://groups.google.com/group/terraform-tool)
- Slack: [Scaleway-community Slack][slack-scaleway] ([#terraform][slack-terraform])

[slack-scaleway]: https://slack.scaleway.com/
[slack-terraform]: https://scaleway-community.slack.com/app_redirect?channel=terraform

<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" width="600px">

## Requirements

-	[Terraform](https://www.terraform.io/downloads.html) 0.10.x
-	[Go](https://golang.org/doc/install) 1.11 (to build the provider plugin)

## Building The Provider

Clone repository to: `$GOPATH/src/github.com/scaleway/terraform-provider-scaleway`

```sh
$ mkdir -p $GOPATH/src/github.com/scaleway; cd $GOPATH/src/github.com/scaleway
$ git clone git@github.com:scaleway/terraform-provider-scaleway.git
```

Enter the provider directory and build the provider

```sh
$ cd $GOPATH/src/github.com/scaleway/terraform-provider-scaleway
$ make build
```

## Using the provider

See the [Scaleway Provider Documentation](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs) to get started using the Scaleway provider.

## Developing the Provider

If you wish to work on the provider, you'll first need [Go](http://www.golang.org) installed on your machine (version 1.13+ is *required*). You'll also need to correctly setup a [GOPATH](http://golang.org/doc/code.html#GOPATH), as well as adding `$GOPATH/bin` to your `$PATH`.

To compile the provider, run `make build`. This will build the provider and put the provider binary in the `$GOPATH/bin` directory.

```sh
$ make build
...
$ $GOPATH/bin/terraform-provider-scaleway
...
```

Please refer to the [TESTING.md](TESTING.md) for testing.
