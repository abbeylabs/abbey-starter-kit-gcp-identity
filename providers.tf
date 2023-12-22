provider "google" {
  billing_project     = "replace-me"
  region      = "us-west1"
}

provider "abbey" {
  bearer_auth = var.abbey_token
}
