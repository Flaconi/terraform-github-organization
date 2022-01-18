variable "token" {
  description = "Github token to be used for given organization to manage its settings."
  type        = string
}

variable "owner" {
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
