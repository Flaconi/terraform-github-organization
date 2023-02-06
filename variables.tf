variable "name" {
  description = "Github organization name to manage."
  type        = string
}

variable "settings" {
  description = "Global organization settings"
  type = object({
    general = object({
      billing_email    = string
      company          = optional(string)
      blog             = optional(string)
      email            = optional(string)
      twitter_username = optional(string)
      location         = optional(string)
      description      = optional(string)
    })
    projects = optional(object({
      organization = optional(bool)
      repository   = optional(bool)
    }))
    repository = optional(object({
      default_permission          = optional(string)
      web_commit_signoff_required = optional(bool)
    }))
    members = optional(object({
      create_repositories          = optional(bool)
      create_public_repositories   = optional(bool)
      create_private_repositories  = optional(bool)
      create_internal_repositories = optional(bool)
      create_pages                 = optional(bool)
      create_public_pages          = optional(bool)
      create_private_pages         = optional(bool)
      fork_private_repositories    = optional(bool)
    }))
    security_for_new_repositories = optional(object({
      advanced_security               = optional(bool)
      dependabot_alerts               = optional(bool)
      dependabot_security_updates     = optional(bool)
      dependency_graph                = optional(bool)
      secret_scanning                 = optional(bool)
      secret_scanning_push_protection = optional(bool)
    }))
  })
  default = null
}

variable "secrets" {
  description = "Global organization secrets"
  type = map(object({
    encrypted_value = optional(string)
    plaintext_value = optional(string)
    visibility      = string # "all", "private" or "selected"
    repositories    = optional(set(string), [])
  }))
  default = {}
}

variable "bot_secrets" {
  description = "Global dependabot secrets"
  type = map(object({
    encrypted_value = optional(string)
    plaintext_value = optional(string)
    visibility      = string # "all", "private" or "selected"
    repositories    = optional(set(string), [])
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
