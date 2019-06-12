provider "vsphere" {
  user                 = "${var.vsphere_user}"
  password             = "${var.vsphere_password}"
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = true
  version              = "1.11.0"
}

module "node" {
  source           = "./modules/node/"
  node_initial_key = "${var.ssh_public_key}"
}