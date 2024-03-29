locals {
  projects = { for p in var.projects :
    replace(lower(p["name"]), " ", "-") => p
  }

  # Combine defaults with input parameters
  rendered_webhooks = {
    for v in var.webhooks : v["ident"] => {
      active = v["active"]
      events = v["events"]
      configuration = {
        url          = v["configuration"]["url"]
        content_type = v["configuration"]["content_type"]
        secret       = v["configuration"]["secret"]
        insecure_ssl = v["configuration"]["insecure_ssl"]
      }
    }
  }
}
