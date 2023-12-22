locals {
  account_name = ""
  repo_name = ""

  project_path = "github://${local.account_name}/${local.repo_name}"
  policies_path = "${local.project_path}/policies"

  # Replace if your abbey email doesn't match your Google User email
  # Example: gcp_member = "your-username@gmail.com"
  gcp_member = "{{ .user.email }}"
  gcp_customer_id = "replace-me"
}


resource "google_cloud_identity_group" "abbey-gcp-quickstart" {
  display_name         = "abbey-gcp-quickstart"
  initial_group_config = "WITH_INITIAL_OWNER"

  # Replace with your customer ID
  parent = "customers/${local.gcp_customer_id}"

  group_key {
    # choose a unique group ID
    id = "replace-me@example.com"
  }

  labels = {
    "cloudidentity.googleapis.com/groups.discussion_forum" = ""
  }
}

resource "abbey_grant_kit" "abbey_gcp_identity_quickstart" {
  name = "Abbey-GCP-Identity-Quickstart"
  description = <<-EOT
    Grants access to Abbey's GCP Group for the Quickstart.
  EOT

  workflow = {
    steps = [
      {
        reviewers = {
          one_of = ["replace-me@example.com"] # CHANGEME
        }
      }
    ]
  }

  policies = [
    { bundle = local.policies_path }
  ]

  output = {
    location = "${local.project_path}/access.tf"
    append = <<-EOT
      resource "google_cloud_identity_group_membership" "member" {
        group    = google_cloud_identity_group.abbey-gcp-quickstart.id
        roles {
          name = "MEMBER"
        }
        preferred_member_key {
          id = local.gcp_member
        }
      }
    EOT
  }
}
