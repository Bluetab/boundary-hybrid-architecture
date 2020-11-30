variable "name" {
  default = "boundary-horse"
  type    = string
}

variable "branch" {
  default = "refactorize-deployment"
  type    = string
}

variable "backend" {
  default = "hashicorp-boundary-infrastructure.tfstate"
  type    = string
}

variable "gcp_region" {
  default = "europe-west1"
}

variable "gcp_zone" {
  default = "europe-west1-b"
}

variable "pub_ssh_key_path" {
  default = "~/.ssh/id_rsa_boundary.pub"
}

variable "priv_ssh_key_path" {
  default = "~/.ssh/id_rsa_boundary"
}
