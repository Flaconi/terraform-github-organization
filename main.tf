resource "github_actions_organization_secret" "this" {
  for_each = var.secrets

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
