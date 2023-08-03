terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "anomalous_number_of_frontend_4xx_http_responses_for_host" {
  source    = "./modules/anomalous_number_of_frontend_4xx_http_responses_for_host"

  providers = {
    shoreline = shoreline
  }
}