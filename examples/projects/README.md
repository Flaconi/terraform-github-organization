# Example

This example will multiple secrets for organization.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 5.13.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_organization"></a> [organization](#module\_organization) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_token"></a> [token](#input\_token) | Github token | `string` | n/a | yes |
| <a name="input_org"></a> [org](#input\_org) | Github organization | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_projects"></a> [projects](#output\_projects) | A list of create projects |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Copyright (c) 2022 **[Flaconi GmbH](https://github.com/flaconi)**
