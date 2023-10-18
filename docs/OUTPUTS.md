# Outputs

 - [Module Docs: README](/README.md)
 - [Module Docs: Resources](/docs/RESOURCES.md)
 - [Module Docs: Variables](/docs/VARIABLES.md)
 - [Module Docs: Outputs](/docs/OUTPUTS.md)

This module produces the following outputs:

## `oidc_provider_arn`: `string`

The ARN for the created `aws_iam_openid_connect_provider` resource.

## `oidc_provider_client_ids`: `list(string)`

The list of OIDC client ids from the `aws_iam_openid_connect_provider` resource.

This is a direct output, and is not a reflection of input variables.

## `oidc_provider_thumbprints`: `list(string)`

The list of OIDC thumbprints from the `aws_iam_openid_connect_provider` resource.

This is a direct output, and is not a reflection of input variables.

## `oidc_provider_url`: `string`

The URL of the `aws_iam_openid_connect_provider` resource.

This is a direct output, and is not a reflection of input variables.

## `server_cert_sha1`: `string`

The SHA-1 fingerprint of the final TLS certificate in the chain obtained from `var.url`.

## `sts_endpoints`: `set(string)`

The value of the `sts_endpoints` variable.

## `tags`: `map(string)`

The value of the `tags` variable.

## `thumbprint_list`: `set(string)`

The value of the `thumbprint_list` variable.

## `url`: `string`

The value of the `url` variable.