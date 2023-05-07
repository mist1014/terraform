variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "lamp"
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}

variable "zone" {
  description = "VPC subnet network id"
  type        = string
  default     = "ru-central1-a"
}
