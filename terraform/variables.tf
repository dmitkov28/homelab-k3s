variable "proxmox_url" {
  type = string
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_token" {
  type      = string
  sensitive = true
}

variable "proxmox_node" {
  type = string
}


variable "ssh_user" {
  type    = string
  default = "debian"
}


variable "gateway" {
  type    = string
  default = "192.168.1.1"
}

variable "ssh_private_key_path" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "proxmox_template_name" {
  type = string
}
