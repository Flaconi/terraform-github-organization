data "github_organization" "this" {
  name = var.name
}

data "github_repository" "managed" {
  for_each = toset(distinct(flatten(concat(
    [for k, v in var.secrets : v.repositories],
    [for k, v in var.bot_secrets : v.repositories],
  ))))
  full_name = "${data.github_organization.this.login}/${each.value}"
}
