resource "github_organization_settings" "this" {
  count = var.settings != null ? 1 : 0

  name = var.settings["general"]["display_name"] != null ? var.settings["general"]["display_name"] : var.name

  billing_email    = var.settings["general"]["billing_email"]
  company          = var.settings["general"]["company"]
  blog             = var.settings["general"]["blog"]
  email            = var.settings["general"]["email"]
  twitter_username = var.settings["general"]["twitter_username"]
  location         = var.settings["general"]["location"]
  description      = var.settings["general"]["description"]

  has_organization_projects = var.settings["projects"]["organization"]
  has_repository_projects   = var.settings["projects"]["repository"]

  default_repository_permission = var.settings["repository"]["default_permission"]
  web_commit_signoff_required   = var.settings["repository"]["web_commit_signoff_required"]

  members_can_create_repositories          = var.settings["members"]["create_repositories"]
  members_can_create_public_repositories   = var.settings["members"]["create_public_repositories"]
  members_can_create_private_repositories  = var.settings["members"]["create_private_repositories"]
  members_can_create_internal_repositories = var.settings["members"]["create_internal_repositories"]
  members_can_create_pages                 = var.settings["members"]["create_pages"]
  members_can_create_public_pages          = var.settings["members"]["create_public_pages"]
  members_can_create_private_pages         = var.settings["members"]["create_private_pages"]
  members_can_fork_private_repositories    = var.settings["members"]["fork_private_repositories"]

  advanced_security_enabled_for_new_repositories               = var.settings["security_for_new_repositories"]["advanced_security"]
  dependabot_alerts_enabled_for_new_repositories               = var.settings["security_for_new_repositories"]["dependabot_alerts"]
  dependabot_security_updates_enabled_for_new_repositories     = var.settings["security_for_new_repositories"]["dependabot_security_updates"]
  dependency_graph_enabled_for_new_repositories                = var.settings["security_for_new_repositories"]["dependency_graph"]
  secret_scanning_enabled_for_new_repositories                 = var.settings["security_for_new_repositories"]["secret_scanning"]
  secret_scanning_push_protection_enabled_for_new_repositories = var.settings["security_for_new_repositories"]["secret_scanning_push_protection"]
}

resource "github_actions_organization_secret" "this" {
  for_each = var.secrets

  secret_name             = each.key
  visibility              = each.value.visibility
  encrypted_value         = lookup(each.value, "encrypted_value", null)
  plaintext_value         = lookup(each.value, "plaintext_value", null)
  selected_repository_ids = each.value.visibility == "selected" ? [for r in each.value["repositories"] : data.github_repository.managed[r].repo_id] : []
}

resource "github_dependabot_organization_secret" "this" {
  for_each = var.bot_secrets

  secret_name             = each.key
  visibility              = each.value.visibility
  encrypted_value         = lookup(each.value, "encrypted_value", null)
  plaintext_value         = lookup(each.value, "plaintext_value", null)
  selected_repository_ids = each.value.visibility == "selected" ? [for r in each.value["repositories"] : data.github_repository.managed[r].repo_id] : []
}


resource "github_organization_project" "this" {
  for_each = local.projects

  name = each.value["name"]
  body = each.value["body"]
}

resource "github_organization_webhook" "this" {
  for_each = local.rendered_webhooks

  active = each.value["active"]
  events = each.value["events"]

  configuration {
    url          = each.value["configuration"]["url"]
    content_type = each.value["configuration"]["content_type"]
    secret       = each.value["configuration"]["secret"]
    insecure_ssl = each.value["configuration"]["insecure_ssl"]
  }
}
