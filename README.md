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
| <a name="provider_github"></a> [github](#provider\_github) | >= 5.13.0 |

<!-- TFDOCS_PROVIDER_END -->

<!-- TFDOCS_REQUIREMENTS_START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 5.13.0 |

<!-- TFDOCS_REQUIREMENTS_END -->

<!-- TFDOCS_INPUTS_START -->
## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: Github organization name to manage.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_secrets"></a> [secrets](#input\_secrets)

Description: Global organization secrets

Type:

```hcl
map(object({
    encrypted_value = optional(string)
    plaintext_value = optional(string)
    visibility      = string # "all", "private" or "selected"
    repositories    = optional(set(string))
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
    repositories    = optional(set(string))
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
      content_type = string
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
| <a name="output_webhook_urls"></a> [webhook\_urls](#output\_webhook\_urls) | Webhook URLs |

<!-- TFDOCS_OUTPUTS_END -->

## License

**[MIT License](LICENSE)**

Copyright (c) 2022 **[Flaconi GmbH](https://github.com/flaconi)**
