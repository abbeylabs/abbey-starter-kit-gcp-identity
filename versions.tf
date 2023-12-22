terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 5.10.0"
    }

    abbey = {
      source = "abbeylabs/abbey"
      version = "~> 0.2.6"
    }
  }
}
