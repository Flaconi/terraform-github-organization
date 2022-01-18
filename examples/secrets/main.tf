variable "token" {
  description = "Github token token"
  type        = string
}

variable "org" {
  description = "Github organization"
  type        = string
}

module "organization" {
  source = "../../"
  token  = var.token
  owner  = var.org

  secrets = {
    TEST_SECRET = {
      visibility = "all"
    },
    SOME_PLAIN_TEXT_SECRET = {
      plaintext_value = "some_secret"
      visibility      = "private"
    }
    ENCRYPTED_SECRET = {
      # Value encrypted with organization public key
      # Public key: https://docs.github.com/en/rest/reference/actions#get-an-organization-public-key
      # Ecnryption: https://docs.github.com/en/rest/reference/actions#create-or-update-an-organization-secret
      encrypted_value = "P1wD+Byzy0JvL77qILs1gLj1wpDIDYIKGcHJbuILlTq3lNLgxDQuHXLVYknj2nx6uaeNGx3AmgsO+Nak"
      visibility      = "selected"
      repositories    = ["test-repostiory"]
    }
  }
}

output "secrets" {
  description = "A map of create secret names"
  value       = module.organization.secrets
}
