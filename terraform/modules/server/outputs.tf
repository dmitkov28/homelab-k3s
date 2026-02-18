output "server_ip" {
  value = proxmox_vm_qemu.k3s_server.default_ipv4_address
}


output "k3s_token" {
  sensitive = true
  value     = random_password.k3s_token.result
}
