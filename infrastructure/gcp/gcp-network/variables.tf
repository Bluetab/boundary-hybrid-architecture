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
# google_compute_subnetwork
######

variable "public_subnets" {
  description = "List of public subnetworks to associate with the network_name"
  type        = list(map(string))
  default     = []
}

variable "intra_subnets" {
  description = "List of intranet subnetworks to associate with the network_name"
  type        = list(map(string))
  default     = []
}

variable "private_subnets" {
  description = "List of private subnetworks to associate with the network_name"
  type        = list(map(string))
  default     = []
}

variable "secondary_ranges" {
  description = "Secondary ranges that will be used in some of the subnets"
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  default     = {}
}

######
# google_compute_router_nat
######

variable "enable_nat_gateway" {
  description = "Should be true to provision NAT Gateways for each intra networks"
  type        = bool
  default     = false
}

######
# google_compute_route
######

variable "routes" {
  description = "List of routes to associate with the network_name"
  type        = list(map(string))
  default     = []
}

######
# Tags
######

variable "labels" {
  description = "A mapping of labels to assign to all resources"
  type        = map(string)
}
