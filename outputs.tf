output "secrets" {
  description = "A map of create secret names"
  value = {
    for name, secret in github_actions_organization_secret.this : name => {
      created = secret.created_at
      updated = secret.updated_at
    }
  }
}

output "projects" {
  description = "A list of created projects"
  value = [
    for id, project in github_organization_project.this : {
      name = project.name
      url  = project.url
    }
  ]
}
