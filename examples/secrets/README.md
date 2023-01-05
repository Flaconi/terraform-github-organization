# Example

This example will multiple secrets for organization.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 5.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >= 5.13.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_organization"></a> [organization](#module\_organization) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [github_repository.test](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_token"></a> [token](#input\_token) | Github token | `string` | n/a | yes |
| <a name="input_org"></a> [org](#input\_org) | Github organization | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_action_secrets"></a> [action\_secrets](#output\_action\_secrets) | A map of create secret names |
| <a name="output_bot_secrets"></a> [bot\_secrets](#output\_bot\_secrets) | A map of create dependabot secret names |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Copyright (c) 2022 **[Flaconi GmbH](https://github.com/flaconi)**
