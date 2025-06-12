# github-oidc-iam Module

locals {
  github_oidc_fingerprint = data.tls_certificate.github_actions.certificates[local.certificate_chain_index].sha1_fingerprint

  # as per AWS docs, choose the top-most _intermediate_ certificate if possible, otherwise choose the root certificate
  # https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html
  certificate_chain_count = length(data.tls_certificate.github_actions.certificates)
  certificate_chain_index = local.certificate_chain_count >= 3 ? 1 : 0
}