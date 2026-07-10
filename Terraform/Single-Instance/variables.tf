##############################
# AWS Configuration
##############################

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-2"
}

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "flask-express-app"
}

variable "environment" {
  description = "Deployment Environment"
  type        = string
  default     = "dev"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
}

##############################
# EC2 Configuration
##############################

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "AWS EC2 Key Pair Name"
  type        = string
}

##############################
# Networking
##############################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Public Subnet ID"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH"
  type        = string
  default     = "0.0.0.0/0"
}

##############################
# GitHub Repository
##############################

variable "github_repo_url" {
  description = "GitHub Repository URL"
  type        = string
}

variable "github_branch" {
  description = "GitHub Branch"
  type        = string
  default     = "main"
}