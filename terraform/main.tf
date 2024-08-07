terraform {
  backend "remote" {
    organization = "Infrastructure_Org"

    workspaces {
      name = "API_S3_Data_Landing"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

