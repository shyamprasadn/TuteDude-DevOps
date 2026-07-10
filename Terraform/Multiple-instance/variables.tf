variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  default = "10.0.2.0/24"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "Existing EC2 Key Pair name"
  type        = string
}

variable "github_repo" {
  description = "Public GitHub repository URL"
  type        = string
}

variable "github_branch" {
  description = "Git branch"
  type        = string
  default     = "main"
}