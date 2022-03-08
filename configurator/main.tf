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
provider "keycloak" {
  client_id = "admin-cli"
  username  = "kcadmin"
  password  = "c1be4646fde0ae132d83"
  url       = "http://localhost:8080"
}
