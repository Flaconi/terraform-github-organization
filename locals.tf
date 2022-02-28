locals {
  projects = { for p in var.projects :
    replace(lower(p["name"]), " ", "-") => p
  }
}
