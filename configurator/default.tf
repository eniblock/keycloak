resource "keycloak_realm" "main" {
  realm             = var.realm_id
  display_name      = var.realm_display == null ? var.realm_id : var.realm_display
  display_name_html = var.realm_html_display == null ? (var.realm_display == null ? var.realm_id : var.realm_display) : var.realm_html_display

  smtp_server {
    host = var.smtp_host
    port = var.smtp_port
    from = var.smtp_from
    ssl  = var.smtp_ssl
    dynamic "auth" {
      for_each = var.smtp_username == "" ? [] : [1]
      content {
        username = var.smtp_username
        password = var.smtp_password
      }
    }
  }

  login_theme = "extra"

  access_token_lifespan = var.access_token_lifespan

  internationalization {
    supported_locales = var.locales
    default_locale    = var.locales[0]
  }

  security_defenses {
    brute_force_detection {
      max_login_failures = 10
    }
  }

  reset_password_allowed = var.reset_password_allowed

  #   password_policy = "upperCase(1) and length(8) and forceExpiredPasswordChange(365) and notUsername"
}

resource "keycloak_openid_client" "frontend" {
  realm_id                     = keycloak_realm.main.id
  client_id                    = "frontend"
  access_type                  = "PUBLIC"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris          = var.valid_redirect_uris
  web_origins                  = ["+"]
}
