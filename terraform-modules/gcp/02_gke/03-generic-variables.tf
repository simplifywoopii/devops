# GCP Info
variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

# remote state
variable "bucket_name" {
  type = string
}

# vpc
variable "vpc_network_key" {
  type = string
}

## cluster setting
variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = number
}

variable "azs" {
  type = list(string)
}