output "settings" {
  description = "Organization settings"
  value       = try(github_organization_settings.this[0], null)
}

output "secrets" {
  description = "A map of create secret names"
  value = {
    for name, secret in github_actions_organization_secret.this : name => {
      created = secret.created_at
      updated = secret.updated_at
    }
  }
}

output "bot_secrets" {
  description = "A map of create dependabot secret names"
  value = {
    for name, secret in github_dependabot_organization_secret.this : name => {
      created = secret.created_at
      updated = secret.updated_at
    }
  }
}

output "webhook_urls" {
  description = "Webhook URLs"
  value       = { for k, v in github_organization_webhook.this : k => v.url }
}
