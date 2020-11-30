
######
# google_compute_route
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
