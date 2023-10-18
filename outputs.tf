# github-oidc-iam Module - Outputs

output oidc_provider_arn {
  value = aws_iam_openid_connect_provider.default.arn
}

output oidc_provider_client_ids {
  value = aws_iam_openid_connect_provider.default.client_id_list
}

output oidc_provider_thumbprints {
  value = aws_iam_openid_connect_provider.default.thumbprint_list
}

output oidc_provider_url {
  value = aws_iam_openid_connect_provider.default.url
}

output server_cert_sha1 {
  value = local.github_oidc_fingerprint
}

output sts_endpoints {
  value = var.sts_endpoints
}

output tags {
  value = var.tags
}

output thumbprint_list {
  value = var.thumbprint_list
}

output url {
  value = var.url
}