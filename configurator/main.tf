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
  description = "the realm id to use"
}

variable "realm_display" {
  default     = null
  type        = string
  description = "the realm name to display"
}

variable "realm_html_display" {
  default     = null
  type        = string
  description = "the realm name to display in HTML"
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

variable "smtp_ssl" {
  default = true
}

variable "smtp_username" {
  default = ""
}

variable "smtp_password" {
  default   = ""
  sensitive = true
}

variable "locales" {
  default = ["en"]
}
