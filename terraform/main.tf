provider "vsphere" {
  user                 = "${var.vsphere_user}"
  password             = "${var.vsphere_password}"
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = true
  version              = "1.11.0"
}

provider "dns" {
  update {
    server        = "${var.dns_server}"
    key_name      = "${var.dns_key_name}."
    key_algorithm = "${var.dns_key_algorithm}"
    key_secret    = "${var.dns_key_secret}"
  }
  version = "2.2"
}