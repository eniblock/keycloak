terraform {
  version = "1.1.7"
}
providers {
  customplugin = {
      source   = "mrparkers/keycloak"
      versions = [">= 3.0"]
  }
}
