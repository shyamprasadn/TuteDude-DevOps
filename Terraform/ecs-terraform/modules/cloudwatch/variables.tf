variable "project_name" {
  description = "Project name"
  type        = string
}

variable "log_retention_days" {
  description = "CloudWatch log retention"
  type        = number
  default     = 7
}

variable "common_tags" {
  type = map(string)
}