variable "name" {
  description = "Descriptive name for all elements"
  type        = string
}

######
# google_compute_subnetwork
######

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
  default     = null
}

variable "network_name" {
  description = "The network name that this subnet belongs to"
  type        = string
  default     = ""
}

variable "subnets" {
  description = "List of subnetworks to associate with the network_name"
  type        = list(map(string))
  default     = []
}

variable "secondary_ranges" {
  description = "Secondary ranges that will be used in some of the subnets"
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  default     = {}
}

######
# Tags
######

variable "labels" {
  description = "A mapping of labels to assign to all resources"
  type        = map(string)
}
