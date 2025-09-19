# Terraform GitHub Organization module

Terraform module to manage settings of GitHub organization

[![lint](https://github.com/flaconi/terraform-github-organization/workflows/lint/badge.svg)](https://github.com/flaconi/terraform-github-organization/actions?query=workflow%3Alint)
[![test](https://github.com/flaconi/terraform-github-organization/workflows/test/badge.svg)](https://github.com/flaconi/terraform-github-organization/actions?query=workflow%3Atest)
[![Tag](https://img.shields.io/github/tag/flaconi/terraform-github-organization.svg)](https://github.com/flaconi/terraform-github-organization/releases)
[![Terraform](https://img.shields.io/badge/Terraform--registry-github--organization-brightgreen.svg)](https://registry.terraform.io/modules/Flaconi/organization/github/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

<!-- TFDOCS_HEADER_START -->


<!-- TFDOCS_HEADER_END -->

<!-- TFDOCS_PROVIDER_START -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.6 |

<!-- TFDOCS_PROVIDER_END -->

<!-- TFDOCS_REQUIREMENTS_START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.6 |

<!-- TFDOCS_REQUIREMENTS_END -->

<!-- TFDOCS_INPUTS_START -->
## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: Github organization name to manage.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_settings"></a> [settings](#input\_settings)

Description: Global organization settings

Type:

```hcl
object({
    general = object({
      billing_email    = string
      display_name     = optional(string)
      company          = optional(string)
      blog             = optional(string)
      email            = optional(string)
      twitter_username = optional(string)
      location         = optional(string)
      description      = optional(string)
    })
    projects = optional(object({
      organization = optional(bool, true)
      repository   = optional(bool, true)
    }), {})
    repository = optional(object({
      default_permission          = optional(string, "read")
      web_commit_signoff_required = optional(bool, false)
    }), {})
    members = optional(object({
      create_repositories          = optional(bool, true)
      create_public_repositories   = optional(bool, true)
      create_private_repositories  = optional(bool, true)
      create_internal_repositories = optional(bool, true)
      create_pages                 = optional(bool, true)
      create_public_pages          = optional(bool, true)
      create_private_pages         = optional(bool, true)
      fork_private_repositories    = optional(bool, false)
    }), {})
    security_for_new_repositories = optional(object({
      advanced_security               = optional(bool, false)
      dependabot_alerts               = optional(bool, false)
      dependabot_security_updates     = optional(bool, false)
      dependency_graph                = optional(bool, false)
      secret_scanning                 = optional(bool, false)
      secret_scanning_push_protection = optional(bool, false)
    }), {})
  })
```

Default: `null`

### <a name="input_secrets"></a> [secrets](#input\_secrets)

Description: Global organization secrets

Type:

```hcl
map(object({
    encrypted_value = optional(string)
    plaintext_value = optional(string)
    visibility      = string # "all", "private" or "selected"
    repositories    = optional(set(string), [])
  }))
```

Default: `{}`

### <a name="input_bot_secrets"></a> [bot\_secrets](#input\_bot\_secrets)

Description: Global dependabot secrets

Type:

```hcl
map(object({
    encrypted_value = optional(string)
    plaintext_value = optional(string)
    visibility      = string # "all", "private" or "selected"
    repositories    = optional(set(string), [])
  }))
```

Default: `{}`

### <a name="input_projects"></a> [projects](#input\_projects)

Description: Global organization projects

Type:

```hcl
list(object({
    name = string
    body = optional(string)
  }))
```

Default: `[]`

### <a name="input_webhooks"></a> [webhooks](#input\_webhooks)

Description: List of webhook configurations.

Type:

```hcl
list(object({
    ident  = string # some unique string to identify this webhook
    active = optional(bool, true)
    events = list(string)
    configuration = object({
      url          = string
      content_type = optional(string, "json")
      secret       = optional(string)
      insecure_ssl = optional(bool, false)
    })
  }))
```

Default: `[]`

<!-- TFDOCS_INPUTS_END -->

<!-- TFDOCS_OUTPUTS_START -->
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bot_secrets"></a> [bot\_secrets](#output\_bot\_secrets) | A map of create dependabot secret names |
| <a name="output_projects"></a> [projects](#output\_projects) | A list of created projects |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | A map of create secret names |
| <a name="output_settings"></a> [settings](#output\_settings) | Organization settings |
| <a name="output_webhook_urls"></a> [webhook\_urls](#output\_webhook\_urls) | Webhook URLs |

<!-- TFDOCS_OUTPUTS_END -->

## License

**[MIT License](LICENSE)**

Copyright (c) 2022-2025 **[Flaconi GmbH](https://github.com/flaconi)**
