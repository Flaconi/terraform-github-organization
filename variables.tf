variable "name" {
  description = "Github organization name to manage."
  type        = string
}

variable "settings" {
  description = "Global organization settings"
  type = object({
    billing_email                                                = string
    company                                                      = optional(string)
    blog                                                         = optional(string)
    email                                                        = optional(string)
    twitter_username                                             = optional(string)
    location                                                     = optional(string)
    description                                                  = optional(string)
    has_organization_projects                                    = optional(bool)
    has_repository_projects                                      = optional(bool)
    default_repository_permission                                = optional(string)
    members_can_create_repositories                              = optional(bool)
    members_can_create_public_repositories                       = optional(bool)
    members_can_create_private_repositories                      = optional(bool)
    members_can_create_internal_repositories                     = optional(bool)
    members_can_create_pages                                     = optional(bool)
    members_can_create_public_pages                              = optional(bool)
    members_can_create_private_pages                             = optional(bool)
    members_can_fork_private_repositories                        = optional(bool)
    web_commit_signoff_required                                  = optional(bool)
    advanced_security_enabled_for_new_repositories               = optional(bool)
    dependabot_alerts_enabled_for_new_repositories               = optional(bool)
    dependabot_security_updates_enabled_for_new_repositories     = optional(bool)
    dependency_graph_enabled_for_new_repositories                = optional(bool)
    secret_scanning_enabled_for_new_repositories                 = optional(bool)
    secret_scanning_push_protection_enabled_for_new_repositories = optional(bool)
  })
  default = null
}

variable "secrets" {
  description = "Global organization secrets"
  type = map(object({
    encrypted_value = optional(string)
    plaintext_value = optional(string)
    visibility      = string # "all", "private" or "selected"
    repositories    = optional(set(string))
  }))
  default = {}
}

variable "bot_secrets" {
  description = "Global dependabot secrets"
  type = map(object({
    encrypted_value = optional(string)
    plaintext_value = optional(string)
    visibility      = string # "all", "private" or "selected"
    repositories    = optional(set(string))
  }))
  default = {}
}

variable "projects" {
  description = "Global organization projects"
  type = list(object({
    name = string
    body = optional(string)
  }))
  default = []
}

variable "webhooks" {
  type = list(object({
    ident  = string # some unique string to identify this webhook
    active = optional(bool, true)
    events = list(string)
    configuration = object({
      url          = string
      content_type = string
      secret       = optional(string)
      insecure_ssl = optional(bool, false)
    })
  }))
  default     = []
  description = "List of webhook configurations."
}
