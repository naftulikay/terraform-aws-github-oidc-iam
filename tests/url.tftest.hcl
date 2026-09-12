# github-oidc-iam Module - Tests

mock_provider aws {}

mock_provider tls {
  mock_data tls_certificate {
    defaults = {
      certificates = [
        {
          cert_pem = "-----BEGIN CERTIFICATE-----\nZmFrZS1yb290\n-----END CERTIFICATE-----"
          is_ca = true
          issuer = "CN=Fake Root CA"
          max_path_length = -1
          not_after = "20300101000000Z"
          not_before = "20200101000000Z"
          public_key_algorithm = "RSA"
          serial_number = "01"
          sha1_fingerprint = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
          signature_algorithm = "SHA256-RSA"
          subject = "CN=Fake Root CA"
          version = 3
        }
      ]
    }
  }
}

run rejects_http_url {
  command = plan

  variables {
    url = "http://evil"
  }

  expect_failures = [var.url]
}

run rejects_trailing_slash_url {
  command = plan

  variables {
    url = "https://token.actions.githubusercontent.com/"
  }

  expect_failures = [var.url]
}

run rejects_schemeless_url {
  command = plan

  variables {
    url = "token.actions.githubusercontent.com"
  }

  expect_failures = [var.url]
}

run accepts_default_url {
  command = plan
}
