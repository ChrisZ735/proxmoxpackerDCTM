
variable "kali_image" {
  type    = string
  default = "kali-linux-2021.4a-live-amd64.iso"
}

variable "proxmox_iso_pool" {
  type    = string
  default = "local:iso"
}

variable "proxmox_node" {
  type    = string
  default = "lovelace"
}

variable "proxmox_password" {
  type    = string
  default = "lovelace"
}

variable "proxmox_storage_format" {
  type    = string
  default = "raw"
}

variable "proxmox_storage_pool" {
  type    = string
  default = "local-lvm"
}

variable "proxmox_storage_pool_type" {
  type    = string
  default = "lvm-thin"
}

variable "proxmox_url" {
  type    = string
  default = "https://10.0.0.148:8006/api2/json"
}

variable "proxmox_username" {
  type    = string
  default = "root@pam"
}

variable "template_description" {
  type    = string
  default = "Kali 2021 Template"
}

variable "template_name" {
  type    = string
  default = "Kali2021-Template"
}

variable "version" {
  type    = string
  default = ""
}

source "proxmox" "kali" {
  boot_command = ["<esc><wait>", "/install/vmlinuz<wait>", " auto<wait>", " console-setup/ask_detect=false<wait>", " console-setup/layoutcode=us<wait>", " console-setup/modelcode=pc105<wait>", " debconf/frontend=noninteractive<wait>", " debian-installer=en_US<wait>", " fb=false<wait>", " initrd=/install/initrd.gz<wait>", " kbd-chooser/method=us<wait>", " netcfg/choose_interface=eth0<wait>", " console-keymaps-at/keymap=us<wait>", " keyboard-configuration/xkb-keymap=us<wait>", " keyboard-configuration/layout=USA<wait>", " keyboard-configuration/variant=USA<wait>", " locale=en_US<wait>", " netcfg/get_domain=vm<wait>", " netcfg/get_hostname=kali<wait>", " grub-installer/bootdev=/dev/sda<wait>", " noapic<wait>", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg auto=true priority=critical", " -- <wait>", "<enter><wait>"]
  boot_wait    = "10s"
  cores        = "2"
  disks {
    disk_size         = "8G"
    format            = "${var.proxmox_storage_format}"
    storage_pool      = "${var.proxmox_storage_pool}"
    storage_pool_type = "${var.proxmox_storage_pool_type}"
    type              = "scsi"
  }
  http_directory           = "http"
  insecure_skip_tls_verify = true
  iso_file                 = "${var.proxmox_iso_pool}/${var.kali_image}"
  memory                   = "2048"
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  node                 = "${var.proxmox_node}"
  os                   = "l26"
  password             = "${var.proxmox_password}"
  proxmox_url          = "${var.proxmox_url}"
  scsi_controller      = "virtio-scsi-single"
  ssh_password         = "lovelace"
  ssh_port             = 22
  ssh_timeout          = "15m"
  ssh_username         = "root"
  template_description = "${var.template_description}"
  template_name        = "${var.template_name}"
  unmount_iso          = true
  username             = "${var.proxmox_username}"
}

build {
  sources = ["source.proxmox.kali"]


  }


