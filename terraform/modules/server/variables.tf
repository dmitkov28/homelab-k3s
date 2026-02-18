variable "proxmox_node" {
  type = string
}

variable "template_name" {
  type = string
}

variable "name" {
  type = string
}

variable "ip" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "ssh_user" {
  type    = string
  default = "debian"
}

variable "memory" {
  type    = number
  default = 2048
}


variable "ssh_private_key_path" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "gateway" {
  type = string
}
