variable "name" {
  description = "Descriptive name for all elements"
  type        = string
}

######
# google_compute_firewall
######

variable "create_firewall" {
  description = "Controls if firewall should be created"
  type        = bool
  default     = true
}

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

variable "subnetworks" {
  description = "The list of subnetworks that allow inbound traffic from within"
  type        = list(string)
  default     = []
}

######
# Tags
######

variable "labels" {
  description = "A mapping of labels to assign to all resources"
  type        = map(string)
}
