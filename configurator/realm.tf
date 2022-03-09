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

resource "keycloak_realm" "main" {
  realm   = var.realm_id
  enabled = true

  smtp_server {
    host = var.smtp_host
    port = var.smtp_port
    from = var.smtp_from
    ssl  = true
    auth {
      username = "tom"
      password = "tom"
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
