variable "token" {
  description = "Github token"
  type        = string
}

variable "org" {
  description = "Github organization"
  type        = string
}

provider "github" {
  token = var.token
  owner = var.org
}

resource "github_repository" "test" {
  name = "test-repository"

  visibility = "private"
}

module "organization" {
  source = "../../"
  name   = var.org

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
      repositories    = [github_repository.test.name]
    }
  }
  bot_secrets = {
    TEST_SECRET = {
      visibility = "all"
    },
    BOT_PLAIN_TEXT_SECRET = {
      bot_plaintext_value = "other_secret"
      visibility          = "private"
    }
    ENCRYPTED_SECRET = {
      # Value encrypted with organization public key
      # Public key: https://docs.github.com/en/rest/reference/actions#get-an-organization-public-key
      # Ecnryption: https://docs.github.com/en/rest/reference/actions#create-or-update-an-organization-secret
      bot_encrypted_value = "P1wD+Byzy0JvL77qILs1gLj1wpDIDYIKGcHJbuILlTq3lNLgxDQuHXLVYknj2nx6uaeNGx3AmgsO+Nak"
      visibility          = "selected"
      repositories        = [github_repository.test.name]
    }
  }

  depends_on = [github_repository.test]
}

output "action_secrets" {
  description = "A map of create secret names"
  value       = module.organization.secrets
}

output "bot_secrets" {
  description = "A map of create dependabot secret names"
  value       = module.organization.bot_secrets
}
