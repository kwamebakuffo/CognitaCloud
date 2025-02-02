# variables.tf

variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the VPC where the WorkSpace will be deployed"
}

variable "subnet_ids" {
  description = "The list of subnet IDs for the WorkSpace deployment"
  type        = list(string)
}

variable "directory_password" {
  description = "The password for the Simple AD directory"
  sensitive   = true
}