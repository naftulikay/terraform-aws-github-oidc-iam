# github-oidc-iam Module - AWS IAM Resources

resource aws_iam_openid_connect_provider default {
  url = var.url
  client_id_list = var.sts_endpoints
  # use the provided thumbprint list if present, otherwise use the detected one, see main.tf
  thumbprint_list = length(var.thumbprint_list) == 0 ? [local.github_oidc_fingerprint] : var.thumbprint_list
  tags = var.tags
}