# 🧪 NixOS Libvirt Kubernetes (Single Node Cluster)

This project provisions a **single-node Kubernetes cluster** on **NixOS** using:

- 🛠️ **Terraform** — to manage virtual machines on Libvirt
- 🐧 **NixOS** — declarative configuration for VM images
- 🌱 **Colmena** — to deploy and manage Kubernetes configuration
- 🐳 **Libvirt/QEMU** — local VM virtualization

## ✅ Prerequisites

- Nix
- Terraform ≥ 1.0
- Libvirt (with `default` pool active)
- QEMU/KVM
- SSH configured with `~/.ssh/id_ed25519.pub` or `~/.ssh/id_rsa.pub`

---

## 🔧 Setup Instructions

### 1. Start a Nix Shell

```bash
nix-shell
```

## Generate the NixOS Image

```bash
make-boot-image
```

## Deploy VM with Terraform

```bash
terraform init
terraform apply
```

## Deploy Kubernetes with Colmena

Ensure you can SSH into the VM via the configured key, then:

```bash
colmena apply
```

## 🧼 Cleanup

```bash
terraform destroy
```

To remove the VM and associated resources.

## 📖 Resources
- [NixOS Kubernetes](https://nixos.wiki/wiki/Kubernetes)
- [nixos-generators](https://github.com/nix-community/nixos-generators)
- [Colmena](https://github.com/zhaofengli/colmena)
- [Terraform Libvirt Provider](https://github.com/dmacvicar/terraform-provider-libvirt)
