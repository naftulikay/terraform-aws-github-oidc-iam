# Resources

 - [Module Docs: README](/README.md)
 - [Module Docs: Resources](/docs/RESOURCES.md)
 - [Module Docs: Variables](/docs/VARIABLES.md)
 - [Module Docs: Outputs](/docs/OUTPUTS.md)

This module creates the following resources:

## `aws_iam_openid_connect_provider.default`

This resource will be created with the following arguments: 

 - [`url`][arg-url] will be set to the GitHub Actions OIDC URL, which is `https://token.actions.githubusercontent.com`.
 - [`client_id_list`][arg-client-id] will be set to a list containing `sts.amazonaws.com`, which is the default host for
   AWS' **S**ecurity **T**oken **S**ervice.
 - [`tags`][arg-tags] will be set to the value of `var.tags`.
 - [`thumbprint_list`][arg-thumbprint-list] will be set to a single-entry list containing the SHA-1 TLS certificate
   fingerprint for `token.actions.githubusercontent.com`, which is detected dynamically.

These arguments can be reconfigured using [module variables](/docs/VARIABLES.md).

 [arg-client-id]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider#client_id_list
 [arg-tags]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider#tags
 [arg-thumbprint-list]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider#thumbprint_list
 [arg-url]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider#url