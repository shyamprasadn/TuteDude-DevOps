variable "project_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "frontend_image" {
  type = string
}

variable "backend_image" {
  type = string
}

variable "frontend_log_group" {
  type = string
}

variable "backend_log_group" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "frontend_security_group_id" {
  type = string
}

variable "backend_security_group_id" {
  type = string
}

variable "frontend_target_group_arn" {
  type = string
}

variable "backend_target_group_arn" {
  type = string
}