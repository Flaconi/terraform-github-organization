variable "name" {
  description = "Github organization name to manage."
  type        = string
}

variable "settings" {
  description = "Global organization settings"
  type = object({
    general = object({
      billing_email    = string
      display_name     = optional(string)
      company          = optional(string)
      blog             = optional(string)
      email            = optional(string)
      twitter_username = optional(string)
      location         = optional(string)
      description      = optional(string)
    })
    projects = optional(object({
      organization = optional(bool, true)
      repository   = optional(bool, true)
    }), {})
    repository = optional(object({
      default_permission          = optional(string, "read")
      web_commit_signoff_required = optional(bool, false)
    }), {})
    members = optional(object({
      create_repositories          = optional(bool, true)
      create_public_repositories   = optional(bool, true)
      create_private_repositories  = optional(bool, true)
      create_internal_repositories = optional(bool, true)
      create_pages                 = optional(bool, true)
      create_public_pages          = optional(bool, true)
      create_private_pages         = optional(bool, true)
      fork_private_repositories    = optional(bool, false)
    }), {})
    security_for_new_repositories = optional(object({
      advanced_security               = optional(bool, false)
      dependabot_alerts               = optional(bool, false)
      dependabot_security_updates     = optional(bool, false)
      dependency_graph                = optional(bool, false)
      secret_scanning                 = optional(bool, false)
      secret_scanning_push_protection = optional(bool, false)
    }), {})
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
