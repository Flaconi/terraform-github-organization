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
    billing_email    = "test@example.com"
    company          = "Test Company"
    blog             = "https://example.com"
    email            = "test@example.com"
    twitter_username = "Test"
    location         = "Test Location"
    name             = "Test Name"
  }
}

output "projects" {
  description = "Organization settings"
  value       = module.organization.settings
}
