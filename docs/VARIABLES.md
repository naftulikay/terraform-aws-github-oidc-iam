# Variables

 - [Module Docs: README](/README.md)
 - [Module Docs: Resources](/docs/RESOURCES.md)
 - [Module Docs: Variables](/docs/VARIABLES.md)
 - [Module Docs: Outputs](/docs/OUTPUTS.md)

This module has the following variables:

## `sts_endpoints`: `set(string)`

A set of hostnames for Amazon's **S**ecurity **T**oken **S**ervice.

Unless you are in GovCloud or China, you should not need to change this value from its default.

> **Default**: `["sts.amazonaws.com"]`

## `tags`: `map(string)`

AWS tags to apply to the created `aws_iam_openid_connect_provider`.

Setting tags can also be done at the provider-level using `default_tags`.

> **Default**: `{}` (empty dictionary)

## `thumbprint_list`: `set(string)`

A set of thumbprints by which to verify OIDC access attempts.

By default, this variable is set to an empty set, and when this is the case, this will be detected at runtime using the
[`tls` provider's][tls-provider] [`tls_certificate`][tf-tls-certificate] data provider, grabbing the SHA-1 fingerprint
of the top-most intermediate CA certificate located at `url`.

Changing this to any other value will use the user-specified values. This is entirely untested, and if you aren't using
GitHub Enterprise, you shouldn't change/set this variable.

See the AWS documentation on this topic:
- https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html

> **Default**: `[]` (empty set)

## `url`: `string`

The URL of the GitHub Actions OIDC provider.

You shouldn't need to modify the value of this variable unless you are using GitHub Enterpise. Support for GitHub
Enterprise is entirely untested.

> **Default**: `https://token.actions.githubusercontent.com`

 [tls-provider]: https://registry.terraform.io/providers/hashicorp/tls/latest/docs
 [tf-tls-certificate]: https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate