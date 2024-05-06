variable "backend_bucket_name" {
  type    = string
  default = "terraform-on-aws-eks-simplifywoopii"
}

variable "eks_bucket_key_name" {
  type    = string
  default = "env:/devops/dev/eks-cluster/terraform.tfstate"
}
