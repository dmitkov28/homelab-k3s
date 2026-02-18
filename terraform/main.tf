# sample usage

module "server" {
  source        = "./modules/server"
  template_name = var.proxmox_template_name
  proxmox_node  = var.proxmox_node
  ip            = "192.168.1.80"
  gateway       = var.gateway

  ssh_user             = var.ssh_user
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key_path  = var.ssh_public_key_path

  name   = "k3s-server"
  vm_id  = 800
  memory = 2048
}

module "agent1" {
  source        = "./modules/agent"
  template_name = var.proxmox_template_name
  proxmox_node  = var.proxmox_node
  ip            = "192.168.1.81"
  gateway       = var.gateway

  ssh_user             = var.ssh_user
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key_path  = var.ssh_public_key_path

  name   = "k3s-agent-1"
  vm_id  = 801
  memory = 1024

  k3s_server_ip = module.server.server_ip
  k3s_token     = module.server.k3s_token

  depends_on = [module.server]
}

module "agent2" {
  source        = "./modules/agent"
  template_name = var.proxmox_template_name
  proxmox_node  = var.proxmox_node
  ip            = "192.168.1.82"
  gateway       = var.gateway

  ssh_user             = var.ssh_user
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key_path  = var.ssh_public_key_path

  name   = "k3s-agent-2"
  vm_id  = 802
  memory = 1024

  k3s_server_ip = module.server.server_ip
  k3s_token     = module.server.k3s_token

  depends_on = [module.server]
}
