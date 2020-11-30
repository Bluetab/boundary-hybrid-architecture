module "network" {
  source = "./gcp-network"

  name               = var.name
  description        = "Testing Hashicorp Boundary"
  enable_nat_gateway = true

  public_subnets = [
    {
      subnet_name    = format("%s-public", var.name)
      subnet_ip_cidr = "10.10.10.0/24"
      subnet_region  = var.region
    }
  ]

  intra_subnets = [
    {
      subnet_name    = format("%s-private01", var.name)
      subnet_ip_cidr = "10.10.20.0/24"
      subnet_region  = var.region
    }
  ]

  private_subnets = [
    {
      subnet_name    = format("%s-private02", var.name)
      subnet_ip_cidr = "10.10.30.0/24"
      subnet_region  = var.region
    }
  ]

  labels = var.labels
}
