# github-oidc-iam Module - Tests

mock_provider aws {}

mock_provider tls {}

run single_cert_chain_uses_root {
  command = plan

  override_data {
    target = data.tls_certificate.github_actions
    values = {
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

  assert {
    condition = output.oidc_server_cert_sha1 == "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    error_message = "expected the root certificate fingerprint for a single-certificate chain"
  }
}

run two_cert_chain_uses_root {
  command = plan

  override_data {
    target = data.tls_certificate.github_actions
    values = {
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
        },
        {
          cert_pem = "-----BEGIN CERTIFICATE-----\nZmFrZS1sZWFm\n-----END CERTIFICATE-----"
          is_ca = false
          issuer = "CN=Fake Root CA"
          max_path_length = 0
          not_after = "20300101000000Z"
          not_before = "20200101000000Z"
          public_key_algorithm = "RSA"
          serial_number = "04"
          sha1_fingerprint = "dddddddddddddddddddddddddddddddddddddddd"
          signature_algorithm = "SHA256-RSA"
          subject = "CN=fake.example.com"
          version = 3
        }
      ]
    }
  }

  assert {
    condition = output.oidc_server_cert_sha1 == "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    error_message = "expected the root certificate fingerprint for a two-certificate chain"
  }
}

run three_cert_chain_uses_top_intermediate {
  command = plan

  override_data {
    target = data.tls_certificate.github_actions
    values = {
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
        },
        {
          cert_pem = "-----BEGIN CERTIFICATE-----\nZmFrZS1pbnRlcm1lZGlhdGU=\n-----END CERTIFICATE-----"
          is_ca = true
          issuer = "CN=Fake Root CA"
          max_path_length = 0
          not_after = "20300101000000Z"
          not_before = "20200101000000Z"
          public_key_algorithm = "RSA"
          serial_number = "02"
          sha1_fingerprint = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
          signature_algorithm = "SHA256-RSA"
          subject = "CN=Fake Intermediate CA"
          version = 3
        },
        {
          cert_pem = "-----BEGIN CERTIFICATE-----\nZmFrZS1sZWFm\n-----END CERTIFICATE-----"
          is_ca = false
          issuer = "CN=Fake Intermediate CA"
          max_path_length = 0
          not_after = "20300101000000Z"
          not_before = "20200101000000Z"
          public_key_algorithm = "RSA"
          serial_number = "04"
          sha1_fingerprint = "dddddddddddddddddddddddddddddddddddddddd"
          signature_algorithm = "SHA256-RSA"
          subject = "CN=fake.example.com"
          version = 3
        }
      ]
    }
  }

  assert {
    condition = output.oidc_server_cert_sha1 == "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    error_message = "expected the top-most intermediate certificate fingerprint for a three-certificate chain"
  }
}

run four_cert_chain_uses_top_intermediate {
  command = plan

  override_data {
    target = data.tls_certificate.github_actions
    values = {
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
        },
        {
          cert_pem = "-----BEGIN CERTIFICATE-----\nZmFrZS1pbnRlcm1lZGlhdGU=\n-----END CERTIFICATE-----"
          is_ca = true
          issuer = "CN=Fake Root CA"
          max_path_length = 1
          not_after = "20300101000000Z"
          not_before = "20200101000000Z"
          public_key_algorithm = "RSA"
          serial_number = "02"
          sha1_fingerprint = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
          signature_algorithm = "SHA256-RSA"
          subject = "CN=Fake Intermediate CA"
          version = 3
        },
        {
          cert_pem = "-----BEGIN CERTIFICATE-----\nZmFrZS1pbnRlcm1lZGlhdGUtMgo=\n-----END CERTIFICATE-----"
          is_ca = true
          issuer = "CN=Fake Intermediate CA"
          max_path_length = 0
          not_after = "20300101000000Z"
          not_before = "20200101000000Z"
          public_key_algorithm = "RSA"
          serial_number = "03"
          sha1_fingerprint = "cccccccccccccccccccccccccccccccccccccccc"
          signature_algorithm = "SHA256-RSA"
          subject = "CN=Fake Intermediate CA 2"
          version = 3
        },
        {
          cert_pem = "-----BEGIN CERTIFICATE-----\nZmFrZS1sZWFm\n-----END CERTIFICATE-----"
          is_ca = false
          issuer = "CN=Fake Intermediate CA 2"
          max_path_length = 0
          not_after = "20300101000000Z"
          not_before = "20200101000000Z"
          public_key_algorithm = "RSA"
          serial_number = "04"
          sha1_fingerprint = "dddddddddddddddddddddddddddddddddddddddd"
          signature_algorithm = "SHA256-RSA"
          subject = "CN=fake.example.com"
          version = 3
        }
      ]
    }
  }

  assert {
    condition = output.oidc_server_cert_sha1 == "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    error_message = "expected the top-most intermediate certificate fingerprint for a four-certificate chain"
  }
}
