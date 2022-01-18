# Terraform GitHub Organization module

Terraform module to manage settings of GitHub organization

[![lint](https://github.com/flaconi/terraform-github-organization/workflows/lint/badge.svg)](https://github.com/flaconi/terraform-github-organization/actions?query=workflow%3Alint)
[![test](https://github.com/flaconi/terraform-github-organization/workflows/test/badge.svg)](https://github.com/flaconi/terraform-github-organization/actions?query=workflow%3Atest)
[![Tag](https://img.shields.io/github/tag/flaconi/terraform-github-organization.svg)](https://github.com/flaconi/terraform-github-organization/releases)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Important notice

:warning: This module uses experimental optional attributes.

More about it [here](https://www.terraform.io/language/expressions/type-constraints#experimental-optional-object-type-attributes).

<!-- TFDOCS_HEADER_START -->


<!-- TFDOCS_HEADER_END -->

<!-- TFDOCS_PROVIDER_START -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 4.19.1 |

<!-- TFDOCS_PROVIDER_END -->

<!-- TFDOCS_REQUIREMENTS_START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 4.19.1 |

<!-- TFDOCS_REQUIREMENTS_END -->

<!-- TFDOCS_INPUTS_START -->
## Required Inputs

The following input variables are required:

### <a name="input_token"></a> [token](#input\_token)

Description: Github token to be used for given organization to manage its settings.

Type: `string`

### <a name="input_owner"></a> [owner](#input\_owner)

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

<!-- TFDOCS_INPUTS_END -->

<!-- TFDOCS_OUTPUTS_START -->
## Outputs

No outputs.

<!-- TFDOCS_OUTPUTS_END -->

## License

**[MIT License](LICENSE)**

Copyright (c) 2022 **[Flaconi GmbH](https://github.com/flaconi)**
