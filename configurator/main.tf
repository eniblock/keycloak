terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 3.0"
    }
  }
  backend "pg" {
    conn_str = "postgres://keycloak:2847e1ab3d91c96725e6@localhost/keycloak?sslmode=disable"
  }
}
variable "admin_username" {
    type = string
}
variable "admin_password" {
    type = string
}
provider "keycloak" {
  client_id = "admin-cli"
  username  = var.admin_username
  password  = var.admin_password
  url       = "http://localhost:8080"
}
