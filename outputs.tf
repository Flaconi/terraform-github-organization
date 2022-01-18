output "secrets" {
  description = "A map of create secret names"
  value = {
    for name, secret in github_actions_organization_secret.this : name => {
      created = secret.created_at
      updated = secret.updated_at
    }
  }
}