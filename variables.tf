variable "name" {
  description = "Github organization name to manage."
  type        = string
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
    bot_encrypted_value = optional(string)
    bot_plaintext_value = optional(string)
    visibility          = string # "all", "private" or "selected"
    repositories        = optional(set(string))
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
    active = optional(bool)
    events = list(string)
    configuration = object({
      url          = string
      content_type = string
      secret       = optional(string)
      insecure_ssl = optional(bool)
    })
  }))
  default     = []
  description = "List of webhook configurations."
}
