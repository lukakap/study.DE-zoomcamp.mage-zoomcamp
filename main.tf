terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.14.0"
    }
  }
}

provider "google" {
  # for authentication we can use google cloud cdk. but hard coded authentication is good in that case
  # export GOOGLE_CREDENTIALS='C:\Users\Luka\Desktop\DESK\Studying\DE-zoomcamp\01-docker-terraform\1_terraform_gcp\angular-sign-demo-405419-36993e4be4b3.json'
  # test - echo $GOOGLE_CREDENTIALS
  credentials = file(var.credential_path)
  project = var.project_name
  region  = var.region
}

resource "google_storage_bucket" "demo-bucket-mage-1" {
  name          = var.gsb_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}