# terraform-aws-github-oidc-iam [![Build Status][build.svg]][build] [![Module][module.svg]][module]

A Terraform module for AWS which sets up an IAM OpenID Connect Provider for GitHub and GitHub Actions.

 - [Module Docs: Resources](/docs/RESOURCES.md)
 - [Module Docs: Variables](/docs/VARIABLES.md)
 - [Module Docs: Outputs](/docs/OUTPUTS.md)

## Usage

This module should work out-of-the-box with no configuration required, unless one or more of the following cases hold
true for your use-case:

 1. You are running in GovCloud or in China.
 2. You are using GitHub Enterprise.

If either of these cases are true, consult the [variable docs](/docs/VARIABLES.md) to determine what variables need
to be modified.

### Terraform

To use the OIDC provider in an IAM assume role policy, the following code can be used to create the OIDC provider,
generate a role assumption policy, and create an IAM role without any permissions:

```terraform
# create the github actions oidc iam provider
module github_oidc_iam {
  source  = "naftulikay/github-oidc-iam/aws"
  version = "1.0.0"
}

# TODO set these to your GitHub org and repo name
variable github_organization { default = "my-org" }
variable github_repository { default = "my-repo" }

# create a role-assumption policy for our new role
data aws_iam_policy_document assume {
  statement {
    sid = "AllowAssumeFromGitHubActions"
    effect = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [module.github_oidc_iam.oidc_provider_arn]
    }

    condition {
      # allow github oidc to access sts.amazonaws.com to get temporary credentials for the IAM role
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = module.github_oidc_iam.sts_endpoints
    }

    condition {
      test = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      # allow any github actions in any branch in https://github.com/${var.github_organization}/${var.github_repository}
      # to assume this role
      values = ["repo:${var.github_organization}/${var.github_repository}:*"]
    }
  }
}

resource aws_iam_role default {
  name = "my-github-actions-role"
  path = "/"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}
```

The above code will allow any action in `"${var.github_organization}/${var.github_repository}` to assume 
`my-github-actions-role`. You **will** need to attach a policy to the role to grant any access to resources as per
usual.

> **NOTE**: You will only need **one** OIDC provider for GitHub Actions for your entire AWS account. If you have
> multiple accounts, create one per account to grant access.

### GitHub Actions

To test the role assumption in GitHub Actions, the following simple workflow file can demonstrate that the role can, in
fact, be assumed:

```yaml
---
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch: {}

# necessary to allow read/write of a temporary JWT token for the repository in the action run
permissions:
  id-token: write
  contents: read

jobs:
  auth:
    runs-on: ubuntu-latest
    steps:
      - uses: aws-actions/configure-aws-credentials@v4
        with:
          # set to the appropriate region
          aws-region: us-east-2
          # set to the arn of the role you'd like to assume
          role-to-assume: arn:aws:iam::MY_NUMERIC_AWS_ACCOUNT_ID:role/my-github-actions-role
```

Run this workflow, and if the run succeeds, everything has been setup properly.

## Additional Documentation

Figuring out how to tie all of this together was non-trivial, but I created this module after I got it working.

Here are some links to additional documentation I used in the creation of this module:

 - GitHub Actions Docs: [Configuring OpenID Connect in Amazon Web Services](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
 - AWS Docs: [Creating OpenID Connect (OIDC) Identity Providers](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)
 - AWS Docs: [Obtaining the thumbprint for an OpenID Connect Identity Provider](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html)
 - AWS Action for Configuring Credentials: [aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials#OIDC)

## License

Licensed at your discretion under either:

 - [Apache Software License, Version 2.0](./LICENSE-APACHE)
 - [MIT License](./LICENSE-MIT)

 [build]:     https://github.com/naftulikay/terraform-aws-github-oidc-iam/actions/workflows/terraform.yml
 [build.svg]: https://github.com/naftulikay/terraform-aws-github-oidc-iam/actions/workflows/terraform.yml/badge.svg
 [module]:     https://registry.terraform.io/modules/naftulikay/github-oidc-iam/aws/latest
 [module.svg]: https://img.shields.io/badge/terraform-module-purple
