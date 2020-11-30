
variable "name" {
  description = "fixture"
  type        = string
}

variable "region" {
  description = "fixture"
  type        = string
  default     = "europe-west3"
}

variable "controllers_dns" {
  type = list
}

######
# Tags
######

variable "labels" {
  description = "fixture"
  type        = map(string)
}

######
# Copied from aws folder
######

variable "tls_private_key_pem" {

}

variable "tls_self_cert_pem" {

}

variable "tls_cert_path" {
  default = "/etc/pki/tls/boundary/boundary.cert"
}

variable "tls_key_path" {
  default = "/etc/pki/tls/boundary/boundary.key"
}

variable "tls_disabled" {
  default = true
}

variable "boundary_bin" {
  default = "/usr/local/bin/"
}

variable "kms_type" {
  default = "aws"
}

variable "kms_key_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}
