provider "vsphere" {
  user                 = "${var.vsphere_user}"
  password             = "${var.vsphere_password}"
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = true
  version              = "1.11.0"
}

# TODO: Use a loop to have a single reference to the node module
# TODO: Move static values to variables
module "worker_nodes" {
  source                               = "./modules/node/"
  vsphere_network                      = "vlan2119-kubernetes"
  vsphere_template                     = "rancheros-1.5.1"
  node_count                           = 1
  node_initial_key                     = "${var.ssh_public_key}"
  node_name                            = "worker"
  node_network_interface               = "eth0"
  cloud_init                           = true
  cloud_init_custom                    = true
  cloud_config_template                = "rancheros-cloud-config.tpl"
  cloud_config_guestinfo_path          = "cloud-init.config.data"
  cloud_config_guestinfo_encoding_path = "cloud-init.data.encoding"
}

module "splunk_nodes" {
  source                               = "./modules/node/"
  vsphere_network                      = "vlan14-servers"
  vsphere_template                     = "centos7-2019-06-13"
  node_count                           = 1
  node_initial_key                     = "${var.ssh_public_key}"
  node_name                            = "splunk"
  node_network_interface               = "ens160"
  node_ips                             = [
    "172.21.14.189/24"
  ]
  node_gateway                         = "172.21.14.1"
  cloud_init                           = true
  cloud_init_custom                    = false
  cloud_config_template                = "centos-cloud-config.tpl"
  metadata_template                    = "centos-metadata.tpl"
  network_config_template              = "centos-network-config.tpl"
  cloud_user                           = "${var.splunk.cloud_user}"
  cloud_pass                           = "${var.splunk.cloud_pass}"
}