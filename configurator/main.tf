terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 3.0"
    }
  }
  backend "pg" {
    conn_str = ""
  }
}
variable "admin_username" {
  type = string
}
variable "admin_password" {
  type      = string
  sensitive = true
}
provider "keycloak" {
  client_id = "admin-cli"
  username  = var.admin_username
  password  = var.admin_password
  url       = "http://localhost:8080"
}
variable "realm_id" {
  default     = "test"
  description = "the realm name to use"
}

# smtp configuration
variable "smtp_host" {
  default = "reglisse.o2switch.net"
}

variable "smtp_port" {
  default = "587"
}

variable "smtp_from" {
  default = "Test"
}

variable "smtp_username" {
  default = ""
}

variable "smtp_password" {
  default   = ""
  sensitive = true
}
