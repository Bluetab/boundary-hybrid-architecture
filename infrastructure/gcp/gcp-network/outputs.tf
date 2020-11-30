
######
# google_compute_network
######

output "network_id" {
  description = "An identifier of the network resource"
  value       = module.vpc.id
}

output "network_name" {
  description = "The name of the network resource"
  value       = module.vpc.name
}

output "network_self_link" {
  description = "The URI of the network resource"
  value       = module.vpc.self_link
}

######
# google_compute_subnetwork
######

output "public_subnet_names" {
  description = "The names of the public subnet resource"
  value       = [for network in module.public.subnets : network.name]
}

output "public_subnet_ips" {
  description = "The IPs and CIDRs of the public subnet resources"
  value       = [for network in module.public.subnets : network.ip_cidr_range]
}

output "public_subnet_self_links" {
  description = "The self-links of the public subnet resources"
  value       = [for network in module.public.subnets : network.self_link]
}

output "intra_subnet_names" {
  description = "The names of the intra subnet resource"
  value       = [for network in module.intra.subnets : network.name]
}

output "intra_subnet_ips" {
  description = "The IPs and CIDRs of the intra subnet resources"
  value       = [for network in module.intra.subnets : network.ip_cidr_range]
}

output "intra_subnet_self_links" {
  description = "The self-links of the intra subnet resources"
  value       = [for network in module.intra.subnets : network.self_link]
}

output "private_subnet_names" {
  description = "The names of the intra private resource"
  value       = [for network in module.private.subnets : network.name]
}

output "private_subnet_ips" {
  description = "The IPs and CIDRs of the private subnet resources"
  value       = [for network in module.private.subnets : network.ip_cidr_range]
}

output "private_subnet_self_links" {
  description = "The self-links of the private subnet resources"
  value       = [for network in module.private.subnets : network.self_link]
}

######
# google_compute_route
######

output "route_names" {
  description = "The route names associated with this VPC"
  value       = [for route in module.routes.routes : route.name]
}

######
# google_compute_firewall
######

output "public" {
  description = "The instance tag indicating network public topology"
  value       = module.firewall.public
}

output "private_restricted" {
  description = "The instance tag indicating network restricted topology"
  value       = module.firewall.private_restricted
}

output "private" {
  description = "The instance tag indicating network private topology"
  value       = module.firewall.private
}

######
# google_compute_router
######

output "router_names" {
  description = "The names of the router resources"
  value       = module.cloud_nat.router_names
}

output "router_self_links" {
  description = "The URI of the router resources"
  value       = module.cloud_nat.router_self_links
}

######
# google_compute_router_nat
######

output "nat_names" {
  description = "The names of the cloud NATs resources"
  value       = module.cloud_nat.nat_names
}
