terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.21.0"
      aws-access-key-id: AWS_ACCESS_KEY
      aws-secret-access-key: AWS_ACCESS_SECRET
    }
  }

  required_version = "~> 1.2"
}
