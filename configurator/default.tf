resource "keycloak_realm" "main" {
  realm             = var.realm_id
  display_name      = var.realm_display == null ? var.realm_id : var.realm_display
  display_name_html = var.realm_display_html == null ? (var.realm_display == null ? var.realm_id : var.realm_display) : var.realm_display_html

  smtp_server {
    host = var.smtp_host
    port = var.smtp_port
    from = var.smtp_from
    ssl  = true
    auth {
      username = var.smtp_username
      password = var.smtp_password
    }
  }

  login_theme = "extra"

  internationalization {
    supported_locales = [
      "en",
      "fr",
    ]
    default_locale = "en"
  }

  security_defenses {
    brute_force_detection {
      max_login_failures = 10
    }
  }

  #   password_policy = "upperCase(1) and length(8) and forceExpiredPasswordChange(365) and notUsername"
}

resource "keycloak_openid_client" "frontend" {
  realm_id                     = keycloak_realm.main.id
  client_id                    = "frontend"
  access_type                  = "PUBLIC"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris          = ["*"]
}
