resource "keycloak_openid_client" "frontend" {
  realm_id                     = keycloak_realm.main.id
  client_id                    = "frontend"
  access_type                  = "PUBLIC"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris          = ["*"]
}
