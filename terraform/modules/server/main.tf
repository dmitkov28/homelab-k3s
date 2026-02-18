resource "proxmox_vm_qemu" "k3s_server" {
  name        = var.name
  target_node = var.proxmox_node
  clone       = var.template_name
  vm_state    = "running"
  os_type     = "cloud-init"

  full_clone = true
  boot       = "order=scsi0"
  agent      = 1
  scsihw     = "virtio-scsi-pci"

  vmid      = var.vm_id
  ipconfig0 = "ip=${var.ip}/24,gw=${var.gateway}"

  ciuser  = var.ssh_user
  sshkeys = file(var.ssh_public_key_path)


  memory = var.memory

  cpu {
    cores   = 2
    sockets = 1
  }

  serial {
    id   = 0
    type = "socket"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size    = "32G"
          storage = "local"
        }
      }

      scsi1 {
        disk {
          size      = "32G"
          storage   = "local"
          cache     = "none"
          replicate = false
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = "local"
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  connection {
    type        = "ssh"
    host        = var.ip
    user        = var.ssh_user
    private_key = file(var.ssh_private_key_path)
  }


  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | K3S_TOKEN=${random_password.k3s_token.result} sh -s - server"
    ]
  }

}


