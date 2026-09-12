# github-oidc-iam Module - Terraform Provider Configuration

terraform {
  required_version = "~> 1"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
