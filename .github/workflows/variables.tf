// Taken from the terraform.tfvars

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "instance_tags" {
  description = "Tags to set for instances"
  type        = map(string)
}

variable "github_pub_key"{
  description = "github public key"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCwEtQ+nExURJriW91MqntgLOR2v59B8kynzLIUjVYuaGTQFsV5eqh9TMSsCaSa+PVDCh6TEoTC8kzChQ4uj/ExEK8qaFmfCuwyEiKYCRG3UzoncYXujERQUjlHkzQfIaJkWGAkTP3BtrUfJu/iLpeXATTGNTfL5OLl+1j369dBuFGcZC+c8fyvJWrP58aWRxW4KSI0OajTVYHFGHH48Z5CItKLwLy40svwkDHMiDScWZFlf2oRL4wzFCeufMcD9oLTpHPcOoiLdn0xBExTHQp7I4uHUE1Q3AoGf+eEA3zLAD8jInhkft3oo122szfzlPpeISBSJ4W0MwyzHE/mKG4/cZY5jBGmjO+9vRUcCsg1W5DELg3TJqzD/ygbN0QCJkvSuvnUDTxEdP9ObNzolZxcaKh4xvR09cvURCaKebWScwfkt0bGuEl7h9dIua0nmOgILpt6q2Vfpdgpq+uNCODojMMphJWniYJsEzNfkKAxS1vmCBcIbAXvXAq8rPrbqZyfAS2BKtVAr72kOp2E1b7JxvwHQlyybD05O/ktsKFaNDyK4BHXh2CLO0A5674sOz3HkDctU3sTjpeW4T/H28hFiewar9mEtDqqeiwStDz7hVfSxHx85BV8ycIAZpNN67757jhKaKMEo5uDe+ldMJT8QAimeQfQPHSsij1MMsQLTw== mbolwell@MPGLT-C02CG9NMMD6M"
}

// Taken from the OSname.tfvars

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "ami_os" {
  description = "AMI OS Type"
  type        = string
}

variable "ami_username" {
  description = "Username for the ami id"
  type        = string
}

variable "ami_user_home" {
  description = "home directory for the user"
  type        = string
}

variable "ansible_inventory_vars" {
  description = "variables for ansible inventory"
  type        = map(string)
}