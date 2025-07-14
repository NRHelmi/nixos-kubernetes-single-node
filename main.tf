terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.7"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_network" "k8s_net" {
  name      = "k8s-net"
  mode      = "nat"
  domain    = "k8s.local"
  addresses = ["192.168.100.0/24"]

  dhcp {
    enabled = true
  }
}

resource "libvirt_volume" "nixos" {
  name   = "nixos.qcow2"
  pool   = "default"
  source = "${path.module}/image/nixos-cloudimg.qcow2/nixos.qcow2"
  format = "qcow2"
}

module "libvirt_k8s_vm" {
  source = "./terraform/modules/libvirt_virtual_machine"

  name   = "k8s"
  memory = 8192
  vcpu   = 4

  network_id = libvirt_network.k8s_net.id
  volume_id  = libvirt_volume.nixos.id
}

resource "local_file" "k8s_hosts" {
  content = jsonencode([
    for network_interface in module.libvirt_k8s_vm.configuration.network_interface :
    {
      ip       = network_interface.addresses.0,
      hostname = network_interface.hostname
    }
  ])
  filename = "${path.module}/config.json"
}
