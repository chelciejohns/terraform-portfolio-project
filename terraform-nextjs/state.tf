terraform {
  backend "s3" {
    bucket         = "nextjs-terraform-state-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-lock-file"
  }
}
