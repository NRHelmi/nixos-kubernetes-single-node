variable "name" {
  type    = string
  default = "nixos"
}

variable "memory" {
  type    = number
  default = 512
}

variable "vcpu" {
  type    = number
  default = 2
}

variable "network_id" {
  type = string
}

variable "volume_id" {
  type = string
}
