resource "github_organization_settings" "this" {
  billing_email                                                = var.settings.billing_email
  company                                                      = var.settings.company
  blog                                                         = var.settings.blog
  email                                                        = var.settings.email
  twitter_username                                             = var.settings.twitter_username
  location                                                     = var.settings.location
  name                                                         = var.settings.name
  description                                                  = var.settings.description
  has_organization_projects                                    = var.settings.has_organization_projects
  has_repository_projects                                      = var.settings.has_repository_projects
  default_repository_permission                                = var.settings.default_repository_permission
  members_can_create_repositories                              = var.settings.members_can_create_repositories
  members_can_create_public_repositories                       = var.settings.members_can_create_public_repositories
  members_can_create_private_repositories                      = var.settings.members_can_create_private_repositories
  members_can_create_internal_repositories                     = var.settings.members_can_create_internal_repositories
  members_can_create_pages                                     = var.settings.members_can_create_pages
  members_can_create_public_pages                              = var.settings.members_can_create_public_pages
  members_can_create_private_pages                             = var.settings.members_can_create_private_pages
  members_can_fork_private_repositories                        = var.settings.members_can_fork_private_repositories
  web_commit_signoff_required                                  = var.settings.web_commit_signoff_required
  advanced_security_enabled_for_new_repositories               = var.settings.advanced_security_enabled_for_new_repositories
  dependabot_alerts_enabled_for_new_repositories               = var.settings.dependabot_alerts_enabled_for_new_repositories
  dependabot_security_updates_enabled_for_new_repositories     = var.settings.dependabot_security_updates_enabled_for_new_repositories
  dependency_graph_enabled_for_new_repositories                = var.settings.dependency_graph_enabled_for_new_repositories
  secret_scanning_enabled_for_new_repositories                 = var.settings.secret_scanning_enabled_for_new_repositories
  secret_scanning_push_protection_enabled_for_new_repositories = var.settings.secret_scanning_push_protection_enabled_for_new_repositories
}

resource "github_actions_organization_secret" "this" {
  for_each = var.secrets

  secret_name             = each.key
  visibility              = each.value.visibility
  encrypted_value         = lookup(each.value, "encrypted_value", null)
  plaintext_value         = lookup(each.value, "plaintext_value", null)
  selected_repository_ids = each.value.visibility == "selected" ? [for r in lookup(each.value, "repositories", []) : data.github_repository.managed[r].repo_id] : []
}

resource "github_dependabot_organization_secret" "this" {
  for_each = var.bot_secrets

  secret_name             = each.key
  visibility              = each.value.visibility
  encrypted_value         = lookup(each.value, "encrypted_value", null)
  plaintext_value         = lookup(each.value, "plaintext_value", null)
  selected_repository_ids = each.value.visibility == "selected" ? [for r in lookup(each.value, "repositories", []) : data.github_repository.managed[r].repo_id] : []
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
