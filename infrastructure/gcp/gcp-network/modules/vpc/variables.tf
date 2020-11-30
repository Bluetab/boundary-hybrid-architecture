variable "name" {
  description = "Descriptive name for all elements"
  type        = string
}

######
# google_compute_network
######

variable "create_vpc" {
  description = "Controls if VPC should be created"
  type        = bool
  default     = true
}

variable "auto_create_subnetworks" {
  description = "Should be true to create a subnet for each region automatically"
  type        = bool
  default     = false
}

variable "routing_mode" {
  description = "The network-wide routing mode to use"
  type        = string
  default     = "GLOBAL"
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
  default     = null
}

variable "description" {
  description = "An optional description of this resource"
  type        = string
  default     = ""
}

variable "delete_default_routes_on_create" {
  description = "Should be true to delete default routes (0.0.0.0/0) after network creation"
  type        = bool
  default     = false
}

######
# google_compute_shared_vpc_host_project
######

variable "shared_vpc_host" {
  description = "Should be true to makes project_id a Shared VPC host project"
  type        = bool
  default     = false
}

######
# Tags
######

variable "labels" {
  description = "A mapping of labels to assign to all resources"
  type        = map(string)
}
