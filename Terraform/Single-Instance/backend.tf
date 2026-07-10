terraform {
  backend "s3" {
    bucket = "sn-si-terraform-bucket"
    key    = "assignment1/single-ec2/terraform.tfstate"
    region = "ap-south-2"
    encrypt = true
  }
}