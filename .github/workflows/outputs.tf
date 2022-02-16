// ssh key outputs
output "key_private_pem" {
  value = tls_private_key.github_actions.private_key_pem
  sensitive = true
}

output "key_public_openssh" {
  value = tls_private_key.github_actions.public_key_openssh
}