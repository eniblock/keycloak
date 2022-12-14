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
  base_path = "/auth"
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
  default = "465"
}

variable "smtp_from" {
  default = "noreply@eniblock.fr"
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
  type    = list(string)
  default = ["en"]
}

variable "reset_password_allowed" {
  default = false
}

variable "valid_redirect_uris" {
  type    = list(string)
  default = ["/*"]
}

variable "access_token_lifespan" {
  default = "5m"
}
