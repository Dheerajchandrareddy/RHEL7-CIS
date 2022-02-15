//terraform {
//    required_providers {
//       aws = {
//        source = "hashicorp/aws"
//        }
//    }
//    required_version = ">=0.14.4"
//}

provider "aws" {
    profile = ""
    region  = var.aws_region
}

// Generate the SSH keypair that we’ll use to configure the EC2 instance.
// After that, write the private key to a local file and upload the public key to AWS


resource "tls_private_key" "benchmark" {   # Generate key
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "temp_key"                  # Add temp_key to AWS
  public_key = tls_private_key.benchmark.public_key_openssh

  provisioner "local-exec" {               # Add the "test_key.pem" to the runner
    command  = "echo '${tls_private_key.benchmark.private_key_pem}' > ./temp_key.pem && chmod 400 temp_key.pem"
  }
}

// Create a security group with access to port 22 and port 80 open to serve HTTP traffic

data "aws_vpc" "default" {
  default = true
}


resource "aws_security_group" "allow_ssh" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// instance setup

resource "aws_instance" "testing_vm" {
    ami                         = var.ami_id
    associate_public_ip_address = true
    key_name                    = aws_key_pair.key_pair.key_name
    instance_type   = var.instance_type
    tags            = var.instance_tags
    vpc_security_group_ids      = [aws_security_group.allow_ssh.id]

  provisioner "file" {
   source = "s3copy.sh"
   destination = "${var.ami_user_home}/s3copy.sh"
 }
}

// generate inventory file
resource "local_file" "inventory" {
  filename = "./hosts.yml"
  content  = <<EOF
    # benchmark host
    all:
      hosts:
        var.ami_os:
          ansible_host: ${aws_instance.testing_vm.public_ip}
      vars:
        setup_audit: true
        run_audit: true
        system_is_ec2: true
        .var.ansible_inventory_vars
    EOF
}