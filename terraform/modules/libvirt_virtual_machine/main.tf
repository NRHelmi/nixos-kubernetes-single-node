terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

resource "libvirt_volume" "volume" {
  name           = "${var.name}.volume"
  base_volume_id = var.volume_id
}

resource "libvirt_domain" "domain" {
  name = var.name

  vcpu   = var.vcpu
  memory = var.memory

  disk {
    volume_id = libvirt_volume.volume.id
  }

  network_interface {
    network_id     = var.network_id
    wait_for_lease = true
  }
}

output "configuration" {
  value = libvirt_domain.domain
}
