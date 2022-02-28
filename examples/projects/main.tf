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

  projects = [
    {
      name = "My first project"
    },
    {
      name = "An Organization Project"
      body = "This is an organization project."
    }
  ]
}

output "projects" {
  description = "A map of create secret names"
  value       = module.organization.projects
}
