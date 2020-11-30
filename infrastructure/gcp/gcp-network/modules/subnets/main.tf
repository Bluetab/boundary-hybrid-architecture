
locals {
  subnets = {
    for x in var.subnets :
    "${x.subnet_region}/${x.subnet_name}" => x
  }
}

resource "google_compute_subnetwork" "subnetwork" {
  for_each = local.subnets

  name = each.value.subnet_name

  ip_cidr_range = each.value.subnet_ip_cidr
  region        = each.value.subnet_region
  description   = lookup(each.value, "description", null)

  private_ip_google_access = lookup(each.value, "subnet_private_access", false)

  dynamic "log_config" {
    for_each = lookup(each.value, "subnet_flow_logs", true) ? [{
      aggregation_interval = lookup(each.value, "subnet_flow_logs_interval", "INTERVAL_15_MIN")
      flow_sampling        = lookup(each.value, "subnet_flow_logs_sampling", "0.5")
      metadata             = lookup(each.value, "subnet_flow_logs_metadata", "EXCLUDE_ALL_METADATA")
    }] : []
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
    }
  }

  secondary_ip_range = [
    for i in range(
      length(
        contains(
        keys(var.secondary_ranges), each.value.subnet_name) == true
        ? var.secondary_ranges[each.value.subnet_name]
        : []
    )) :
    var.secondary_ranges[each.value.subnet_name][i]
  ]

  network = var.network_name
  project = var.project_id
}
