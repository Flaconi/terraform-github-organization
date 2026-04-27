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
      value      = "test_secret"
      visibility = "all"
    },
    SOME_PLAIN_TEXT_SECRET = {
      value      = "some_secret"
      visibility = "private"
    }
    ENCRYPTED_SECRET = {
      # Value encrypted with organization public key
      # Public key: https://docs.github.com/en/rest/actions/secrets?apiVersion=2026-03-10#get-an-organization-public-key
      # Encryption: https://docs.github.com/en/rest/guides/encrypting-secrets-for-the-rest-api?apiVersion=2026-03-10
      value_encrypted = "9kDPWbJ2FhSAE0XPqTHS4Ueno8wWoJIAPYlayvY583lc+l2olynOFL+GOpPO5JZlEHAPUVTA5hiKJo/794MISQ=="
      visibility      = "selected"
      repositories    = [github_repository.test.name]
    }
  }
  bot_secrets = {
    TEST_SECRET = {
      value      = "test_secret"
      visibility = "all"
    },
    BOT_PLAIN_TEXT_SECRET = {
      value      = "other_secret"
      visibility = "private"
    }
    ENCRYPTED_SECRET = {
      # Value encrypted with organization public key
      # Public key: https://docs.github.com/en/rest/dependabot/secrets?apiVersion=2026-03-10#get-an-organization-public-key
      # Encryption: https://docs.github.com/en/rest/guides/encrypting-secrets-for-the-rest-api?apiVersion=2026-03-10
      value_encrypted = "cUptE62ZyXD2QYDLoz7w2UrQ2AebMoKArEc4QHs3Mz4DsByV7AyUlWhnt/drYJj+GPUshLav4DAo8sm1SF+Ixw=="
      visibility      = "selected"
      repositories    = [github_repository.test.name]
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
