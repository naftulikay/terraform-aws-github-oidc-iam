# github-oidc-iam Module

locals {
  # the sha-1 fingerprint for the final certificate in the chain for the server at var.url
  github_oidc_fingerprint = data.tls_certificate.github_actions.certificates[0].sha1_fingerprint
}