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

run client_ids_and_default_thumbprint {
  command = apply

  assert {
    condition = output.oidc_provider_client_ids == toset(["sts.amazonaws.com"])
    error_message = "expected client_id_list to contain only sts.amazonaws.com"
  }

  assert {
    condition = length(output.oidc_provider_thumbprints) == 1
    error_message = "expected exactly one thumbprint by default"
  }
}
