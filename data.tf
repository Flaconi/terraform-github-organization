data "github_organization" "this" {
  name = var.owner
}

data "github_repository" "managed" {
  for_each  = toset(flatten([for k, v in var.secrets : v.repositories if v.repositories != null]))
  full_name = "${var.owner}/${each.value}"
}
