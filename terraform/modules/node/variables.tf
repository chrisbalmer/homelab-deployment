variable "vsphere_datacenter" {
  description = "The datacenter in vCenter to deploy the node(s) to."
  default     = "the farm"
}
variable "vsphere_cluster" {
  description = "The cluster in the datacenter to deploy the node(s) to."
  default     = "operations"
}
variable "vsphere_resource_pool" {
  description = "The resouce pool to deploy the node(s) to."
  default     = "Resources"
}
variable "vsphere_datastore" {
  description = "The datastore to deploy the node(s) to."
  default     = "vsanDatastore"
}
variable "vsphere_network" {
  description = "The network to connect the node(s) to."
  default     = "vlan2119-kubernetes"
}
variable "vsphere_template" {
  description = "The template to use for creating the node(s)."
  default     = "rancheros-1.5.1"
}


variable "node_count" {
  description = "How many nodes of this type to create."
  default     = "3"
}
variable "node_prefix" {
  description = "The prefix for the full node name, i.e. dev, prod, etc"
  default     = "ops-"
}
variable "node_name" {
  description = "The name of the node, i.e. worker, master, etc"
  default     = "worker"
}
variable "node_guest_id" {
  description = "The guest ID for the virtual machine OS, since this assumes RancherOS, this shouldn't be changed yet."
  default     = "otherLinux64Guest"
}
variable "node_disk_size" {
  description = "The size of the node disk drive in GB."
  default     = "64"
}
variable "node_ips" {
  description = "IP addresses to assign to the nodes."
  default = [
    "172.21.19.21/24",
    "172.21.19.22/24",
    "172.21.19.23/24"
  ]
}
variable "node_gateway" {
  description = "Gateway for the node."
  default = "172.21.19.1"
}
variable "node_dns" {
  description = "DNS servers for the node."
  default = "172.21.14.2,172.21.14.4"
}
variable "node_network_interface" {
  description = "Network interface used by the node."
  default = "eth0"
}
variable "node_initial_key" {
  description = "The initial SSH key to allow access to the node."
}
variable "node_domain_name" {
  description = "The domain name to assign to the node."
  default     = "farm.oakops.io"
}