locals {
  projects = { for p in var.projects :
    replace(lower(p["name"]), " ", "-") => p
  }

  # These settings are default for webhooks
  webhook_defaults = {
    active = true
    configuration = {
      insecure_ssl = false
    }
  }
  # Combine defaults with input parameters
  rendered_webhooks = {
    for v in var.webhooks : v["ident"] => {
      active = v["active"] != null ? v["active"] : local.webhook_defaults["active"]
      events = v["events"]
      configuration = {
        url          = v["configuration"]["url"]
        content_type = v["configuration"]["content_type"]
        secret       = v["configuration"]["secret"]
        insecure_ssl = v["configuration"]["insecure_ssl"] != null ? v["configuration"]["insecure_ssl"] : local.webhook_defaults["configuration"]["insecure_ssl"]
      }
    }
  }
}
