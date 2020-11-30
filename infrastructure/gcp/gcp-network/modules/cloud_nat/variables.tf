variable "name" {
  description = "Descriptive name for all elements"
  type        = string
}

######
# google_compute_router
######

variable "create_vpc" {
  description = "Controls if VPC should be created"
  type        = bool
  default     = true
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

variable "network_name" {
  description = "The network name that this subnet belongs to"
  type        = string
  default     = ""
}

variable "router_asn" {
  description = "The local BGP autonomous system number"
  type        = string
  default     = "64514"
}

variable "enable_nat_gateway" {
  description = "Should be true to provision NAT Gateways for each intra subnetworks"
  type        = bool
  default     = false
}

variable "subnetworks" {
  description = "The list of subnetworks that allow NAT traffic"
  type        = list(map(string))
  default     = []
}

######
# google_compute_router_nat
######

variable "nat_ip_allocate_option" {
  description = "How external IPs should be allocated for this NAT"
  type        = string
  default     = "AUTO_ONLY"
}

variable "nat_ips" {
  description = "The List of self_links of external IPs"
  type        = list(string)
  default     = []
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "How NAT should be configured per subnetwork"
  type        = string
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "min_ports_per_vm" {
  description = "Minimum number of ports allocated to a VM from this NAT config"
  type        = string
  default     = "64"
}

variable "udp_idle_timeout_sec" {
  description = "The timeout (in seconds) for UDP connections"
  type        = string
  default     = "30"
}

variable "icmp_idle_timeout_sec" {
  description = "The timeout (in seconds) for ICMP connections"
  type        = string
  default     = "30"
}

variable "tcp_established_idle_timeout_sec" {
  description = "The timeout (in seconds) for TCP established connections"
  type        = string
  default     = "1200"
}

variable "tcp_transitory_idle_timeout_sec" {
  description = "The timeout (in seconds) for TCP transitory connections"
  type        = string
  default     = "30"
}

variable "nat_subnetworks" {
  description = "One or more subnetwork NAT configurations"
  type = list(object({
    name                    = string,
    source_ip_ranges_to_nat = list(string)
  }))
  default = []
}

variable "log_config_enable" {
  description = "Should be true to indicate whether or not to export logs"
  type        = bool
  default     = false
}
variable "log_config_filter" {
  description = "Specifies the desired filtering of logs on this NAT"
  type        = string
  default     = "ALL"
}

######
# Tags
######

variable "labels" {
  description = "A mapping of labels to assign to all resources"
  type        = map(string)
}
