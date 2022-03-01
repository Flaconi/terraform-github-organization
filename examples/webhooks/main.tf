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

  webhooks = [
    {
      ident  = "google"
      events = ["issues"]
      configuration = {
        url          = "https://google.de/"
        content_type = "form"
        insecure_ssl = false
      }
    },
    {
      ident  = "github"
      active = false
      events = ["pull_request", "release"]
      configuration = {
        url          = "https://github.com/"
        content_type = "json"
        secret       = "SOME-VERY-SECRET-STRING"
      }
    }
  ]
}

output "webhooks" {
  description = "A map of create webhook URLs"
  value       = module.organization.webhook_urls
}
