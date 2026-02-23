# Homelab K3s Cluster

Automated deployment of a K3s Kubernetes cluster using either Terraform (Proxmox) or Vagrant (VirtualBox). This project provisions a lightweight Kubernetes environment with one server node and two agent nodes, perfect for homelab experimentation and learning.

## Architecture

### Terraform (Proxmox)
- **k3s-server** (192.168.1.80) - Control plane node with 2GB RAM
- **k3s-agent-1** (192.168.1.81) - Worker node with 1GB RAM
- **k3s-agent-2** (192.168.1.82) - Worker node with 1GB RAM

### Vagrant (VirtualBox)
- **k3s-server** (192.168.1.100) - Control plane node with 2GB RAM, 2 CPUs
- **k3s-agent-1** (192.168.1.101) - Worker node with 1GB RAM, 2 CPUs
- **k3s-agent-2** (192.168.1.102) - Worker node with 1GB RAM, 2 CPUs

## Features

- **Automated provisioning** - Single `terraform apply` deploys entire cluster
- **Modular design** - Reusable Terraform modules for server and agent nodes
- **Cloud-init integration** - Automated VM configuration and SSH key injection
- **Secure token generation** - Random K3s token for cluster authentication
- **Idempotent deployment** - Safe to run multiple times

## Prerequisites

### Terraform (Proxmox)
- Proxmox VE 8.0.3 installed and configured
- API token created with appropriate permissions
- Cloud-init enabled Debian 13 template
- Network bridge `vmbr0` configured
- Terraform 1.14.x
- SSH key pair generated
- Network access to Proxmox host

### Vagrant (VirtualBox)
- VirtualBox installed
- Vagrant installed
- At least 4GB RAM available for VMs

## Quick Start

### Option 1: Terraform (Proxmox)

1. **Clone the repository**
   ```bash
   git clone github.com/dmitkov28/homelab-k3s homelab-k3s
   cd homelab-k3s
   ```

2. **Configure variables**
   ```bash
   cd terraform
   cp example.tfvars terraform.tfvars
   ```

3. **Edit `terraform.tfvars`** with your values:
   ```hcl
   proxmox_url      = "https://your-proxmox:8006/api2/json"
   proxmox_username = "terraform@pam!terraform"
   proxmox_token    = "your-api-token"
   proxmox_node     = "pve"
   
   ssh_user             = "debian"
   ssh_private_key_path = "~/.ssh/id_rsa"
   ssh_public_key_path  = "~/.ssh/id_rsa.pub"
   ```

4. **Deploy the cluster**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

5. **Access your cluster**
   ```bash
   ssh debian@192.168.1.80
   sudo kubectl get nodes
   ```

### Option 2: Vagrant (VirtualBox)

1. **Clone the repository**
   ```bash
   git clone github.com/dmitkov28/homelab-k3s homelab-k3s
   cd homelab-k3s/vagrant
   ```

2. **(Optional) Set K3s token**
   ```bash
   export K3S_TOKEN="your-custom-token"
   ```

3. **Deploy the cluster**
   ```bash
   vagrant up
   ```

4. **Access your cluster**
   ```bash
   vagrant ssh k3s-server
   sudo kubectl get nodes
   ```


## How It Works

1. **Server Provisioning** - Creates VM from cloud-init template, configures networking, installs K3s in server mode
2. **Token Generation** - Generates secure random token for cluster authentication
3. **Agent Provisioning** - Creates agent VMs and joins them to the server using the token
4. **Dependency Management** - Agents wait for server to be ready before joining


## Cleanup

### Terraform
VMs must not be running for the `destroy` command to work, so make sure to stop them first.

```bash
terraform destroy
```

This removes all VMs but preserves the template.

### Vagrant
```bash
vagrant destroy -f
```
