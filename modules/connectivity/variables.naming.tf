# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name"
  type        = string
  default     = ""
}

variable "use_naming" {
  description = "Use the Azure NoOps naming provider to generate default resource name. `storage_account_custom_name` override this if set. Legacy default name is used if this is set to `false`."
  type        = bool
  default     = true
}

variable "use_location_short_name" {
  description = "Use short location name for resources naming (ie eastus -> eus). Default is true. If set to false, the full cli location name will be used. if custom naming is set, this variable will be ignored."
  type        = bool
  default     = true
}

variable "deploy_environment" {
  description = "Name of the workload's environnement"
  type        = string
}

# Custom naming override
variable "custom_resource_group_name" {
  description = "The name of the custom resource group to create. If not set, the name will be generated using the `root_id`, `workload_name`, `deploy_environment` and `environment` variables."
  type        = string
  default     = null
}

variable "storage_account_custom_name" {
  description = "Custom Azure Storage Account name, generated if not set"
  type        = string
  default     = ""
}
