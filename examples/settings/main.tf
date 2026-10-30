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

module "organization" {
  source = "../../"
  name   = var.org

  settings = {
    general = {
      billing_email    = "test@example.com"
      company          = "Test Company"
      blog             = "https://example.com"
      email            = "test@example.com"
      twitter_username = "Test"
      location         = "Test Location"
    }
  }

  workflow_permissions = {
    default_workflow_permissions     = "read"
    can_approve_pull_request_reviews = false
  }
}

output "projects" {
  description = "Organization settings"
  value       = module.organization.settings
}
